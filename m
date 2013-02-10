From: wendelin klimann <wklimann@gmail.com>
Subject: ASoC: BeagleBoard driver development (PCM3168)
Date: Sun, 10 Feb 2013 22:50:37 +0100
Message-ID: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E752A260307
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 22:50:37 +0100 (CET)
Received: by mail-la0-f43.google.com with SMTP id ek20so5201688lab.2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 13:50:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hello

I try to implement an PCM3168 audio codec from TI to the BeagleBoard but
actually i am stuck and it would be rally nice if one could help me a
little bit.
My ALSA driver version is 1.0.24 and i use an 3.2.18 kernel.
As a startingpoint i used the files

*/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3008.c*
*/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3008.h*


The files                   (see end of e-mail)

*/linux-mainline-3.2.18-r121b/git/sound/soc/omap/pcm3168_soundcard.c
/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3168.c
/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3168.h*

could be compiled successfully and also the insmod loads the modules

*$: insmod
/lib/modules/3.2.18/kernel/sound/soc/omap/snd-soc-pcm3168_soundcard.ko*

*$: lsmod*
Module                  Size  Used by
snd_soc_pcm3168         1886  0
snd_soc_pcm3168_soundcard     2094  0
twl4
030_madc_hwmon      2569  0
snd_soc_omap3beagle     2239  0
rtc_twl                 4382  0
snd_soc_twl4030        37616  1
rtc_ds1307              6642  0
snd_soc_omap            3521  1
snd_soc_omap_mcbsp      8374  1
snd_soc_core          107346  6
snd_soc_pcm3168,snd_soc_pcm3168_soundcard,snd_soc_omap3beagle,snd_soc_twl4030,snd_soc_omap,snd_soc_omap_mcbsp
regmap_spi              1263  1 snd_soc_core
snd_pcm                78039  4
snd_soc_twl4030,snd_soc_omap,snd_soc_omap_mcbsp,snd_soc_core
snd_timer              18848  1 snd_pcm
snd                    57930  3 snd_soc_core,snd_pcm,snd_timer
soundcore               6954  1 snd
iptable_nat             3819  0
snd_page_alloc          4979  1 snd_pcm
nf_nat                 16515  1 iptable_nat
nf_conntrack_ipv4      12018  3 iptable_nat,nf_nat
nf_conntrack           71219  3 iptable_nat,nf_nat,nf_conntrack_ipv4
nf_defrag_ipv4          1379  1 nf_conntrack_ipv4
ip_tables              10537  1 iptable_nat
x_tables               16505  2 iptable_nat,ip_tables
gpio_keys               7117  0
autofs4                20492  2

but the new ALSA device is not recognized

*$:aplay -l*
**** List of PLAYBACK Hardware Devices ****
card 0: omap3beagle [omap3beagle], device 0: TWL4030 twl4030-hifi-0 []
  Subdevices
: 1/1
  Subdevice #0: subdevice #0

So i tried to get some information in

*$: cd /sys/kernel/debug/asoc*

*/sys/kernel/debug/asoc$: ls*
codecs       dais         omap3beagle  pcm3168      platforms

*/sys/kernel/debug/asoc$: cat codecs*
pcm3168-codec.0
twl4030-codec

*/sys/kernel/debug/asoc$: cat dais*
pcm3168-hifi
twl4030-voice
twl4030-hifi
omap-mcbsp-dai.4
omap-mcbsp-dai.3
omap-mcbsp-dai.2
omap-mcbsp-dai.1
omap-mcbsp-dai.0

*/sys/kernel/debug/asoc$: cat platforms*
omap-pcm-audio
snd-soc-dummy

*/sys/kernel/debug/asoc$:cd omap3beagle*

*/sys/kernel/debug/asoc/omap3beagle$:ls*
dapm           dapm_pop_time  twl4030-codec

*/sys/kernel/debug/asoc/omap3beagle$:cd /sys/kernel/debug/asoc/pcm3168*

*/sys/kernel/debug/asoc/pcm3168$: ls*
dapm_pop_time


At this point i have no idea how to solve the problem or how to debug
further and i would be very grateful for any hint.

Thanks a lot
Wendelin




*
***********************************************************************************************
*
/linux-mainline-3.2.18-r121b/git/sound/soc/omap/pcm3168_soundcard.c
*
**
***********************************************************************************************

*/*
 * PCM3168 ASoC driver for BeagleBoard.
 *
 * Author:    Hugo Villeneuve
 * Copyright (C) 2008 Lyrtech inc
 *
 * adapted by Klimann Wendelin <wklimann@hotmail.com>
 *
 *
 * Based on ASoC driver for TI DAVINCI EVM platform, original copyright
follow:
 * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/clk.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <asm/mach-types.h>
//#include <asm/dma.h>
#include <mach/hardware.h>
#include <mach/gpio.h>
//#include <mach/edma.h>
#include <plat/mcbsp.h>

#include "omap-mcbsp.h"
#include "omap-pcm.h"

#include "../codecs/pcm3168.h"

/*
 * CLKX and CLKR are the inputs for the Sample Rate Generator.
 * FSX and FSR are outputs, driven by the sample Rate Generator.
 */
/*
 * SND_SOC_DAIFMT_CBS_CFS
 * for codec in slave mode
 */
#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B |    \
              SND_SOC_DAIFMT_CBM_CFM |    \
              SND_SOC_DAIFMT_IB_NF)

static int pcm3168_hw_params(struct snd_pcm_substream *substream,
                struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
    int fs;
    int ret = 0;


printk("in hw_params -> by kli");


    /* Fsref can be 8000 to 96000. */
    fs = params_rate(params);

    /* set cpu DAI configuration */
    ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
    if (ret < 0) {
        printk(KERN_ERR "can't set cpu DAI configuration\n");
        return ret;
    }

    pr_debug("pcm3168_hw_params: rate = %d Hz\n", fs);

    return 0;
}

static struct snd_soc_ops pcm3168_ops = {
    .hw_params = pcm3168_hw_params,
};

/* omap-pcm3168 digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link pcm3168_dai = {
    .name = "PCM3168",  /* Codec name */
    .stream_name = "PCM3168",
    .cpu_dai_name = "omap-mcbsp-dai.2",
    .codec_dai_name = "pcm3168-hifi",
    .codec_name = "pcm3168-codec",
    .platform_name = "omap-pcm-audio",
    .ops = &pcm3168_ops,
};

/* omap-pcm3168 audio machine driver */
static struct snd_soc_card snd_soc_pcm3168 = {
    .name = "pcm3168",                      // -> "OMAP pcm3168"
    .owner = THIS_MODULE,
    .dai_link = &pcm3168_dai,
    .num_links = 1,
};

/* pcm3168 audio private data */
static struct pcm3168_setup_data pcm3168_pcm3168_setup = {
//    .dem0_pin = GPIO(45),
//    .dem1_pin = GPIO(46),
//    .pdad_pin = GPIO(47),
//    .pdda_pin = GPIO(38),
};

struct platform_device pcm3168_codec = {
        .name = "pcm3168-codec",
        .id = 0,
        .dev = {
                .platform_data = &pcm3168_pcm3168_setup,
        },
};



static struct platform_device *pcm3168_snd_device;

static int __init pcm3168_init(void)
{
    int ret;

printk(KERN_ALERT "in init soundcard \n");

    if (!(machine_is_omap3_beagle()))
        return -ENODEV;

    platform_device_register(&pcm3168_codec);

    pcm3168_snd_device = platform_device_alloc("soc-audio", 0);
    if (!pcm3168_snd_device) {
        printk(KERN_ERR "platform device allocation failed\n");
        return -ENOMEM;
    }

    platform_set_drvdata(pcm3168_snd_device, &snd_soc_pcm3168);
//    platform_device_add_data(pcm3168_snd_device, &pcm3168_snd_data,
//                 sizeof(pcm3168_snd_data));

/*    ret = platform_device_add_resources(pcm3168_snd_device,
                        pcm3168_snd_resources,
                        ARRAY_SIZE(pcm3168_snd_resources));
    if (ret) {
        printk(KERN_ERR "platform device add resources failed\n");
        goto error;
    }
*/
    ret = platform_device_add(pcm3168_snd_device);
    if (ret)
        goto error;

    return ret;

error:
    platform_device_put(pcm3168_snd_device);
    return ret;
}

static void __exit pcm3168_exit(void)
{
    platform_device_unregister(pcm3168_snd_device);
    platform_device_unregister(&pcm3168_codec);
}

module_init(pcm3168_init);
module_exit(pcm3168_exit);

MODULE_AUTHOR("Klimann Wendelin <wklimann@hotmail.com>");
MODULE_DESCRIPTION("PCM3168 Beagle ASoC driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:pcm3168-soc-audio");




*
***********************************************************************************************
*
/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3168.c
   *
**
***********************************************************************************************

*/*
 * ALSA Soc PCM3168 codec support
 *
 * Author:    Hugo Villeneuve
 * Copyright (C) 2008 Lyrtech inc
 *
 * adapted by Klimann Wendelin
 *
 *
 * Based on AC97 Soc codec, original copyright follow:
 * Copyright 2005 Wolfson Microelectronics PLC.
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 * Generic PCM3168 support.
 */

#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/gpio.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/clk.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <sound/core.h>
#include <sound/initval.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
//#include <sound/soc-dapm.h>
#include <sound/soc.h>

#include <asm/mach-types.h>
#include <mach/hardware.h>
#include <mach/gpio.h>
#include <plat/mcbsp.h>

#include "../omap/omap-mcbsp.h"
#include "../omap/omap-pcm.h"

#include "pcm3168.h"



#define PCM3168_VERSION "0.1"

#define PCM3168_RATES   SNDRV_PCM_RATE_8000_96000 /*(SNDRV_PCM_RATE_32000 |
SNDRV_PCM_RATE_44100 |    \
               SNDRV_PCM_RATE_48000)*/

static struct snd_soc_dai_driver pcm3168_dai = {

    .name = "pcm3168-hifi",
    .playback = {
        .stream_name = "PCM3168 Playback",
        .channels_min = 2,
        .channels_max = 8,
        .rates = PCM3168_RATES,
        .formats = SNDRV_PCM_FMTBIT_S16_LE, //SNDRV_PCM_FMTBIT_S32_LE
    },
    .capture = {
        .stream_name = "PCM3168 Capture",
        .channels_min = 2,
        .channels_max = 6,
        .rates = PCM3168_RATES,
        .formats = SNDRV_PCM_FMTBIT_S16_LE, //SNDRV_PCM_FMTBIT_S32_LE
    },
};

static void pcm3168_gpio_free(struct pcm3168_setup_data *setup)
{
//    gpio_free(setup->dem0_pin);
//    gpio_free(setup->dem1_pin);
//    gpio_free(setup->pdad_pin);
//    gpio_free(setup->pdda_pin);
}

static int pcm3168_soc_probe(struct snd_soc_codec *codec)
{
    struct pcm3168_setup_data *setup = codec->dev->platform_data;
    int ret = 0;

printk(KERN_ALERT "in SOC Probe -> kli \n");

    printk(KERN_INFO "PCM3168 SoC Audio Codec %s\n", PCM3168_VERSION);

    return ret;

gpio_err:
//    pcm3168_gpio_free(setup);

    return ret;
}

static int pcm3168_soc_remove(struct snd_soc_codec *codec)
{
    struct pcm3168_setup_data *setup = codec->dev->platform_data;

//    pcm3168_gpio_free(setup);
    return 0;
}


#define pcm3168_soc_suspend NULL
#define pcm3168_soc_resume NULL


static struct snd_soc_codec_driver soc_codec_dev_pcm3168 = {
    .probe =     pcm3168_soc_probe,
    .remove =     pcm3168_soc_remove,
    .suspend =    pcm3168_soc_suspend,
    .resume =    pcm3168_soc_resume,
};

static int __devinit pcm3168_codec_probe(struct platform_device *pdev)
{
    int ret;
    printk(KERN_ALERT "probe pcm3168 -> kli \n");

    ret = snd_soc_register_codec(&pdev->dev,
            &soc_codec_dev_pcm3168, &pcm3168_dai, 1);

    printk(KERN_ALERT "probe_after pcm3168 -> kli = %d \n", ret);

    return ret;
}

static int __devexit pcm3168_codec_remove(struct platform_device *pdev)
{
    printk(KERN_ALERT "remove pcm3168 -> kli \n");

    snd_soc_unregister_codec(&pdev->dev);
    return 0;
}

MODULE_ALIAS("platform:pcm3168-codec");

static struct platform_driver pcm3168_codec_driver = {
    .probe        = pcm3168_codec_probe,
    .remove        = __devexit_p(pcm3168_codec_remove),
    .driver        = {
    .name        = "pcm3168-codec",
    .owner        = THIS_MODULE,
    },
};

static int __init pcm3168_modinit(void)
{
    printk(KERN_ALERT "in init of 3168 -> kli \n");
    return platform_driver_register(&pcm3168_codec_driver);
}
module_init(pcm3168_modinit);

static void __exit pcm3168_exit(void)
{
    printk(KERN_ALERT "in exit of 3168 -> kli \n");
    platform_driver_unregister(&pcm3168_codec_driver);
}
module_exit(pcm3168_exit);

MODULE_DESCRIPTION("Soc PCM3168 driver");
MODULE_AUTHOR("Klimann Wendelin <wklimann@hotmail.com>");
MODULE_LICENSE("GPL");


*
***********************************************************************************************
*
/linux-mainline-3.2.18-r121b/git/sound/soc/codecs/pcm3168.h
    *
***********************************************************************************************
*

/*
 * PCM3168 ALSA SoC Layer
 *
 * Author:    Hugo Villeneuve
 * Copyright (C) 2008 Lyrtech inc
 *
 * adapted by Klimann Wendelin <wklimann@hotmail.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#ifndef __LINUX_SND_SOC_PCM3168_2_H
#define __LINUX_SND_SOC_PCM3168_2_H

struct pcm3168_setup_data {
//    unsigned dem0_pin;
//    unsigned dem1_pin;
//    unsigned pdad_pin;
//    unsigned pdda_pin;
};

#endif
