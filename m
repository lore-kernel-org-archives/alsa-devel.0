From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 177/182] ASoC: wm5100: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:48:52 +0000
Message-ID: <20151212224852.GB579@sirena.org.uk>
References: <1449669089-7167-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669089-7167-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:51:29PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKRRAAoJECTWi3JdVIfQcyoH/0FzjEd5QT8FkA5tTk1T7dZz
9vsDDHJhCojmV5Hk23o86v6vRA71In9JE24FwX0hIxS+rEKw2VmcrWrN9YGXF8rn
ovmscElx1RsypWuDWoWjJpdseBwh8SpIEEfgbbXMXUdpO+cf4t5KW4++R5jyGQIk
cxNp+4WCZFaMzotxnOdifsgKQ15Io+HVDUzS8vixNUBo86QsaPoxzJpoCzyaqZI2
YWaZ+ldwar8AiHpYRsGHDACZGbNoa/ek25O1B6ZRVoA9hNliSXOo4CarGfUOqtjt
FWauHbh26BPEAOqqhUhbVkdkvPZRO3kcJzdxrREZwJ6O/+nHXFOb/uftu4xYSLI=
=SvXm
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
