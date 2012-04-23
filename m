From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 23 Apr 2012 19:59:37 +0100
Message-ID: <20120423185936.GW8318@opensource.wolfsonmicro.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4121752375086577447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E63B1043F7
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 20:59:42 +0200 (CEST)
In-Reply-To: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4121752375086577447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je0mZywpqEo4t1RU"
Content-Disposition: inline


--je0mZywpqEo4t1RU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 11:33:22AM +0200, Ola Lilja wrote:

This is massively better than previous versions!  There's still some
issues but hopefully not hard to correct.

> @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
>  	tristate "Build all ASoC CODEC drivers"
>  	select SND_SOC_88PM860X if MFD_88PM860X
>  	select SND_SOC_L3
> +	select SND_SOC_AB8500_CODEC if SND_SOC_UX500

Shouldn't this depend on the MFD core for the device instead?

> +static int regulators_init(struct device *dev)
> +{
> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "%s: Enter\n", __func__);
> +
> +	regulators_get_regulator(dev, &drvdata->reg_vaud, "V-AUD");
> +	regulators_get_regulator(dev, &drvdata->reg_vamic1, "V-AMIC1");
> +	regulators_get_regulator(dev, &drvdata->reg_vamic2, "V-AMIC2");
> +	regulators_get_regulator(dev, &drvdata->reg_vdmic, "V-DMIC");
> +
> +	if (IS_ERR(drvdata->reg_vaud.consumer) ||
> +		IS_ERR(drvdata->reg_vamic1.consumer) ||
> +		IS_ERR(drvdata->reg_vamic2.consumer) ||
> +		IS_ERR(drvdata->reg_vdmic.consumer)) {
> +		regulators_cleanup(drvdata);
> +		return -ENXIO;
> +	}

This won't work with probe deferral - if we need to defer then the
driver will squash down the -EPROBE_DEFER and fail totally.  Not a big
deal, though.

> +static int dapm_audioclk_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *k, int event)
> +{

We should add a variant of REGULATOR_SUPPLY for clocks too, have a
framework thing that will own the clock - this is all generic code which
gets repeated for each clock, we could easily factor it out into the
core.

> +static int dapm_audioreg_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *k, int event)
> +{
> +	struct device *dev = w->codec->dev;
> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
> +	int status = 0;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		status = regulator_enable(drvdata->reg_vaud.consumer);
> +	else
> +		regulator_disable(drvdata->reg_vaud.consumer);

Similarly this is just a REGULATOR_SUPPLY.

> +/* Mic 1b - Regulator select */
> +static const struct soc_enum enum_mic1breg_sel = SOC_ENUM_SINGLE(0, 0, 2,
> +								enum_micreg);
> +static const struct snd_kcontrol_new dapm_mic1breg_mux[] = {
> +				SOC_DAPM_ENUM_VIRT("Mic 1b Regulator Select",
> +						enum_mic1breg_sel),
> +};

Can you explain how this hardware works in more detail?  It seems very
odd to be changing the regulator used to supply something at runtime.

> +static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
> +	unsigned int val;
> +
> +	val = (ucontrol->value.enumerated.item[0] != 0);
> +	if (drvdata->mclk_sel == val)
> +		return 0;
> +
> +	drvdata->mclk_sel = val;
> +
> +	return 1;
> +}

This is really weird

> +static const char * const enum_earselcm[] = {"0.95V", "1.10V", "1.27V",
> +					"1.58V"};
> +static SOC_ENUM_SINGLE_DECL(soc_enum_earselcm,
> +	AB8500_ANACONF1, AB8500_ANACONF1_EARSELCM, enum_earselcm);

Some of this stuff looks awfully like it ought to be platform data...

> +static const char * const enum_ensemicx[] = {"Differential", "Single Ended"};
> +static SOC_ENUM_SINGLE_DECL(soc_enum_ensemic1,
> +	AB8500_ANAGAIN1, AB8500_ANAGAINX_ENSEMICX, enum_ensemicx);
> +static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic1,
> +	AB8500_ANAGAIN1, AB8500_ANAGAINX_LOWPOWMICX, enum_dis_ena);

This for example is normally fixed by the physical design and can't
sensibly be varied at runtime.

> +	/* Digital interface - AD to slot mapping */
> +	SOC_ENUM("Digital Interface AD To Slot 0 Map", soc_enum_adslot0map),
> +	SOC_ENUM("Digital Interface AD To Slot 1 Map", soc_enum_adslot1map),

Can you usefully leave these fixed with a default configuration?
There's been some chat about adding a framework feature for this but
it's not there yet - lots of devices have similar features.  If not then
this code is fine.

> +static int ab8500_codec_configure_audio_macrocell(struct snd_soc_codec *codec)
> +{
> +	u8 value8;
> +	unsigned int value;
> +	int status;
> +
> +	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
> +				AB8500_STW4500CTRL3_CLK32KOUT2DIS |
> +					AB8500_STW4500CTRL3_RESETAUDN,
> +				AB8500_STW4500CTRL3_RESETAUDN);
> +	if (status < 0)
> +		return status;
> +
> +	status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
> +						(u8)AB8500_GPIO_DIR4_REG,
> +						&value8);
> +	if (status < 0)
> +		return status;
> +	value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
> +		GPIO31_DIR_OUTPUT;
> +	status |= abx500_set_register_interruptible(codec->dev,
> +						(u8)AB8500_MISC,
> +						(u8)AB8500_GPIO_DIR4_REG,
> +						value);

Still not sure why this isn't platform data.

> +	/* Add controls */
> +	status = snd_soc_add_codec_controls(codec, ab8500_ctrls,
> +				ARRAY_SIZE(ab8500_ctrls));
> +	if (status < 0) {
> +		dev_err(dev, "%s: failed to add codec-controls (%d).\n",
> +			__func__, status);
> +		return status;
> +	}

At least this one could be done from the driver struct.

> +	/* Add DAPM-widgets */
> +	status = snd_soc_dapm_new_controls(&codec->dapm, ab8500_dapm_widgets,
> +			ARRAY_SIZE(ab8500_dapm_widgets));
> +	if (status < 0) {
> +		dev_err(codec->dev,
> +			"%s: Failed to create DAPM controls (%d).\n",
> +			__func__, status);
> +		return status;
> +	}

This could also be done from the driver struct.

> +	status = snd_soc_dapm_add_routes(&codec->dapm, ab8500_dapm_routes,
> +					ARRAY_SIZE(ab8500_dapm_routes));
> +	if (status < 0) {
> +		dev_err(codec->dev, "%s: Failed to add DAPM routes (%d).\n",
> +			__func__, status);
> +		return status;
> +	}

This too.

> +	if (IS_ERR(drvdata->clk_ptr_sysclk)) {
> +		dev_err(dev,
> +			"%s: ERROR: Clocks needed for streaming not available!",
> +			__func__);
> +		return -ENXIO;

return PTR_ERR().

> +	dev_info(&pdev->dev, "%s: Register codec.\n", __func__);

Remove this or downgrade to debug, it's noisy and not adding much
information.

--je0mZywpqEo4t1RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlaZUAAoJEBus8iNuMP3dm98P/j0onUJSpBqh0BLiU6DOLfpX
n3GQc0DKe2sj1uugKhoe7wsKVPDDQWuYujU5bP8Ezy3R6NwJkrew5mP5kjYoYKfY
XkEB7WO12RBSjXD0o3TcGymA/BPH1ZutDhaSihN7YIA4nVL5YTZiaMpIOCQNV8uJ
VpGfIgJCMTB+X5W+jyI2guwfVebDDFP5DRDKqE//EcMotNlxQwTrCbalIbd6U/wx
w4f0pSYY3Pe7kpwX/p5ftuX3QeghOo95/dgIjw1dFre31BYEdhNl/tMlV6ESrKS5
v35s60c0Dm1HBQogF/EefO4NOsy+YaWeVb090bJbDYRR7e5+x2X98jGpj1gvYKSs
OSfjFuPCexg7YTZ+V69KjBnb/C/L6NVBWGStr/Bi+Cpx7q8c2zXEMsdMJ4pz1eWy
AUfRI44JZlPf52jveBqA99ojQFg8JPr+1KSfWz2p4P5LVUKF0YPaY8L4ymnOx+gu
ecl1h1p8Tb30hs9AoRL+SFkGKeRu2/jld+osm/VRHUsfJV8GGhdXXCKwhjJyR058
6romGfBCGOT4CZBGCuJAwfbYre0eGhAD4KRcl0jAFPpS8jlcWhf1yG69Mz5TAl+S
GZ/UcyP0i2jqtnPIhTqBBXFyctQwRs5jn+j2YDHEtXiOnV0EDlqKUWr9U6IWW2Tx
AEfGE9ona/sfv96PSpgu
=QJ8O
-----END PGP SIGNATURE-----

--je0mZywpqEo4t1RU--

--===============4121752375086577447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4121752375086577447==--
