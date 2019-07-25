From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: cs47l15: Add codec driver for
 Cirrus Logic CS47L15
Date: Thu, 25 Jul 2019 13:47:33 +0100
Message-ID: <20190725124732.GA4213@sirena.org.uk>
References: <20190725123152.28179-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1061313715301916514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D88E8F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 14:47:35 +0200 (CEST)
In-Reply-To: <20190725123152.28179-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1061313715301916514==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2019 at 01:31:51PM +0100, Charles Keepax wrote:

>  	select SND_SOC_CS47L24 if MFD_CS47L24
> +	select SND_SOC_CS47L15 if MFD_CS47L15
>  	select SND_SOC_CS47L35 if MFD_CS47L35

The Makefile and Kconfig sorting is a bit off.  Please send a followup
fixing this.

> +static irqreturn_t cs47l15_adsp2_irq(int irq, void *data)
> +{
> +	struct cs47l15 *cs47l15 = data;
> +	struct madera_priv *priv = &cs47l15->core;
> +	struct madera *madera = priv->madera;
> +	int ret;
> +
> +	ret = wm_adsp_compr_handle_irq(&priv->adsp[0]);
> +	if (ret == -ENODEV) {
> +		dev_err(madera->dev, "Spurious compressed data IRQ\n");
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cs47l15_dsp_bus_error(int irq, void *data)
> +{
> +	struct wm_adsp *dsp = (struct wm_adsp *)data;
> +
> +	return wm_adsp2_bus_error(dsp);
> +}

Noticeable difference in pattern between these two interrupt helpers
(and makes me wonder why we need the wrappers at all).

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05pOIACgkQJNaLcl1U
h9AyIAf/eTR5+rJfcY6/4JYG398BWfKCj9Lmn//ckAnVftEqwCoh2X525gSdj7Aq
Rtb0zeFXGrqWBbl0Fiuo1Uhx15PidXC9DQltbetZLCV0BGHX3hXhac8rcvnEX9AN
lU9p+6s9+3dOaLT0KpKrmbvu0TIqR/H0NsY/5WnphBDKwPt3WJuxcIeZkhITVcEY
AYxvPUjekXKdhZpWWe/KrOi3HRX0KXs4oM7j+GFPpnOg81hz6sCYbsv4eDVkmpBo
rYws3KPnBALQbC+p5y7TXfR9YiN7G0QTlle07zGdadtbQmAT/Y0b1/+5qnJPEZTq
u5In/7/l1Ob5zvxOP0tBUZ2XazjWrg==
=G85S
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--===============1061313715301916514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1061313715301916514==--
