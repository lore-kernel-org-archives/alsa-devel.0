From: IOhannes m zmoelnig <zmoelnig@iem.at>
Subject: Re: crash with assertion (?)
Date: Tue, 07 Sep 2010 18:32:49 +0200
Message-ID: <4C866931.8080402@iem.at>
References: <4C8662AD.1040607@iem.at> <4C866349.8020502@iem.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6628818527241051273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iem.at (iem.kug.ac.at [193.170.191.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E90110384A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 18:32:50 +0200 (CEST)
Received: from router.iemnet ([192.168.7.1]:59251 helo=[192.168.7.141])
	by mail.iem.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <zmoelnig@iem.at>) id 1Ot16H-0005FK-Tl
	for alsa-devel@alsa-project.org; Tue, 07 Sep 2010 18:32:49 +0200
In-Reply-To: <4C866349.8020502@iem.at>
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

--===============6628818527241051273==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000301050703040207060204"

This is a cryptographically signed message in MIME format.

--------------ms000301050703040207060204
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2010-09-07 18:07, IOhannes m zmoelnig wrote:
> it seems like debian compiles the package without explicitely adding th=
e
> "--without-debug" configure-flag, does resulting in assert()ions that
> exist the application.
>=20
> i will file a bug-report with debian, so they can fix this.
>=20
> in the meantime: why is it the default to compile with asserts?
>=20

but obviously the assertion is there for a reason (so i guess i would
get crashes even if the assertion was not there, since the assert() only
protects from a NULL-pointer dereferencing)

which brings the bug back to alsa-lib....


fgamsdr
IOhannes


--------------ms000301050703040207060204
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKYjCC
BS0wggMVoAMCAQICAwYpcDANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wODEy
MTUxNjM3MDdaFw0xMDEyMTUxNjM3MDdaMDsxGTAXBgNVBAMUEElPaGFubmVzIHpt9mxuaWcx
HjAcBgkqhkiG9w0BCQEWD3ptb2VsbmlnQGllbS5hdDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAKLQhgkPj0tjKYXWT4jMXaIwxPXxsI1jQat4/FQxYNKWwSKPi2p+mqrKgoTc
qBszVGhBzhU9QndtpAeygvc0O5QVhyqnpndYoPu4kI5DhHemdwE6VvWiMFgEeOTywiOQJoUt
zulhHovz6xa9fSPqgO5c174CKsD3ekfOQ+m1xmZ6xd3hHDgm30186abxCsGOOXSadh+bnlGG
pCXLKbZiRvF5WfOL6Y3myb3IinYErrerpjROshxC5ibd9KdlGXJ3MDEZGirM7tW75iiU7yz7
umZDGNmcIrWCNs65YuRFfe42W2JOXqYvdiLKeK5iSNbuX/R5JZDrTvJU56cFmUy6hocCAwEA
AaOB+zCB+DAMBgNVHRMBAf8EAjAAMFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBvd24g
Y2VydGlmaWNhdGUgZm9yIEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9y
ZzBABgNVHSUEOTA3BggrBgEFBQcDBAYIKwYBBQUHAwIGCisGAQQBgjcKAwQGCisGAQQBgjcK
AwMGCWCGSAGG+EIEATAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3Nw
LmNhY2VydC5vcmcwGgYDVR0RBBMwEYEPem1vZWxuaWdAaWVtLmF0MA0GCSqGSIb3DQEBBQUA
A4ICAQBS/kdsg+n5pCKqUOVrRYM2TlGXY38/5TyEmfvhlvjDHDs8s4Cc/TtxLyyHrHYKpH4Z
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
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGKXAwCQYFKw4DAhoF
AKCCAegwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTAwOTA3
MTYzMjQ5WjAjBgkqhkiG9w0BCQQxFgQUoBFddiuhmunw4Kb8DnXbcHiPszYwXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAw
eTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIw
IAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwYpcDCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBD
ZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5v
cmcCAwYpcDANBgkqhkiG9w0BAQEFAASCAQBb6sx+OUa8h1tQ8VDnhGo0g5a+GBrBqxFIdqcI
Rp4FIvxubgsmHUXuzvygGD6F2unYggPQ1taX812W/o1PQeIdVu9ilHFJqvxVdVxqrxdSoQ1R
0LkWhm9OR9sMxywPHT3I/80CClPvel6DRn5+obzv5OZvIBrLdfI/R56jlqjJxxJqciebeI+Z
rzeJ8aKUipCcuPXuNfF1nBpjZjQn0Hln8vpPrGP5jnQqX46dTT34pFRs56OxvEjJls9RyeVQ
bK2QyFWbQdwzaKiTgxkF9pT0UHum2L3gC4ChlK8GiiEh9/JEvcmIPaWu8lOgzHRww4GUs6Qy
nCAFmvLhjowWNtudAAAAAAAA
--------------ms000301050703040207060204--

--===============6628818527241051273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6628818527241051273==--
