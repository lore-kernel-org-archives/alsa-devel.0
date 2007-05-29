From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Subject: [PATCH] Add quirk for Supermicro PDSBA to
	alc883_cfg_tbl[]
Date: Tue, 29 May 2007 03:46:28 -0400
Message-ID: <1180424788.22486.3.camel@Box.ncat.edu>
Reply-To: crimsun@ubuntu.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7525649121606997476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F39824378
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 09:46:35 +0200 (CEST)
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
Cc: crimsun@ubuntu.com
List-Id: alsa-devel@alsa-project.org


--===============7525649121606997476==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1qxI2VWeDiiFUDSQdvCH"


--=-1qxI2VWeDiiFUDSQdvCH
Content-Type: multipart/mixed; boundary="=-GCqjdiGaeTtFujV+DCvk"


--=-GCqjdiGaeTtFujV+DCvk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is a diff against current alsa-kernel hg tip.

Thanks,
Daniel Chen

--=-GCqjdiGaeTtFujV+DCvk
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=diff; charset=UTF-8

Y2hhbmdlc2V0OiAgIDUwODA6YmVjODI3MjdmZDAwDQp0YWc6ICAgICAgICAgdGlwDQp1c2VyOiAg
ICAgICAgY3JpbXN1bkBCb3gubmNhdC5lZHUNCmRhdGU6ICAgICAgICBUdWUgTWF5IDI5IDAzOjQx
OjU1IDIwMDcgLTA0MDANCnN1bW1hcnk6ICAgICBbUEFUQ0hdIEFkZCBxdWlyayBmb3IgU3VwZXJt
aWNybyBQRFNCQSB0byBhbGM4ODNfY2ZnX3RibFtdDQoNCmRpZmYgLXIgMzM3OTYyZTE5ZGU2IC1y
IGJlYzgyNzI3ZmQwMCBwY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYw0KLS0tIGEvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMJRnJpIE1heSAyNSAxMjoxODo0OSAyMDA3ICswMjAwDQorKysgYi9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYwlUdWUgTWF5IDI5IDAzOjQxOjU1IDIwMDcgLTA0MDANCkBAIC02Mzky
LDYgKzYzOTIsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgzX2NmZ190DQog
CVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweDQzMjQsICJNU0kiLCBBTEM4ODNfVEFSR0FfRElHKSwN
CiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4YTQyMiwgIk1TSSIsIEFMQzg4M19UQVJHQV8yY2hf
RElHKSwNCiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDAsICJBY2VyIGxhcHRvcCIsIEFMQzg4M19B
Q0VSKSwNCisJU05EX1BDSV9RVUlSSygweDE1ZDksIDB4ODc4MCwgIlN1cGVybWljcm8gUERTQkEi
LCBBTEM4ODNfM1NUXzZjaCksDQogCVNORF9QQ0lfUVVJUksoMHgxNjFmLCAweDIwNTQsICJNZWRp
b24gbGFwdG9wIiwgQUxDODgzX01FRElPTiksDQogCVNORF9QQ0lfUVVJUksoMHgxMDcxLCAweDgy
NTgsICJFdmVzaGFtIFZveWFlZ2VyIiwgQUxDODgzX0xBUFRPUF9FQVBEKSwNCiAJU05EX1BDSV9R
VUlSSygweDgwODYsIDB4ZDYwMSwgIkQxMDJHR0MiLCBBTEM4ODNfM1NUXzZjaCksDQoNCg==


--=-GCqjdiGaeTtFujV+DCvk--

--=-1qxI2VWeDiiFUDSQdvCH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGW9pUe9GwFciKvaMRAuYHAJ9peE1ElZWg2hbmugYtN02etPSU9gCfQULU
nLgC+z1HoZU+CtftZgssCxw=
=o+Jj
-----END PGP SIGNATURE-----

--=-1qxI2VWeDiiFUDSQdvCH--

--===============7525649121606997476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7525649121606997476==--
