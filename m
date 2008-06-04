From: Tony Vroon <tony@vroon.org>
Subject: [ALC268 patch_realtek.c] COMPAL IFL90/JFL-92 laptop
	quirk to	select ALC268_TOSHIBA
Date: Wed, 04 Jun 2008 10:52:35 +0100
Message-ID: <1212573155.3937.10.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6597960839744775765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F2E324366
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 11:53:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============6597960839744775765==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d1+KxAjQa0VmnEdXza6m"


--=-d1+KxAjQa0VmnEdXza6m
Content-Type: multipart/mixed; boundary="=-vMQFsSwJkfZiuBuL+7c5"


--=-vMQFsSwJkfZiuBuL+7c5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Good morning,

Could you please consider the attached patch. The COMPAL IFL90/JFL-92
laptop defaults to an incorrect output channel on autoprobe, resulting
in no audio. The user was unable to enable analog audio with the mixer
controls provided.
Testing confirms that the Toshiba model enables both headphone with
automuting and the internal speakers. Embedded sign-off and short patch
description.

Tested-By: Guri <gurashka@gmail.com>
=EF=BB=BFSigned-Off-By: Tony Vroon <tony@linx.net>

Regards,
Tony V.
LINX sysadmin

--=-vMQFsSwJkfZiuBuL+7c5
Content-Disposition: attachment; filename=COMPAL-ALC268_TOSHIBA.patch
Content-Type: text/x-patch; name=COMPAL-ALC268_TOSHIBA.patch; charset=UTF-8
Content-Transfer-Encoding: base64

VXNlIHF1aXJrIHRhYmxlIHRvIGFzc2lnbiBBTEMyNjhfVE9TSElCQSB0byBDT01QQUwgSUZMOTAv
SkZMLTkyIGxhcHRvcHMuDQpObyBhbmFsb2cgb3V0cHV0IG9uIGF1dG9wcm9iZS4NCg0KVGVzdGVk
LUJ5OiBHdXJpIDxndXJhc2hrYUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUb255IFZyb29u
IDx0b255QGxpbngubmV0Pg0KDQotLS0gc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMub3Jp
ZwkyMDA4LTA2LTAzIDIyOjEzOjA0LjAwMDAwMDAwMCArMDEwMA0KKysrIHNvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCTIwMDgtMDYtMDMgMjI6MTQ6NDIuMDAwMDAwMDAwICswMTAwDQpAQCAt
OTI4MCw2ICs5MjgwLDcgQEANCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MzBjYywgIlRPU0hJ
QkEiLCBBTEMyNjhfVE9TSElCQSksDQogCVNORF9QQ0lfUVVJUksoMHgxMDI1LCAweDAxMjYsICJB
Y2VyIiwgQUxDMjY4X0FDRVIpLA0KIAlTTkRfUENJX1FVSVJLKDB4MTAyNSwgMHgwMTMwLCAiQWNl
ciBFeHRlbnNhIDUyMTAiLCBBTEMyNjhfQUNFUiksDQorCVNORF9QQ0lfUVVJUksoMHgxNGMwLCAw
eDAwMjUsICJDT01QQUwgSUZMOTAvSkZMLTkyIiwgQUxDMjY4X1RPU0hJQkEpLA0KIAlTTkRfUENJ
X1FVSVJLKDB4MTUyZCwgMHgwNzYzLCAiRGl2ZXJzZSAoQ1BSMjAwMCkiLCBBTEMyNjhfQUNFUiks
DQogCXt9DQogfTsNCg==


--=-vMQFsSwJkfZiuBuL+7c5--

--=-d1+KxAjQa0VmnEdXza6m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhGZeMACgkQp5vW4rUFj5qiKQCgiu5TumJYuj3/7dyVV+DGLPjV
9+gAoI41zDVEfL3eidZyoKMA/1ZtsX+X
=Gs0N
-----END PGP SIGNATURE-----

--=-d1+KxAjQa0VmnEdXza6m--


--===============6597960839744775765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6597960839744775765==--
