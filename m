From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add DA7210 codec device support
	for ALSA
Date: Wed, 9 Dec 2009 12:10:17 +0000
Message-ID: <20091209121017.GJ19851@opensource.wolfsonmicro.com>
References: <u4oo0x3gy.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B73D010383C
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 13:10:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <u4oo0x3gy.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>, Jason Coughlan <jason.coughlan@diasemi.com>, Dajun Chen <Dajun.Chen2@diasemi.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 11:53:33AM +0900, Kuninori Morimoto wrote:

> +static inline unsigned int da7210_read(struct snd_soc_codec *codec,
> +				       unsigned int reg)
> +{
> +	/* FIXME !!
> +	 *
> +	 * we should read status from I2C.
> +	 * But not supported now.
> +	 */

As Liam noted there are a few issues with the I2C stuff - you should be
able to resolve these issues by removing the I2C code in the driver with
soc-cache.c usage, which is a good idea anyway.

> +static const char *da7210_mic_bias_voltage[] = { "1.5", "1.6", "2.2", "2.3" };

> +static const struct soc_enum da7210_enum[] = {
> +	SOC_ENUM_SINGLE(DA7210_MIC_L, 4, 4, da7210_mic_bias_voltage),
> +};

Please use individual variables rather than an array - it doesn't make
much difference for small numbers of enums (like one!) but as the number
increases it makes it much easier to keep track of which enum is bein
referenced to by which control.

A couple of other comments of mine will be replicated from Liam's.

> +/* Add non DAPM controls */
> +static const struct snd_kcontrol_new da7210_snd_controls[] = {
> +	/* Mixer Playback controls */
> +	SOC_DOUBLE_R("DAC Gain", DA7210_DAC_L, DA7210_DAC_R, 0, 0x37, 1),

Should be "DAC Volume" - control names are interpreted by ALSA to let it
know how to present the controls to applications.

> +	SOC_DOUBLE("In PGA Gain", DA7210_IN_GAIN, 0, 4, 0x0F, 0),

Should be "In PGA Volume".

> +	SOC_SINGLE("Mic Bias", DA7210_MIC_L, 6, 1, 0),

This should be a DAPM widget.

> +	value  = da7210_read_reg_cache(codec, reg);
> +	value &= mask;
> +	da7210_write(codec, reg, value);

snd_soc_update_bits().

> +
> +	da7210_dai.dev = codec->dev;
> +	da7210_codec = codec;
> +
> +	ret = snd_soc_register_dai(&da7210_dai);
> +	if (ret) {
> +		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
> +		return -ENOMEM;
> +	}

Should also register the CODEC.

> +	/* Enable Left & Right MIC PGA and Mic Bias */
> +	da7210_write(codec, DA7210_MIC_L, DA7210_MIC_L_EN | DA7210_MICBIAS_EN);
> +	da7210_write(codec, DA7210_MIC_R, DA7210_MIC_R_EN);
> +
> +	/* Enable Left and Right input PGA */
> +	da7210_write(codec, DA7210_INMIX_L, DA7210_IN_L_EN);
> +	da7210_write(codec, DA7210_INMIX_R, DA7210_IN_R_EN);
> +
> +	/* Enable ADC Highpass Filter */
> +	da7210_write(codec, DA7210_ADC_HPF, DA7210_ADC_HPF_EN);
> +
> +	/* Enable Left and Right ADC */
> +	da7210_write(codec, DA7210_ADC, DA7210_ADC_L_EN | DA7210_ADC_R_EN);

These all look like they should be controls of some kind - either DAPM
or regular - and should be fairly straightforward to convert over.
Since you're already using DAPM the power stuff especially should be
properly supported since a mix of DAPM and non-DAPM control often leads
to confusion and bugs.

For power bits there's no point setting a default since DAPM will
overwrite them on startup anyway.  In general the ASoC policy is for the
CODEC driver to leave things at chip default since the driver has to
work on many boards and the chip default is usually chosen as it will
have to be at least somewhat sane for most boards.

> +	/* Enable DAI */
> +	da7210_write(codec, DA7210_DAI_CFG3, DA7210_DAI_OE | DA7210_DAI_EN);

I suspect you should use an AIF DAPM widget for these, or possibly an
AIF widget in conjunction with a supply widget.

> +	/* Diable PLL and bypass it */
> +	da7210_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);

> +	/* Bypass PLL and set MCLK freq rang to 10-20MHz */
> +	da7210_write(codec, DA7210_PLL_DIV3,
> +		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);

Since these aren't made configurable by the driver and are a bit more
involved than controls it's OK to set defaults for these, though ideally
they'd be supported by the driver.

> +       /* Enable standbymode */
> +       da7210_write(codec, DA7210_STARTUP2,
> +                    DA7210_LOUT1_L_STBY | DA7210_LOUT1_R_STBY |

...

> +       /* Activate all enabled subsystem */
> +       da7210_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);

This definitely looks like it ought to be being handled in the bias
level configuration and/or by DAPM.

> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +static int da7210_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)

No need to ifdef where I2C is the only control interface.
