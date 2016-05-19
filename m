From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: Enable cache usage to fix crashes on resume
Date: Thu, 19 May 2016 11:10:01 +0100
Message-ID: <20160519101001.GB8206@sirena.org.uk>
References: <1463593762-31871-1-git-send-email-broonie@kernel.org>
 <52f206d4-ea9d-0cfc-613a-c625298cb9b2@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52f206d4-ea9d-0cfc-613a-c625298cb9b2@ti.com>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 19, 2016 at 09:33:15AM +0300, Peter Ujfalusi wrote:

> Should the ak4642 implement the suspend callback and:

> static int ak4642_suspend(struct snd_soc_codec *codec)
> {
> 	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);
>=20
> 	regcache_cache_only(regmap, true);

> I know it is highly unlikely that anything is going to be written to the =
chip
> while the board is suspended. Probably the suspend and changing the cache=
 only
> is not needed, but in this way things look a bit more complete?

Yes, that's more idiomatic - it also allows better sharing with runtime
PM.

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPZD4AAoJECTWi3JdVIfQK8IH/RPgm94N8B1xOpQEgSvOkn7S
/xR1+4H9ntTd5wmSwk9fBSt3Wse+i32lIcPX6sQi/sFQYS3uvT5zoXw4yqg5hGw6
1Z/xtx4GoZPY1E0IorIR9IpOshih/6015uBHyg1HbvOwMzZGgN/imzyz/GbZXOr7
n0891/n/u8P1frqbOhntO48cAH3TksNwIZBA3HT1ttL3lIGQJ0UATQcwpKU//q7u
ZOMtNm4hv5qNxN1Uld6ar+wOCTzi8ckyxCBR827ak6lZxQV/K9dRw4rQswIMUlxW
ajRkjSmtBAkL6UzTQfXgPYFTwkXdg5gxfX2zEPn8hGrV8x0GavsdNFRwHpE42Ys=
=FiHw
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
