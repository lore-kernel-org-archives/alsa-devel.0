From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 180/182] ASoC: wm8996: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:53:47 +0000
Message-ID: <20151212225347.GE579@sirena.org.uk>
References: <1449669114-7317-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669114-7317-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:51:54PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKV6AAoJECTWi3JdVIfQiFkH/RICYuAoOtJX8JpiZsNfqD38
dRxC7NAIfYjpCbpuyOreK+Nquq5IaCVF6X0zeqycD4+cSo/N3D9E6ydp7j9XD7xR
JjT770t6LYDDAnrwhrsU7h5cbYT3QZMlb6CmCm8deEnFIserRQUlO2ZhA5aZLbMt
xi43izaETKLybvOPIgQjq0A0Z6XZfd4KJtbf96lOjPsC+IuXod2nEeo31MuIhrmH
0LOkDlhs+DL0LgJa/vj5KrYfJid0+i651ecjtJXxH2/ZYI5MBuc8sCBmwsJLNqBM
s/ZhDZkbe0j25xJlvMcrK1JlMCij41jY7EoHI+AO6Wfg2ST96vlvr4ZPo8c0Xr0=
=QiKT
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
