$botkey = "" #insert bot token. DO NOT SHARE THIS FILE WITHOUT REMOVING IT

$source = 'node.js', 'npm', 'wget', 'Source SDK', 'VKontakte', 'fasm', 'PHP', 'MySQL', 'MongoDb', 'git' # X is a part of Y
$dest = 'Github', 'mail.ru', 'Gitlab', 'Microsoft'                                                     # where X is $source and Y is $dest
# P.S.: i didn't bother to add code to add everything from file. Too bad!


$offset = -1
function SendMsg($text) {
  #this shit is here because i didn't bother to put it in one line and because is i did it would be a mess of a code. Too bad!
  $body = @{
    chat_id = $json.result[$i].message.chat.id
    text    = "$text"
  }
                
  Write-Host "message: "+$body.text
  Invoke-WebRequest -Uri "https://api.telegram.org/bot$botkey/sendMessage" -Body $body 
}
while ($true) {
  $json = Invoke-WebRequest -Uri $getUpdatesLink -Body @{ offset = $offset } | ConvertFrom-Json # this works with a primitive method. it checks new messages every second(you can change it in the config)
  $l = $json.result.length
  $i = 0

  while ($i -lt $l) {
    $offset = $json.result[$i].update_id + 1
    if ($json.result[$i].message.text -match "(.*)monopol(.*)" -OR $json.result[$i].message.text -match "(.*)монопол(.*)") {
      #it supports english, russian and plenty of other languages
      SendMsg($source[(Get-Random -Maximum ([array]$source).count)] + " is now a part of " + $dest[(Get-Random -Maximum ([array]$dest).count)])
    }
    $i++
    Start-Sleep -s 1
  }
}