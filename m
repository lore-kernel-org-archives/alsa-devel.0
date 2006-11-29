From: Erik Slagter <erik@slagter.name>
Subject: Re: SPDIF/IEC958 sample rate on HDA/ALC882
Date: Wed, 29 Nov 2006 12:18:28 +0100
Message-ID: <456D6C84.6090507@slagter.name>
References: <4548D24F.7080409@slagter.name>	<s5hhcwj4u0s.wl%tiwai@suse.de>	<456C35F5.5070808@slagter.name>	<s5hd5774onm.wl%tiwai@suse.de>	<456C8316.30309@slagter.name>	<s5h64cy4kis.wl%tiwai@suse.de>	<456D63C9.5080605@slagter.name>
	<s5h4psi4j6a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1315522231=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4psi4j6a.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============1315522231==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms010505020200080506090602"

This is a cryptographically signed message in MIME format.

--------------ms010505020200080506090602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>> aplay -Dhw:0,0 sample.wav gives valid sound through spdif (though
>> limited), but aplay -Dhw:0,1 gives garbage on the same spdif output.
>> That doesn't look like an issue of aplay or the alsa lib, but a driver
>> issue.

> Ok, now I get to know about your tests, which program you used :)
> Still I don't know what is sample.wav, though.  It's 48kHz?
> You can try -Dspdif, too, BTW.

It's really really simple.

I generated wav files from /dev/zero using sox, with sample rates of 32
khz, 44.1 khz, 48 khz and 96 khz. Then I used simply aplay to play them all.

aplay -Dhw:0,0 test.wav

The wavs containing 44.1 and 48 khz play without a problem, BUT when
playing the 44.1 khz file, my DAT recorder still says it 48 khz and it
looks the audio is resampled somewhere. The 32 khz and 96 khz give a
message about sample rate not being available and then aplay selects
44.1 khz instead.

Then I did the same using -Dhw:0,2 (in the latest alsa versions this has
become hw:0,1) and the result is exactly the same (same wavs, same spdif
output,same dat recorder) EXCEPT there is a lot of noise through the
sound. I cannot believe this is a feature... This looks more like a
channels/bits/rate mismatch: one channel has audio AND noise, the other
channel is silent.

> Also, you can compare the proc file content between two states,
> i.e. during aplay -Dhw:0,0 and -Dhw:0,2.
> In addition, check the parameters printed via aplay -v option to see
> whether they are identical.

This is interesting. The 44.1 khz wav file is played by aplay using 44.1
khz, the pcm0p/sub0/hw_params also says it's 44.1 khz, still the DAT
recorder remains locked at 48 khz. Looks like at some point alsa fails
to set the actual output sample rate (spdif modulation)?

There is no difference in this behaviour wether I am using hw:0,0 or hw:0,2


--------------ms010505020200080506090602
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUTCC
AwMwggJsoAMCAQICEH7+jMMkILvfMGzj+Ok1nw8wDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MTAxMTA4MjIxMVoX
DTA3MTAxMTA4MjIxMVowajEQMA4GA1UEBBMHU2xhZ3RlcjEVMBMGA1UEKhMMRXJpayBNYXJ0
aWpuMR0wGwYDVQQDExRFcmlrIE1hcnRpam4gU2xhZ3RlcjEgMB4GCSqGSIb3DQEJARYRZXJp
a0BzbGFndGVyLm5hbWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDM5rtCRQmb
ZzxbezId4+cmqrIzzR8ZMxyPH4pMsrPLe1L9SwbzWZbPZZEY47tmeEJv4JZHo6FpSscXHj5Y
pk2i6l+u9HrvexKVZVo6bO8zEJGNWaWbE0Y/4wUhsvlQw8ssRMDNZb6YR3SADHgTtuPgChqj
DxX1jnQK+vFxk3s/ub55nOWjzRItqPWJNuRac5esv5DSR43TQm0YujoAXPnswzr2l1y4oCKQ
iPIrf5erlK60N4d9US3EPpCkByGyyYQ7IE75NB5E/kCfNV8g41bpJIB6sobCUl+faHozSD/c
AfrYhRNCj//LkG5q5EtKoKSFMKSZoVmwUsv77M/GJpXbAgMBAAGjLjAsMBwGA1UdEQQVMBOB
EWVyaWtAc2xhZ3Rlci5uYW1lMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAPF1+
u8w++Z8aqKBPN9yEHt+u/GC5cBHLTE0ltBuPKDdUr5POL1yrJsWsFgaj2/MPA2w+dF4dcZmz
7DKpClL2+06FdXmUa7hOzpw4HgS2riznlIT0KuobhDjxj9V/W1dzAp2NwwlsuIz60/t2w97b
5miMwlNioNq9CoXOIiSxI2EwggMDMIICbKADAgECAhB+/ozDJCC73zBs4/jpNZ8PMA0GCSqG
SIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTAeFw0wNjEwMTEwODIyMTFaFw0wNzEwMTEwODIyMTFaMGoxEDAOBgNVBAQTB1NsYWd0ZXIx
FTATBgNVBCoTDEVyaWsgTWFydGlqbjEdMBsGA1UEAxMURXJpayBNYXJ0aWpuIFNsYWd0ZXIx
IDAeBgkqhkiG9w0BCQEWEWVyaWtAc2xhZ3Rlci5uYW1lMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAzOa7QkUJm2c8W3syHePnJqqyM80fGTMcjx+KTLKzy3tS/UsG81mWz2WR
GOO7ZnhCb+CWR6OhaUrHFx4+WKZNoupfrvR673sSlWVaOmzvMxCRjVmlmxNGP+MFIbL5UMPL
LETAzWW+mEd0gAx4E7bj4Aoaow8V9Y50CvrxcZN7P7m+eZzlo80SLaj1iTbkWnOXrL+Q0keN
00JtGLo6AFz57MM69pdcuKAikIjyK3+Xq5SutDeHfVEtxD6QpAchssmEOyBO+TQeRP5AnzVf
IONW6SSAerKGwlJfn2h6M0g/3AH62IUTQo//y5BuauRLSqCkhTCkmaFZsFLL++zPxiaV2wID
AQABoy4wLDAcBgNVHREEFTATgRFlcmlrQHNsYWd0ZXIubmFtZTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBQUAA4GBADxdfrvMPvmfGqigTzfchB7frvxguXARy0xNJbQbjyg3VK+Tzi9c
qybFrBYGo9vzDwNsPnReHXGZs+wyqQpS9vtOhXV5lGu4Ts6cOB4Etq4s55SE9CrqG4Q48Y/V
f1tXcwKdjcMJbLiM+tP7dsPe2+ZojMJTYqDavQqFziIksSNhMIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCA2QwggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhB+/ozDJCC73zBs4/jpNZ8PMAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MTEyOTExMTgyOFowIwYJKoZI
hvcNAQkEMRYEFCvOvz6exhi3WSARJZo8Dj/raLtgMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQfv6MwyQgu98wbOP46TWfDzCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQfv6MwyQg
u98wbOP46TWfDzANBgkqhkiG9w0BAQEFAASCAQCUicqSmCqmPlwWqaWxKK9ieJ3CMBOBgM+E
XzZjWN71dBeWer82xlItqsFhJPiY9SIuagOeTulO7Bn6BEc173ZN8+fkzeJ48SZRj5e30Obv
Dk22LSnkGR18mG8sAjv0oGN9DgpoCmGyd+FyF/M3DAGPsi/35I6aOIbxM54c1dUjsdIeTKun
Q3wPyQJbjXXeLCIktWYnwlS5QQBa2togm3liSlCOxuBrmybKigL91KUfwHygZF3u/YwlQH/C
qaqkM9gcObpNxkLtneYcT8V8DrQkefrMCHksEhSd1IUhGHT0QUKf+26IfwONS6lsjm5ejBpV
RetLed3kAme4sb4fV4cVAAAAAAAA
--------------ms010505020200080506090602--


--===============1315522231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1315522231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1315522231==--
