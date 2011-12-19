From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dsd1791: Introduce driver for TI
 DSD1791 stereo codec
Date: Mon, 19 Dec 2011 21:44:30 +0000
Message-ID: <1324331070.7421.6.camel@odin>
References: <1324320810-17948-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id DD959103852
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:44:35 +0100 (CET)
Received: by mail-we0-f177.google.com with SMTP id a10so2319947wer.22
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 13:44:32 -0800 (PST)
In-Reply-To: <1324320810-17948-1-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, leon@leon.nu, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-12-19 at 13:53 -0500, Michael Williamson wrote:
> This patch introduces a (spi) codec driver for the Texas Instruments
> DSD1791 24 bit audio stereo DAC.
> 
> http://www.ti.com/product/dsd1791
> 
> Testing for basic operation using 16 and 24 bit I2S mode has been
> performed using a MityDSP-L138 SOM and an Industrial I/O board
> from Critical Link.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Looks mostly fine, just a few comments :-

> ---
> This patch incorporates changes from the original RFC as a result of comments
> received from Mark Brown, Leon Romanovsky, and Lars-Peter Clausen.  Thanks.
> 
> Summary of Changes:
> 	- Use devm_kzalloc()
> 	- use regmap cached I/O feature of framework
> 	- simplify code applying codec fmt configuration
> 	- clean up section attributes on local functions
> 	- make local functions/variables static where appropriate
> 	- remove set_sysclk method
> 	- remove unused tlv header file
> 	- remove chatter
> 	- strip "-codec" from driver name
> 	- fixup driver variable name for consistency
> 	- Add Left and Right volume control
> 	- Add digital mute
> 
>  sound/soc/codecs/Kconfig   |    4 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/dsd1791.c |  256 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/dsd1791.c
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 4584514..95b7969 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -33,6 +33,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_CX20442
>  	select SND_SOC_DA7210 if I2C
>  	select SND_SOC_DFBMCS320
> +	select SND_SOC_DSD1791 if SPI_MASTER
>  	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
>  	select SND_SOC_LM4857 if I2C
>  	select SND_SOC_MAX98088 if I2C
> @@ -205,6 +206,9 @@ config SND_SOC_DA7210
>  config SND_SOC_DFBMCS320
>  	tristate
>  
> +config SND_SOC_DSD1791
> +	tristate
> +
>  config SND_SOC_DMIC
>  	tristate
>  
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index a2c7842..d6b5f6a 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -21,6 +21,7 @@ snd-soc-cx20442-objs := cx20442.o
>  snd-soc-da7210-objs := da7210.o
>  snd-soc-dfbmcs320-objs := dfbmcs320.o
>  snd-soc-dmic-objs := dmic.o
> +snd-soc-dsd1791-objs := dsd1791.o
>  snd-soc-l3-objs := l3.o
>  snd-soc-max98088-objs := max98088.o
>  snd-soc-max98095-objs := max98095.o
> @@ -120,6 +121,7 @@ obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
>  obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
>  obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
>  obj-$(CONFIG_SND_SOC_DFBMCS320)	+= snd-soc-dfbmcs320.o
> +obj-$(CONFIG_SND_SOC_DSD1791)	+= snd-soc-dsd1791.o
>  obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
>  obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
>  obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
> diff --git a/sound/soc/codecs/dsd1791.c b/sound/soc/codecs/dsd1791.c
> new file mode 100644
> index 0000000..41bbc61
> --- /dev/null
> +++ b/sound/soc/codecs/dsd1791.c
> @@ -0,0 +1,256 @@
> +/*
> + * ALSA SoC codec driver for Texas Instruments DSD1791.
> + *
> + * Author:      (C) Michael Williamson <michael.williamson@criticallink.com>
> + * Copyright:   (C) 2011 Critical Link, LLC
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +
> +#define DSD1791_REG_DIGATT_L	16
> +#define DSD1791_REG_DIGATT_R	17
> +#define DSD1791_REG_AUDFMT	18
> +#define DSD1791_REG_SRST	20
> +
> +#define DSD1791_FMT_16RJ	(0<<4)
> +#define DSD1791_FMT_20RJ	(1<<4)
> +#define DSD1791_FMT_24RJ	(2<<4)
> +#define DSD1791_FMT_24LJ	(3<<4)
> +#define DSD1791_FMT_16I2S	(4<<4)
> +#define DSD1791_FMT_24I2S	(5<<4)
> +#define DSD1791_FMT_MASK	0x70
> +
> +/* DSD1791 register cache (16 through 23 are used) */
> +static const u8 dsd1791_reg[] = {
> +	[16] = 0xFF,
> +	[17] = 0xFF,
> +	[18] = 0x50,
> +	[19] = 0x00,
> +	[20] = 0x00,
> +	[21] = 0x01,
> +	[22] = 0x00,
> +	[23] = 0x00,
> +};
> +
> +struct dsd1791 {
> +	struct spi_device *spi;
> +	struct snd_soc_codec codec;
> +	int dai_fmt;
> +	int pcm_fmt;
> +};
> +
> +static int dsd1791_set_format_word(struct dsd1791 *dsd1791,
> +				   struct snd_soc_codec *codec)
> +{
> +	u8 fmt = 0;
> +	u8 reg;
> +
> +	switch (dsd1791->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		switch (dsd1791->pcm_fmt) {
> +		case SNDRV_PCM_FORMAT_S16_LE:
> +			fmt = DSD1791_FMT_16I2S;
> +			break;
> +		case SNDRV_PCM_FORMAT_S24_LE:
> +			fmt = DSD1791_FMT_24I2S;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		switch (dsd1791->pcm_fmt) {
> +		case SNDRV_PCM_FORMAT_S16_LE:
> +			fmt = DSD1791_FMT_16RJ;
> +			break;
> +		case SNDRV_PCM_FORMAT_S24_LE:
> +			fmt = DSD1791_FMT_24RJ;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		switch (dsd1791->pcm_fmt) {
> +		case SNDRV_PCM_FORMAT_S24_LE:
> +			fmt = DSD1791_FMT_24LJ;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	reg = snd_soc_read(codec, DSD1791_REG_AUDFMT);
> +	reg &= ~(DSD1791_FMT_MASK);
> +	reg |= fmt;
> +	return snd_soc_write(codec, DSD1791_REG_AUDFMT, reg);

You could make the code flow easier by using snd_soc_update_bits() here
and in other places.

> +}
> +
> +static int dsd1791_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	u8 reg;
> +
> +	reg = snd_soc_read(codec, DSD1791_REG_AUDFMT);
> +	if (mute)
> +		reg |= 1;
> +	else
> +		reg &= ~1;
> +	return snd_soc_write(codec, DSD1791_REG_AUDFMT, reg);
> +}
> +
> +static int dsd1791_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +
> +	dsd1791->pcm_fmt = params_format(params);
> +
> +	return dsd1791_set_format_word(dsd1791, codec);
> +}
> +
> +static int dsd1791_set_fmt(struct snd_soc_dai *codec_dai,
> +			     unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +
> +	dsd1791->dai_fmt = fmt;
> +
> +	return dsd1791_set_format_word(dsd1791, codec);
> +}
> +
> +#define DSD1791_RATES	SNDRV_PCM_RATE_8000_192000
> +#define DSD1791_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE)
> +
> +static const struct snd_soc_dai_ops dsd1791_dai_ops = {
> +	.hw_params	= dsd1791_hw_params,
> +	.set_fmt	= dsd1791_set_fmt,
> +	.digital_mute	= dsd1791_mute,
> +};
> +
> +static struct snd_soc_dai_driver dsd1791_dai = {
> +	.name = "dsd1791",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = DSD1791_RATES,
> +		.formats = DSD1791_FORMATS,
> +	},
> +	.ops = &dsd1791_dai_ops,
> +};
> +
> +static const struct snd_kcontrol_new dsd1791_snd_controls[] = {
> +	SOC_SINGLE("Left Playback Volume", DSD1791_REG_DIGATT_L, 0, 255, 0),
> +	SOC_SINGLE("Right Playback Volume", DSD1791_REG_DIGATT_R, 0, 255, 0),

Best to use SOC_DOUBLE_R here and rename to "Master Playback Volume"

> +};
> +
> +static int dsd1791_probe(struct snd_soc_codec *codec)
> +{
> +	u8 reg;
> +	int ret;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_SPI);
> +	if (ret) {
> +		dev_err(codec->dev, "Failed to set Cache I/O: %d\n", ret);
> +		goto err;

I dont think goto is required in either case here so easier just to
return.

> +	}
> +
> +	ret = snd_soc_write(codec, DSD1791_REG_SRST, 0x40);
> +	if (ret) {
> +		dev_err(codec->dev, "Unable to reset device: %d\n", ret);
> +		goto err;
> +	}
> +
> +	/* default format after reset */
> +	dsd1791->dai_fmt = SND_SOC_DAIFMT_I2S;
> +	dsd1791->pcm_fmt = SNDRV_PCM_FORMAT_S24_LE;
> +
> +	/* enable attenuation control */
> +	reg = snd_soc_read(codec, DSD1791_REG_AUDFMT);
> +	reg |= 0x80;
> +	snd_soc_write(codec, DSD1791_REG_AUDFMT, reg);
> +
> +	snd_soc_add_controls(codec, dsd1791_snd_controls,
> +				ARRAY_SIZE(dsd1791_snd_controls));
> +	return 0;
> +err:
> +	return ret;
> +}
> +
> +struct snd_soc_codec_driver dsd1791_codec_driver = {
> +	.probe			= dsd1791_probe,
> +	.reg_cache_size		= ARRAY_SIZE(dsd1791_reg),
> +	.reg_word_size		= sizeof(u8),
> +	.reg_cache_default	= dsd1791_reg,
> +};
> +
> +static int __devinit dsd1791_spi_probe(struct spi_device *spi)
> +{
> +	struct dsd1791 *dsd1791;
> +
> +	dsd1791 = devm_kzalloc(&spi->dev, sizeof *dsd1791, GFP_KERNEL);
> +	if (!dsd1791)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, dsd1791);
> +
> +	return snd_soc_register_codec(&spi->dev,
> +		&dsd1791_codec_driver, &dsd1791_dai, 1);
> +};
> +
> +static int __devexit dsd1791_spi_remove(struct spi_device *spi)
> +{
> +	snd_soc_unregister_codec(&spi->dev);

What about your private data ?

> +	return 0;
> +}
> +
> +static struct spi_driver dsd1791_spi_driver = {
> +	.driver = {
> +		.name = "dsd1791",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = dsd1791_spi_probe,
> +	.remove = __devexit_p(dsd1791_spi_remove),
> +};
> +
> +static int __init dsd1791_init(void)
> +{
> +	return spi_register_driver(&dsd1791_spi_driver);
> +}
> +module_init(dsd1791_init);
> +
> +static void __exit dsd1791_exit(void)
> +{
> +	spi_unregister_driver(&dsd1791_spi_driver);
> +}
> +module_exit(dsd1791_exit);
> +
> +MODULE_DESCRIPTION("ASoC DSD1791 codec driver");
> +MODULE_AUTHOR("Michael Williamson");
> +MODULE_LICENSE("GPL");

GPL v2 according to the commnts at the top.

Thanks

Liam
