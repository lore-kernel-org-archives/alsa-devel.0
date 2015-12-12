From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 179/182] ASoC: wm8962: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:53:23 +0000
Message-ID: <20151212225323.GD579@sirena.org.uk>
References: <1449669107-7264-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669107-7264-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:51:47PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKS6AAoJECTWi3JdVIfQcAEH/AyrJR3wGykj4etLrF7e8lEH
mb+z+yuGWn3E7cccK0GUTx386kaFV+2d5Nqij8m48MuHqsxos54r1iIMlpregG3z
uz7CLoUV2XxVn2KsxroTI8yBkk8SIAoXtR7OgcZvuUyI52uKw2YpRqXHOrtA9iVr
2n8EDOeVxt/M3UzI8QGFNZ6T/2gBjXF+tS+CvqAdS5Y5amQoW/91YqltdU2WeIMg
N/Y28C2DtA0vesMBAfeXCw6GF/l5C6ATor3B/H1bDCRIWVx3ckrLWa6pwHGgu+rQ
Yq8SpdqZ8KnCetndD+VTmin7hDqNE2W2bLwqVfr82K2cS+neoaPxLPSOoeZ2Arg=
=uy0i
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
