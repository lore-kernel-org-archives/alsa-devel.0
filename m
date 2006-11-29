From: Erik Slagter <erik@slagter.name>
Subject: Re: SPDIF/IEC958 sample rate on HDA/ALC882
Date: Wed, 29 Nov 2006 11:41:13 +0100
Message-ID: <456D63C9.5080605@slagter.name>
References: <4548D24F.7080409@slagter.name>	<s5hhcwj4u0s.wl%tiwai@suse.de>	<456C35F5.5070808@slagter.name>	<s5hd5774onm.wl%tiwai@suse.de>	<456C8316.30309@slagter.name>
	<s5h64cy4kis.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0899592047=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64cy4kis.wl%tiwai@suse.de>
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

--===============0899592047==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms010400050103060305060309"

This is a cryptographically signed message in MIME format.

--------------ms010400050103060305060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>> Also I really don't get the relationship between the sample rate of the
>> wav file I'm using for testing (with aplay) and iecset. I'd expect that
>> aplay would set the sample (locking) rate of the spdif interface to the
>> sample frequency as the wav file, what is the use of iecset (rate) then?
>> I am using hw:0,0 to really avoid software resampling.

> Well, still I didn't write what you did and what you got...

Spotted well, it takes some time to recreate the complete test suite.

I will have a go once more with newer alsa libs/utils and then submit
the results. I wasn't too eager before because I didn't get any reply
for weeks...

>>>>>> Maybe I am using the wrong "hw", there is also a "hw:0,2" device, which
>>>>>> I cannot make work properly at all (only one channel is output, large
>>>>>> chunks are discarded, much much clipping).
>>>>> The first PCM device is for the multi-output PCM.  It's for both
>>>>> analog and digital.  The dedicated SPDIF is the secondary one.
>>>> But why does the second interface gives _some_ (although wrong) output
>>>> on my spdif output then?
>>> No idea, possibly wrong parameters are passed.
>> By whom or what? Actually I don't care that much, but it looks like a
>> bug to me.
> Possibly.  But too little information to analyze.

I think you're misunderstanding me here.

aplay -Dhw:0,0 sample.wav gives valid sound through spdif (though
limited), but aplay -Dhw:0,1 gives garbage on the same spdif output.
That doesn't look like an issue of aplay or the alsa lib, but a driver
issue.

>> [ rate bitfields in proc #codec# output ]
> Try HG version, and you'll see what they mean better.

The driver version in the kernel is kind of recent, so I really doubt
that. If you can give me a pointer to a file that has defines or enums,
that actually resolve to numbers, for this bitfield, I'd be obliged.


--------------ms010400050103060305060309
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MTEyOTEwNDExM1owIwYJKoZI
hvcNAQkEMRYEFFNiS/xkSkTAnxBwd09bNgaPfaVXMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQfv6MwyQgu98wbOP46TWfDzCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQfv6MwyQg
u98wbOP46TWfDzANBgkqhkiG9w0BAQEFAASCAQAJFlTaLOk1q832hN42IJn2QpfHy/5evfGz
KNt67VGvEl9BU4QPhSiZ37biPJ+6BB1+2Giz5rHZ79EGrcOQaFAssLPkwPJ1ASQItivaBUyq
oXNMGkg5jt1Qf6UNXZYTC99fvlNW7VgQHl0aQ+Z7MXrWc8AokR9w1rlJVfw47hRCLMsnDojK
RBJ8Sd7l6yLxGLrItRwlPUMxfd88xI2T5gPF0A0m64ZkiACTsuADg69njrAEAgqc5up+qxo/
q7V2cly9KEgjcZTePWnwVUDF50eyq/W4hJVubPtFAo1lyT+OUfvbWGSvnq5D9sP9R/QHowvk
Me7UpcM63ua/BIE0E5r+AAAAAAAA
--------------ms010400050103060305060309--


--===============0899592047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0899592047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0899592047==--
