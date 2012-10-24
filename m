From: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Wed, 24 Oct 2012 13:49:38 +0200
Message-ID: <5087D5D2.6020208@mixxx.org>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>	<4FC5AC47.4060606@mixxx.org>	<4FC5C9C8.1000604@ladisch.de>
 <4FC7CDC1.8020606@ladisch.de>	<4FD2F324.7070402@mixxx.org>
 <4FD32E76.3090304@ladisch.de> <4FD49A51.3050809@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9159658027572125664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A062652E4
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2012 13:49:46 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so165605bku.38
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2012 04:49:46 -0700 (PDT)
In-Reply-To: <4FD49A51.3050809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============9159658027572125664==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms090705010005030906010702"

This is a cryptographically signed message in MIME format.

--------------ms090705010005030906010702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello again.

I'm very sorry for my absence. As usual with works of passion, life has=20
gotten in the way the past few months.

On 06/10/2012 03:00 PM, Clemens Ladisch wrote:
> New patch below.

This one seems to work perfectly with Mixxx! However, the amidi dump=20
still shows an extra 00 byte after every message:

F0 00 01 60 48 53 53 00 00 0F 09 02 0C 09 0A 05 0C F7
00
F0 00 01 60 48 53 53 00 00 0F 09 03 00 08 03 05 0C F7
00
F0 00 01 60 48 53 53 00 00 0F 09 03 04 06 0D 05 0C F7
00
80 20 00
    00
F0 00 01 60 48 53 53 00 00 0F 09 03 08 05 06 05 0C F7
00
F0 00 01 60 48 53 53 00 00 0F 09 03 0C 03 0F 05 0C F7
00
90 20 0D
    00
F0 00 01 60 48 53 53 00 00 0F 09 04 00 02 09 05 0C F7
00
F0 00 01 60 48 53 53 00 00 0F 09 04 04 01 02 05 0C F7
00
F0 00 01 60 48 53 53 00 00 0F 09 04 07 0F 0B 05 0C F7
00


We should probably fix that.

BTW, which ALSA version (and Linux kernel version) did the last patch go =

into, if any?

Sincerely,
Sean M. Pappalardo
"D.J. Pegasus"
Mixxx Developer - Controller Specialist


--------------ms090705010005030906010702
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
A9owggPWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAhc1MAkG
BSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTEyMTAyNDExNDkzOFowIwYJKoZIhvcNAQkEMRYEFLo1QbxCd2ySTq1Zq4VXE8vZJ7kfMGwG
CSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
gaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29t
IEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2
BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
AgIXNTCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQQICFzUwDQYJKoZIhvcNAQEBBQAEggEAAqZBRBR1WMfiJTmI6hv1Zah13ayWUvxp
K0fdKKlnDdT45bT+CVp/YxAipLaBX67Ku8PLoIpxBkJD+sYLI+r7Aeb5x7sMLZUFNXCHcGya
lDkL7xBW6bw4S5C4/KnD1xMarz9EKdoA4iTuMN1XYBJMkjjUQpIImwDwtAnaezig6SQHeJ6v
GHO87akC3g0HvIodpF8bb/rAVDOhTCxfqREzb57RYBnaW1aHkptkad1OI+nXgr/ofVWedZyp
/5g8m6gTAX7EI5aDOIMXO9pjdQc4bPNtoV1/fqk9FcXG/1fBCh12S0lO9Ae8BbzbfC34ZFlF
1ZP3t1Vo1LIlqK0Y4Z3zwwAAAAAAAA==
--------------ms090705010005030906010702--

--===============9159658027572125664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9159658027572125664==--
