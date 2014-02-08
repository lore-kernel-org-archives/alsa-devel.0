From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Sat, 08 Feb 2014 17:06:39 +0100
Message-ID: <52F6560F.7060606@metafoo.de>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com> <1391749517-11787-2-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391749517-11787-2-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/07/2014 06:05 AM, Sean Cross wrote:
> Add support for the ES8328 audio codec.

Hi,

a couple of minor coments. Also when submitting a patch it is a good idea to 
run scripts/checkpatch.pl on the patch itself and `make C=2` and `make C=2 
CHECK=scripts/coccicheck` on your driver module (E.g. in your case `make C=2 
sound/soc/codecs/es8328.o`). These tools check your driver for a couple of 
known issues. Fixing those before the submission will make the reviews job 
easier.
> [...]
> +uint8_t sample_ratios[] = {

static const

> +	[ES8328_RATE_8019 ] = 0x9,
> +	[ES8328_RATE_11025] = 0x7,
> +	[ES8328_RATE_22050] = 0x4,
> +	[ES8328_RATE_44100] = 0x2,
> +};
> [...]
> +
> +static int es8328_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		u8 dac = snd_soc_read(codec, ES8328_DACCONTROL2);
> +		dac &= ~ES8328_DACCONTROL2_RATEMASK;
> +
> +		switch (params_rate(params)) {
> +		case 8000:
> +			dac |= sample_ratios[ES8328_RATE_8019];
> +			break;
> +		case 11025:
> +			dac |= sample_ratios[ES8328_RATE_11025];
> +			break;
> +		case 22050:
> +			dac |= sample_ratios[ES8328_RATE_22050];
> +			break;
> +		case 44100:
> +			dac |= sample_ratios[ES8328_RATE_44100];
> +			break;
> +		default:
> +			dev_err(codec->dev, "%s: unknown rate %d\n",
> +				 __func__, params_rate(params));
> +			return -EINVAL;
> +		}
> +		snd_soc_write(codec, ES8328_DACCONTROL2, dac);
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		u8 adc = snd_soc_read(codec, ES8328_ADCCONTROL5);
> +		adc &= ~ES8328_ADCCONTROL5_RATEMASK;
> +
> +		switch (params_rate(params)) {
> +		case 8000:
> +			adc |= sample_ratios[ES8328_RATE_8019];
> +			break;
> +		case 11025:
> +			adc |= sample_ratios[ES8328_RATE_11025];
> +			break;
> +		case 22050:
> +			adc |= sample_ratios[ES8328_RATE_22050];
> +			break;
> +		case 44100:
> +			adc |= sample_ratios[ES8328_RATE_44100];
> +			break;
> +		default:
> +			dev_err(codec->dev, "%s: unknown rate %d\n",
> +				 __func__, params_rate(params));
> +			return -EINVAL;
> +		}
> +		snd_soc_write(codec, ES8328_ADCCONTROL5, adc);
> +	}

The only difference between the capture and the playback path seems to be 
the register that's written two. By adding a variable that holds the 
register number and gets initialized based on the direction you can elimate 
about half of the code in this function.

> +
> +	return 0;
[...]
> +static int es8328_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +			         int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (clk_id) {
> +	case 0:
> +		es8328->sysclk = freq;

es8328->sysclk seems to be unused. I guess it might be used if you add 
support for different base clock rates. For now you should probably return 
an error if freq != 22579200.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
[...]
> +static int es8328_dac_enable(struct snd_soc_codec *codec)
> +{
> +	u16 old_volumes[4];
> +	u16 reg;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		old_volumes[i] = snd_soc_read(codec, i + ES8328_DACCONTROL24);
> +		snd_soc_write(codec, i + ES8328_DACCONTROL24, 0);
> +	}

This looks like a job for AUTOMUTE controls. They'll set the volume to zero 
before the DAC is powered down and restore the original value after the DAC 
was powered up.

> +
> +	/* Power up LOUT2 ROUT2, and power down xOUT1 */
> +	snd_soc_write(codec, ES8328_DACPOWER,
> +			ES8328_DACPOWER_ROUT2_ON |
> +			ES8328_DACPOWER_LOUT2_ON);
> +
> +	/* Enable click-free power up */
> +	snd_soc_write(codec, ES8328_DACCONTROL6, ES8328_DACCONTROL6_CLICKFREE);
> +	snd_soc_write(codec, ES8328_DACCONTROL3, 0x36);
> +
> +	/* Set I2S to 16-bit mode */
> +	snd_soc_write(codec, ES8328_DACCONTROL1, ES8328_DACCONTROL1_DACWL_16);
> +
> +	/* No attenuation */
> +	snd_soc_write(codec, ES8328_DACCONTROL4, 0x00);
> +	snd_soc_write(codec, ES8328_DACCONTROL5, 0x00);
> +
> +	/* Set LIN2 for the output mixer */
> +	snd_soc_write(codec, ES8328_DACCONTROL16,
> +			ES8328_DACCONTROL16_RMIXSEL_RIN2 |
> +			ES8328_DACCONTROL16_LMIXSEL_LIN2);
> +
> +	/* Point the left DAC at the left mixer */
> +	snd_soc_write(codec, ES8328_DACCONTROL17, ES8328_DACCONTROL17_LD2LO);
> +	/* Point the right DAC at the right mixer */
> +	snd_soc_write(codec, ES8328_DACCONTROL20, ES8328_DACCONTROL20_RD2RO);
> +
> +	/* Disable all other outputs */
> +	snd_soc_write(codec, ES8328_DACCONTROL18, 0x00);
> +	snd_soc_write(codec, ES8328_DACCONTROL19, 0x00);
> +
> +
> +	/* Disable mono mode for DACL, and mute DACR */
> +	snd_soc_write(codec, ES8328_DACCONTROL7, 0x00);
> +
> +	for (i = 0; i < 4; i++)
> +		snd_soc_write(codec, i + ES8328_DACCONTROL24, old_volumes[i]);
> +
> +	reg = snd_soc_read(codec, ES8328_CHIPPOWER);
> +	reg &= ~(ES8328_CHIPPOWER_DACVREF_OFF |
> +		 ES8328_CHIPPOWER_DACPLL_OFF |
> +		 ES8328_CHIPPOWER_DACSTM_RESET |
> +		 ES8328_CHIPPOWER_DACDIG_OFF);
> +	snd_soc_write(codec, ES8328_CHIPPOWER, reg);
> +	snd_soc_write(codec, ES8328_DACCONTROL3, 0x32);
> +
> +	return 0;
> +}
[...]
> +static int es8328_suspend(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +

If you don't do anything in suspend there is no need to provide a callback 
function.

> +static int es8328_resume(struct snd_soc_codec *codec)
> +{
> +	es8328_init(codec);
> +	return 0;
> +}
> +
> +static int es8328_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +	struct device *dev = codec->dev;
> +
> +	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to configure cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* power on device */
> +	es8328_init(codec);
> +
> +	return 0;
> +}
> +
> +static int es8328_remove(struct snd_soc_codec *codec)
> +{
> +	/* Power everything down and reset the cip */
> +	snd_soc_write(codec, ES8328_CHIPPOWER,
> +			ES8328_CHIPPOWER_DACSTM_RESET |
> +			ES8328_CHIPPOWER_ADCSTM_RESET |
> +			ES8328_CHIPPOWER_DACDIG_OFF |
> +			ES8328_CHIPPOWER_ADCDIG_OFF |
> +			ES8328_CHIPPOWER_DACVREF_OFF |
> +			ES8328_CHIPPOWER_ADCVREF_OFF);
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_codec_driver soc_codec_dev_es8328 = {

es8328_codec_driver is a better name.

THe soc_codec_dev_... naming scheme you see in some drivers comes from a pre 
multi-component era where it was more firt

> +	.probe =		es8328_probe,
> +	.remove =		es8328_remove,
> +	.suspend =		es8328_suspend,
> +	.resume =		es8328_resume,
> +	.controls =		es8328_snd_controls,
> +	.num_controls =		ARRAY_SIZE(es8328_snd_controls),
> +	.dapm_widgets =		es8328_dapm_widgets,
> +	.num_dapm_widgets =	ARRAY_SIZE(es8328_dapm_widgets),
> +	.dapm_routes =		es8328_intercon,
> +	.num_dapm_routes =	ARRAY_SIZE(es8328_intercon),
> +};
[...]
> +#if defined(CONFIG_SPI_MASTER)
> +static int es8328_spi_probe(struct spi_device *spi)
> +{
> +	struct es8328_priv *es8328;
> +	int ret;
> +
> +	es8328 = devm_kzalloc(&spi->dev, sizeof(struct es8328_priv),
> +			      GFP_KERNEL);

sizeof(*es8328) is the preferred style for kernel code.

> +	if (es8328 == NULL)
> +		return -ENOMEM;
> +
> +	es8328->regmap = devm_regmap_init_spi(spi, &es8328_regmap);
> +	if (IS_ERR(es8328->regmap))
> +		return PTR_ERR(es8328->regmap);
> +
> +	spi_set_drvdata(spi, es8328);
> +
> +	ret = snd_soc_register_codec(&spi->dev,
> +			&soc_codec_dev_es8328, &es8328_dai, 1);
> +	if (ret < 0)
> +		dev_err(&spi->dev, "unable to register codec: %d\n", ret);
> +
> +	return ret;
> +}
[...]
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +static int es8328_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct es8328_priv *es8328;
> +	int ret;
> +
> +	es8328 = devm_kzalloc(&i2c->dev, sizeof(struct es8328_priv),
> +			      GFP_KERNEL);

same here.

> +	if (es8328 == NULL)
> +		return -ENOMEM;
> +
> +	es8328->regmap = devm_regmap_init_i2c(i2c, &es8328_regmap);
> +	if (IS_ERR(es8328->regmap))
> +		return PTR_ERR(es8328->regmap);
> +
> +	i2c_set_clientdata(i2c, es8328);
> +
> +	ret =  snd_soc_register_codec(&i2c->dev,
> +			&soc_codec_dev_es8328, &es8328_dai, 1);
> +
> +	return ret;
> +}
> +
[...]
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
