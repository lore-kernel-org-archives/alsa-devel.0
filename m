From: =?ISO-8859-1?Q?Christian_Rothl=E4nder?= <Mailinglisten@rothlaender.net>
Subject: es1968 suspend2ram problem
Date: Tue, 05 Feb 2008 19:11:30 +0100
Message-ID: <47A8A6D2.6060106@rothlaender.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3111336523379280349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by alsa0.perex.cz (Postfix) with ESMTP id E641524453
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 19:11:35 +0100 (CET)
Received: from [10.0.10.1]
	(HSI-KBW-085-216-074-109.hsi.kabelbw.de [85.216.74.109])
	by post.webmailer.de (klopstock mo20) (RZmta 16.5)
	with ESMTP id z03316k15GLpva for <alsa-devel@alsa-project.org>;
	Tue, 5 Feb 2008 19:11:35 +0100 (MET)
	(envelope-from: <Mailinglisten@rothlaender.net>)
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

--===============3111336523379280349==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040207030806010407080303"

This is a cryptographically signed message in MIME format.

--------------ms040207030806010407080303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi there

I got suspend2ram working on my desktop machine, using a terratec dmx (quite old, but rock-solid hardware mixing) with
es1878 Chipset.

If I'm unloading the module before hibernation and reload after wakeup everything works (thought kmix and kradio are
being closed, which is a bit stupid). If I'm trying to suspend with the module loaded no sound output is possible after
wakeup (mixer still there). An alsasound restart won't bring the soundcard up again (no mixer, no nothing).

Tried this with kernel 2.6.22 buildin alsa as well as the freshest HG tree.
System is Gentoo.

Any ideas where to search for that problem? Looks like a bug to me.

Christian


--------------ms040207030806010407080303
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILazCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggQQMIIDeaADAgECAhAxa+BCph4YlQEotIix9eDZ
MA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wNzA3MTAwODUzMzhaFw0wODA3MDkwODUzMzhaMIIBBTEUMBIGA1UEBBML
Um90aGxhZW5kZXIxEjAQBgNVBCoTCUNocmlzdGlhbjEeMBwGA1UEAxMVQ2hyaXN0aWFuIFJv
dGhsYWVuZGVyMSgwJgYJKoZIhvcNAQkBFhlDaHJpc3RpYW5AUm90aGxhZW5kZXIubmV0MSww
KgYJKoZIhvcNAQkBFh1NYWlsaW5nbGlzdGVuQHJvdGhsYWVuZGVyLm5ldDE9MDsGCSqGSIb3
DQEJARYuY2hyaXN0aWFuLnJvdGhsYWVuZGVyQHN0dWRlbnQudW5pLXR1ZWJpbmdlbi5kZTEi
MCAGCSqGSIb3DQEJARYTYXNkYmlnbWFjQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMUxJiHXCgGlqm9f2zsAkIuKp/f/58wgMnpyqRFErBcTMcFP5SFjlP1+
Jtf8aOgB8zsoIKDpnnznN8mIF/j14/A9pi/CSKtDAo6sITWKewdSvQzmMlzS6hCFRnzznaQ8
6LFXYFSwEHygPraG9AneAJSAn556YgJCETDerP6uJL2Ak6CY1mA74BXEsSAojMhcSNMiJuDS
NEO26dk9riVVwjRS4oaeS57lOL84p6huLHAdz5u9Tpxn01WT0oZwEF86tzfgznjH+0KMabqZ
d1J4zu8Iy92xUDV+/Ufu38oCgyRDd95ZlJ1iopLKwNNsic6knievIstUzLX4L/gFy3anPv0C
AwEAAaOBnTCBmjCBiQYDVR0RBIGBMH+BGUNocmlzdGlhbkBSb3RobGFlbmRlci5uZXSBHU1h
aWxpbmdsaXN0ZW5Acm90aGxhZW5kZXIubmV0gS5jaHJpc3RpYW4ucm90aGxhZW5kZXJAc3R1
ZGVudC51bmktdHVlYmluZ2VuLmRlgRNhc2RiaWdtYWNAZ21haWwuY29tMAwGA1UdEwEB/wQC
MAAwDQYJKoZIhvcNAQEFBQADgYEAbnU58t4Fv9lNeMsx+RJXgbOzS2g2y7p+qbi2uf2PhjGR
iTVocMJ6nKEnfSTRi6Bmt9+3vjDlSOYaj1LtyrC+u1ziE6NV+bQzbBUVheD5nggyiqkPwMGp
qP5n7zuwzsPGkTRlOSuPBn8vbd4wvJswTAsLGb6k6HrvZLAFHugcc8EwggQQMIIDeaADAgEC
AhAxa+BCph4YlQEotIix9eDZMA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYD
VQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNzA3MTAwODUzMzhaFw0wODA3MDkwODUz
MzhaMIIBBTEUMBIGA1UEBBMLUm90aGxhZW5kZXIxEjAQBgNVBCoTCUNocmlzdGlhbjEeMBwG
A1UEAxMVQ2hyaXN0aWFuIFJvdGhsYWVuZGVyMSgwJgYJKoZIhvcNAQkBFhlDaHJpc3RpYW5A
Um90aGxhZW5kZXIubmV0MSwwKgYJKoZIhvcNAQkBFh1NYWlsaW5nbGlzdGVuQHJvdGhsYWVu
ZGVyLm5ldDE9MDsGCSqGSIb3DQEJARYuY2hyaXN0aWFuLnJvdGhsYWVuZGVyQHN0dWRlbnQu
dW5pLXR1ZWJpbmdlbi5kZTEiMCAGCSqGSIb3DQEJARYTYXNkYmlnbWFjQGdtYWlsLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMUxJiHXCgGlqm9f2zsAkIuKp/f/58wg
MnpyqRFErBcTMcFP5SFjlP1+Jtf8aOgB8zsoIKDpnnznN8mIF/j14/A9pi/CSKtDAo6sITWK
ewdSvQzmMlzS6hCFRnzznaQ86LFXYFSwEHygPraG9AneAJSAn556YgJCETDerP6uJL2Ak6CY
1mA74BXEsSAojMhcSNMiJuDSNEO26dk9riVVwjRS4oaeS57lOL84p6huLHAdz5u9Tpxn01WT
0oZwEF86tzfgznjH+0KMabqZd1J4zu8Iy92xUDV+/Ufu38oCgyRDd95ZlJ1iopLKwNNsic6k
nievIstUzLX4L/gFy3anPv0CAwEAAaOBnTCBmjCBiQYDVR0RBIGBMH+BGUNocmlzdGlhbkBS
b3RobGFlbmRlci5uZXSBHU1haWxpbmdsaXN0ZW5Acm90aGxhZW5kZXIubmV0gS5jaHJpc3Rp
YW4ucm90aGxhZW5kZXJAc3R1ZGVudC51bmktdHVlYmluZ2VuLmRlgRNhc2RiaWdtYWNAZ21h
aWwuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAbnU58t4Fv9lNeMsx+RJX
gbOzS2g2y7p+qbi2uf2PhjGRiTVocMJ6nKEnfSTRi6Bmt9+3vjDlSOYaj1LtyrC+u1ziE6NV
+bQzbBUVheD5nggyiqkPwMGpqP5n7zuwzsPGkTRlOSuPBn8vbd4wvJswTAsLGb6k6HrvZLAF
Hugcc8ExggNkMIIDYAIBATB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIQMWvgQqYeGJUBKLSIsfXg2TAJBgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wODAyMDUxODExMzBaMCMGCSqGSIb3
DQEJBDEWBBQm7ymNUXXzgGB5e44oJXjhRTvywDBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0ECEDFr4EKmHhiVASi0iLH14NkwgYcGCyqGSIb3DQEJEAILMXigdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDFr4EKmHhiV
ASi0iLH14NkwDQYJKoZIhvcNAQEBBQAEggEALq6BidxKgYxPPUqWANVfsMu2QIGtox98QrVO
jhaxJoPs3p8+Zg3XzZXiFas8XZ1hTv/shlq6SUxtd6LxYiI9gUc/8E14m+vTICg3n754/39f
xcbQQ5kUXakEvkXAyrpeKtcLRpnUf8s+1ePtX/Nd+ghGi6L02Ld18AJXmjpQClpO8EaUH7sn
9AntBqDh2KJQITt8/ZH8NYCVU4FLeCIDGBPkceYRYI+14mLsJejy4dflbiqhR5Ej76+BjJRs
EkDz8fSSOE7CIvt6+4uzQqY6rBjOwQA4s8aB8IGw5izCP8xoJ067pTAvLsmMPGdSwa9RgNsn
rAcSP6QNYifFCyQvnwAAAAAAAA==
--------------ms040207030806010407080303--

--===============3111336523379280349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3111336523379280349==--
