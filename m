From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: da7213: Add checking of SRM lock status before
 enabling DAI
Date: Tue, 10 May 2016 19:23:53 +0100
Message-ID: <20160510182353.GA6019@sirena.org.uk>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
 <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
 <20160510182143.GD6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160510182143.GD6261@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2016 at 07:21:43PM +0100, Mark Brown wrote:
> On Tue, May 10, 2016 at 04:11:05PM +0100, Adam Thomson wrote:
>=20
> > +		/* Slave mode, if SRM not enabled no need for status checks */
> > +		pll_ctrl =3D snd_soc_read(codec, DA7213_PLL_CTRL);
> > +		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
> > +			return 0;
>=20
> This isn't going to work, the driver has no volatile registers but it
> does have a cache...

Ugh, yes it does - was looking at the wrong driver there.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMib3AAoJECTWi3JdVIfQNFQH/R946umw6j9dZ0CgAxVtMbis
NjvyR9os3WtU0i+bmqvsZ8edk9/QRLePBvLl5PYK7COoPqGWOJQI5GW+ZZ/4D1eN
P4gk7FbQ+T2KUvLZUqlcdsKqMjYCPlrBvUZTjLPr6YJEo6KV2lkiDulNqwagDGix
4poYk78htaoZlvpimToTsP+1OutM7uoeNkzOTobUkKmrJVJ+wZmkLhctzOAQF1tt
a+9wP8mb2xdWaJjnY/JWXgaoSuSMCjU1W2j0YKHKYQsh0zg2ThQdI5+OQID15YtY
ITyZHotu41qkl9FGEmA6VYbJSbrHLzOn9loBn/izg7izrzWoIqG8/N1CBNZgv9E=
=CF3y
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
