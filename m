From: Tony Vroon <tony@linx.net>
Subject: [ALC262 patch_realtek.c] Fujitsu Lifebook PC speaker
	signal
Date: Thu, 10 Apr 2008 12:10:41 +0100
Message-ID: <1207825841.5651.20.camel@localhost>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5278760266479011310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 730D62447F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 13:13:52 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============5278760266479011310==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MQ6mXDHOhkb5iX/Xo41t"


--=-MQ6mXDHOhkb5iX/Xo41t
Content-Type: multipart/mixed; boundary="=-czqnxqTkrVtDPU5TOrLY"


--=-czqnxqTkrVtDPU5TOrLY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good afternoon,

Could you please consider the following patch for the 2.6.26 merge window.
The legacy PC speaker signal was not routed to outputs. The codec is not=20
prevented from powering down in this patch, although I suppose one could=20
argue that perhaps it should be. Let me know if anyone feels strongly one=20
way or the other.

Signed-Off-By: Tony Vroon <tony@linx.net>

Regards,
Tony V.
LINX sysadmin

--=-czqnxqTkrVtDPU5TOrLY
Content-Disposition: attachment; filename=alc262-fujitsu-pcspk.patch
Content-Type: text/x-patch; name=alc262-fujitsu-pcspk.patch; charset=utf-8
Content-Transfer-Encoding: base64

LS0tIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jLk9MRAkyMDA4LTA0LTEwIDExOjUyOjIz
LjAwMDAwMDAwMCArMDEwMA0KKysrIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDgt
MDQtMTAgMTE6NTA6MjkuMDAwMDAwMDAwICswMTAwDQpAQCAtODA2NSw2ICs4MDY1LDggQEANCiAJ
fSwNCiAJSERBX0NPREVDX1ZPTFVNRSgiQ0QgUGxheWJhY2sgVm9sdW1lIiwgMHgwYiwgMHgwNCwg
SERBX0lOUFVUKSwNCiAJSERBX0NPREVDX01VVEUoIkNEIFBsYXliYWNrIFN3aXRjaCIsIDB4MGIs
IDB4MDQsIEhEQV9JTlBVVCksDQorCUhEQV9DT0RFQ19WT0xVTUUoIlBDIFNwZWFrZXIgVm9sdW1l
IiwgMHgwYiwgMHgwNSwgSERBX0lOUFVUKSwNCisJSERBX0NPREVDX01VVEUoIlBDIFNwZWFrZXIg
U3dpdGNoIiwgMHgwYiwgMHgwNSwgSERBX0lOUFVUKSwNCiAJSERBX0NPREVDX1ZPTFVNRSgiTWlj
IEJvb3N0IiwgMHgxOCwgMCwgSERBX0lOUFVUKSwNCiAJSERBX0NPREVDX1ZPTFVNRSgiTWljIFBs
YXliYWNrIFZvbHVtZSIsIDB4MGIsIDB4MCwgSERBX0lOUFVUKSwNCiAJSERBX0NPREVDX01VVEUo
Ik1pYyBQbGF5YmFjayBTd2l0Y2giLCAweDBiLCAweDAsIEhEQV9JTlBVVCksDQo=


--=-czqnxqTkrVtDPU5TOrLY--

--=-MQ6mXDHOhkb5iX/Xo41t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkf99bEACgkQp5vW4rUFj5rlkgCfTfbZLzRvaYN3uqYCfbXlOoLu
VhkAnRb8he65ESafJiF6hQGyOEScVEAE
=k0QN
-----END PGP SIGNATURE-----

--=-MQ6mXDHOhkb5iX/Xo41t--


--===============5278760266479011310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5278760266479011310==--
