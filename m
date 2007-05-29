From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Subject: Re: [PATCH] Add quirk for Supermicro PDSBA
	to	alc883_cfg_tbl[]
Date: Tue, 29 May 2007 03:52:52 -0400
Message-ID: <1180425172.22486.6.camel@Box.ncat.edu>
References: <1180424788.22486.3.camel@Box.ncat.edu>
Reply-To: crimsun@ubuntu.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5350744548622917525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id CF1BE24378
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 09:52:54 +0200 (CEST)
Received: from ns1.mcdownloads.com (localhost [127.0.0.1])
	by ns1.mcdownloads.com (Postfix) with ESMTP id 7E7EC2844E12D
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 00:52:52 -0700 (PDT)
Received: from [127.0.0.1] (adhd.irule.net [66.81.0.197])
	(Authenticated sender: crimsun@fungus.sh.nu)
	by ns1.mcdownloads.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 00:52:52 -0700 (PDT)
In-Reply-To: <1180424788.22486.3.camel@Box.ncat.edu>
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


--===============5350744548622917525==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mGJx+ZnI/SuNC6P4Kfds"


--=-mGJx+ZnI/SuNC6P4Kfds
Content-Type: multipart/mixed; boundary="=-B63D51WB+mEuH5t1ebYa"


--=-B63D51WB+mEuH5t1ebYa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-29 at 03:46 -0400, Daniel T. Chen wrote:
> Attached is a diff against current alsa-kernel hg tip.

Err, let's use the correct one from hg export.  Apologies for the
earlier clutter.

--=-B63D51WB+mEuH5t1ebYa
Content-Disposition: attachment; filename=diff.1
Content-Type: text/plain; name=diff.1; charset=UTF-8
Content-Transfer-Encoding: base64

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBjcmltc3VuQEJveC5uY2F0LmVkdQ0KIyBEYXRl
IDExODA0MjQ1MTUgMTQ0MDANCiMgTm9kZSBJRCBiZWM4MjcyN2ZkMDAzNDA2YmQxYzUzZjhmZTAy
ODMwNTg5OTNiYTMwDQojIFBhcmVudCAgMzM3OTYyZTE5ZGU2MTg2MjU2YjY2N2ZmZWJlMmI4ZDQ4
Y2ViODQyNw0KW1BBVENIXSBBZGQgcXVpcmsgZm9yIFN1cGVybWljcm8gUERTQkEgdG8gYWxjODgz
X2NmZ190YmxbXQ0KDQpUZXN0ZWQgYW5kIHZlcmlmaWVkIGluICNhbHNhL0ZyZWVub2RlIG9uIFR1
ZXNkYXksIE1heSAyOSwgMjAwNy4NCg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3Jp
bXN1bkB1YnVudHUuY29tPg0KDQpkaWZmIC1yIDMzNzk2MmUxOWRlNiAtciBiZWM4MjcyN2ZkMDAg
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMNCi0tLSBhL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCUZy
aSBNYXkgMjUgMTI6MTg6NDkgMjAwNyArMDIwMA0KKysrIGIvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMJVHVlIE1heSAyOSAwMzo0MTo1NSAyMDA3IC0wNDAwDQpAQCAtNjM5Miw2ICs2MzkyLDcgQEAg
c3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4M19jZmdfdA0KIAlTTkRfUENJX1FVSVJL
KDB4MTQ2MiwgMHg0MzI0LCAiTVNJIiwgQUxDODgzX1RBUkdBX0RJRyksDQogCVNORF9QQ0lfUVVJ
UksoMHgxNDYyLCAweGE0MjIsICJNU0kiLCBBTEM4ODNfVEFSR0FfMmNoX0RJRyksDQogCVNORF9Q
Q0lfUVVJUksoMHgxMDI1LCAwLCAiQWNlciBsYXB0b3AiLCBBTEM4ODNfQUNFUiksDQorCVNORF9Q
Q0lfUVVJUksoMHgxNWQ5LCAweDg3ODAsICJTdXBlcm1pY3JvIFBEU0JBIiwgQUxDODgzXzNTVF82
Y2gpLA0KIAlTTkRfUENJX1FVSVJLKDB4MTYxZiwgMHgyMDU0LCAiTWVkaW9uIGxhcHRvcCIsIEFM
Qzg4M19NRURJT04pLA0KIAlTTkRfUENJX1FVSVJLKDB4MTA3MSwgMHg4MjU4LCAiRXZlc2hhbSBW
b3lhZWdlciIsIEFMQzg4M19MQVBUT1BfRUFQRCksDQogCVNORF9QQ0lfUVVJUksoMHg4MDg2LCAw
eGQ2MDEsICJEMTAyR0dDIiwgQUxDODgzXzNTVF82Y2gpLA0K


--=-B63D51WB+mEuH5t1ebYa--

--=-mGJx+ZnI/SuNC6P4Kfds
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGW9vUe9GwFciKvaMRAsYBAJwOS8sQW0AN7d7mU0OSNIsWr1fa0gCgi7Lg
9RFsiMCBX0rh/qL4IUDk9eY=
=vYPv
-----END PGP SIGNATURE-----

--=-mGJx+ZnI/SuNC6P4Kfds--

--===============5350744548622917525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5350744548622917525==--
