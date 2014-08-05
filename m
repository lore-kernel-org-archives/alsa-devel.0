From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Tue, 05 Aug 2014 09:19:44 +0530
Message-ID: <53E05458.6080605@gmail.com>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407183077-23807-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 08/05/2014 01:41 AM, Brian Austin wrote:
> This patch adds support for the Cirrus Logic CS35L32 Boosted Amplifier
> I2S output provides monitor data to the SOC/CODEC/DSP for speaker protection/enhancement algorithms
>
> Changes for v2:
> - Interrupt Status Registers added to regmap volatile
> - Use Speaker for volume control name
> - Zero Cross Switch rename
> - Remove Gain Manager from DTS and add to kcontrols
> - Add VP-Supply to regulator list
> - Remove unneeded DAPM event
> - Specify MCLK rates as numbers
> - Move probe/remove code to device level probe/remove
> - Move regmap_register_patch to after REV_ID check
>
> Changes for v3:
> - Add regulator_disable for error in i2c_probe
>
> Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>   include/dt-bindings/sound/cs35l32.h |   26 ++
>   sound/soc/codecs/Kconfig            |    5 +
>   sound/soc/codecs/Makefile           |    2 +
>   sound/soc/codecs/cs35l32.c          |  647 +++++++++++++++++++++++++++++++++++
>   sound/soc/codecs/cs35l32.h          |   93 +++++
>   5 files changed, 773 insertions(+)
>   create mode 100644 include/dt-bindings/sound/cs35l32.h
>   create mode 100644 sound/soc/codecs/cs35l32.c
>   create mode 100644 sound/soc/codecs/cs35l32.h
>
> diff --git a/include/dt-bindings/sound/cs35l32.h b/include/dt-bindings/sound/cs35l32.h
> new file mode 100644
> index 0000000..0c6d6a3
> --- /dev/null
> +++ b/include/dt-bindings/sound/cs35l32.h
> @@ -0,0 +1,26 @@
> +#ifndef __DT_CS35L32_H
> +#define __DT_CS35L32_H
> +
> +#define CS35L32_BOOST_MGR_AUTO		0
> +#define CS35L32_BOOST_MGR_AUTO_AUDIO	1
> +#define CS35L32_BOOST_MGR_BYPASS	2
> +#define CS35L32_BOOST_MGR_FIXED		3
> +
> +#define CS35L32_DATA_CFG_LR_VP		0
> +#define CS35L32_DATA_CFG_LR_STAT	1
> +#define CS35L32_DATA_CFG_LR		2
> +#define CS35L32_DATA_CFG_LR_VPSTAT	3
> +
> +#define CS35L32_BATT_THRESH_3_1V	0
> +#define CS35L32_BATT_THRESH_3_2V	1
> +#define CS35L32_BATT_THRESH_3_3V	2
> +#define CS35L32_BATT_THRESH_3_4V	3
> +
> +#define CS35L32_BATT_RECOV_3_1V		0
> +#define CS35L32_BATT_RECOV_3_2V		1
> +#define CS35L32_BATT_RECOV_3_3V		2
> +#define CS35L32_BATT_RECOV_3_4V		3
> +#define CS35L32_BATT_RECOV_3_5V		4
> +#define CS35L32_BATT_RECOV_3_6V		5
> +
> +#endif /* __DT_CS35L32_H */
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 0b9571c..36410d8 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -43,6 +43,7 @@ config SND_SOC_ALL_CODECS
>   	select SND_SOC_ALC5623 if I2C
>   	select SND_SOC_ALC5632 if I2C
>   	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
> +	select SND_SOC_CS35L32 if I2C
>   	select SND_SOC_CS42L51_I2C if I2C
>   	select SND_SOC_CS42L52 if I2C && INPUT
>   	select SND_SOC_CS42L56 if I2C && INPUT
> @@ -319,6 +320,10 @@ config SND_SOC_ALC5632
>   config SND_SOC_CQ0093VC
>   	tristate
>   
> +config SND_SOC_CS35L32
> +	tristate "Cirrus Logic CS35L32 CODEC"
> +	depends on I2C
> +
>   config SND_SOC_CS42L51
>   	tristate
>   
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 1bd6e1c..538676b 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -32,6 +32,7 @@ snd-soc-ak4671-objs := ak4671.o
>   snd-soc-ak5386-objs := ak5386.o
>   snd-soc-arizona-objs := arizona.o
>   snd-soc-cq93vc-objs := cq93vc.o
> +snd-soc-cs35l32-objs := cs35l32.o
>   snd-soc-cs42l51-objs := cs42l51.o
>   snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
>   snd-soc-cs42l52-objs := cs42l52.o
> @@ -199,6 +200,7 @@ obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
>   obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
>   obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
>   obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
> +obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
>   obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
>   obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
>   obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
> diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
> new file mode 100644
> index 0000000..0e22426
> --- /dev/null
> +++ b/sound/soc/codecs/cs35l32.c
> @@ -0,0 +1,647 @@
> +/*
> + * cs35l32.c -- CS35L32 ALSA SoC audio driver
> + *
> + * Copyright 2014 CirrusLogic, Inc.
> + *
> + * Author: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +#include <dt-bindings/sound/cs35l32.h>
> +
> +#include "cs35l32.h"
> +

includes in alphabetical order...

(...)

> +static bool cs35l32_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CS35L32_DEVID_AB:
> +	case CS35L32_DEVID_CD:
> +	case CS35L32_DEVID_E:
> +	case CS35L32_FAB_ID:
> +	case CS35L32_REV_ID:
> +	case CS35L32_INT_STATUS_1:
> +	case CS35L32_INT_STATUS_2:
> +	case CS35L32_INT_STATUS_3:
> +	case CS35L32_LED_STATUS:
> +		return 1;

return true...?

> +	default:
> +		return 0;

return false...?

> +	}
> +}
> +
> +static bool cs35l32_precious_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CS35L32_INT_STATUS_1:
> +	case CS35L32_INT_STATUS_2:
> +	case CS35L32_INT_STATUS_3:
> +	case CS35L32_LED_STATUS:
> +		return 1;

return true...?

> +	default:
> +		return 0;

return false...?

> +	}
> +}
> +

(...)

> +static int cs35l32_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		snd_soc_update_bits(codec, CS35L32_ADSP_CTL,
> +				    CS35L32_ADSP_MASTER_MASK,
> +				CS35L32_ADSP_MASTER_MASK);

snd_soc_update_bits(codec, CS35L32_ADSP_CTL,
		    CS35L32_ADSP_MASTER_MASK,
		    CS35L32_ADSP_MASTER_MASK);

> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		snd_soc_update_bits(codec, CS35L32_ADSP_CTL,
> +				    CS35L32_ADSP_MASTER_MASK, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs35l32_set_tristate(struct snd_soc_dai *dai, int tristate)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
> +					CS35L32_SDOUT_3ST, tristate << 3);

return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
			   CS35L32_SDOUT_3ST, tristate << 3);

> +}
> +
> +static const struct snd_soc_dai_ops cs35l32_ops = {
> +	.set_fmt = cs35l32_set_dai_fmt,
> +	.set_tristate = cs35l32_set_tristate,
> +};
> +
> +static struct snd_soc_dai_driver cs35l32_dai[] = {
> +	{
> +		.name = "cs35l32-monitor",
> +		.id = 0,
> +		.capture = {
> +			.stream_name = "Capture",
> +			.channels_min = 2,
> +			.channels_max = 2,
> +			.rates = CS35L32_RATES,
> +			.formats = CS35L32_FORMATS,
> +		},
> +		.ops = &cs35l32_ops,
> +		.symmetric_rates = 1,
> +	}
> +};
> +
> +static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
> +			      int clk_id, int source, unsigned int freq, int dir)

static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
				    int clk_id, int source, unsigned int freq, int dir)

> +{
> +
> +	switch (freq) {
> +	case 6000000:
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_DIV2_MASK, 0);
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_RATIO_MASK,
> +					CS35L32_MCLK_RATIO);

dto...

> +		break;
> +	case 12000000:
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_DIV2_MASK,
> +					CS35L32_MCLK_DIV2_MASK);

dto..

> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_RATIO_MASK,
> +					CS35L32_MCLK_RATIO);

dto...

> +		break;
> +	case 6144000:
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_DIV2_MASK, 0);
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_RATIO_MASK, 0);
> +		break;
> +	case 12288000:
> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +				    CS35L32_MCLK_DIV2_MASK,
> +					CS35L32_MCLK_DIV2_MASK);

dto...

> +		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
> +

(...)

> +static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
> +				    struct cs35l32_platform_data *pdata)

match open parenthesis...
static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
				  struct cs35l32_platform_data *pdata)

> +{
> +	struct device_node *np = i2c_client->dev.of_node;
> +	unsigned int val;

(...)

> +static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
> +				       const struct i2c_device_id *id)
> +{
> +	struct cs35l32_private *cs35l32;
> +	struct cs35l32_platform_data *pdata =
> +		dev_get_platdata(&i2c_client->dev);
> +	int ret, i;
> +	unsigned int devid = 0;
> +	unsigned int reg;
> +
> +
> +	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs35l32_private),
> +			       GFP_KERNEL);
> +	if (!cs35l32) {
> +		dev_err(&i2c_client->dev, "could not allocate codec\n");

No need to put the debug message here..  :-)  We acn directly return from here...

> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(i2c_client, cs35l32);
> +
> +	cs35l32->regmap = devm_regmap_init_i2c(i2c_client, &cs35l32_regmap);
> +	if (IS_ERR(cs35l32->regmap)) {
> +		ret = PTR_ERR(cs35l32->regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pdata) {
> +		cs35l32->pdata = *pdata;
> +	} else {
> +		pdata = devm_kzalloc(&i2c_client->dev,
> +				     sizeof(struct cs35l32_platform_data),
> +				GFP_KERNEL);

should match open parenthesis's...

  devm_kzalloc(&i2c_client->dev,
	      sizeof(struct cs35l32_platform_data),
	      GFP_KERNEL);

> +		if (!pdata) {
> +			dev_err(&i2c_client->dev, "could not allocate pdata\n");
> +			return -ENOMEM;
> +		}
> +		if (i2c_client->dev.of_node) {
> +			ret = cs35l32_handle_of_data(i2c_client,
> +						     &cs35l32->pdata);
> +			if (ret != 0)

if (ret < 0)...?

> +				return ret;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(cs35l32->supplies); i++)
> +		cs35l32->supplies[i].supply = cs35l32_supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(&i2c_client->dev,
> +				      ARRAY_SIZE(cs35l32->supplies),
> +				      cs35l32->supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +			"Failed to request supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(cs35l32->supplies),
> +				    cs35l32->supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +			"Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Reset the Device */
> +	cs35l32->reset_gpio = devm_gpiod_get(&i2c_client->dev,
> +		"reset-gpios");

cs35l32->reset_gpio = devm_gpiod_get(&i2c_client->dev,
				     "reset-gpios");

> +	if (IS_ERR(cs35l32->reset_gpio)) {
> +		ret = PTR_ERR(cs35l32->reset_gpio);
> +		if (ret != -ENOENT && ret != -ENOSYS)
> +			return ret;
> +

(...)

> +	/* Setup VBOOST Management */
> +	if (cs35l32->pdata.boost_mng)
> +		regmap_update_bits(cs35l32->regmap, CS35L32_AUDIO_LED_MNGR,
> +				   CS35L32_BOOST_MASK,
> +				cs35l32->pdata.boost_mng);

regmap_update_bits(cs35l32->regmap, CS35L32_AUDIO_LED_MNGR,
		   CS35L32_BOOST_MASK,
		   cs35l32->pdata.boost_mng);

> +
> +	/* Setup ADSP Format Config */
> +	if (cs35l32->pdata.sdout_share)
> +		regmap_update_bits(cs35l32->regmap, CS35L32_ADSP_CTL,
> +				    CS35L32_ADSP_SHARE_MASK,
> +				cs35l32->pdata.sdout_share << 3);

dto...

> +
> +	/* Setup ADSP Data Configuration */
> +	if (cs35l32->pdata.sdout_datacfg)
> +		regmap_update_bits(cs35l32->regmap, CS35L32_ADSP_CTL,
> +				   CS35L32_ADSP_DATACFG_MASK,
> +				cs35l32->pdata.sdout_datacfg << 4);

dto...

> +
> +	/* Setup Low Battery Recovery  */
> +	if (cs35l32->pdata.batt_recov)
> +		regmap_update_bits(cs35l32->regmap, CS35L32_BATT_THRESHOLD,
> +				   CS35L32_BATT_REC_MASK,
> +				cs35l32->pdata.batt_recov << 1);

dto....

> +
> +	/* Setup Low Battery Threshold */
> +	if (cs35l32->pdata.batt_thresh)
> +		regmap_update_bits(cs35l32->regmap, CS35L32_BATT_THRESHOLD,
> +				   CS35L32_BATT_THRESH_MASK,
> +				cs35l32->pdata.batt_thresh << 4);

dto...

> +
> +	/* Power down the AMP */
> +	regmap_update_bits(cs35l32->regmap, CS35L32_PWRCTL1, CS35L32_PDN_AMP,
> +			    CS35L32_PDN_AMP);

dto...

> +
> +	/* Clear MCLK Error Bit since we don't have the clock yet */
> +	ret = regmap_read(cs35l32->regmap, CS35L32_INT_STATUS_1, &reg);
> +
> +	ret =  snd_soc_register_codec(&i2c_client->dev,
> +			&soc_codec_dev_cs35l32, cs35l32_dai,
> +			ARRAY_SIZE(cs35l32_dai));

dto...

> +	if (ret < 0)
> +		goto err_disable;
> +
> +	return 0;
> +
> +err_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
> +			       cs35l32->supplies);
> +}
> +

(...)

> +static struct i2c_driver cs35l32_i2c_driver = {
> +	.driver = {
> +		   .name = "cs35l32",
> +		   .owner = THIS_MODULE,

No need to update this owner field. It will be done by module_i2c_driver()  :-)

> +		   .pm = &cs35l32_runtime_pm,
> +		   .of_match_table = cs35l32_of_match,
> +		   },
> +	.id_table = cs35l32_id,
> +	.probe = cs35l32_i2c_probe,
> +	.remove = cs35l32_i2c_remove,
> +};
> +
> +module_i2c_driver(cs35l32_i2c_driver);
>
-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
