From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rnsd: fix build regression without CONFIG_OF
Date: Sat, 11 Apr 2015 23:05:28 +0100
Message-ID: <20150411220528.GW6023@sirena.org.uk>
References: <6164726.dCMByIoYOc@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wuN2GQ5aRyktBDdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6164726.dCMByIoYOc@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--wuN2GQ5aRyktBDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 12:18:37AM +0200, Arnd Bergmann wrote:
> The r-car sound driver only works when CONFIG_OF is set, and
> after a recent change has a compile-time dependency as well:

Applied, thanks.

--wuN2GQ5aRyktBDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKZqnAAoJECTWi3JdVIfQ7BsH/ijiHg/1Ia9hiTeKNNulXk3l
DErc4JBKhVvlw38F54a3PZ/bYxfptW9FJi5X2t6wku8cNY+/IRQe1TMLVvIuIP6K
RL1/r/XMuMyVt19+motE7zwTjJZ2YiJlhy+Y8CCn3vLFH/18Cz5LjpQh6W9BUXW2
AaKK8T6p+CVlzOqdX6AygdMKN84HYdXoSVyWcBPRi7dwG9HMD12ZDM/6UBaS3Y68
qBhgE1R69b/04tO2MslsuYrYrYE3WDE00FqRd2+rIrf4xcFaEFpnnn5OfpfrZAaI
2iJtOUCfoxQWUwZAd3jZvt9TPBEjyjjTlrfTnH+yNkwakFHYGrQJXaaCzmIkc7Y=
=rZUk
-----END PGP SIGNATURE-----

--wuN2GQ5aRyktBDdI--
