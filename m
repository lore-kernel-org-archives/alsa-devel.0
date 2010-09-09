From: IOhannes m zmoelnig <zmoelnig@iem.at>
Subject: Re: crash with assertion (?)
Date: Thu, 09 Sep 2010 11:43:45 +0200
Message-ID: <4C88AC51.9030803@iem.at>
References: <4C8662AD.1040607@iem.at>
	<4C8670FD.5020906@ladisch.de>	<4C874C1E.8040007@iem.at>
	<AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4549471874880716605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iem.at (iem.kug.ac.at [193.170.191.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DB452436C
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 11:43:46 +0200 (CEST)
Received: from router.iemnet ([192.168.7.1]:35579 helo=[192.168.7.141])
	by mail.iem.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <zmoelnig@iem.at>) id 1OtdfW-00064f-6j
	for alsa-devel@alsa-project.org; Thu, 09 Sep 2010 11:43:46 +0200
In-Reply-To: <AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>
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

--===============4549471874880716605==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms080807070108010303050701"

This is a cryptographically signed message in MIME format.

--------------ms080807070108010303050701
Content-Type: multipart/mixed;
 boundary="------------040900090404000509000207"

This is a multi-part message in MIME format.
--------------040900090404000509000207
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2010-09-09 03:30, Raymond Yau wrote:

> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___par=
ams.htm
l

> what is the minimum rate returned by snd_pcm_hw_params_get_rate_min() w=
hen
> using hw:0,0 ?

for hw:0,0 it is 48000, direction=3D0
for plughw:0,0 i get 4000(sic!), direction=3D0

>=20
> To debug , you will need to enable RULES_DEBUG In pcm_params.c
>=20
> add snd_pcm_dump() after snd_pcm_hw_params in your program
>=20
> export LIBASOUND_DEBUG=3D1
>=20
> and post the output of your program

ok, i tried that.
there's of course the little problem with havind snd_pcm_dump() after
snd_pcm_hw_params(), since the latter crashes...
so i added it before i start configuring the device as well. here's the
pseudocode:
<snip>
open(PLAYBACK);
dump();
nonblock(1); get_rate(); set_rate(44100); set_period(64);
dump();
close();
open(CAPTURE);
dump();
nonblock(1); get_rate(); set_rate(44100); set_period(64); /* CRASH */
dump();
close();
</snip>

i prefixed all the printout of my application with "JMZ", so you can
easily filter it out.

fgmasdr
IOhannes


--------------040900090404000509000207
Content-Type: application/x-gzip;
 name="assertion.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="assertion.log.gz"

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
nMUvtf8DgjKP07zrAAA=
--------------040900090404000509000207--

--------------ms080807070108010303050701
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
AKCCAegwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTAwOTA5
MDk0MzQ1WjAjBgkqhkiG9w0BCQQxFgQULgPKnPhpQ1wtjq9owt4lzL8Un78wXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAw
eTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIw
IAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwYpcDCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBD
ZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5v
cmcCAwYpcDANBgkqhkiG9w0BAQEFAASCAQAuXTMmqqm0btPDBc30iH29hSpXWdwRwzeQVwrj
q2nLMavTDf2nVpusyVhNoKOHAsuh2Raax8EtmB8+/wUs4v1INBLCtJHCyx3hqPKTqsEcq0rw
FJfXKQdXQwuxvGcEW4oABLG+5KcwZ7jGoRDM7BNSq/eBfJvTTNDwgp4rFu2cLnmzA/mAbf1K
eG2VYj4i3/ZwPhGlb4oetjJxVwnaU6EMxG7G385WDG/nVUPTe+ep2CmvTIK/8fFqsrRD6P9t
0Uoi4eFsnhTpa8pDM17ZSkHL6a3wqZNnQkgVXYmHXwSm2WJTvY9nnhnQw5vTUWeF+HqA4ZTZ
yJay3mo2Orzk/zb0AAAAAAAA
--------------ms080807070108010303050701--

--===============4549471874880716605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4549471874880716605==--
