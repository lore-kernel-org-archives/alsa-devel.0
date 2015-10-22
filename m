From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: cs47l24: Add driver for Cirrus Logic
 CS47L24 and WM1831 codecs
Date: Thu, 22 Oct 2015 13:40:57 +0100
Message-ID: <20151022124057.GG8232@sirena.org.uk>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1445264027-7357-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445264027-7357-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 03:13:47PM +0100, Richard Fitzgerald wrote:

> @@ -134,6 +134,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_WM5100 if I2C
>  	select SND_SOC_WM5102 if MFD_WM5102
>  	select SND_SOC_WM5110 if MFD_WM5110
> +	select SND_SOC_CS47L24 if MFD_CS47L24
>  	select SND_SOC_WM8350 if MFD_WM8350
>  	select SND_SOC_WM8400 if MFD_WM8400
>  	select SND_SOC_WM8510 if SND_SOC_I2C_AND_SPI

Please keep the Makefile and Kconfig sorted.

> +config SND_SOC_CS47L24
> +	tristate "TEST cs47l24"
> +

This isn't a good help text for the symbol.

Otherwise the code looks good.

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKNlYAAoJECTWi3JdVIfQ51wH/jRi5+mpiG8OZ8PLj37oVxd7
U7XpNGssv/lOU18+dWhQcEwkW3NND+rwB9zOyYrropl5eaNtA0UQheoI9Qj9DyqW
0hhvDoPcYYaaWtP8dQrMifm8y4xAsfWos/qmd7OlcycoOIEXmI0RkVUugckhKK13
oYqD5wkTfIhBlyWu2+XzpR9ZTTafcVdMU9lDovhNxbaZwrke+Bvk1StlQgxB3ShJ
WzKZFtYKk8jpRwMIGMtnKA2Yo/DEi+uCqOAP+cyfVL8m6Ne4ZAUC//zwNy71GiyU
JP6zZIzi+w/eN8VJoEryi6cGYBMOD50aqNjRGnwiCBrHdvxZyMeycrt71MSLbeI=
=vy8I
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
