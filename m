From: Ben Dooks <ben@simtec.co.uk>
Subject: RFC: ASoC driver for S3C24XX Simtec boards
Date: Wed, 24 Jun 2009 12:11:55 +0100
Message-ID: <20090624111155.GA390@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 81B261037F3
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 13:12:32 +0200 (CEST)
Received: from ben by teyla.home.fluff.org with local (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1MJQOR-00006X-6n
	for alsa-devel@alsa-project.org; Wed, 24 Jun 2009 12:11:55 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'd like some comments on the following driver which
is currently being developed to get ASoC working on
the TLV320AIC23 based Simtec boards.

My question is:

1) I'm not seeing a control to enable/disable the
   'Speaker Amp', do I need to change the controls
   or how this is exported?

2) There are two boards with an GPIO AMP which has
   two gain controls. This is a TPA2001D1 which
   provides a gain of 6,12,18 or 23.5dB depending
   on the GPIO settings.

   [ http://focus.ti.com/docs/prod/folders/print/tpa2001d1.html ]

This driver has yet to be tested on all our boards.


/* sound/soc/s3c24xx/s3c24xx_simtec.c
 *
 * Copyright 2009 Simtec Electronics
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
*/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <linux/clk.h>
#include <linux/i2c.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <plat/audio-simtec.h>

#include "s3c24xx-pcm.h"
#include "s3c24xx-i2s.h"

#include "../codecs/tlv320aic23.h"

/* supported machines:
 *
 * Machine	Connections		AMP
 * -------	-----------		---
 * BAST		MIC, HPOUT, LOUT, LIN	TPA2001D1 (HPOUTL,R) (gain hardwired)
 * VR1000	HPOUT, LIN		None
 * VR2000	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
 * DePicture	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
 * Anubis	LIN, LOUT, MIC, HP	TPA2001D1 (HPOUTL,R)
 */

static struct s3c24xx_audio_simtec_pdata *pdata;
static struct clk *xtal_clk;

/**
 * simtec_spk_event - handle power management event for speaker
 * @w: The widget for this event
 * @k: The sound control the event is for.
 * @event; The event being processed.
 *
 * Handle power management events to deal with the state of the
 * GPIO AMP attached to some boards.
*/
static int simtec_spk_event(struct snd_soc_dapm_widget *w,
			    struct snd_kcontrol *k, int event)
{
	int value = SND_SOC_DAPM_EVENT_ON(event) ? 0 : 1;

	gpio_set_value(pdata->amp_gpio, value);
	return 0;
}

static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
	SND_SOC_DAPM_HP("Headphone Jack", NULL),
	SND_SOC_DAPM_LINE("Line In", NULL),
	SND_SOC_DAPM_LINE("Line Out", NULL),
	SND_SOC_DAPM_MIC("Mic Jack", NULL),

	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM,
			   0, 0, NULL, 0, simtec_spk_event,
			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
};

static const struct snd_soc_dapm_route audio_map[] = {
	{ "Headphone Jack", NULL, "LHPOUT"},
	{ "Headphone Jack", NULL, "RHPOUT"},

	{ "Line Out", NULL, "LLOUT" },
	{ "Line Out", NULL, "RLOUT" },

	{ "LLINEIN", NULL, "Line In"},
	{ "RLINEIN", NULL, "Line In"},

	{ "MICIN", NULL, "Mic Jack"},
};

static const struct snd_soc_dapm_route amp_map[] = {
	{ "Speaker Amp", NULL, "RHPOUT" },
	{ "Speaker Amp", NULL, "LHPOUT" },
};

static int spk_gain;

/**
 * speaker_gain_get - read the speaker gain setting.
 * @kcontrol: The control for the speaker gain.
 * @ucontrol: The value that needs to be updated.
 *
 * Read the value for the AMP gain control.
 */
static int speaker_gain_get(struct snd_kcontrol *kcontrol,
			    struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = spk_gain;
	return 0;
}

/**
 * speaker_gain_put - set the speaker gain setting.
 * @kcontrol: The control for the speaker gain.
 * @ucontrol: The value that needs to be set.
 *
 * Set the value of the speaker gain from the specified
 * @ucontrol setting.
 */
static int speaker_gain_put(struct snd_kcontrol *kcontrol,
			    struct snd_ctl_elem_value *ucontrol)
{
	int value = ucontrol->value.integer.value[0];

	spk_gain = value;

	gpio_set_value_cansleep(pdata->amp_gain[0], value & 1);
	gpio_set_value_cansleep(pdata->amp_gain[1], value >> 1);

	return 0;
}

static const struct snd_kcontrol_new amp_controls[] = {
	SOC_SINGLE_EXT("Speaker Gain", 0, 0, 3, 0, speaker_gain_get, speaker_gain_put),
};

/**
 * simtec_tlv320aic23_init - initialise and add controls
 * @codec; The codec instance to attach to.
 *
 * Attach our controls and configure the necessary codec
 * mappings for our sound card instance.
*/
static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
{
	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
				  ARRAY_SIZE(tlv320aic23_dapm_widgets));

	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));

	if (pdata->amp_gpio > 0) {
		printk(KERN_DEBUG "%s: adding amp routes\n", __func__);
		snd_soc_dapm_add_routes(codec, amp_map, ARRAY_SIZE(amp_map));
		snd_soc_dapm_enable_pin(codec, "Speaker Amp");
	}

	if (pdata->amp_gain[0] > 0) {
		printk(KERN_DEBUG "%s: adding amp controls\n", __func__);
		snd_soc_add_controls(codec, amp_controls, ARRAY_SIZE(amp_controls));
	}

	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
	snd_soc_dapm_enable_pin(codec, "Line In");
	snd_soc_dapm_enable_pin(codec, "Line Out");
	snd_soc_dapm_enable_pin(codec, "Mic Jack");
	snd_soc_dapm_sync(codec);

	return 0;
}

#define CODEC_CLOCK 12000000

/**
 * simtec_hw_params - update hardware parameters
 * @substream: The audio substream instance.
 * @params: The parameters requested.
 *
 * Update the codec data routing and configuration  settings
 * from the supplied data.
 */
static int simtec_hw_params(struct snd_pcm_substream *substream,
			    struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
	int ret;

	/* Set the CODEC as the bus clock master, I2S */
	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
				  SND_SOC_DAIFMT_NB_NF |
				  SND_SOC_DAIFMT_CBM_CFM);
	if (ret) {
		printk(KERN_ERR "%s: failed set cpu dai format\n", __func__);
		return ret;
	}

	/* Set the CODEC as the bus clock master */
	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
				  SND_SOC_DAIFMT_NB_NF |
				  SND_SOC_DAIFMT_CBM_CFM);
	if (ret) {
		printk(KERN_ERR "%s: failed set codec dai format\n", __func__);
		return ret;
	}

	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
				     CODEC_CLOCK, SND_SOC_CLOCK_IN);
	if (ret) {
		printk(KERN_ERR "%s: failed setting codec sysclk\n", __func__);
		return ret;
	}

	if (pdata->use_mpllin) {
		ret = snd_soc_dai_set_sysclk(cpu_dai, S3C24XX_CLKSRC_MPLL,
					     0, SND_SOC_CLOCK_OUT);

		if (ret) {
			printk(KERN_ERR "%s: failed to set MPLLin as clksrc\n",
			       __func__);
			return ret;
		}
	}

	if (pdata->output_cdclk) {
		int cdclk_scale;

		cdclk_scale = clk_get_rate(xtal_clk) / CODEC_CLOCK;
		cdclk_scale--;

		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
					     cdclk_scale);
	}

	return 0;
}

static int simtec_hw_startup(struct snd_pcm_substream *substream)
{
	/* call any board supplied startup code, this currently only
	 * covers the bast/vr1000 which have a CPLD in the way of the
	 * LRCLK */
	if (pdata->startup)
		pdata->startup();

	return 0;
}

static struct snd_soc_ops simtec_ops = {
	.startup	= simtec_hw_startup,
	.hw_params	= simtec_hw_params,
};

static struct snd_soc_dai_link simtec_dai_aic23 = {
	.name		= "tlv320aic23",
	.stream_name	= "TLV320AIC23",
	.cpu_dai	= &s3c24xx_i2s_dai,
	.codec_dai	= &tlv320aic23_dai,
	.init		= simtec_tlv320aic23_init,
	.ops		= &simtec_ops,
};

/* simtec audio machine driver */
static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
	.name		= "Simtec",
	.platform	= &s3c24xx_soc_platform,
	.dai_link	= &simtec_dai_aic23,
	.num_links	= 1,
};

/* simtec audio subsystem */
static struct snd_soc_device simtec_snd_devdata_aic23 = {
	.card		= &snd_soc_machine_simtec_aic23,
	.codec_dev	= &soc_codec_dev_tlv320aic23,
};

/**
 * attach_gpio_amp - get and configure the necessary gpios
 * @dev: The device we're probing.
 * @pd: The platform data supplied by the board.
 *
 * If there is a GPIO based amplifier attached to the board, claim
 * the necessary GPIO lines for it, and set default values.
 */
static int attach_gpio_amp(struct device *dev,
			   struct s3c24xx_audio_simtec_pdata *pd)
{
	int ret;

	/* attach gpio amp gain (if any) */
	if (pdata->amp_gain[0] > 0) {
		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain");
		if (ret) {
			dev_err(dev, "cannot get amp gpio gain0\n");
			return ret;
		}

		ret = gpio_request(pd->amp_gain[1], "gpio-amp-gain");
		if (ret) {
			dev_err(dev, "cannot get amp gpio gain0\n");
			gpio_free(pdata->amp_gain[0]);
			return ret;
		}

		gpio_direction_output(pd->amp_gain[0], 0);
		gpio_direction_output(pd->amp_gain[1], 0);
	}

	/* note, curently we assume GPA0 isn't valid amp */
	if (pdata->amp_gpio > 0) {
		ret = gpio_request(pd->amp_gpio, "gpio-amp");
		if (ret) {
			dev_err(dev, "cannot get amp gpio %d (%d)\n",
				pd->amp_gpio, ret);
			goto err_amp;
		}

		/* start with amp off */
		gpio_direction_output(pd->amp_gpio, 1);
	}

	return 0;

err_amp:
	if (pd->amp_gain[0] > 0) {
		gpio_free(pd->amp_gain[0]);
		gpio_free(pd->amp_gain[1]);
	}

	return ret;
}

static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
{
	if (pd->amp_gain[0] > 0) {
		gpio_free(pd->amp_gain[0]);
		gpio_free(pd->amp_gain[1]);
	}

	if (pd->amp_gpio > 0)
		gpio_free(pd->amp_gpio);
}

static int __devinit simtec_audio_probe(struct platform_device *pdev)
{
	struct platform_device *snd_dev;
	int ret;

	dev_info(&pdev->dev, "probe called\n");

	pdata = pdev->dev.platform_data;
	if (!pdata) {
		dev_err(&pdev->dev, "no platform data supplied\n");
		return -EINVAL;
	}

	xtal_clk = clk_get(&pdev->dev, "xtal");
	if (IS_ERR(xtal_clk)) {
		dev_err(&pdev->dev, "could not get clkout0\n");
		return -EINVAL;
	}

	dev_info(&pdev->dev, "xtal rate is %ld\n", clk_get_rate(xtal_clk));

	ret = attach_gpio_amp(&pdev->dev, pdata);
	if (ret)
		goto err_clk;

	snd_dev = platform_device_alloc("soc-audio", -1);
	if (!snd_dev) {
		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
		ret = -ENOMEM;
		goto err_gpio;
	}

	platform_set_drvdata(snd_dev, &simtec_snd_devdata_aic23);
	simtec_snd_devdata_aic23.dev = &snd_dev->dev;

	ret = platform_device_add(snd_dev);
	if (ret) {
		dev_err(&pdev->dev, "failed to add soc-audio dev\n");
		platform_device_put(snd_dev);
		goto err_clk;
	}

	platform_set_drvdata(pdev, snd_dev);
	return 0;

err_gpio:
	detach_gpio_amp(pdata);

err_clk:
	clk_put(xtal_clk);
	return ret;
}

static int __devexit simtec_audio_remove(struct platform_device *pdev)
{
	struct platform_device *snd_dev = platform_get_drvdata(pdev);

	platform_device_unregister(snd_dev);

	detach_gpio_amp(pdata);
	clk_put(xtal_clk);
	return 0;
}

static struct platform_driver simtec_audio_platdrv = {
	.driver	= {
		.owner	= THIS_MODULE,
		.name	= "s3c24xx-tlv320aic23",
	},
	.probe	= simtec_audio_probe,
	.remove	= __devexit_p(simtec_audio_remove),
};

MODULE_ALIAS("platform:s3c24xx-tlv320aic23");

static int __init simtec_init(void)
{
	return platform_driver_register(&simtec_audio_platdrv);
}

static void __exit simtec_exit(void)
{
	platform_driver_unregister(&simtec_audio_platdrv);
}

module_init(simtec_init);
module_exit(simtec_exit);

MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
MODULE_LICENSE("GPL");
