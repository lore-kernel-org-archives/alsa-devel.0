From: John Sauter <John_Sauter@systemeyescomputerstore.com>
Subject: Re: audio surveilance
Date: Fri, 08 Jan 2010 13:45:53 -0500
Message-ID: <1262976353.5921.1.camel@sauterws02.sauterhome>
References: <1262404487.4427.7.camel@sauterws02.sauterhome>
	<1262889015.28819.6.camel@sauterws02.sauterhome>
	<alpine.LNX.2.00.1001081546130.4210@eeebox2.perex-int.cz>
Reply-To: John_Sauter@systemeyescomputerstore.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6544192168898839278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.LNX.2.00.1001081546130.4210@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6544192168898839278==
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature"; boundary="=-Tb2sEzi0Bdo6Ao79F0Jq"


--=-Tb2sEzi0Bdo6Ao79F0Jq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-01-08 at 15:58 +0100, Jaroslav Kysela wrote:
> On Thu, 7 Jan 2010, John Sauter wrote:
>=20
> > Mr. Kysela,
> >
> > I have some patches to aplay to make it more useful for audio
> > surveillance.  I have submitted the patches to the devel mailing list
> > for comment here:
> > <http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/0242=
78.html>.
> >
> > I have received no negative comments, so I would like to propose these
> > patches for inclusion in mainline.  What is the procedure for submittin=
g
> > patches for alsa-util?
>=20
> Could you, please, a bit clean up your patch?
>=20
> - There are a lot of "if (pidfile_written) remove (pidfile_name)" lines.
>    It would be better  to create another function like prg_exit() and add
>    this code there.
>=20
> - Many C expressions are not splitted to more lines:
>    "if (max_file_size && (rest > max_file_size)) rest =3D max_file_size;"
>=20
> - Check all conditions. Use && and || operators instead bit-like AND (&)
>    and OR (|). Like "if (filecount | use_strftime) {" etc.
>=20
> - I would also appreciate, if you can split '--process-id-file' code
>    changes and rest of implementation to two standalone patches for more
>    easier review. Also, your patch contains some "space/tab replacements"=
 -
>    it might be moved to another patch too.
>=20
>  					Thanks,
>  						Jaroslav
>=20

Thank you, Jaroslav.  I will make those changes and re-submit.
    John Sauter (John_Sauter@systemeyescomputerstore.com)


--=-Tb2sEzi0Bdo6Ao79F0Jq
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILOTCCBN0w
ggPFoAMCAQICEHGS++YZX6xNEoV0cTSiGKcwDQYJKoZIhvcNAQEFBQAwezELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBwwHU2FsZm9yZDEaMBgGA1UECgwR
Q29tb2RvIENBIExpbWl0ZWQxITAfBgNVBAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0w
NDAxMDEwMDAwMDBaFw0yODEyMzEyMzU5NTlaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQx
FzAVBgNVBAcTDlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsx
ITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJz
dC1DbGllbnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAsjmFpPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVNNRm5pELlzkniii8efNIx
B8dOtINknS4p1aJkxIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8
om+rWV6lL8/K2m2qL+usobNqqrcuZzWLeeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHG
TPNpsaguG7bUMSAsvIKKjqQOpdeJQ/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7Nl
yP0e03RiqhjKaJMeoYV+9Udly/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4IBJzCCASMwHwYDVR0j
BBgwFoAUoBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59
MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdJQQWMBQGCCsGAQUFBwMCBggr
BgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwewYDVR0fBHQwcjA4oDagNIYyaHR0cDovL2NybC5j
b21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNqA0oDKGMGh0dHA6Ly9jcmwu
Y29tb2RvLm5ldC9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDARBglghkgBhvhCAQEEBAMCAQYw
DQYJKoZIhvcNAQEFBQADggEBAJ2Vyzy4fqUJxB6/C8LHdo45PJTGEKpPDMngq4RdiVTgZTvzbRx8
NywlVF+WIfw3hJGdFdwUT4HPVB1rbEVgxy35l1FM+WbKPKCCjKbI8OLp1Er57D9Wyd12jMOCAU9s
APMeGmF0BEcDqcZAV5G8ZSLFJ2dPV9tkWtmNH7qGL/QGrpxp7en0zykX2OBKnxogL5dMUbtGB8SK
N04g4wkxaMeexIud6H4RvDJoEJYRmETYKlFgTYjrdDrfQwYyyDlWjDoRUtNBpEMD9O3vMyfbOeAU
TibJ2PU54om4k123KSZB6rObroP8d3XK6Mq1/uJlSmM+RMTQw16Hc6mYHK9/FX8wggZUMIIFPKAD
AgECAhEAyul/1r9bEQ78VeQYPidf2TANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJ
BgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVT
VCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVU
Ti1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0wOTAzMDEwMDAw
MDBaFw0xMDAzMDEyMzU5NTlaMIHuMTUwMwYDVQQLEyxDb21vZG8gVHJ1c3QgTmV0d29yayAtIFBF
UlNPTkEgTk9UIFZBTElEQVRFRDFGMEQGA1UECxM9VGVybXMgYW5kIENvbmRpdGlvbnMgb2YgdXNl
OiBodHRwOi8vd3d3LmNvbW9kby5uZXQvcmVwb3NpdG9yeTEfMB0GA1UECxMWKGMpMjAwMyBDb21v
ZG8gTGltaXRlZDEUMBIGA1UEAxMLSm9obiBTYXV0ZXIxNjA0BgkqhkiG9w0BCQEWJ2pvaG5fc2F1
dGVyQHN5c3RlbWV5ZXNjb21wdXRlcnN0b3JlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAMqyvG9cN7jE5kASp3V2C0EsTDlpxuBXwqBN/utIP19TeDz7V3/iFvYG80oXTo5O9cbQ
2Ahshlzz1pic0GDg+JKBUTfd7nicSNgyZKj9bCdTT3L4gRpHOL43RNet0tA+huQM6zz3S2+3RZnC
jp/yjeh2Bu10nzDBRAs4D6Mw6CBJ7iFzW5mHNPlPAR1sFtVq/Tcc/jy3f9NKOMSJTaWz0LVUKMAm
dsDwss7kwpgFqwWE4PNr+7i8DeiL8DsC0fncsO67HlhvoiPZqF1zmOHpI7P8ujtRazA8Lq1WUtOh
HaMYZli52Rx1onmXWmMpiiRBncmNNZ2QLEXAuP0b2zO35XcCAwEAAaOCAikwggIlMB8GA1UdIwQY
MBaAFImCZ33EnSZwAEu0UEh83j2uBG59MB0GA1UdDgQWBBTG3EgnOAC1yQkVg4DldKdKSIr+rjAO
BgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGy
MQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYI
KwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMIGlBgNVHR8EgZ0wgZowTKBK
oEiGRmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRFbWFpbC5jcmwwSqBIoEaGRGh0dHA6Ly9jcmwuY29tb2RvLm5ldC9VVE4tVVNFUkZp
cnN0LUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kRW1haWwuY3JsMGwGCCsGAQUFBwEBBGAwXjA2Bggr
BgEFBQcwAoYqaHR0cDovL2NydC5jb21vZG9jYS5jb20vVVROQUFBQ2xpZW50Q0EuY3J0MCQGCCsG
AQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wMgYDVR0RBCswKYEnam9obl9zYXV0ZXJA
c3lzdGVtZXllc2NvbXB1dGVyc3RvcmUuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQB7rUiCoa34C3V4
WO5GFpMeWF+MmwSQAJtOkO2eYr2Xkz0oxn99Tq7QHxUqlC0qbSEUD1Ac+aJlmCFKxT4+WavGkdt2
43HMxYcu3gseM0n+P+nTkEvRFFEj0Q/7DxIBFzMBaTFdFZgC9a4U2v0krm5agR8OBLG+1IwAQS6H
uS3gjI5JWx9s7InLOHYce0bg5n8hwX9YPA0nYoXVrNwm2WcnbfQZ1qJMpdh+LBIx+sxes5pjGKAc
OZvCDK6OCFAxgPiJyEG6cKpnLTE2bsaVzB2SaGlcgD/x/4m95CEMu/M3/CIgyD5fzEuLgyRdA61l
zPdBPorTun+WLcwnHNvz667JMYICSzCCAkcCAQEwgcQwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQI
EwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0
d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNF
UkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEQDK6X/Wv1sRDvxV5Bg+J1/Z
MAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
MDAxMDgxODQ1NDdaMCMGCSqGSIb3DQEJBDEWBBTzxrKm/5GpduPFJMjnS5frykfhxjANBgkqhkiG
9w0BAQEFAASCAQB5wpWA0mdR+EPRfp73iJBxMhLzUTOllZ5Z1gUOMPLbv4NhdIlf8ZZ1oUz2HDe/
/LGNTVRw9/v2+WBdZCmFjCaOJ/oQzxtchnR2IhL1bE9uW57LZHuc0HjxdAEKFzlr3ZNqHegKZart
7E9NkyNLhdFfOdA1tccBgeKnkr5AUteyDvAYkrcFoWWoFJJ80rWNP6Bh7qeX7kcJ4DOos51e5y+v
Lg6pdBYUTLvdn17chB7GfC6JIrHH7L1EIzKJl1KlGkmeOtd1YyJUJUapuI/D3jbCCSj828DQk0ng
JYBNY94r7WcYRHbteMqBHnE1zzcSTbiikdf0pz31LAW9TQHqp8lLAAAAAAAA


--=-Tb2sEzi0Bdo6Ao79F0Jq--


--===============6544192168898839278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6544192168898839278==--
