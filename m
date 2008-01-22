From: Rick Measham <rick@measham.id.au>
Subject: Re: =?utf-8?q?1=2E0=2E16rc1_release_--_error=3A_?=
 =?utf-8?b?4oCYc3lzdGVtX3V0c25hbWXigJkgdW5kZWNsYXJlZA==?=
Date: Wed, 23 Jan 2008 06:25:54 +1100
Message-ID: <47964342.1060608@measham.id.au>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1464785885252386233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from argentum.mailguard.com.au (argentum.mailguard.com.au
	[69.16.232.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 31BBA103815
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 20:25:58 +0100 (CET)
Received: from argentum.mailguard.com.au (localhost [127.0.0.1])
	by argentum.mailguard.com.au (Postfix) with ESMTP id F07FB89C47E
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 06:25:56 +1100 (EST)
Received: from [10.0.1.104] (218-214-148-59.people.net.au [218.214.148.59])
	by argentum.mailguard.com.au (Postfix) with ESMTP id 643C089C40F
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 06:25:55 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
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

--===============1464785885252386233==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080504010602070106080600"

This is a cryptographically signed message in MIME format.

--------------ms080504010602070106080600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela wrote:
> 	1.0.16rc1 release is available for download on=20

Running Kubuntu:

# uname -a
Linux lugtop 2.6.20-16-386 #2 Sun Sep 23 19:47:10 UTC 2007 i686 GNU/Linux=



During the make:

In file included from=20
/usr/src/alsa/alsa-driver-1.0.16rc1/acore/info_oss.c:7:
/usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:=
=20
In function =E2=80=98snd_sndstat_proc_read=E2=80=99:
/usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:=
96:=20
error: =E2=80=98system_utsname=E2=80=99 undeclared (first use in this fun=
ction)
/usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:=
96:=20
error: (Each undeclared identifier is reported only once
/usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:=
96:=20
error: for each function it appears in.)
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.16rc1/acore/info_oss.o] Error=
 1
make[2]: *** [/usr/src/alsa/alsa-driver-1.0.16rc1/acore] Error 2
make[1]: *** [_module_/usr/src/alsa/alsa-driver-1.0.16rc1] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.20-16-386'
make: *** [compile] Error 2


Cheers!
Rick Measham


--------------ms080504010602070106080600
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJBzCC
At4wggJHoAMCAQICEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloX
DTA4MDYyNzA2NTAwMlowRDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8G
CSqGSIb3DQEJARYScmlja0BtZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAwOurNHlazx8aZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7
P4KZAc9Rsfqg+E4hqPVaO7P6gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DO
oTJqhJwiv2AVzE2tV+71ikGB0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pi
d+idUA4oHN0IdS6j2h9R3tzH8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+
PtYRXeVZpontx/21IRpP7NQ0taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQAB
oy8wLTAdBgNVHREEFjAUgRJyaWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQUFAAOBgQABki3vumGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8Va
PEI9lRnfry/L8muvvnf6k5pk5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUo
I9rdUo6gAHiLqjx3mqZq3nrk9xC8s3PYMnmkUgxzuK1dcjCCAt4wggJHoAMCAQICEHahvhsV
L0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloXDTA4MDYyNzA2NTAwMlowRDEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8GCSqGSIb3DQEJARYScmlja0Bt
ZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwOurNHlazx8a
ZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7P4KZAc9Rsfqg+E4hqPVaO7P6
gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DOoTJqhJwiv2AVzE2tV+71ikGB
0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pid+idUA4oHN0IdS6j2h9R3tzH
8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+PtYRXeVZpontx/21IRpP7NQ0
taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQABoy8wLTAdBgNVHREEFjAUgRJy
aWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQABki3v
umGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8VaPEI9lRnfry/L8muvvnf6k5pk
5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUoI9rdUo6gAHiLqjx3mqZq3nrk
9xC8s3PYMnmkUgxzuK1dcjCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEa
MBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2Vy
dmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcw
MDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065ypla
HmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FW
y688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEE
QB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2
oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3Js
MAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0x
MzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9l
X5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggNkMIIDYAIBATB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdqG+GxUv
SrLUJ073sqe23DAJBgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wODAxMjIxOTI1NTRaMCMGCSqGSIb3DQEJBDEWBBS16TDo4MYTb07q
xn28Bwty9N3svjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAE
MXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHah
vhsVL0qy1CdO97KnttwwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcN
AQEBBQAEggEAa+V/tonkE7NYlEKqGWzzCt4N4tFm2b7rog5aRbM4IYRQEfgDQSF21/XiKZxl
4VF12pg/cg9GCypB+JhE0xEuFJZdomHF9KYUYAdPOM3/o3o+qd462HsIh/zkYJrPPwgn+95h
Y/IvjUbJP89Y2b+2Xhdt2XRTFuBks7hTJsotUAQjq5BbfQm28vZO5++G7NqZ8M8XsnVRRl85
AcLm/NuYyNJxflePNKbdfdPCkUyeMNSPHm2luecexHz8fP+sZUqN35RZMyznIiC49vhHiZum
D9JV8vznxnafTMYAuSP23eng88d4I7EZUkybIVsJHSf27rJAgGFKibvvAZ7YpR+CXgAAAAAA
AA==
--------------ms080504010602070106080600--

--===============1464785885252386233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1464785885252386233==--
