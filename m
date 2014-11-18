From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: arizona: Add initial CS47L24 codec driver
Date: Tue, 18 Nov 2014 14:51:14 +0000
Message-ID: <20141118145114.GN22111@sirena.org.uk>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com>
 <20141111170543.GC25738@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141111170543.GC25738@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 05:05:43PM +0000, Richard Fitzgerald wrote:
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig   |    8 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/arizona.c |    5 +
>  sound/soc/codecs/cs47l24.c | 1133 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs47l24.h |   23 +

Can you split out the arizona.c change into a separate patch to be
merged via the MFD tree along with the new #define please?  Everything
else can go in via the ASoC tree but that build depends on the new
defines.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa1zhAAoJECTWi3JdVIfQ0t8H/jXoz+Qxae4NeoG8y2g5VKUJ
mRmwlDW9yKTIFCVyRFmzsaaXKgbBAhnjOG0ZTeW9CTYH/Yidlqpgq9cFOxPOlCMA
kw3P2inFLEpWDfunJ6/gA//Goa7hfRc38iyboDCzjcUAosiF5n/DBzw4VMhQPZ4w
WZUo7lXr0DjTIAGjFUt/irCZ0qLLWVB3W8tGuM4jpiZB1201ILnGMX+xPdJ99sa2
dS2PoDD47eQQRbG3D6hokeWFlOtdAjAZ2CyFmo6a5iSDfh8T+E94sIykvxahuVQj
pTa+s/jxwrWNGWp6x/IF4bjfcjh4Dj+/FxpYdpK3y/S3bGvLgGQ2nxhG7tOcrnI=
=ahcJ
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
