From: Tony Vroon <tony@linx.net>
Subject: RESEND: [ALC268 patch_realtek.c] COMPAL IFL90/JFL-92
	laptop quirk	to select ALC268_TOSHIBA
Date: Wed, 04 Jun 2008 11:05:59 +0100
Message-ID: <1212573959.3937.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8950588017365272450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A8924380
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 12:07:03 +0200 (CEST)
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


--===============8950588017365272450==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3pf9HDlPoUcuR2/CF2b+"


--=-3pf9HDlPoUcuR2/CF2b+
Content-Type: multipart/mixed; boundary="=-P4dzS2Kdp/Es4XOot/Qi"


--=-P4dzS2Kdp/Es4XOot/Qi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF=EF=BB=BFRight then, leave it to me to send the wrong version of t=
he patch from
the wrong e-mail address. Please disregard the previous message, that
diff will not apply. Apologies.

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

--=-P4dzS2Kdp/Es4XOot/Qi
Content-Disposition: attachment; filename=COMPAL-ALC268_TOSHIBA-v3.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=COMPAL-ALC268_TOSHIBA-v3.patch; charset=UTF-8

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


--=-P4dzS2Kdp/Es4XOot/Qi--

--=-3pf9HDlPoUcuR2/CF2b+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhGaQcACgkQp5vW4rUFj5r8uwCfSSD29EUtHWXBgtgQ3tYHGveM
SCEAoL39ks6F9JTq9wSaqb8YvcRq3Njg
=Y9XQ
-----END PGP SIGNATURE-----

--=-3pf9HDlPoUcuR2/CF2b+--


--===============8950588017365272450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8950588017365272450==--
