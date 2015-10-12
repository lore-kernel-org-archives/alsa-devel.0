From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 12 Oct 2015 16:47:15 +0100
Message-ID: <20151012154715.GF4238@sirena.org.uk>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151012090045.GA7448@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 11:00:45AM +0200, Pavel Machek wrote:

> Does this look like a step in right direction?

>  static const struct regulator_desc arizona_ldo1_hc =3D {
> -	.name =3D "LDO1",

No, you definitely shouldn't be doing this - the regulator names should
reflect the names the device has in the datasheet to aid people in going
=66rom software to the hardware and back again.  They shouldn't be
dynamically generated at runtime.  If you need to namespace by device
provide an interface which explicitly namespaces by device rather than
hacking it into another interface, the usual thing is to use the struct
device as the context.

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWG9YDAAoJECTWi3JdVIfQwEoH/1cLfI87QVx6auh0DiJKtFVX
HpsZdp6jNlg4ESNYrABqn9KUbpvtSD0XB3sFsyLGbRIJS4P/jd/cIsKIu1STjcDC
rRiq4F8InF0WISssex1AniwjaMpwjpKM6b3nj5uUApyf0QwYD4kT5gxw9pCQPjtk
YCXtBPm/sljUtkLQLkeqFYFHckeLEfxQnH7kL0Obt1NZrRAzSVRp2lmJwJyvlvJG
1OGlyEeAasNdx2X98iuTMakjPmLy3x+j999R37PAiQfvJ2ZuVl+KJ91dsoQvuYG7
+GVCuzztz4rpNSSa7ZcZz1QReF9TQaIst/rbRAJSmfPptpE/vU3sdoqpbgK9+Ww=
=2Bu4
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
