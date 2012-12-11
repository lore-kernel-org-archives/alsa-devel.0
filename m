From: Denis Washington <denisw@online.de>
Subject: [PATCH 0/2] Make ASUS Xonar U3 S/PDIF channel
	accessible
Date: Tue, 11 Dec 2012 11:37:26 +0100
Message-ID: <50C70CE6.4070606@online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1171889357136353831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3019B260309
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 11:37:31 +0100 (CET)
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

--===============1171889357136353831==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010508040602030206040705"

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms010508040602030206040705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

This is my first ALSA patch ever (in fact, also my first kernel patch=20
and my first e-mail to this mailing list); as such, I'm sorry when I did =

something wrong and/or didn't follow the procedure properly. I hope you=20
can forgive me.

I recently bought an ASUS Xonar U3 USB audio card. It general it works=20
well with Linux, but unfortunately, it's PCM output channel is unusable=20
for headphones because it allows virtually no volume control (maximum=20
loudness is already reach at a volume level of 2 or 3). The card does=20
also have a digital (S/PDIF) output channel, which however isn't=20
switched on by the Linux USB audio driver:

http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg28970.html=


When I boot into Windows (where the ASUS driver seemingly enables the=20
channel) and then reboot into Linux, I can use this channel and control=20
volume as expected. It's just this turning on of S/PDIF which is=20
missing, as suggested by the alsa-user thread linked to above.

The patchset that follows enables S/PDIF on the Xonar U3 by using the=20
(seemingly compatible) mixer quirks code as for the U1, just as done and =

tested by the initiator of the alsa-user thread, together with a very=20
minor cleanup (renaming internal xonar_u1_* identifiers to just=20
xonar_u_*). The change seems to work well (tested with the 3.7.0 Ubuntu=20
kernel as found in today' daily version).

Regard,
Denis Washington


--------------ms010508040602030206040705
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
Fw0xMjEyMTExMDM3MjZaMCMGCSqGSIb3DQEJBDEWBBSxEoZRDasJ/12dU8GMOTac8Kb7ZzBs
BgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENv
bSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBD
QQIDA7lZMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBAgMDuVkwDQYJKoZIhvcNAQEBBQAEggEAPGV4NcNkuQgWpnQY82pB/TZ2RVBW
EzbhFB36ApJTPjMI9Sn+kEPAWdYcFOJo97i0mEi5A+MFOK3X9fg0VWRidzAcE9e8IabxJEp9
c/9cxF6UoXDHOfoQ4OSu7knxiYTpOXHU89MFekCM3tDPrH0nXl8uTgT8YrA/cRoTSTltCYiW
DvTD3m718StUQa+JdXGtSwgknXQ/j/IMUVQ3d7OCSzw0F/6HZI/3WoS4t7dQIhs/WiiI1qQ/
i1E4pUEfx1SXkSEscIyQmX/+UmgS7r5flHpfTOFRetgs+Tmlw4klvO1q6kIW0Zdfk3rnRlBR
u5l0AzMeKrMgszhFv3HmOptbAAAAAAAAAA==
--------------ms010508040602030206040705--

--===============1171889357136353831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1171889357136353831==--
