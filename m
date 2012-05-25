From: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Subject: Help requested: new HSS1394 MIDI back-end
Date: Fri, 25 May 2012 21:43:17 +0200
Message-ID: <4FBFE0D5.8030501@mixxx.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8031111226226226646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E9090244B8
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2012 21:43:25 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so1046238bkc.38
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2012 12:43:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============8031111226226226646==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms040305060501010207020405"

This is a cryptographically signed message in MIME format.

--------------ms040305060501010207020405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello everyone.

I am a developer for Mixxx, GPL cross-platform digital DJ software:=20
http://www.mixxx.org. My focus is the controller subsystem. I am ready=20
to finally add Linux support for HSS1394 DJ controllers such as=20
Stanton's SCS.1m and SCS.1d.

HSS1394 is just MIDI over IEEE1394 (Firewire) at wire speed. The Windows =

and OSX library source code is LGPL and available on LaunchPad here:=20
https://launchpad.net/hss1394

The Stanton SCS.1m is a sound interface integrated with a two-way=20
control surface that speaks HSS1394. (The sound card uses an Oxford chip =

set and works fine with FFADO 2.0.1 today up to 96kHz. I use it with=20
Mixxx via JACK.)

The Stanton SCS.1d is a two-way control surface (no sound card) that=20
speaks HSS1394 and is capable of sending ALOT of latency-sensitive data: =

about 4000 messages per platter rotation. (Now imagine if you had four=20
or even two of them on the same network running at +50% speed. This=20
would quickly overwhelm USB, at least at the time these devices were=20
designed.)

Read about them here:
http://www.stantondj.com/stanton-controllers-systems/system1.html

After a lengthy discussion on the FFADO mailing list, we determined that =

the best (cleanest and most flexible) way to get Linux support for these =

devices is to write an ALSA kernel driver that speaks HSS1394 with the=20
devices and presents an ALSA MIDI device (with no data rate limits) for=20
each to Linux applications.

The advantage of doing this is that the devices will appear to all MIDI=20
applications without them having to have specific support for HSS1394.=20
This means they could be used in DAW applications as well.

(FWIW, FFADO trunk has a program called test-scs that does exactly this, =

but using that is impractical because it depends on various internal=20
parts of the FFADO source so would require bundling all of FFADO with=20
the application, and it's unable to see non-audio devices due to FFADO's =

intended use (so it sees the SCS.1m but not the .1d.))

So my questions are: where can I find documentation on writing a new=20
MIDI driver for ALSA? And is anyone else interested in helping me do this=
?

Thank you very much for your time and work. Help me take the last step=20
to my dream DJ setup! (Linux, FLAC and SCS.1 controllers.)

Sincerely,
Sean M. Pappalardo
"D.J. Pegasus"
Mixxx Developer - Controller Specialist


--------------ms040305060501010207020405
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIINtjCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIIHejCCBmKgAwIBAgICFzUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMTEwMDUwOTU4MjBa
Fw0xMzEwMDUwODI2MThaMIG+MSAwHgYDVQQNExc1Mjg2MjUtMkxtSDcwOVRWS3FBR1N4QjEL
MAkGA1UEBhMCVVMxETAPBgNVBAgTCE5ldyBZb3JrMRYwFAYDVQQHEw1TdGF0ZW4gSXNsYW5k
MSIwIAYDVQQKExlSZW5lZ2FkZSBUZWNobm9sb2dpZXMgREJBMRgwFgYDVQQDEw9TZWFuIFBh
cHBhbGFyZG8xJDAiBgkqhkiG9w0BCQEWFXNwYXBwYWxhcmRvQG1peHh4Lm9yZzCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAK1NNpr6hUJ8LOZMez9xHLjyZRYqeJz4Lp5+2dxd
slcNSxT7n/4wKzLdQiadXLeLKxBGy6OrGNZN2a2cO3+g/0vE3VvcgJJZVW8R7QX1qIaL8oSM
KcMj76LE/CHtzpYkyPDQipQXhgn6sRe0qvc4IfvOpkwtgpZ2p6kDFO+sl2a97N1Ep/wrS7h1
MMbaRqpi01jpls8FrysT8vcXzofqaj3S36vr8jdcmCTW4hDz2Si/YZ/jgvF1w7nv6n16Y9fl
avbhPqSQK4FHKDmRRwyBzVErGzb0MuaNlVlaGWj8a9qtVZa5OoDN+Sx0vnMbP5PJ8JuW/be0
SxzOyH1RTZu0z+ECAwEAAaOCA7AwggOsMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1Ud
JQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUUvDFTXcNxsN+0UNFTI/K3ZoX
m6swHwYDVR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswIAYDVR0RBBkwF4EVc3BhcHBh
bGFyZG9AbWl4eHgub3JnMIICIQYDVR0gBIICGDCCAhQwggIQBgsrBgEEAYG1NwECAjCCAf8w
LgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYB
BQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgfcGCCsG
AQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5U
aGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAyIFZh
bGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlh
bmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhl
IHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggrBgEFBQcCAjCBjzAnFiBTdGFydENv
bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRMaWFiaWxpdHkgYW5kIHdhcnJhbnRp
ZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdhbCBhbmQgTGltaXRhdGlvbnMiIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwu
c3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUH
MAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MyL2NsaWVudC9jYTBCBggr
BgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNzMi5jbGll
bnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkqhkiG
9w0BAQUFAAOCAQEALuOsKhJbsLicRnSPl4PMV5ZqM4mTi+qh5YZapOppBJLUuAvR0RsUN7n1
cOgAbSjnU0/9m7wA/Rm5rt4OWP1L+K6NMIem2Dh7ghP2qXmDia439ACksTxQU+IUhVQCg3ZT
Ama2VQSOCSM0IinfRk/h7f4bLqQ67OPN4ZeaPOHZs49V6xbIxn1GbfQkZ5hVC77zQsbN2Hx9
rKZfg0OlEos8fd3HnuB9IS1RthS7Cbz/BgyA/GX2ViEZjQEcgsXh70tEDQ/LA6OaTE7+4a5S
eDNRhvB5L0r3LQRgkWGQBGDwsL+M0isFmt4VSqIV62Ixx/zZhcknODotr585NfQ2NuFUvjGC
A80wggPJAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAhc1MAkG
BSsOAwIaBQCgggIOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTEyMDUyNTE5NDMxN1owIwYJKoZIhvcNAQkEMRYEFDdUKKsMWV+QErarz/XFFo0FT17MMF8G
CSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpAYJKwYBBAGCNxAE
MYGWMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UE
CxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAhc1MIGmBgsqhkiG
9w0BCRACCzGBlqCBkzCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgIXNTAN
BgkqhkiG9w0BAQEFAASCAQBpvJlPRLFk/a6UJEvDhWgQ9YDTktqsgRMj/7tyjPyidopMttAw
OoHEko6n32bswOpfraZH6gFSavBP9hZbOm4CC2UIV6zM7YO1xVQfa6fnc/dzhhbBSgFJBfR4
iAGXbp1J6sUYrePWTX1QqKO2Ct0FAMr6pzm8xw0J70cgYCWnKafpyMO6mA38xj48cnEb6UAF
bbJJZXY6Uml/nk59+AZYtvW+4GwTo+lkySdLLIcuYEWfMDN4h0wWwnx+0tBoxyC5Pp24sXdC
AwKU0ReLmRX/aR6N2rJ8Wqqkj8Z5sGYNTBu+//AhG8rRfK9coS+9kB2dzJ2UtNx8M83/qHgr
CRFQAAAAAAAA
--------------ms040305060501010207020405--

--===============8031111226226226646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8031111226226226646==--
