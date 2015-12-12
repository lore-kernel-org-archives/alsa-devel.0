From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 181/182] ASoC: ac97: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:54:01 +0000
Message-ID: <20151212225401.GF579@sirena.org.uk>
References: <1449669121-7366-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669121-7366-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:52:01PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKWIAAoJECTWi3JdVIfQw7gH/2k+/Mmrv6FRBq0L09+A7rD9
TVF++p7wPNSqZdcvfFfIyYogiENvq6rCfrgjco1bgf3kT+eFshzebm/LH0CKtZcn
7ygG8b4T4G8SwmeNIioO81fxFMHS8gxswH8mRSvGxWYMhHFP4uhVXFjmXBJUj0lL
arvjCtHgkDgZd7Ygia9eDr5dAbxrP+i4vkJt+kug/bv+5jV9Vp7gKRucmyPfNtI6
Wy1BE+Z2zaOpaLpYD3jaBYia4xhoL65TbLFRvnOyk1SRan7LXJfDaSWcwJ+w8GKD
W8KS2kYLD7pfFKo6jczhKQONb4MBacl6VjyMpXZEW6cQFhscZ4xVs4F8enizlLA=
=6uQJ
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
