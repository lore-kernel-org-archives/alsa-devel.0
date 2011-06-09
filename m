From: Michele Da Rold <michele.darold@ecsproject.com>
Subject: wm8974 and sam9g45 atmel
Date: Thu, 09 Jun 2011 17:11:48 +0200
Message-ID: <4DF0E2B4.7040401@ecsproject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cp-out9.libero.it (cp-out9.libero.it [212.52.84.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A44A24399
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 17:12:03 +0200 (CEST)
Received: from [192.168.0.101] (151.78.24.231) by cp-out9.libero.it (8.5.133)
	id 4DD24233036475C3 for alsa-devel@alsa-project.org;
	Thu, 9 Jun 2011 17:12:01 +0200
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

Hello everybody, I'm starting a new development with a Atmel SAM9G45 and 
a WM8974.

I'm using kernel 2.6.33.2

I have connected the SSC1 pin TD,TF,TK and the RD pin, so I want to use 
WM8974 like a slave.

I wrote a interface driver based on sam9263_wm8731.c

The driver seem to load ok, I recognize the codec but when I start a mp3 
playing (I use mpg123) the playback not start.

Putting some dedug messagge the driver not call the function 
"set_bias_level", and call the mute function with mute=0.
Testing the MCLK signal I not see any clock on pin because I never call 
clk_enable!!

There is a way to identify the problem?
Someone could help me?

Thank you in advance
Michele Da Rold

I put the code of driver (don't care about printk I used it for debug 
purpose!!)

/*
  * sam9g45_wm8974  --  SoC audio for AT91SAM9G20-based
  * 			ATMEL AT91SAM9G20ek board.
  *
  *  Copyright (C) 2005 SAN People
  *  Copyright (C) 2008 Atmel
  *
  * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
  *
  * Based on sam9263_wm8731.c.
  * Frank Mandarino <fmandarino@endrelia.com>
  * Copyright 2006 Endrelia Technologies Inc.
  * Based on corgi.c by:
  * Copyright 2005 Wolfson Microelectronics PLC.
  * Copyright 2005 Openedhand Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
  USA
  */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/clk.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/i2c.h>

#include <linux/atmel-ssc.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <asm/mach-types.h>
#include <mach/hardware.h>
#include <mach/gpio.h>

#include "../codecs/wm8974.h"
#include "atmel-pcm.h"
#include "atmel_ssc_dai.h"

#define MCLK_RATE 12000000

/*
  * As shipped the board does not have inputs.  However, it is relatively
  * straightforward to modify the board to hook them up so support is left
  * in the driver.
  */
#undef ENABLE_MIC_INPUT
#define ENABLE_MIC_INPUT 1
static struct clk *mclk;

static int at91sam9g45ek_hw_params(struct snd_pcm_substream *substream,
	struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
	int ret;
	
	printk(KERN_DEBUG
			"at91sam9g45_wm8974 "
		": at91sam9g45ek_hw_params() called\n");
	
	/* set codec DAI configuration */
	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS/*SND_SOC_DAIFMT_CBM_CFM*/);
	if (ret < 0)
		return ret;

	/* set cpu DAI configuration */
	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS/*SND_SOC_DAIFMT_CBM_CFM*/);
	if (ret < 0)
		return ret;

	return 0;
}

static struct snd_soc_ops at91sam9g45ek_ops = {
	.hw_params = at91sam9g45ek_hw_params,
};

static int at91sam9g45ek_set_bias_level(struct snd_soc_card *card,
					enum snd_soc_bias_level level)
{
	static int mclk_on;
	int ret = 0;

	printk(KERN_DEBUG
			"at91sam9g45_wm8974 "
		": at91sam9g45ek_set_bias_level() called %d\n",level);
	
	switch (level) {
	case SND_SOC_BIAS_ON:
	case SND_SOC_BIAS_PREPARE:
		if (!mclk_on)
			ret = clk_enable(mclk);
		if (ret == 0)
			mclk_on = 1;
		break;

	case SND_SOC_BIAS_OFF:
	case SND_SOC_BIAS_STANDBY:
		if (mclk_on)
			clk_disable(mclk);
		mclk_on = 0;
		break;
	}

	return ret;
}
#if 0
static const struct snd_soc_dapm_widget at91sam9g45ek_dapm_widgets[] = {
	SND_SOC_DAPM_MIC("Int Mic", NULL),
	SND_SOC_DAPM_SPK("Ext Spk", NULL),
};

static const struct snd_soc_dapm_route intercon[] = {

	/* Speaker output mixer */
	{"Speaker Mixer", "PCM Playback Switch", "DAC"},
	{"Speaker Mixer", "Aux Playback Switch", "Aux Input"},
	{"Speaker Mixer", "Line Bypass Switch", "Boost Mixer"},
	/* speaker connected to SPKOUTP */
	{"SpkN Out", NULL, "Speaker Mixer"},
	{"SpkP Out", NULL, "Speaker Mixer"},
	{"SPKOUTN", NULL, "SpkN Out"},
	{"SPKOUTP", NULL, "SpkP Out"},
	
	/* Input PGA */
	{"Input PGA", "Aux Switch", "Aux Input"},
	{"Input PGA", "MicN Switch", "MICN"},
	{"Input PGA", "MicP Switch", "MICP"},
};


/*
  * Logic for a wm974 as connected on a at91sam9g45ek board.
  */
static int at91sam9g45ek_wm8974_init(struct snd_soc_codec *codec)
{
	struct snd_soc_dai *codec_dai = &codec->dai[0];
	int ret;

	printk(KERN_DEBUG
			"at91sam9g45_wm8974 "
		": at91sam9g45_wm8974_init() called\n");
/*
	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
		MCLK_RATE, SND_SOC_CLOCK_IN);
	if (ret < 0) {
		printk(KERN_ERR "Failed to set WM8974 SYSCLK: %d\n", ret);
		return ret;
	}
*/
	/* Add specific widgets */
	snd_soc_dapm_new_controls(codec, at91sam9g45ek_dapm_widgets,
				  ARRAY_SIZE(at91sam9g45ek_dapm_widgets));
	/* Set up specific audio path interconnects */
	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
	
	
	/* not connected */
	snd_soc_dapm_nc_pin(codec, "MONOOUT");
	snd_soc_dapm_nc_pin(codec, "AUX");

#ifdef ENABLE_MIC_INPUT
	snd_soc_dapm_enable_pin(codec, "Int Mic");
#else
	snd_soc_dapm_nc_pin(codec, "Int Mic");
#endif

	/* always connected */
	snd_soc_dapm_enable_pin(codec, "Ext Spk");

	snd_soc_dapm_sync(codec);

	return 0;
}
#endif
static struct snd_soc_dai_link at91sam9g45ek_dai = {
	.name = "WM8974",
	.stream_name = "WM8974 PCM",
	.cpu_dai = &atmel_ssc_dai[1],
	.codec_dai = &wm8974_dai,	
#if 0	
	.init = at91sam9g45ek_wm8974_init,
#endif	
	.ops = &at91sam9g45ek_ops,
};

static struct snd_soc_card snd_soc_at91sam9g45ek = {
	.name = "AT91SAMG45",
	.platform = &atmel_soc_platform,
	.dai_link = &at91sam9g45ek_dai,
	.num_links = 1,
	.set_bias_level = at91sam9g45ek_set_bias_level,
};

static struct snd_soc_device at91sam9g45ek_snd_devdata = {
	.card = &snd_soc_at91sam9g45ek,
	.codec_dev = &soc_codec_dev_wm8974,
};

static struct platform_device *at91sam9g45ek_snd_device;

static int __init at91sam9g45ek_init(void)
{
	struct atmel_ssc_info *ssc_p = at91sam9g45ek_dai.cpu_dai->private_data;
	struct ssc_device *ssc = NULL;
	struct clk *main;
	int ret;


	at91_set_A_periph(AT91_PIN_PD27, 0);
	
	/*
	 * Codec MCLK is supplied by PCK1 - set it up.
	 */
	mclk = clk_get(NULL, "pck1");
	if (IS_ERR(mclk)) {
		printk(KERN_ERR "ASoC: Failed to get MCLK\n");
		ret = PTR_ERR(mclk);
		goto err;
	}

	main = clk_get(NULL, "main");
	if (IS_ERR(main)) {
		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
		ret = PTR_ERR(mclk);
		goto err_mclk;
	}
	ret = clk_set_parent(mclk, main);
	clk_put(main);
	if (ret != 0) {
		printk(KERN_ERR "ASoC: Failed to set MCLK parent\n");
		goto err_mclk;
	}

	clk_set_rate(mclk, MCLK_RATE);
		
	/*
	 * Request SSC device
	 */
	ssc = ssc_request(1);
	if (IS_ERR(ssc)) {
		printk(KERN_ERR "ASoC: Failed to request SSC 1\n");
		ret = PTR_ERR(ssc);
		ssc = NULL;
		goto err_ssc;
	}
	ssc_p->ssc = ssc;

	at91sam9g45ek_snd_device = platform_device_alloc("soc-audio", -1);
	if (!at91sam9g45ek_snd_device) {
		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
		ret = -ENOMEM;
	}

	platform_set_drvdata(at91sam9g45ek_snd_device,
			&at91sam9g45ek_snd_devdata);
	at91sam9g45ek_snd_devdata.dev = &at91sam9g45ek_snd_device->dev;

	ret = platform_device_add(at91sam9g45ek_snd_device);
	if (ret) {
		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
		platform_device_put(at91sam9g45ek_snd_device);
	}

	return ret;

err_ssc:
	ssc_free(ssc);
	ssc_p->ssc = NULL;
err_mclk:
	clk_put(mclk);
	mclk = NULL;
err:
	return ret;
}

static void __exit at91sam9g45ek_exit(void)
{
	struct atmel_ssc_info *ssc_p = at91sam9g45ek_dai.cpu_dai->private_data;
	struct ssc_device *ssc;

	if (ssc_p != NULL) {
		ssc = ssc_p->ssc;
		if (ssc != NULL)
			ssc_free(ssc);
		ssc_p->ssc = NULL;
	}

	platform_device_unregister(at91sam9g45ek_snd_device);
	at91sam9g45ek_snd_device = NULL;
	clk_put(mclk);
	mclk = NULL;
}

module_init(at91sam9g45ek_init);
module_exit(at91sam9g45ek_exit);

/* Module information */
MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
MODULE_DESCRIPTION("ALSA SoC AT91SAM9G45_WM8974");
MODULE_LICENSE("GPL");
