From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 30 May 2012 14:14:21 +0100
Message-ID: <20120530131421.GK9947@opensource.wolfsonmicro.com>
References: <1337865998-26150-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8327009323502792507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A34C5247A1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 15:14:22 +0200 (CEST)
In-Reply-To: <1337865998-26150-1-git-send-email-ola.o.lilja@stericsson.com>
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


--===============8327009323502792507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2012 at 03:26:38PM +0200, Ola Lilja wrote:

> +static void show_regulator_status(struct device *dev)
> +{
> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
> +	struct ab8500_codec_drvdata_dbg *dbg = &drvdata->dbg;
> +
> +	dev_dbg(dev, "%s: Regulator-status:\n", __func__);
> +	dev_dbg(dev, "%s:     V-AUD: %s\n", __func__,
> +		(regulator_is_enabled(dbg->vaud) > 0) ?
> +			"On" : "Off");
> +	dev_dbg(dev, "%s:     V-AMIC1: %s\n", __func__,
> +		(regulator_is_enabled(dbg->vamic1) > 0) ?
> +			"On" : "Off");
> +	dev_dbg(dev, "%s:     V-AMIC2: %s\n", __func__,
> +		(regulator_is_enabled(dbg->vamic2) > 0) ?
> +			"On" : "Off");
> +	dev_dbg(dev, "%s:     V-DMIC: %s\n", __func__,
> +		(regulator_is_enabled(dbg->vdmic) > 0) ?
> +			"On" : "Off");

What problems are you finding when you try to use the debug
infrastructure in both the regulator API and DAPM to discover the state
of the regulators?

> +	/* Clocks */
> +	SND_SOC_DAPM_CLOCK_SUPPLY("audioclk"),
> +	SND_SOC_DAPM_CLOCK_SUPPLY("gpio.1"),

This looks wrong - audioclk looks reasonable but gpio.1 looks like a
board-specific name which shouldn't be encoded into the driver.

> +	if (ucontrol->value.integer.value[0] != SID_APPLY_FIR) {
> +		dev_err(codec->dev,
> +			"%s: ERROR: This control supports '%s' only!\n",
> +			__func__, enum_sid_state[SID_APPLY_FIR]);
> +		return 0;
> +	}

I'd expect this to return an error...

> +	status = snd_soc_dapm_force_enable_pin(&codec->dapm,
> +					"ANC Configure Input");
> +	if (status < 0) {
> +		dev_err(dev,
> +			"%s: ERROR: Failed to enable power (status = %d)!\n",
> +			__func__, status);
> +		goto cleanup;
> +	}
> +	snd_soc_dapm_sync(&codec->dapm);
> +
> +	mutex_lock(&codec->mutex);

Your locking looks bad here.  Nothing ensures that something doesn't
come along and undo the force enable.  Looking at the code this is the
only function that fiddles with the input but there's still a race where
one writer might exit the mutex section and disable the pin while a
second enters the mutex section.

> +static int filter_control_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct filter_control *fc =
> +			(struct filter_control *)kcontrol->private_value;
> +	unsigned int i;
> +
> +	for (i = 0; i < fc->count; i++)
> +		ucontrol->value.integer.value[i] = fc->value[i];
> +
> +	return 0;
> +}
> +
> +static int filter_control_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct filter_control *fc =
> +			(struct filter_control *)kcontrol->private_value;
> +	unsigned int i;
> +
> +	for (i = 0; i < fc->count; i++)
> +		fc->value[i] = ucontrol->value.integer.value[i];

These don't seem to be locked?

> +int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)

static.  Lots of other functions in the rest of the driver have the same
issue.

> +static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
> +
> +	return 0;
> +}

Remove empty functions.

> +	default:
> +		dev_err(dai->codec->dev,
> +			"%s: ERROR: Unsupported INV mask 0x%x\n",
> +			__func__, fmt & SND_SOC_DAIFMT_INV_MASK);
> +		return -EINVAL;
> +		break;

The break is redundant.

> +	/* Only 16 bit slot width is supported at the moment in TDM mode */
> +	if (slot_width != 16) {
> +		dev_err(dai->codec->dev,
> +			"%s: ERROR: Unsupported slot_width %d.\n",
> +			__func__, slot_width);
> +		return -EINVAL;
> +	}

You've got code which supports other widths...

> +static struct snd_soc_codec_driver ab8500_codec_driver = {
> +	.probe =		ab8500_codec_probe,
> +	.read =			ab8500_codec_read_reg,
> +	.write =		ab8500_codec_write_reg,
> +	.reg_cache_size =	0,

no need to init things to zero or NULL in static structs.

> +#define PRE_PMU_POST_PMD			(SND_SOC_DAPM_PRE_PMU | \
> +						SND_SOC_DAPM_POST_PMD)

You shouldn't define stuff like this in your driver!

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxhyKAAoJEBus8iNuMP3dzLgP/27/8Em3/va4cAzjMQXhSMWJ
arS/CJ/seVwNUiYAmTF4Vv6zYW35cNY9SUCjeNB4oq1qNOwk3QWOCKWGHeNQKtor
Fz6kBShANd5TnSTEpjnL3YyeL3Xg2YNQ1QzLhGHdmgExw3lLDZ44BQc71qSpVJp7
BGPW+uoJOXAlbrGI48zlsVeM3Yw89zVrIhnzmexNZTZUnh7DykSNNkH5MJ5C/lM0
0XTqmOS8lGtGU+I4Z25m1x9MQV1Qi33QT116jtr6AlvYDAJ4Cxcyax0izEAuHZ/s
WQSH6ULUB+V1cjxFpgo582C7YkSjbVBBKkGRR0GD/ZtuUVfApmS1kElNV1UCfvwF
VGcmXsRep0SMDW+N44+F3IsdB3HbWnd7YjCFpFXVQEukf8lS1cTbCLOc1zQFwwq9
YER7D7y1omEMgvrXblb77jME9Biwd3CetDf1UHw+GW0j0vrGnSN1LBkp31FXbg/Q
hRSX1umTEib5ZRB5RGagxW4TISX52DPOUrSvOOo6FhqJbRzit5bu5732ak5zU0Fo
2M+9F/iaj7XJt3y5QE4JqXMde9Cdif+pJagdJOdGIlmGXpmVGYSJaqkp36jMYkT/
m5TJnUgYlbuBGMpRla5gVFNnRhjccFR5ADvKWsB/2Kl1ch8xodO9F9MghpIOFXD4
Ju5AZT5zF5fz/jyh60b9
=3T2i
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--

--===============8327009323502792507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8327009323502792507==--
