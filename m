From: "Scott Parkerson" <Scott.Parkerson@ateb.com>
Subject: FW: Oops? Linux 2.4.19 + snd-usb-audio (ALSA 0.9.0-rc5)
Date: Fri, 22 Nov 2002 10:06:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <64AE3D5B518E3648ACC823FBCB0B7375F550BD@sr002-2kexc.ateb.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="----=_NextPart_000_0018_01C2920E.CA0926B0";
	micalg=SHA1;
	protocol="application/x-pkcs7-signature"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C2920E.CA0926B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
> Sent: Thursday, November 21, 2002 1:26 AM
> To: Scott Parkerson
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Oops? Linux 2.4.19 + snd-usb-audio 
> (ALSA 0.9.0-rc5)
> 
> I think that will happen with most PCMCIA and USB devices in
> linux. 

That may be true. However, it does not happen with the stock 2.4.19 USB
audio drivers. An unexpected hot removal does not cause an Oops to
occur. The application will usually get a write() error, and that's it.
This is much more desirable to have happen than an Oops, especially in a
production environment where a user might "accidentally" pull the plug.

> I think people will have to wait until kernel 2.5.x or above
> for better 
> plug-n-unplug support.

I disagree. I think the device drivers can be made to handle a case
where the device's mapped addresses have "disappeared" out from under
them. This kind of stuff is not necessarily operating system dependent
(although there may be some OS-dependent ways to check to see if the
hardware is "OK" before attempting to post a write or read. You can
cause the same crap to happen in Windows unless your driver is carefully
written.

> Maybe I am wrong, and it is just a co-incidence that all the
> devices I 
> have had bugs in the drivers.

I don't believe you are wrong. I just don't believe that it's a priority
for some developers to make sure that their drivers fail gracefully
under this condition. I mean, it's Linux -- isn't the audience "people
with a clue"? (sarcasm mine). Plus, most drivers are written for devices
that can't be hot plugged under most conditions (i.e. PCI adapters).

As for how all this relates to ALSA -- I don't know if it's up to ALSA
to check to see if a device is still there or not. It might be up to the
individual driver to handle it. 

Regards,
Scott

------=_NextPart_000_0018_01C2920E.CA0926B0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII+zCCAoow
ggHzoAMCAQICAwilxDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAyMTEwNjEzNDYyMFoXDTAzMTEwNjEzNDYyMFowSjEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEnMCUGCSqGSIb3DQEJARYYU2NvdHQuUGFya2Vyc29uQGF0ZWIuY29t
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDebEziup36Mixrt42wFG+rrcqtHAUlfLayPOPO
HT5j6uNYqwb3UdeSHxAlDoKoITnfGg39S779TlLUXVIIUt5f2G0X87+pFA6N7iQqWJsH5DfdchKz
SRTcMlqxQOncolY5FCrKL/a9CUMNoeA9CbQWT0snYz613JjeOrJzuWdnqwIDAQABozUwMzAjBgNV
HREEHDAagRhTY290dC5QYXJrZXJzb25AYXRlYi5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0B
AQQFAAOBgQBA8WlKAzMRpBM+Ux+Rvkt2Fx0GIPjdD4EYmfvCBrU3jxxif7zDhrG3v3qb4uoeRaE0
608xuf4QCdH8EP57dO+pHIGAFhMy8Q3QBoa8408JJqjqslLKidbUFQHGPPMhi+7Ug8DIGdFcymM8
St9zI7jHAYdPwxNkhZk69O6o4BBxpzCCAy0wggKWoAMCAQICAQAwDQYJKoZIhvcNAQEEBQAwgdEx
CzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEa
MBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2Vydmlj
ZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqG
SIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw05NjAxMDEwMDAwMDBaFw0y
MDEyMzEyMzU5NTlaMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0
aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANRp19SwlGRbcelH2AxRtupykbCEXn0tDY97Et+FJXUo
dDpCLGMnn5V7S+9+GYcdhuqj3bnOlmQawhRuRKx85o/oTQ9xH0A4pgCjh3j2+ZSGXq3qwF5269kU
o11uenwMpUtVfwYZKX+emibVars4JAhqmMex2qOYkf152+VaxBy5AgMBAAGjEzARMA8GA1UdEwEB
/wQFMAMBAf8wDQYJKoZIhvcNAQEEBQADgYEAx+ySfk749ZalZ2IqpPBNEWDQb41gWGGsJrtSNVwI
zzD7qEqWih9iQiOMFw/0umScF6xHKd+dmF7SbGBxXKKs3Hnj524ARx+1DSjoAp3kmv0T9KbZfLH4
3F8jJgmRgHPQFBveQ6mDJfLmnC8Vyv6mq4oHdYsM3VGEa+T40c53ooEwggM4MIICoaADAgECAhBm
RXK3zHT1z2N2RYTQLpEBMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMM
V2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0
aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVt
YWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAwMDAwWhcNMDQwODI3MjM1OTU5WjCBkjELMAkGA1UE
BhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQK
EwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25h
bCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMzKm
Y8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSptcDz63K737nRvMLwzkH/5NHGgo22Y8cNPomXbDfpL
8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzpq+AYA6h8Q0JQUYeDPPA5tJtUihOH/7ObnUlm
AC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVs
MS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEEBQADgYEA
MbFLR135AXHl9VNsXXnWPZjAJhNigSKnEvgilegbSbcnewQ5uvzm8iTrkfq97A0qOPdQVahs9w2t
TBu8A/S166JHn2yiDFiNMUIJEWywGmnRKxKyQF1q+XnQ6i4l3Yrk/NsNH50C81rbyjz2ROomaYd/
SJ7OpZ/nhNjJYmKtBcYxggNpMIIDZQIBATCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwAgMIpcQwCQYFKw4DAhoFAKCCAiQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMDIxMTIyMTUwNjEzWjAjBgkqhkiG9w0BCQQxFgQU1PcTErPmAl46YIhooiw8
0N2Pfv8wZwYJKoZIhvcNAQkPMVowWDAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwBwYFKw4DAhowCgYIKoZIhvcNAgUwgasG
CSsGAQQBgjcQBDGBnTCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRl
IFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMIpcQw
ga0GCyqGSIb3DQEJEAILMYGdoIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlm
aWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwilxDANBgkqhkiG9w0BAQEFAASBgGxVBsDMJQBl+UdclbZgi+ORH92sRRcHo7xQxGV1DIhAZy7x
xLhJ3lkjsyXYANG1PUAOzmXgkarFRyI3W/SDRwjNYfGEXFx3zP5NRRh4+VCPrfzr7JTLXQL2vgBw
HezvDUaO/3DgQUdYLD9qh6spQeKzH8GFoYjk10VekL8P3BRiAAAAAAAA

------=_NextPart_000_0018_01C2920E.CA0926B0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
