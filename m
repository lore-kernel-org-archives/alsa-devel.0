From: Erik Slagter <erik@slagter.name>
Subject: Re: SPDIF/IEC958 sample rate on HDA/ALC882
Date: Fri, 08 Dec 2006 14:55:55 +0100
Message-ID: <45796EEB.3050807@slagter.name>
References: <4548D24F.7080409@slagter.name> <s5hhcwj4u0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0680507119=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcwj4u0s.wl%tiwai@suse.de>
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

--===============0680507119==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms010807060409090202040501"

This is a cryptographically signed message in MIME format.

--------------ms010807060409090202040501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>> Maybe I am using the wrong "hw", there is also a "hw:0,2" device, which
>> I cannot make work properly at all (only one channel is output, large
>> chunks are discarded, much much clipping).

> The first PCM device is for the multi-output PCM.  It's for both
> analog and digital.  The dedicated SPDIF is the secondary one.

I've been experimenting at large yesterday, and I now I finally
understand what you mean by this sentence.

It appears that if you send output to hw:0,0 which comprises of
two-channel data AND the iec958 enable control is set to on, then the
hw:0,1 is also opened (returns "busy" on open) and the sound is sent to
that device simultaneously. If the amount of channels is other than 2,
then this scheme is not followed, and the secondary interface remains
available. If the iec958 enable control is set to false, none of the
hw:0,0 or hw:0,1 output data to spdif.

Is this intended behaviour? I think it is very very confusing. IMHO the
alsa lib has enough features to copy sound to both devices, when the
user actually wants that. And I don't! hw:0,0 should simply output to
analog en hw:0,1 to digital... At least the user should be able to
choose the behaviour using the iec958 enable control, being "on"
implementing the current "copying" behaviour and otherwise simply
exposing two independent devices.

Oh and BTW the bug I reported earlier on, with the hw:0,1 (digital)
interface giving noise in one channel, appears to be really a bug, with
a workaround, so it might be a simple one to resolve; if you output
sound to the device and toggle the iec958 control a few times, the noise
goes away and the interface works OK. Looks like an initialisation
problem to me...

This is all with vanilla linux 2.6.19 (alsa 1.0.13).

--------------ms010807060409090202040501
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MTIwODEzNTU1NVowIwYJKoZI
hvcNAQkEMRYEFHKw09doIAidGe+M/BSKsvNeAtOSMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQfv6MwyQgu98wbOP46TWfDzCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQfv6MwyQg
u98wbOP46TWfDzANBgkqhkiG9w0BAQEFAASCAQBql4yHVL2xPs+ZH/iH/c5J+Q9MVYRzeH/4
5oNeWAH0wiEA4VXCXsUCtJ/jEeZ49t22UwISUK/X/7w2Dt6gfOM+9GeAOwXox1PlZDmCGcNh
uFipx0CGq07E+3MEbc9sF4MV4cvkkBdKfECBLrb8Kw/qdOrjFOwTO8i7zPUNJsdAM3tfCqoK
WizURTC+E959RrbCzd5Tz4giJ4gxZ78qB0/cqw+/JB6gdt32S1MatmtvWtc1dK41gIz7Gxj7
fP/qMPEkJJ9vJkrFoHIVq4BvwQ0UMDpLpjsuXtJnhHKwYBN53MrWgngYifkz2kIp0oHYaImD
BNF8yZR6cwYtTwuEND5hAAAAAAAA
--------------ms010807060409090202040501--


--===============0680507119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0680507119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0680507119==--
