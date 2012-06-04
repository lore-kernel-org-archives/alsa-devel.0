From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: bfin: add i2s driver for blackfin
	bf60x processor
Date: Mon, 4 Jun 2012 16:07:33 +0100
Message-ID: <20120604150732.GM7538@opensource.wolfsonmicro.com>
References: <1338840199-19714-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6635326778772891776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7318924378
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 17:07:34 +0200 (CEST)
In-Reply-To: <1338840199-19714-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6635326778772891776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Content-Disposition: inline


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 04:03:19PM -0400, Scott Jiang wrote:
> This driver includes i2s dai, dma and sport driver. It enables i2s
> mode support on blackfin bf60x platform.

This should be a patch series, for example the DAI, DMA and SPORT
drivers would normally all be split out.

Overall this is mostly good, the main thing that's jumping out at me is
that the SPORT API looks like it doesn't really have too many device
specifics in it so it's a bit surprising that we need completely
separate I2S and DMA drivers for the two chip generations.

> +config SND_BF6XX_I2S
> +	tristate "SoC I2S Audio for the ADI BF6xx chip"
> +	depends on BLACKFIN && BF60x

Shouldn't BF60x already depend on BLACKFIN?

>  config SND_BF5XX_SOC_SSM2602
>  	tristate "SoC SSM2602 Audio support for BF52x ezkit"

This bit also needs updating...

>  config SND_BF5XX_SPORT_NUM
>  	int "Set a SPORT for Sound chip"
> -	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97 || SND_BF5XX_TDM)
> +	depends on (BLACKFIN && SND_SOC)

Shouldn't have a dependency on SND_SOC - this menu can't be entered
without ASoC being enabled.

> +static int __init snd_bfin_i2s_pcm_init(void)
> +{
> +	return platform_driver_register(&bfin_i2s_pcm_driver);
> +}
> +module_init(snd_bfin_i2s_pcm_init);

module_platform_driver().

> +#ifdef CONFIG_PM
> +static int bfin_i2s_suspend(struct snd_soc_dai *dai)
> +{
> +	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
> +
> +	if (dai->capture_active)
> +		sport_rx_stop(sport);
> +	if (dai->playback_active)
> +		sport_tx_stop(sport);
> +	return 0;
> +}

The framework should do this for you, by the time we get to suspending
there shouldn't be any active streams that aren't supposed to stay
active over the time the device is suspended.

> +static int __init bfin_i2s_init(void)
> +{
> +	return platform_driver_register(&bfin_i2s_driver);
> +}
> +
> +static void __exit bfin_i2s_exit(void)
> +{
> +	platform_driver_unregister(&bfin_i2s_driver);
> +}

module_platform_driver().

> +void sport_tx_start(struct sport_device *sport)
> +{

Is it not possible to make the SPORT API the same between the 5xx and
the 6xx such that we can share all the drivers between the two chip
generations with just the SPORT code varying?

> +	dev_info(dev, "SPORT create success\n");

Make this dev_dbg at most.

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzM8uAAoJEBus8iNuMP3dlyQQAIK/qj2b2jKvRN16jJ0LCw/W
doKp2PYmWy+REmu9g5MjHB/xtfEGZEL2gH5yQ4AMoim14Lk9T9YKfTSy2k3uxgH2
GkPPr6F3cf61SxBunQvyvvADXRlvX5A/PeJshifsI/tF4BzXWOQhwwWizGv0xqd/
UwWXzYzL1gVclyb7dMRhxmRkzFWNWze5D2HcXTCQJEXwO/YlmAQBsf+/lPmsCOOl
D3qRse/X11PzKStQ90dzOgG0X3YX4v0DYAaaymEPHTBTQZPk6mbMDnUA38RbZWOU
caweVA0gKuijrnJfDKYstZi++kx0fN4wPdiy6OoFUC1gw+pm8AhdZbLppNJPG/Tp
NsDoYU11cwgkUqcoW4TWczCXeqXWtrWlFCzv8MCqFBv92swzzIDv527GNEqzdhT3
wUncR9WN0A9+SEhern7CrEUNbBQcNSrPkckcFz5J/EqPLqEJxoiORI+StWJAOpj5
Eo8jzNdTikayJxVJJwCf1Fqe3PQTXO0iEuK7tTpJQLMV6YWmvjlLDS1psqPvwIye
tz2twRz7C1rkZ+sRC1zBAzk2WPoCg7BOcWUCuWH9im+pHxzUylgtHv1vJirv3+PV
fBHbmCRxDndy6nhf36iui70FUz53Dua7VLJfelM4CIVwRAbH/vdBd97uoIrhpDHd
0r/zXUAGvvm45Mh39fqD
=uMK9
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--

--===============6635326778772891776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6635326778772891776==--
