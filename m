From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Subject: [PATCH] Add SSID for Dell XPS400 to stac922x_cfg_tbl[]
Date: Fri, 08 Jun 2007 03:05:26 -0400
Message-ID: <1181286326.16999.4.camel@Box.ncat.edu>
Reply-To: crimsun@ubuntu.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0480665277838882922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id C489E24682
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 09:05:34 +0200 (CEST)
Received: from ns1.mcdownloads.com (localhost [127.0.0.1])
	by ns1.mcdownloads.com (Postfix) with ESMTP id 5FAAB28495A0C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jun 2007 00:05:30 -0700 (PDT)
Received: from [127.0.0.1] (adhd.irule.net [66.81.0.197])
	(Authenticated sender: crimsun@fungus.sh.nu)
	by ns1.mcdownloads.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Fri,  8 Jun 2007 00:05:30 -0700 (PDT)
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


--===============0480665277838882922==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZogG9te7DSrmnVCPjOSB"


--=-ZogG9te7DSrmnVCPjOSB
Content-Type: multipart/mixed; boundary="=-5QzGSWcwxGkKq7fPDkjx"


--=-5QzGSWcwxGkKq7fPDkjx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Attached please find an hg changeset against current alsa-kernel tip
adding a quirk entry for a Dell XPS400.

Thanks,
Daniel Chen

--=-5QzGSWcwxGkKq7fPDkjx
Content-Disposition: attachment; filename=new3.diff
Content-Type: text/x-patch; name=new3.diff; charset=UTF-8
Content-Transfer-Encoding: base64

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBjcmltc3VuQEJveC5uY2F0LmVkdQ0KIyBEYXRl
IDExODEyODYxMDggMTQ0MDANCiMgTm9kZSBJRCAyZjQ3MjI5MTM4ZmQ5NWMwYWQwNzZhODc2Mjc0
ZDYyYjczNjI2YzcyDQojIFBhcmVudCAgZDQxOTQyN2M0MDcxMzM0MGNmNWFiN2IwZTZiMTIyYTgy
NDY1ZDZiYQ0KW1BBVENIXSBBZGQgU1NJRCBmb3IgRGVsbCBYUFM0MDAgdG8gc3RhYzkyMnhfY2Zn
X3RibFtdDQoNClRoaXMgaGcgY2hhbmdlc2V0IGFnYWluc3QgY3VycmVudCBhbHNhLWtlcm5lbCB0
aXAgYWRkcyB0aGUNClNTSUQgZm9yIGEgRGVsbCBYUFM0MDAgKGh0dHBzOi8vbGF1bmNocGFkLm5l
dC9idWdzLzExOTI2NikNCnRvIGEgU2lnbWF0ZWwgcXVpcmsgbGlzdC4gIChJdCBpcyBjYXJyaWVk
IGluIFVidW50dSBGZWlzdHkNCmJ1dCB3YXMgaW5hZHZlcnRlbnRseSBvbWl0dGVkIGZyb20gdGhl
IHByZXZpb3VzIHN5bmMuKQ0KDQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3Vu
QHVidW50dS5jb20+DQoNCmRpZmYgLXIgZDQxOTQyN2M0MDcxIC1yIDJmNDcyMjkxMzhmZCBwY2kv
aGRhL3BhdGNoX3NpZ21hdGVsLmMNCi0tLSBhL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwlUaHUg
SnVuIDA3IDE4OjAyOjQ2IDIwMDcgLTA0MDANCisrKyBiL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwu
YwlGcmkgSnVuIDA4IDAzOjAxOjQ4IDIwMDcgLTA0MDANCkBAIC02ODAsNiArNjgwLDggQEAgc3Rh
dGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIHN0YWM5MjJ4X2NmZw0KIAlTTkRfUENJX1FVSVJLKFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4MDcwNywNCiAJCSAgICAgICJJbnRlbCBEOTQ1UCIsIFNUQUNf
RDk0NUdUUDUpLA0KIAkvKiBvdGhlciBzeXN0ZW1zICAqLw0KKwlTTkRfUENJX1FVSVJLKFBDSV9W
RU5ET1JfSURfREVMTCwgMHgwMWQxLA0KKwkJICAgICAgIkRlbGwgWFBTNDAwIiwgU1RBQ19EOTQ1
X1JFRiksDQogCS8qIEFwcGxlIE1hYyBNaW5pIChlYXJseSAyMDA2KSAqLw0KIAlTTkRfUENJX1FV
SVJLKDB4ODM4NCwgMHg3NjgwLA0KIAkJICAgICAgIk1hYyBNaW5pIiwgU1RBQ19JTlRFTF9NQUNf
VjMpLA0K


--=-5QzGSWcwxGkKq7fPDkjx--

--=-ZogG9te7DSrmnVCPjOSB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGaP+2e9GwFciKvaMRAhmMAJ9PjlAzCRqH5wmYjtdSXovSXO1x8wCgmx6O
QyyPmxg3ySb1YYdKrdSbzds=
=7QVt
-----END PGP SIGNATURE-----

--=-ZogG9te7DSrmnVCPjOSB--

--===============0480665277838882922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0480665277838882922==--
