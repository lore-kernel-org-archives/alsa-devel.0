From: Denis Washington <denisw@online.de>
Subject: [PATCH 1/2] Enable S/PDIF on the ASUS Xonar U3
Date: Tue, 11 Dec 2012 11:38:32 +0100
Message-ID: <50C70D28.70804@online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907389391594717774=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C332602F4
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 11:38:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--===============7907389391594717774==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010005090702060907060605"

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms010005090702060907060605
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

The only required change is to extend the existing Xonar U1
mixer quirks to the U3, which seems to be controlled the same
way.
---
  sound/usb/mixer_quirks.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ae2b714..2223089 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1107,8 +1107,9 @@ int snd_usb_mixer_apply_create_quirk(struct=20
usb_mixer_interface *mixer)
  		err =3D snd_ftu_create_mixer(mixer);
  		break;

-	case USB_ID(0x0b05, 0x1739):
-	case USB_ID(0x0b05, 0x1743):
+	case USB_ID(0x0b05, 0x1739): /* ASUS Xonar U1 */
+	case USB_ID(0x0b05, 0x1743): /* ASUS Xonar U1 (2) */
+	case USB_ID(0x0b05, 0x17a0): /* ASUS Xonar U3 */
  		err =3D snd_xonar_u1_controls_create(mixer);
  		break;

--=20
1.8.0



--------------ms010005090702060907060605
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIINSjCC
BjQwggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDE1NVoXDTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOr
lr6KMoOMpohBllVHrdRvEg/q6r8jR+EK75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSM
zR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6
qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxDz2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSD
kOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr/+N2JLKutIxMYqQOJebr/f/h5t95
m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFcfH6WNU7y1LhRgjAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqD
CH14qywGXLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy
6QMVQjbbMXltUfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPI
zKKR9tQW8gGK+2+RHxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKf
KSETEPrHh7p5shuuNktvsv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HOR
z9v3vQwR4e3ksLc2JZOAFK+ssS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9
sIPP7ON0fz095HdThKjiVJe6vofq+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCie
uoBJ9OlqmsVWQvifIYf40dJPZkk9YgGTzWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7t
w1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGqUp/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQ
G2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb19mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t
5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIHDjCCBfagAwIBAgIDA7lZMA0GCSqGSIb3DQEB
BQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMi
U2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20g
Q2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcNMTIwMjE0MTAwNTA4
WhcNMTMwMjE0MTgzOTI3WjBXMRkwFwYDVQQNExBMNmdGeFExWHdaeXRGN1lxMRkwFwYDVQQD
DBBkZW5pc3dAb25saW5lLmRlMR8wHQYJKoZIhvcNAQkBFhBkZW5pc3dAb25saW5lLmRlMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmAhzvlayB5uCi6VNrgC7OFelwcFCpjY6
1TV+7tW4Ty/UaO3GGGxT9VHvKTwrM26zR2yn0HGGeHPmEAjOYykM7ECdm9ngsEYgHeD6bFoU
nmTe++7hFFYpt45WBvRK3nNXwUWOCsNbdk8xJ3zKYg33dAC1ElgxDa7LVUbsUQs2KZs7POsN
eglKYbwJ+pf7KJDtUi03I+uePDD1tyL4V79kuJuWn+TDCt8aNRPrcnCm0upeo4zKIGbjRyg3
6dt8/f0Z0j0B1tCsxW+tJNYAuNW1wcd+uFtnK7naqE0H0yKWrWMKDoEH1kEBRXmqOyZh0z6A
MckT1d9koDI17rM8EWUsqwIDAQABo4IDqzCCA6cwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTpR41raZ+/vaajVNrE
9QzD1rGCUDAfBgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAbBgNVHREEFDASgRBk
ZW5pc3dAb25saW5lLmRlMIICIQYDVR0gBIICGDCCAhQwggIQBgsrBgEEAYG1NwECAjCCAf8w
LgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYB
BQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgfcGCCsG
AQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5U
aGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZh
bGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlh
bmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhl
IHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggrBgEFBQcCAjCBjzAnFiBTdGFydENv
bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRMaWFiaWxpdHkgYW5kIHdhcnJhbnRp
ZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdhbCBhbmQgTGltaXRhdGlvbnMiIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwu
c3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUH
MAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MxL2NsaWVudC9jYTBCBggr
BgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNzMS5jbGll
bnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkqhkiG
9w0BAQUFAAOCAQEAq7F/lnxjk1g3NoypFR6OPukxeatCRGwayef2zSqZUDD2rR+zImknVpwE
Xu9q17bxfsb/TtP2ZP+eBh+8L8IBml78Twnn7pIUW8MHazbqNOz+bVgyxZRnMjQGKpy+P74T
dIm38z5aqQSL2tOpAQHxA0kBZFMF/5egW92oCkg66MA9zoz2ZVU342/E4Lt/CMYUfHeU4y6Y
4pR/qcMfu2zmeGi6kC/hHKDcB6ZAksl74GxkeGZIDpYbvzD6uvgCIJm/mjFFIJJGLG9MNezG
uWDLLpjsMbShkmJ3DjHMarrrEJzqcY3hwEL5ZkSpCYDs2DJEQGlglOvUeoZ7BnJ10Muj8jGC
A90wggPZAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwO5WTAJ
BgUrDgMCGgUAoIICHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xMjEyMTExMDM4MzJaMCMGCSqGSIb3DQEJBDEWBBQXMC5nT6FmVLxqqVZ6fsEKJJvfDjBs
BgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENv
bSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBD
QQIDA7lZMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBAgMDuVkwDQYJKoZIhvcNAQEBBQAEggEAGQyKpj/cSoATCSb2s+jWoYdV3+cB
bOqGBgb/lc8S5NU3LYcW4uCPUXyzL/ckwLyu3dj/bcnCPABPeuX26iIJblbRyGjLH6F15uKF
t4hfewU6AHxCaevzo0GYLl9wGDqErbzEGN/kki35010PHYBHRgSm1Dl+RNU803jnb2nG3d+g
ZP96emFnwj5IC6X0SgkQnUCV5ulojGVUhXklpzSVi5a7Z089oyfOsiGGGyC/6uMl8Ls4dJYV
PDFYCaeJbvgzO92vpZKsO59xFny+0DWSEOBVUpETiZgY7dtfbneVPfWjfqxZxx3aQZWS1NfB
m4KpezH04o0KZoUKri44+oyeIAAAAAAAAA==
--------------ms010005090702060907060605--

--===============7907389391594717774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7907389391594717774==--
