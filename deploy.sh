#!/usr/bin/env bash

set -e

if [[ "${TRAVIS_BRANCH}" == "master" && "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  openssl aes-256-cbc -k "$SERVER_KEY" -in deploy_key.enc -d -a -out deploy.key
  cp deploy.key ~/.ssh/
  chmod 600 ~/.ssh/deploy.key
  git config --global user.email "m@yyu.pw"
  git config --global user.name "Yoshimura Yuu"
  git fetch origin gh-pages:gh-pages
  git stash -u
  git checkout gh-pages
  rm ransomware.pdf ransomware_without_animation.pdf
  git stash pop
  git add ransomware.pdf ransomware_without_animation.pdf
  git commit -a -m "auto commit on travis $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT"
  git push git@github.com:y-yu/ransomware-slide.git gh-pages:gh-pages
fi
