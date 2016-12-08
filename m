From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS43130 codec
Date: Thu, 8 Dec 2016 16:23:36 +0000
Message-ID: <20161208162336.l5g5cbcc2bzt65ke@sirena.org.uk>
References: <09a77398-831b-4be7-9089-f7ac4fcfc16a@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jmalvq2pta2m4xz7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <09a77398-831b-4be7-9089-f7ac4fcfc16a-k7YZYYsDncjfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--jmalvq2pta2m4xz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 07, 2016 at 02:17:27PM -0600, Li Xu wrote:

Overall this looks pretty good - there's a fair number of issues below
but they're all fairly simple stylistic things rather than anything
majorly wrong so hopefully should be easy to correct.

>  	select SND_SOC_CS53L30 if I2C
> +	select SND_SOC_CS43130 if I2C
>  	select SND_SOC_CX20442 if TTY

Please keep Kconfig and Makefile sorted.

> +static bool cs43130_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CS43130_DEVID_AB ... CS43130_SUBREV_ID:
> +	case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
> +		return true;

You don't need to mark the device ID volatile, just don't provide
defaults and regmap will cache it the first time it reads it.  If the
device ID is volatile you've got bigger problems.

> +			/*PDN_PLL= 0,enable*/

Please use the standard kernel coding style, need spaces here.

> +			regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_9,
> +					    CS43130_PLL_REF_PREDIV_MASK,
> +						pll_ratio_table[i].sclk_prediv
> +						);

There's no need for the ); to be on a new line here, nor for the extra
indentation on the line before.  There are lots more coding style
issues, checkpatch will probably pick up many of them.

> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (cs43130->pll_bypass)
> +			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_XTAL);
> +		else
> +			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
> +
> +		usleep_range(10000, 10050);
> +		/*ASP_3ST = 0 in master mode*/
> +		if (cs43130->dai_mode)
> +			regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
> +						    0x01, 0x00);

No need to undo this in slave mode?

> +	if (stickies[0] & CS43130_XTAL_ERR_INT)
> +		pr_debug("%s: Crystal err\n", __func__);

dev_ prints and shouldn't this one be an error?

> +	/* Enable HP detect */
> +	regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
> +		CS43130_HP_DETECT_CTRL_MASK, CS43130_HP_DETECT_CTRL_MASK);

Why enable this when the only handling is a couple of log messages?

> +#ifdef CONFIG_PM
> +static int cs43130_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions, they don't serve any purpose.

--jmalvq2pta2m4xz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhJiQcACgkQJNaLcl1U
h9AYEgf8D83r8tso3rD+U8nmJ54K8BarXdYcyG12O6lvk7IlOFZResk3FE7VJVoh
Py61GlRwoMil8J9qtewABCUr3V1PbZ90o0j5Dx4E1xsIvl/KyzRXjjKHCq9Mgb8n
9CIrK5t3pzS8aZBzB+ObJNdihtD4zu2nRdY9g9ofK8e71oItMh0bS0YHgixo+AUs
WBthzs4dsSLnoU/170Wb18WoCISzJy29+nlQKtMQEUI0jlxKwzf2w9l5mhgUiJNX
OBZ6YmE/62KZy/crQrLOV/StEYkR04pF4STxWlWjZ760sNX4GHMAZtF9frexBDt9
lFolhnvfTqrvrX55hzj9I8mxk6AElg==
=NRlR
-----END PGP SIGNATURE-----

--jmalvq2pta2m4xz7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
