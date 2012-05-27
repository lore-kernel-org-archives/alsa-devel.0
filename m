From: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Sun, 27 May 2012 22:59:25 +0200
Message-ID: <4FC295AD.1030901@mixxx.org>
References: <4FBFE0D5.8030501@mixxx.org> <4FC23123.8000702@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1163900327866780500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8A3CE24447
	for <alsa-devel@alsa-project.org>;
	Sun, 27 May 2012 22:59:32 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so1906585bkc.38
	for <alsa-devel@alsa-project.org>; Sun, 27 May 2012 13:59:32 -0700 (PDT)
In-Reply-To: <4FC23123.8000702@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============1163900327866780500==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms070406050503000007020608"

This is a cryptographically signed message in MIME format.

--------------ms070406050503000007020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello again.

On 05/27/2012 03:50 PM, Clemens Ladisch wrote:
> See the document "Writing an ALSA Driver", and look at the source code
> of other MIDI drivers, such as, for example, sound/usb/midi.c or the
> (untested) patch below.

Holy crap!! Thank you so much for that patch, Clemens! I just updated my =

kernel and tried it with the SCS.1m but unfortunately it reports an error=
:

firewire_ohci: isochronous cycle inconsistent
firewire_core: created device fw1: GUID 0012600000000000, S400
firewire_core: phy config: card 0, new root=3Dffc0, gap_count=3D5
snd_scs1x fw1.0: transaction failed: type error
snd_scs1x: probe of fw1.0 failed with error -5

Turning on the SCS.1d then yields:
firewire_core: phy config: card 0, new root=3Dffc2, gap_count=3D7
firewire_core: phy config: card 0, new root=3Dffc2, gap_count=3D7
firewire_core: created device fw2: GUID 0012600100000000, S400


I'm guessing the type error is around line 254 in scs1x.c, but where=20
does tcode come from? (I'm totally green with systems and Firewire=20
programming.) I glanced at the MIDI section of that "writing a driver"=20
PDF before I wrote to this list. I guess I'll go actually read it now. :)=


FYI, I'm now on kernel 3.2.18-rt23 #2 SMP PREEMPT x86_64.

> BTW: What is the output of "lsfirewire -v" for these devices?

device fw1:
   vendor ID: 0x001260
   model ID: 0x001000
   vendor: Stanton DJ
   model: SCS.1m
   guid: 0x0012600000000000
   units: 0x00a02d:0x010001
   unit fw1.0:
     model ID: 0x001000
     model: SCS.1m
     specifier ID: 0x00a02d
     version: 0x010001
device fw2:
   vendor ID: 0x001260
   model ID: 0x002000
   vendor: Stanton DJ
   model: SCS.1d
   guid: 0x0012600100000000
   units: 0x00a02d:0x010001
   unit fw2.0:
     model ID: 0x002000
     model: SCS.1d
     specifier ID: 0x00a02d
     version: 0x010001


bus 0, node 0: 080028:424296  Texas Instruments TSB41AB1/2
bus 0, node 1: 080028:424296  Texas Instruments TSB41AB1/2

I tried poking around with firewire-request read but didn't find=20
anything interesting. (Then again, I don't really know what I'm looking=20
at or for.)

Sincerely,
Sean M. Pappalardo
"D.J. Pegasus"
Mixxx Developer - Controller Specialist


--------------ms070406050503000007020608
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
DTEyMDUyNzIwNTkyNVowIwYJKoZIhvcNAQkEMRYEFBQZMKgaHuiuhF6jjK//85oHTAp2MF8G
CSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpAYJKwYBBAGCNxAE
MYGWMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UE
CxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAhc1MIGmBgsqhkiG
9w0BCRACCzGBlqCBkzCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgIXNTAN
BgkqhkiG9w0BAQEFAASCAQCA/fyexScCL9gJ8gIObHzAJAZDEk4BeP9WKEsSl58Pgsj91zXg
ai0xKmcnWyb8pgiOIy6swSAEOjN6vY/MrOlSnxG9q1V7QH81EUlJXCwb3kbsqqT0K7X5pSGl
kEq8hQvE1ykzRUiIAnKgneKEftgyD+YGxEN2KS4qnG7PmRtfLS+O6vHQ4mq3d9OWQYSjq0lp
Qpk50R/I9QTScFdpzA9C9Nf2V+zMcF16sqw06Mm7saBUBqdwezLa7cPJ+MNVoGxFLQs6VuHP
1P68NFsgw6DyVdQOahGTQICv2IrAgCseC3S0bFeNDP+RFra50EMCxPR0jHFg289IBzpR71r/
nat5AAAAAAAA
--------------ms070406050503000007020608--

--===============1163900327866780500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1163900327866780500==--
