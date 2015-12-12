From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 178/182] ASoC: wm8903: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:50:19 +0000
Message-ID: <20151212225019.GC579@sirena.org.uk>
References: <1449669097-7214-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669097-7214-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:51:37PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKRhAAoJECTWi3JdVIfQrpIH/jFe+8TBwatuK1NPubLmdVhJ
O/TJ/cbXobDdmQlotnx/2c1BPntv9Erau8buIkaxZyGWiyQCdgYye3QC842HEhqz
/zgOsJdqLjKHvgNssCzExB/+EpppKsOnD0Acr/mhVWVEecmlKMKXgUwOlS7aXe8J
mxpOTcI6L+sPPXNbFKjBJBFnixk8bTG/Ph+uiSyPK/QGOeGyjSjq6Qrhgp0rFoB+
jd/s9DUAYuXtjgSuP5o0S6Ge90dCpSTo0MHN8mRIF/Q0VlspWjsNey1Lw/VJRnL1
B0UsOwALoOocPewTne8fLuvkmmW/V6P91fFBOtt5xD4ncQeEHKGDLA8J4ocg818=
=QzLI
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
