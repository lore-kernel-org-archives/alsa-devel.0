From: =?ISO-8859-1?Q?Christian_Rothl=E4nder?= <Mailinglisten@rothlaender.net>
Subject: Re: [PATCH] SM56 Modem in Asus A8J Notebook Series
Date: Fri, 18 May 2007 16:45:40 +0200
Message-ID: <464DBC14.3080308@rothlaender.net>
References: <464DA751.5010705@rothlaender.net>	<s5hr6pemdcq.wl%tiwai@suse.de>	<464DB5E8.202@rothlaender.net>
	<s5hmz02mce9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6468350940457630953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by alsa0.perex.cz (Postfix) with ESMTP id DD5E324385
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 16:45:39 +0200 (CEST)
Received: from [10.0.10.1]
	(HSI-KBW-085-216-074-109.hsi.kabelbw.de [85.216.74.109])
	by post.webmailer.de (mrclete mo50) (RZmta 6.5)
	with ESMTP id B04368j4IDvjMi for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 16:45:39 +0200 (MEST)
In-Reply-To: <s5hmz02mce9.wl%tiwai@suse.de>
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

--===============6468350940457630953==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040002080602030201040000"

This is a cryptographically signed message in MIME format.

--------------ms040002080602030201040000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> > It's a process to merge to the upstream kernel.  We need to give a
> > kind of approval from the patch authors and contributors.
> > It consists of a line

ok .. something new for me  :-)
Here it goes:

Signed-off-by: Christian Rothlaender <christian@rothlaender.net>

================================================================
hda-codec - patch_si3045.c

This patch adds support for the ASUS A8J Series 56k Modem (Motorola SM56)

Signed-off-by: Christian Rothlaender <christian@rothlaender.net>

THE PATCH STARTS BELOW
================================================================


> Just a small issue is left. With the alsa driver buildin into 2.6.19
> slmodem is working, with any newer one (either
> standalone or buildin driver) we have a "hda-intel: invalid
> format_val, rate=9600, ch=1, format=2" error in dmesg. Seems
> something has been broken on that step (probably 1.0.13 to
> 1.0.14?). Sadly I'm not able to tell right now which alsa was
> included into 2.6.19. I'm trying to compare the files to get an idea
> what's wrong (#2799 and #2820 are reporting similar
> problems).
> >
> > This should have been fixed in the recent version.
> > The driver dropped the support of 9600HZ accidentally.

That's really good to hear. Can you close the Bug entry #2732 then?
(#2799 and #2820 can be closed too, if the 9600 Hz problem is solved)

So thanks a lot ...

Christian

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGTbwUYMBp7Qf+VpkRApyKAJ4xfBkrLiG1D7whZIV1CteUTRhFagCfd/LU
2jeMsy1MQ/WxX5A7P/iThjM=
=A9s6
-----END PGP SIGNATURE-----

--------------ms040002080602030201040000
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILXTCC
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
NU1341YheILcIRk13iSx0x1G/11fZU8wggQJMIIDcqADAgECAhAxOFXG3lIzEWoE4+oH6KIK
MA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wNjA3MDkwOTQ0MjNaFw0wNzA3MDkwOTQ0MjNaMIIBAjEUMBIGA1UEBBML
Um90aGxhZW5kZXIxEjAQBgNVBCoTCUNocmlzdGlhbjEeMBwGA1UEAxMVQ2hyaXN0aWFuIFJv
dGhsYWVuZGVyMSgwJgYJKoZIhvcNAQkBFhlDaHJpc3RpYW5AUm90aGxhZW5kZXIubmV0MSww
KgYJKoZIhvcNAQkBFh1NYWlsaW5nbGlzdGVuQHJvdGhsYWVuZGVyLm5ldDEfMB0GCSqGSIb3
DQEJARYQYXNkY2hyaXNpQHdlYi5kZTE9MDsGCSqGSIb3DQEJARYuY2hyaXN0aWFuLnJvdGhs
YWVuZGVyQHN0dWRlbnQudW5pLXR1ZWJpbmdlbi5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAKuzQ0LvIhT2gvKmuu3a91DQnOQ16Bk+iNCvufPQ1zfJyhNbIxl91Vme6aGW
Nghp1Hz8kya2VTLgzq5IdF7ValmKq4HCbFjxTxGDlwXA5Vki43xbrPz4jpRJjIP3aVnmf0Ro
SSpLdvle1j5n7DYhhJ//TbSxZgSldfQJiGVqQ/fbvdqkAKmm4BPg+m6BtwfEkQ5csriZDCKh
qrdttlsAkAWLYXsFQFxtHXmEtmFD9X617xPVHWkF8SsmtrTtAOQWElG217px76ylXth8mBwi
rDAGhw9HvzKxD4Q56/mWCXN/43SSHd2VWhj1xaRTMWi123MQ8gj/E+DW3e55olcunykCAwEA
AaOBmTCBljCBhQYDVR0RBH4wfIEZQ2hyaXN0aWFuQFJvdGhsYWVuZGVyLm5ldIEdTWFpbGlu
Z2xpc3RlbkByb3RobGFlbmRlci5uZXSBEGFzZGNocmlzaUB3ZWIuZGWBLmNocmlzdGlhbi5y
b3RobGFlbmRlckBzdHVkZW50LnVuaS10dWViaW5nZW4uZGUwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQB5NKmtji0B6l3akyofnK3M8HJi44Rl0WANOLIqQrtiixrWi6jB+B0i
pmpjwrTXqSM/Slag5ijGln5ZhKdeOM/tp29EeLtFvc8xRMKjC9TUGH+A42JNPQxJ7JwZIajJ
TdfZTctIXbaG8ujNiudI+9rp+2zsNHrWSqcvtqb8Nq/SGjCCBAkwggNyoAMCAQICEDE4Vcbe
UjMRagTj6gfoogowDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MDcwOTA5NDQyM1oXDTA3MDcwOTA5NDQyM1owggEC
MRQwEgYDVQQEEwtSb3RobGFlbmRlcjESMBAGA1UEKhMJQ2hyaXN0aWFuMR4wHAYDVQQDExVD
aHJpc3RpYW4gUm90aGxhZW5kZXIxKDAmBgkqhkiG9w0BCQEWGUNocmlzdGlhbkBSb3RobGFl
bmRlci5uZXQxLDAqBgkqhkiG9w0BCQEWHU1haWxpbmdsaXN0ZW5Acm90aGxhZW5kZXIubmV0
MR8wHQYJKoZIhvcNAQkBFhBhc2RjaHJpc2lAd2ViLmRlMT0wOwYJKoZIhvcNAQkBFi5jaHJp
c3RpYW4ucm90aGxhZW5kZXJAc3R1ZGVudC51bmktdHVlYmluZ2VuLmRlMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq7NDQu8iFPaC8qa67dr3UNCc5DXoGT6I0K+589DXN8nK
E1sjGX3VWZ7poZY2CGnUfPyTJrZVMuDOrkh0XtVqWYqrgcJsWPFPEYOXBcDlWSLjfFus/PiO
lEmMg/dpWeZ/RGhJKkt2+V7WPmfsNiGEn/9NtLFmBKV19AmIZWpD99u92qQAqabgE+D6boG3
B8SRDlyyuJkMIqGqt222WwCQBYthewVAXG0deYS2YUP1frXvE9UdaQXxKya2tO0A5BYSUbbX
unHvrKVe2HyYHCKsMAaHD0e/MrEPhDnr+ZYJc3/jdJId3ZVaGPXFpFMxaLXbcxDyCP8T4Nbd
7nmiVy6fKQIDAQABo4GZMIGWMIGFBgNVHREEfjB8gRlDaHJpc3RpYW5AUm90aGxhZW5kZXIu
bmV0gR1NYWlsaW5nbGlzdGVuQHJvdGhsYWVuZGVyLm5ldIEQYXNkY2hyaXNpQHdlYi5kZYEu
Y2hyaXN0aWFuLnJvdGhsYWVuZGVyQHN0dWRlbnQudW5pLXR1ZWJpbmdlbi5kZTAMBgNVHRMB
Af8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBAHk0qa2OLQHqXdqTKh+crczwcmLjhGXRYA04sipC
u2KLGtaLqMH4HSKmamPCtNepIz9KVqDmKMaWflmEp144z+2nb0R4u0W9zzFEwqML1NQYf4Dj
Yk09DEnsnBkhqMlN19lNy0hdtoby6M2K50j72un7bOw0etZKpy+2pvw2r9IaMYIDZDCCA2AC
AQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDE4
VcbeUjMRagTj6gfoogowCQYFKw4DAhoFAKCCAcMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMDcwNTE4MTQ0NTQwWjAjBgkqhkiG9w0BCQQxFgQUHWzT+zds
k8hbcxmzzEcH6eeBN1IwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0D
AgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQB
gjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhAxOFXG3lIzEWoE4+oH6KIKMIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhAxOFXG3lIzEWoE4+oH6KIKMA0GCSqG
SIb3DQEBAQUABIIBAC/J9+8nMByPWPPtJkSLDcdyhwsq31uXcRXXyayMlw2hGsG5Wlu8qUIT
Gh6x2sHqdMfeS4b+zCYIj00OB4iIaa2TSeFXq5fDamCCrtvxFhsYAsUxzbsw4OuatOmFdzuh
0hOyxMHedkvQi4FToSSl7BqQv6PrrJI0BSt9zK+iZnG+OSVAZC1q8nst0zip0VFOvytXRtih
DKoPU2tq2benYe3ROvo7A34ykN3TCfO+wtnQQaTKUIWpbEFZajhKeqDsbV7Kfuk8gyFYJvhr
vmFlgU7bRMJI7pjhpNnszQAp6TW4e1a2LtHh9q3HtlMXV9rChZj57/hvy84xXJeX+TtLa5MA
AAAAAAA=
--------------ms040002080602030201040000--

--===============6468350940457630953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6468350940457630953==--
