From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]fsl_ssi: fix of_property_read_u32_array return
 value check
Date: Thu, 5 Mar 2015 01:01:20 +0000
Message-ID: <20150305010120.GE21293@sirena.org.uk>
References: <54F77DAE.20005@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TDS/kOeeb6k+9xc4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F77DAE.20005@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--TDS/kOeeb6k+9xc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 10:48:30PM +0100, Maciej S. Szmigiero wrote:
> of_property_read_u32_array returns 0 on success,
> so the return value shouldn't be inverted twice,
> first on assignment then in condition expression.
>=20
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

Applied, thanks.

--TDS/kOeeb6k+9xc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU96rgAAoJECTWi3JdVIfQ3OsH/29rbEKEUx2MKle1uVyQyIk5
4glsvAqNwJI3kxqttF5EeHbK90PBiujFyQpPsHgPok+H9URYV4ohlzrlSpc2peRw
oiIje2nTvdWNWGejurqKnqctijmF8l94D9In0wbdFMIlEiE3rdulk44ZQO25O5Af
9cGwwV5AsxpSwzQvWveYy6NFXk5Dq2GoprGtG1Gg+2OMShBDRGZNh1W0M1+KAWZ0
F8jMMdlRvi5sYEvl1jr0M1Bxiplk1BH8VvdkVwbi/p6K6PUGdZ0XztIDTn6yfl80
JUDPDbvMMflI7QvwZ9cJVpbN6lxlCqBIzc3XUt43gHpNhKUMYsRSypQuNfaRSP0=
=xVnr
-----END PGP SIGNATURE-----

--TDS/kOeeb6k+9xc4--
