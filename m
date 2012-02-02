From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Thu, 2 Feb 2012 23:14:37 +0000
Message-ID: <20120202231427.GG3112@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7626491668204071145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03D572435C
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 12:38:32 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 7B27A110471
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 11:38:29 +0000 (GMT)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7626491668204071145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 06:30:30AM -0800, Reddy, MR Swami wrote:

> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in & 0=
xff));
> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
> +                            ((state->in >> 8) & 0xff));
> +
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
> +                            state->out & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
> +                            (state->out >> 8) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
> +                            (state->out >> 16) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
> +                            (state->out >> 24) & 0xff);

I see you've ignored my concern about not validating the inputs at all
here.

> +       switch (lm49453->sysclk) {
> +       case 12288000:
> +       case 26000000:
> +       case 19000000:
> +               /* PLL CLK slection */
> +               pll_clk =3D ~BIT(4);
> +               break;
> +       case 48000:
> +       case 32576:
> +               /* FLL CLK slection */
> +               pll_clk =3D BIT(4);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

Similarly for my concern about why you're updating the PLL configuration
here - to repeat my previous comments shouldn't this be part of either
the sysclk or PLL setup?  It doesn't look anything to do with hw_params.

Please don't just ignore review comments, it's likely that if you send
the same code again the same issues will be raised.  At least reply to
the mail if you think the review has missed something.  It's not great
finding the same issues over and over again...

> +       case SND_SOC_BIAS_STANDBY:
> +               if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_OFF)
> +                       regcache_sync(lm49453->regmap);
> +      =20
> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
> +               break;
> +
> +       case SND_SOC_BIAS_OFF:
> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
> +               break;
> +       }

This looks very wrong, you're setting the chip enable bit to the same
value in both STANDBY and OFF.

> +static int lm49453_resume(struct snd_soc_codec *codec)
> +{
> +       struct lm49453_priv *lm49453 =3D snd_soc_codec_get_drvdata(codec);
> +=20
> +       regcache_sync(lm49453->regmap);
> +=20
> +       lm49453_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +       lm49453_set_bias_level(codec, codec->dapm.suspend_bias_level);
> +
> +       return 0;
> +}

If that's all you're doing to resume you shouldn't need suspend and
resume functions at all, you're also syncing the cache in set_bias_level()
and the subsystem will bring the device down to the lowest possible
power level (off in the case of this device) before it suspends.

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKxjJAAoJEBus8iNuMP3dzRoP/jLdGkJ0ziJEHjrGoP6uilGS
Y08Sic7w8PiUSJgRje1T1xjmiR0LyEbaz8v5I/vfTd8GrNo4X+0Rv7ZyTvEldif4
B41dT5zFb2YNtsQHfufI2hxKcn+DcnoJ/2AwXwYxRnX3RXswqgLteeCA8RGw7cgD
g/IP4v9lVJJxrZl1z9FjoRMgM0gdZSvHD1EmCNyhHZl25lken6B4KY3oRBomvkom
eWmjBcNfM6z5uyzR3dRyrLFlUWnpuDR+9m2rp7WMHPIeUoZSSmswxzavNEIlEXDv
N/9jC5V5Adsx+33l2JBctN+vB2FM2C6xNqNC9Zlcz93ARmUuNVTB9bYIqP9Co58z
FDaI5azRjSZ9L3lUC6dNFuASwA488gq5pyq2P/gw7APQfEzXNWg9We+WUmgIuYUh
QRpg2YjDzguCke7w+X4fGDS7uz710rI1F4eAR+hz05dGW0KEzzxJX8BGjEH/ws13
TbUm2boePqlKNUDCipHK5uE3DtDF4migVcXCorGXD4FmE3W8ZoBXfsQcwk4GHbP2
AyxQi7FpT2JkFeIqlJ5CL/BnNUYIRESeryQMmLHytqUxReNFvldhqhIrT4VqtLM/
4AkzRYY6R2+UKyg3KjFb5ws5Chwagac+3kDD9zlHyHGMDbVLHUT6FHqofO3UcITg
6eX8d0QTMUif9cMw47D7
=nc51
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

--===============7626491668204071145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7626491668204071145==--
