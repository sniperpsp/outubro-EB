versao=$(git rev-parse HEAD | cut -c 1-7)
echo $versao
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 730335588602.dkr.ecr.us-east-1.amazonaws.com
docker build -t biadev .
docker tag biadev:latest 730335588602.dkr.ecr.us-east-1.amazonaws.com/biadev:$versao
docker push 730335588602.dkr.ecr.us-east-1.amazonaws.com/biadev:$versao
rm .env 2> /dev/null
./gerar-compose.sh
rm bia-versao-*zip
zip -r bia-versao-$versao.zip docker-compose.yml
git checkout docker-compose.yml
