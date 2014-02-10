From: Ezequiel RG <eze_rg@yahoo.com.ar>
Subject: Register wm8782 codec driver
Date: Mon, 10 Feb 2014 13:32:39 -0800 (PST)
Message-ID: <1392067959.72456.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Reply-To: Ezequiel RG <eze_rg@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm31.bullet.mail.ne1.yahoo.com (nm31.bullet.mail.ne1.yahoo.com
 [98.138.229.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 68E0726086C
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 00:57:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone, i'm trying to interface the wm8782 codec with my Beaglebone Bl=
ack running 3.8.13 kernel.
I'm getting this error when i load the device tree file:=A0davinci_evm soun=
d.11: ASoC: CODEC (null) not registered
What i'm doing wrong??

The correponding source file are attached.

Thanks for your help!


wm8782.c
/*
=A0* sound/soc/codecs/wm8782.c
=A0* simple, strap-pin configured 24bit 2ch ADC
=A0*
=A0* Copyright: 2011 Raumfeld GmbH
=A0* Author: Johannes Stezenbach <js@sig21.net>
=A0*
=A0* based on ad73311.c
=A0* Copyright:Analog Device Inc.
=A0* Author:Cliff Cai <cliff.cai@analog.com>
=A0*
=A0* This program is free software; you can redistribute =A0it and/or modif=
y it
=A0* under =A0the terms of =A0the GNU General =A0Public License as publishe=
d by the
=A0* Free Software Foundation; =A0either version 2 of the =A0License, or (a=
t your
=A0* option) any later version.
=A0*/

#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/device.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/ac97_codec.h>
#include <sound/initval.h>
#include <sound/soc.h>
#include <linux/of_device.h>
#include <linux/of_device.h>


static const struct of_device_id wm8782_of_match[] =3D {
=A0{ .compatible =3D "wlf,wm8782", },
=A0{ }
=A0};
MODULE_DEVICE_TABLE(of, wm8782_of_match);

static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] =3D {
SND_SOC_DAPM_INPUT("AINL"),
SND_SOC_DAPM_INPUT("AINR"),
};

static const struct snd_soc_dapm_route wm8782_dapm_routes[] =3D {
{ "Capture", NULL, "AINL" },
{ "Capture", NULL, "AINR" },
};

static struct snd_soc_dai_driver wm8782_dai =3D {
.name =3D "wm8782-hifi",
.capture =3D {
.stream_name =3D "Capture",
.channels_min =3D 2,
.channels_max =3D 2,
/* For configurations with FSAMPEN=3D0 */
.rates =3D SNDRV_PCM_RATE_8000_48000,
.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
=A0 SNDRV_PCM_FMTBIT_S20_3LE |
=A0 SNDRV_PCM_FMTBIT_S24_LE,
},
};

static struct snd_soc_codec_driver soc_codec_dev_wm8782 =3D {
.dapm_widgets =3D wm8782_dapm_widgets,
.num_dapm_widgets =3D ARRAY_SIZE(wm8782_dapm_widgets),
.dapm_routes =3D wm8782_dapm_routes,
.num_dapm_routes =3D ARRAY_SIZE(wm8782_dapm_routes),
};

static int wm8782_probe(struct platform_device *pdev)
{
return snd_soc_register_codec(&pdev->dev,
&soc_codec_dev_wm8782, &wm8782_dai, 1);
}

static int wm8782_remove(struct platform_device *pdev)
{
snd_soc_unregister_codec(&pdev->dev);
return 0;
}

static struct platform_driver wm8782_codec_driver =3D {
.driver =3D {
.name =3D "wm8782",
.owner =3D THIS_MODULE,
},
.probe =3D wm8782_probe,
.remove =3D wm8782_remove,
};

module_platform_driver(wm8782_codec_driver);

MODULE_DESCRIPTION("ASoC WM8782 driver");
MODULE_AUTHOR("Johannes Stezenbach <js@sig21.net>");
MODULE_LICENSE("GPL");




davinci-evm.c

/*
=A0* ASoC driver for TI DAVINCI EVM platform
=A0*
=A0* Author: =A0 =A0 =A0Vladimir Barinov, <vbarinov@embeddedalley.com>
=A0* Copyright: =A0 (C) 2007 MontaVista Software, Inc., <source@mvista.com>
=A0*
=A0* This program is free software; you can redistribute it and/or modify
=A0* it under the terms of the GNU General Public License version 2 as
=A0* published by the Free Software Foundation.
=A0*/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/platform_data/edma.h>
#include <linux/i2c.h>
#include <linux/of_platform.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>

#include <asm/dma.h>
#include <asm/mach-types.h>

#include <linux/edma.h>

#include "davinci-pcm.h"
#include "davinci-i2s.h"
#include "davinci-mcasp.h"

#include <linux/of_gpio.h>


#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
static int evm_hw_params(struct snd_pcm_substream *substream,
 struct snd_pcm_hw_params *params)
{
struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
struct snd_soc_codec *codec =3D rtd->codec;
struct snd_soc_card *soc_card =3D codec->card;
struct device_node *np =3D soc_card->dev->of_node;
int ret =3D 0;
unsigned sysclk;

if (np) {
ret =3D of_property_read_u32(np, "ti,codec-clock-rate", &sysclk);
if (ret < 0)
return ret;
} else {
/* ASP1 on DM355 EVM is clocked by an external oscillator */
if (machine_is_davinci_dm355_evm() ||
machine_is_davinci_dm6467_evm() ||
machine_is_davinci_dm365_evm())
sysclk =3D 27000000;

/*
 * ASP0 in DM6446 EVM is clocked by U55, as configured by
 * board-dm644x-evm.c using GPIOs from U18. =A0There are six
 * options; here we "know" we use a 48 KHz sample rate.
 */
else if (machine_is_davinci_evm())
sysclk =3D 12288000;

else if (machine_is_davinci_da830_evm() ||
machine_is_davinci_da850_evm())
sysclk =3D 24576000;

else
return -EINVAL;
}

/* set codec DAI configuration */
ret =3D snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
if (ret < 0)
return ret;

/* set cpu DAI configuration */
ret =3D snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
if (ret < 0)
return ret;

/* set the codec system clock */
ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
if (ret < 0)
return ret;

/* set the CPU system clock */
ret =3D snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
if (ret < 0)
return ret;

return 0;
}

static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
struct snd_pcm_hw_params *params)
{
struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;

/* set cpu DAI configuration */
return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
}

static struct snd_soc_ops evm_ops =3D {
.hw_params =3D evm_hw_params,
};

static struct snd_soc_ops evm_spdif_ops =3D {
.hw_params =3D evm_spdif_hw_params,
};

/* davinci-evm machine dapm widgets */
static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] =3D {
SND_SOC_DAPM_HP("Headphone Jack", NULL),
SND_SOC_DAPM_LINE("Line Out", NULL),
SND_SOC_DAPM_MIC("Mic Jack", NULL),
SND_SOC_DAPM_LINE("Line In", NULL),
};

/* davinci-evm machine audio_mapnections to the codec pins */
static const struct snd_soc_dapm_route audio_map[] =3D {
/* Headphone connected to HPLOUT, HPROUT */
{"Headphone Jack", NULL, "HPLOUT"},
{"Headphone Jack", NULL, "HPROUT"},

/* Line Out connected to LLOUT, RLOUT */
{"Line Out", NULL, "LLOUT"},
{"Line Out", NULL, "RLOUT"},

/* Mic connected to (MIC3L | MIC3R) */
{"MIC3L", NULL, "Mic Bias 2V"},
{"MIC3R", NULL, "Mic Bias 2V"},
{"Mic Bias 2V", NULL, "Mic Jack"},

/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
{"LINE1L", NULL, "Line In"},
{"LINE2L", NULL, "Line In"},
{"LINE1R", NULL, "Line In"},
{"LINE2R", NULL, "Line In"},
};

/* Logic for a tda998x as connected on a davinci-evm */
static int evm_tda998x_init(struct snd_soc_pcm_runtime *rtd)
{
struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
int ret;

ret =3D snd_soc_dai_set_clkdiv(cpu_dai, 0, 1);
if (ret < 0)
return ret;

ret =3D snd_soc_dai_set_clkdiv(cpu_dai, 1, 8);
if (ret < 0)
return ret;

ret =3D snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_IN);
if (ret < 0)
return ret;

ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFM=
T_I2S | SND_SOC_DAIFMT_IB_NF);
if (ret < 0)
return ret;

return 0;
}

/* Logic for a aic3x as connected on a davinci-evm */
static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
{
struct snd_soc_codec *codec =3D rtd->codec;
struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
struct snd_soc_dapm_context *dapm =3D &codec->dapm;
struct device_node *np =3D codec->card->dev->of_node;
int ret;

/* Add davinci-evm specific widgets */
snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
 =A0ARRAY_SIZE(aic3x_dapm_widgets));

if (np) {
ret =3D snd_soc_of_parse_audio_routing(codec->card,
"ti,audio-routing");
if (ret)
return ret;
} else {
/* Set up davinci-evm specific audio path audio_map */
snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
}

/* Divide McASP MCLK by 2 to provide 12MHz to codec */
ret =3D snd_soc_dai_set_clkdiv(cpu_dai, 0, 2);
if (ret < 0)
return ret;

/* not connected */
snd_soc_dapm_disable_pin(dapm, "MONO_LOUT");
snd_soc_dapm_disable_pin(dapm, "HPLCOM");
snd_soc_dapm_disable_pin(dapm, "HPRCOM");

/* always connected */
snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
snd_soc_dapm_enable_pin(dapm, "Line Out");
snd_soc_dapm_enable_pin(dapm, "Mic Jack");
snd_soc_dapm_enable_pin(dapm, "Line In");

return 0;
}

/* davinci-evm digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link dm6446_evm_dai =3D {
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name =3D "davinci-mcbsp",
.codec_dai_name =3D "tlv320aic3x-hifi",
.codec_name =3D "tlv320aic3x-codec.1-001b",
.platform_name =3D "davinci-mcbsp",
.init =3D evm_aic3x_init,
.ops =3D &evm_ops,
};

static struct snd_soc_dai_link dm355_evm_dai =3D {
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name =3D "davinci-mcbsp.1",
.codec_dai_name =3D "tlv320aic3x-hifi",
.codec_name =3D "tlv320aic3x-codec.1-001b",
.platform_name =3D "davinci-mcbsp.1",
.init =3D evm_aic3x_init,
.ops =3D &evm_ops,
};

static struct snd_soc_dai_link dm365_evm_dai =3D {
#ifdef CONFIG_SND_DM365_AIC3X_CODEC
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name =3D "davinci-mcbsp",
.codec_dai_name =3D "tlv320aic3x-hifi",
.init =3D evm_aic3x_init,
.codec_name =3D "tlv320aic3x-codec.1-0018",
.ops =3D &evm_ops,
.platform_name =3D "davinci-mcbsp",
#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
.name =3D "Voice Codec - CQ93VC",
.stream_name =3D "CQ93",
.cpu_dai_name =3D "davinci-vcif",
.codec_dai_name =3D "cq93vc-hifi",
.codec_name =3D "cq93vc-codec",
.platform_name =3D "davinci-vcif",
#endif
};

static struct snd_soc_dai_link dm6467_evm_dai[] =3D {
{
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name=3D "davinci-mcasp.0",
.codec_dai_name =3D "tlv320aic3x-hifi",
.platform_name =3D "davinci-mcasp.0",
.codec_name =3D "tlv320aic3x-codec.0-001a",
.init =3D evm_aic3x_init,
.ops =3D &evm_ops,
},
{
.name =3D "McASP",
.stream_name =3D "spdif",
.cpu_dai_name=3D "davinci-mcasp.1",
.codec_dai_name =3D "dit-hifi",
.codec_name =3D "spdif_dit",
.platform_name =3D "davinci-mcasp.1",
.ops =3D &evm_spdif_ops,
},
};

static struct snd_soc_dai_link da830_evm_dai =3D {
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name =3D "davinci-mcasp.1",
.codec_dai_name =3D "tlv320aic3x-hifi",
.codec_name =3D "tlv320aic3x-codec.1-0018",
.platform_name =3D "davinci-mcasp.1",
.init =3D evm_aic3x_init,
.ops =3D &evm_ops,
};

static struct snd_soc_dai_link da850_evm_dai =3D {
.name =3D "TLV320AIC3X",
.stream_name =3D "AIC3X",
.cpu_dai_name=3D "davinci-mcasp.0",
.codec_dai_name =3D "tlv320aic3x-hifi",
.codec_name =3D "tlv320aic3x-codec.1-0018",
.platform_name =3D "davinci-mcasp.0",
.init =3D evm_aic3x_init,
.ops =3D &evm_ops,
};

/* davinci dm6446 evm audio machine driver */
static struct snd_soc_card dm6446_snd_soc_card_evm =3D {
.name =3D "DaVinci DM6446 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D &dm6446_evm_dai,
.num_links =3D 1,
};

/* davinci dm355 evm audio machine driver */
static struct snd_soc_card dm355_snd_soc_card_evm =3D {
.name =3D "DaVinci DM355 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D &dm355_evm_dai,
.num_links =3D 1,
};

/* davinci dm365 evm audio machine driver */
static struct snd_soc_card dm365_snd_soc_card_evm =3D {
.name =3D "DaVinci DM365 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D &dm365_evm_dai,
.num_links =3D 1,
};

/* davinci dm6467 evm audio machine driver */
static struct snd_soc_card dm6467_snd_soc_card_evm =3D {
.name =3D "DaVinci DM6467 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D dm6467_evm_dai,
.num_links =3D ARRAY_SIZE(dm6467_evm_dai),
};

static struct snd_soc_card da830_snd_soc_card =3D {
.name =3D "DA830/OMAP-L137 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D &da830_evm_dai,
.num_links =3D 1,
};

static struct snd_soc_card da850_snd_soc_card =3D {
.name =3D "DA850/OMAP-L138 EVM",
.owner =3D THIS_MODULE,
.dai_link =3D &da850_evm_dai,
.num_links =3D 1,
};


#if defined(CONFIG_OF)

enum {
MACHINE_VERSION_1 =3D 0,/* DM365 with Voice Codec */
MACHINE_VERSION_2,/* DM365/DA8xx/OMAPL1x/AM33xx */
MACHINE_VERSION_3,/* AM33xx BeagleBone Black */
};

static const struct of_device_id davinci_evm_dt_ids[] =3D {
{
.compatible =3D "ti,dm365-voice-codec-audio",
.data =3D (void *)MACHINE_VERSION_1,
},
{
.compatible =3D "ti,da830-evm-audio",
.data =3D (void *)MACHINE_VERSION_2,
},
{
.compatible =3D "ti,am33xx-beaglebone-black",
.data =3D (void *)MACHINE_VERSION_3,
},
{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, davinci_mcasp_dt_ids);

/*
=A0* This struct is just used as place holder. It will be filled with
=A0* data from dt node
=A0*/
static struct snd_soc_dai_link evm_dai =3D {
.name=3D "WM8782",
.stream_name=3D "AIC3X",
.codec_dai_name=3D "wm8782-hifi",
};

/* davinci evm audio machine driver */
static struct snd_soc_card evm_soc_card =3D {
.owner =3D THIS_MODULE,
.dai_link =3D &evm_dai,
.num_links =3D 1,
};

static int davinci_evm_probe(struct platform_device *pdev)
{
struct device_node *np =3D pdev->dev.of_node;
const struct of_device_id *match =3D
of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
u32 machine_ver, clk_gpio;
int ret =3D 0;

machine_ver =3D (u32)match->data;
switch (machine_ver) {
case MACHINE_VERSION_1:
evm_dai.name=3D "Voice Codec - CQ93VC";
evm_dai.stream_name=3D "CQ93";
evm_dai.codec_dai_name=3D "cq93vc-hifi";
break;
case MACHINE_VERSION_2:
evm_dai.ops =3D &evm_ops;
evm_dai.init =3D evm_aic3x_init;
break;
case MACHINE_VERSION_3:
evm_dai.name=3D "NXP TDA HDMI Chip";
evm_dai.stream_name=3D "HDMI";
evm_dai.codec_dai_name=3D "nxp-hdmi-hifi";
evm_dai.init =3D evm_tda998x_init;

/*
 * Move GPIO handling out of the probe, if probe gets
 * deferred, the gpio will have been claimed on previous
 * probe and will fail on the second and susequent probes
 */
clk_gpio =3D of_get_named_gpio(np, "mcasp_clock_enable", 0);
if (clk_gpio < 0) {
 =A0dev_err(&pdev->dev, "failed to find mcasp_clock enable GPIO!\n");
 =A0return -EINVAL;
}
ret =3D gpio_request_one(clk_gpio, GPIOF_OUT_INIT_HIGH,
 =A0 =A0 =A0 "McASP Clock Enable Pin");
if (ret < 0) {
 =A0dev_err(&pdev->dev, "Failed to claim McASP Clock Enable pin\n");
 =A0return -EINVAL;
}
gpio_set_value(clk_gpio, 1);
break;
}

evm_dai.codec_of_node =3D of_parse_phandle(np, "ti,audio-codec", 0);
if (!evm_dai.codec_of_node)
return -EINVAL;

evm_dai.cpu_of_node =3D of_parse_phandle(np,
"ti,mcasp-controller", 0);
if (!evm_dai.cpu_of_node)
return -EINVAL;

evm_dai.platform_of_node =3D evm_dai.cpu_of_node;

evm_soc_card.dev =3D &pdev->dev;
ret =3D snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
if (ret)
return ret;

ret =3D snd_soc_register_card(&evm_soc_card);
if (ret)
dev_err(&pdev->dev, "snd_soc_register_card fuck failed (%d)\n", ret);

return ret;
}

static int davinci_evm_remove(struct platform_device *pdev)
{
struct snd_soc_card *card =3D platform_get_drvdata(pdev);

snd_soc_unregister_card(card);

return 0;
}

static struct platform_driver davinci_evm_driver =3D {
.probe=3D davinci_evm_probe,
.remove=3D davinci_evm_remove,
.driver=3D {
.name=3D "davinci_evm",
.owner=3D THIS_MODULE,
.of_match_table =3D of_match_ptr(davinci_evm_dt_ids),
},
};
#endif

static struct platform_device *evm_snd_device;

static int __init evm_init(void)
{
struct snd_soc_card *evm_snd_dev_data;
int index;
int ret;

#if defined(CONFIG_OF)
/*
 * If dtb is there, the devices will be created dynamically.
 * Only register platfrom driver structure.
 */
if (of_have_populated_dt())
return platform_driver_register(&davinci_evm_driver);
#endif

if (machine_is_davinci_evm()) {
evm_snd_dev_data =3D &dm6446_snd_soc_card_evm;
index =3D 0;
} else if (machine_is_davinci_dm355_evm()) {
evm_snd_dev_data =3D &dm355_snd_soc_card_evm;
index =3D 1;
} else if (machine_is_davinci_dm365_evm()) {
evm_snd_dev_data =3D &dm365_snd_soc_card_evm;
index =3D 0;
} else if (machine_is_davinci_dm6467_evm()) {
evm_snd_dev_data =3D &dm6467_snd_soc_card_evm;
index =3D 0;
} else if (machine_is_davinci_da830_evm()) {
evm_snd_dev_data =3D &da830_snd_soc_card;
index =3D 1;
} else if (machine_is_davinci_da850_evm()) {
evm_snd_dev_data =3D &da850_snd_soc_card;
index =3D 0;
} else
return -EINVAL;

evm_snd_device =3D platform_device_alloc("soc-audio", index);
if (!evm_snd_device)
return -ENOMEM;

platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
ret =3D platform_device_add(evm_snd_device);
if (ret)
platform_device_put(evm_snd_device);

return ret;
}

static void __exit evm_exit(void)
{
#if defined(CONFIG_OF)
if (of_have_populated_dt()) {
platform_driver_unregister(&davinci_evm_driver);
return;
}
#endif

platform_device_unregister(evm_snd_device);
}

module_init(evm_init);
module_exit(evm_exit);

MODULE_AUTHOR("Vladimir Barinov");
MODULE_DESCRIPTION("TI DAVINCI EVM ASoC driver");
MODULE_LICENSE("GPL");



device tree file

/*
* Copyright (C) 2014 John Rhoades
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License version 2 as
* published by the Free Software Foundation.
*/
/dts-v1/;
/plugin/;
=A0
/ {
=A0 =A0 compatible =3D "ti,beaglebone-black";
=A0 =A0 part-number =3D "jsr-cs4271";
=A0 =A0 version =3D "00A0";
=A0
=A0 =A0 /* state the resources this cape uses */
=A0 =A0 exclusive-use =3D
=A0 =A0 =A0 =A0 /* the pin header uses */
=A0 =A0 =A0 =A0 "P9.17", =A0 =A0 =A0 =A0/* cs4271 reset */
=A0 =A0 =A0 =A0 /* i2c2 */
=A0 =A0 =A0 =A0 "P9.19", =A0 =A0 =A0 =A0/* i2c2: scl */
=A0 =A0 =A0 =A0 "P9.20", =A0 =A0 =A0 =A0/* i2c2: sca */
=A0 =A0 =A0 =A0 /* mcasp0 */
=A0 =A0 =A0 =A0 "P9.31", =A0 =A0/* mcasp0: aclkx =A00x190 */
=A0 =A0 =A0 =A0 "P9.29", =A0 =A0/* mcasp0: fsx =A0 =A00x194 */
=A0 =A0 =A0 =A0 /* not used "P9.30", =A0 =A0 =A0 =A0/* mcasp0: axr0 =A0 0x1=
98 */
=A0 =A0 =A0 =A0 "P9.28", =A0 =A0/* mcasp0: axr2 =A0 0x19c */
=A0 =A0 =A0 =A0 "P9.42", =A0 =A0 =A0 =A0/* mcasp0: aclkr =A00x1a0 */
=A0 =A0 =A0 =A0 "P9.27", =A0 =A0 =A0 =A0/* mcasp0: fsr =A0 =A00x1a4 */
=A0 =A0 =A0 =A0 /* not used "P9.41", =A0 =A0 =A0 =A0/* mcasp0: axr1 =A0 0x1=
a8 */
=A0 =A0 =A0 =A0 "P9.25", =A0 =A0/* mcasp0: axr3 =A0 0x1ac */
=A0 =A0 =A0 =A0 /* the hardware IP uses */
=A0 =A0 =A0 =A0 "gpio1_27",
=A0 =A0 =A0 =A0 "snd-soc-wm8782", // needed to get module loaded
=A0 =A0 =A0 =A0 "mcasp0";
=A0
=A0 =A0 fragment@0 {
=A0 =A0 =A0 =A0 target =3D <&am33xx_pinmux>;
=A0 =A0 =A0 =A0 __overlay__ {
=A0
=A0 =A0 =A0 =A0 =A0 =A0 wm8782_i2c2_reset: wm8782_i2c2_reset {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-single,pins =3D <
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x078 0x0f =A0 =A0 =A0/* gpio0_5, m=
ode7 */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
=A0 =A0 =A0 =A0 =A0 =A0 };
=A0 =A0 =A0 =A0 =A0 =A0 wm8782_i2c2_pins: wm8782_i2c2_pins {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-single,pins =3D <
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x178 0x73 =A0 =A0/* I2C2_sda */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x17c 0x73 =A0 =A0 =A0/* I2C2_scl */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
=A0 =A0 =A0 =A0 =A0 =A0 };
=A0 =A0 =A0 =A0 =A0 =A0 mcasp0_pins: mcasp0_pins {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-single,pins =3D <
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x190 0x20 =A0 =A0 =A0/* P9.31 mcas=
p0 0->aclkx =A0 */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x194 0x20 =A0 =A0 =A0/* P9.29 mcas=
p0 0->fsx =A0 =A0 */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x198 0x20 =A0 =A0 =A0/* P9.30 mcas=
p0 0->axr0 =A0 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x19c 0x22 =A0 =A0/* P9.28 mcasp0 0=
->ahclkr, 2->axr2 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1a0 0x20 =A0 =A0 =A0/* P9.42 mcas=
p0 0->aclkr, =A02->axr2 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1a4 0x20 =A0 =A0 =A0/* P9.27 mcas=
p0 0->fsr, =A0 =A02->axr3 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1a8 0x20 =A0 =A0/* P9.41 mcasp0 0=
->axr1 =A0 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1ac 0x22 =A0 =A0 =A0/* P9.25 mcas=
p0 0->ahclkx, 2->axr3 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
=A0 =A0 =A0 =A0 =A0 =A0 };
=A0 =A0 =A0 =A0 };
=A0 =A0 };
=A0
=A0 =A0 fragment@2 {
=A0 =A0 =A0 =A0 target =3D <&i2c2>;
=A0 =A0 =A0 =A0 __overlay__ {
=A0
=A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
=A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
=A0
=A0 =A0 =A0 =A0 =A0 =A0 wm8782: wm8782@10 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D ",wm8782";
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x10>;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D "okay";
=A0 =A0 =A0 =A0 =A0 =A0 };
=A0 =A0 =A0 =A0 };
=A0 =A0 };
=A0
=A0 =A0 fragment@3 {
=A0 =A0 =A0 =A0 target =3D <&mcasp0>;
=A0 =A0 =A0 =A0 __overlay__ {
=A0 =A0 =A0 =A0 =A0 =A0 pinctrl-names =3D "default";
=A0 =A0 =A0 =A0 =A0 =A0 pinctrl-0 =3D <&mcasp0_pins>;
=A0
=A0 =A0 =A0 =A0 =A0 =A0 status =3D "okay";
=A0
=A0 =A0 =A0 =A0 =A0 =A0 op-mode =3D <0>; =A0 =A0 =A0 =A0 =A0/* MCASP_I2S_MO=
DE */
=A0 =A0 =A0 =A0 =A0 =A0 tdm-slots =3D <2>;
=A0 =A0 =A0 =A0 =A0 =A0 num-serializer =3D <16>;
=A0 =A0 =A0 =A0 =A0 =A0 serial-dir =3D < =A0/* 0: INACTIVE, 1: TX, 2: RX */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0 2 1 /* axr2: capture data, axr3: play d=
ata */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0 0 0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0 0 0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0 0 0
=A0 =A0 =A0 =A0 =A0 =A0 >;
=A0 =A0 =A0 =A0 =A0 =A0 tx-num-evt =3D <1>;
=A0 =A0 =A0 =A0 =A0 =A0 rx-num-evt =3D <1>;
=A0 =A0 =A0 =A0 };
=A0 =A0 };
=A0
=A0 =A0 fragment@4 {
=A0 =A0 =A0 =A0 target =3D <&ocp>;
=A0 =A0 =A0 =A0 __overlay__ {
=A0 =A0 =A0 =A0 =A0 =A0 sound {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,da830-evm-audio"; //"ti,=
am33xx-beaglebone-black";
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,model =3D "DA830 EVM"; // "wm8782";
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,audio-codec =3D <&wm8782>;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,mcasp-controller =3D <&mcasp0>;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,codec-clock-rate =3D <24576000>;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #mcasp_clock_enable =3D <&gpio2 27 0>; /* B=
eagleBone Black Clk enable on GPIO1_27 */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,audio-routing =3D
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Headphone Jack", =A0 =A0 =A0 "HPLO=
UT",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Headphone Jack", =A0 =A0 =A0 "HPRO=
UT",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "LINE1L", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "Line In",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "LINE1R", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "Line In";
=A0 =A0 =A0 =A0 =A0 =A0 };
=A0 =A0 =A0 =A0 };
=A0 =A0 };
};
