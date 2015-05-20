From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rx51: use flags argument of devm_gpiod_get to set
 direction
Date: Wed, 20 May 2015 19:09:05 +0100
Message-ID: <20150520180905.GN21577@sirena.org.uk>
References: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: alsa-devel@alsa-project.org


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 09:48:08AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.

Applied, thanks.

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXM3AAAoJECTWi3JdVIfQQJkH/1/9MWT5R+xYmi8/dHcNJF1T
3xWVgsLz2n1s0PP2iOulH+AFTHDB9NkvUgUxY+dfjIS74c2U0m6QARPSoyHvI8eM
lrOt2lHnj9X2U+Wp+wqnzOfVdLLiF9ON3PSnUE3Dw92/JzIAJD9v6kRzkYsDvFX3
1VVQxx5b+CfHlMN7GxDbqZ1uI6nMZjAipIS83KBqrQPMDVg0MhmHsmu69ICUpKFj
T3ISgP7GUBqTQLOF0/2FKFJdfVLEym4VG0ELnJR3EODRk40hP8CVqp5A03aHYMFm
01HfJ+7HtoxXG3st7kVqrPjOZPrxtXr3MSuXDNX5OVN4hkDAjmp8m3xMqLO4BqY=
=YKvu
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
