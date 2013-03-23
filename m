From: wendelin klimann <wklimann@gmail.com>
Subject: Re: ASoC: BeagleBoard driver development (PCM3168)
Date: Sat, 23 Mar 2013 22:56:45 +0100
Message-ID: <CAGxc5aA+HDDoMOQk_PGLdMN4XVoERtdhMyFBw-DvuY9uO9y+oA@mail.gmail.com>
References: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
 <5118F700.90006@ti.com>
 <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
 <51235D8E.7040705@ti.com>
 <CAGxc5aDQ5btyvhcEnCcvNJZhRuCZWz8XS9SxOqcgmgBSx+bYZQ@mail.gmail.com>
 <5124D1EB.9030404@ti.com> <514DBE3A.3040502@gmail.com>
 <514DD0D9.1080800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 743652652C7
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 22:56:46 +0100 (CET)
Received: by mail-la0-f49.google.com with SMTP id fs13so9164256lab.22
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 14:56:46 -0700 (PDT)
In-Reply-To: <514DD0D9.1080800@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Daniel


> *root@beagleboard:/lib/modules/3.7.4+/kernel/sound/soc/omap# aplay

> > -Dhw:1,0 /home/root/fifi.wav*
> >     [ 1128.677337] omap-dma-engine omap-dma-engine: allocating channel
> > for 17
> >     Playing WAVE '/h[ 1128.689544] can't set codec DAI configuration -
> > pcm3168
>
> This is where your trouble starts, and the reason is that when you call
> snd_soc_dai_set_fmt() on your codec dai, the core will do this:
>
>         if (dai->driver->ops->set_fmt == NULL)
>                 return -ENOTSUPP;
>
> And because you didn't implement that callback in your codec driver, the
> setup will fail. You need to implement that callback, and acknowledge
> that the codec is able to operate under the wanted conditions. See other
> codec drivers for a reference.
>

Thanks that helped to understand the problem and i was able to measure
first signals on my McBSP :-)


>
> Also, you seem to wildly mix machine and codec code, which is exactly
> what ASoC tries to prevent. Codec drivers are completely separated from
> the machine part, because they are supposed to be exchangeable. See what
> other machine code and codec drivers do. In general, as soon you as you
> import a machine or platform specific header file from your codec code,
> you're doing something wrong.
>
>
well i had several headers in my codec file which were not used but i think
there is no code which is mixed between the codec- and the machine-driver.
Next time i will clean up my code before sending it.

Thanks a lot for the fast answer
Wendelin


ps.:
The cleaned up files are added, if there are still mixes between the codec-
and machine-driver i would be glad if you could tell me.

******************************************************************************************************
*
kernel_3.7.4+/sound/soc/codecs/pcm3168.c
*
******************************************************************************************************
/*
 * ALSA Soc PCM3168 codec support
 *
 * Author: Klimann Wendelin <wklimann@hotmail.com>
 *
 * based on:
 *   > pcm3008.c
 *   > Author:    Hugo Villeneuve
 *   > Copyright (C) 2008 Lyrtech inc
 *   >
 *   > Based on AC97 Soc codec, original copyright follow:
 *   > Copyright 2005 Wolfson Microelectronics PLC.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
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
#include <sound/soc.h>

#include "pcm3168.h"

#define PCM3168_VERSION "0.1"


static int pcm3168_hw_params(struct snd_pcm_substream *substream,
                struct snd_pcm_hw_params *params,
                struct snd_soc_dai *dai)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_codec *codec = rtd->codec;

    dev_dbg(codec->dev, "Sample format 0x%X\n", params_format(params));
    dev_dbg(codec->dev, "Channels %d\n", params_channels(params));
    dev_dbg(codec->dev, "Rate %d\n", params_rate(params));

    return 0;
}

static int pcm3168_set_dai_fmt(struct snd_soc_dai *codec_dai,
                  unsigned int fmt)
{
    struct snd_soc_codec *codec = codec_dai->codec;

    /* codec role */
    switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
    case SND_SOC_DAIFMT_CBM_CFM:
        dev_dbg(codec->dev, "Codec is master\n");
        break;
    case SND_SOC_DAIFMT_CBS_CFS:
        dev_dbg(codec->dev, "Codec is slave\n");
        break;
    default:
        return -EINVAL;
    }

    /* DAI format */
    dev_dbg(codec->dev, "DAI format 0x%X",
        fmt & SND_SOC_DAIFMT_FORMAT_MASK);

    /* Bit clock and frame sync polarities */
    dev_dbg(codec->dev, "Clock polarities 0x%X\n",
        fmt & SND_SOC_DAIFMT_INV_MASK);

    return 0;
}

#define PCM3168_RATES   SNDRV_PCM_RATE_8000_96000 /*(SNDRV_PCM_RATE_32000 |
SNDRV_PCM_RATE_44100 |    \
               SNDRV_PCM_RATE_48000)*/
#define PCM3168_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE |
SNDRV_PCM_FMTBIT_S32_LE)

static const struct snd_soc_dai_ops pcm3168_dai_hifi_ops = {
    .hw_params    = pcm3168_hw_params,
    .set_fmt    = pcm3168_set_dai_fmt,
};

static struct snd_soc_dai_driver pcm3168_dai = {
    .name = "pcm3168-hifi",
    .playback = {
        .stream_name = "PCM3168 Playback",
        .channels_min = 2,
        .channels_max = 8,
        .rates = PCM3168_RATES,
        .formats = PCM3168_FORMATS,     //SNDRV_PCM_FMTBIT_S16_LE,
//SNDRV_PCM_FMTBIT_S32_LE
        .sig_bits = 24,
    },
    .capture = {
        .stream_name = "PCM3168 Capture",
        .channels_min = 2,
        .channels_max = 6,
        .rates = PCM3168_RATES,
        .formats = PCM3168_FORMATS,     //SNDRV_PCM_FMTBIT_S16_LE,
//SNDRV_PCM_FMTBIT_S32_LE
        .sig_bits = 24,
    },
    .ops = &pcm3168_dai_hifi_ops,
};

static int pcm3168_soc_probe(struct snd_soc_codec *codec)
{
    struct pcm3168_setup_data *setup = codec->dev->platform_data;
    int ret = 0;

    printk(KERN_INFO "PCM3168 SoC Audio Codec %s\n", PCM3168_VERSION);

    return ret;
}

static int pcm3168_soc_remove(struct snd_soc_codec *codec)
{
    struct pcm3168_setup_data *setup = codec->dev->platform_data;

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
    printk(KERN_ALERT "probe pcm3168 codec -> kli \n");

    ret = snd_soc_register_codec(&pdev->dev,
            &soc_codec_dev_pcm3168, &pcm3168_dai, 1);

    printk(KERN_ALERT "probe_after pcm3168 codec -> kli = %d \n", ret);

    return ret;
}

static int __devexit pcm3168_codec_remove(struct platform_device *pdev)
{
    printk(KERN_ALERT "remove pcm3168 codec -> kli \n");

    snd_soc_unregister_codec(&pdev->dev);
    return 0;
}

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
MODULE_ALIAS("platform:pcm3168-codec");



******************************************************************************************************
*
kernel_3.7.4+/sound/soc/omap/omap-pcm3168.c
*
******************************************************************************************************
/*
 * PCM3168 ASoC driver for BeagleBoard.
 *
 * based on:
 *   > omap3beagle.c  --  SoC audio for OMAP3 Beagle
 *   > Author: Steve Sakoman <steve@sakoman.com>
 *
 * adapted by Klimann Wendelin <wklimann@hotmail.com>
 *
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 *
 */

#include <linux/clk.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>
#include <sound/pcm_params.h>

#include <asm/mach-types.h>
#include <mach/hardware.h>
#include <mach/gpio.h>
//#include <plat/mcbsp.h>

#include "omap-mcbsp.h"
#include "omap-pcm.h"

/*
 * Uncomment to test codec in slave mode or without actual codec. This makes
 * possible to test this driver by letting the OMAP to be DAI link master
 */
#define PCM3168_CODEC_SLAVE        1


static int pcm3168_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *codec_dai = rtd->codec_dai;
    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
    unsigned int fmt, div;
    int ret;

#ifdef PCM3168_CODEC_SLAVE
        fmt =    SND_SOC_DAIFMT_DSP_B |
                SND_SOC_DAIFMT_CBS_CFS |
                SND_SOC_DAIFMT_IB_NF;
#else
        fmt =    SND_SOC_DAIFMT_DSP_B |
                SND_SOC_DAIFMT_CBM_CFM |
                SND_SOC_DAIFMT_IB_NF;
#endif

    /* Set codec DAI configuration */
    ret = snd_soc_dai_set_fmt(codec_dai, fmt);
    if (ret < 0) {
        printk(KERN_ERR "can't set codec DAI configuration - pcm3168\n");
        return ret;
    }

    /* Set cpu DAI configuration */
    ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
    if (ret < 0) {
        printk(KERN_ERR "can't set cpu DAI configuration - pcm3168\n");
        return ret;
    }

#ifdef PCM3168_CODEC_SLAVE

    ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
                     48000000, SND_SOC_CLOCK_IN);
    if (ret < 0) {
        pr_err("can't set McBSP sysclk - pcm3168\n");
        return ret;
    }

    /*
     * Calculate McBSP SRG divisor in McBSP master mode
     */
    div = 48000000 / params_rate(params) / params_channels(params);

    switch (params_format(params)) {
    case SNDRV_PCM_FORMAT_S16_LE:
        div /= 16;
        break;
    case SNDRV_PCM_FORMAT_S24_LE:
    case SNDRV_PCM_FORMAT_S32_LE:
        div /= 32;
        break;
    };

    /*
     * Round to maximum divisor if needed. This means that extra bit-clock
     * cycles are transmitted when sample rate and number of bits in frame
     * (channels * sample bits) are low.
     */
    if (div >= 256)
        div = 256;

    ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
    if (ret < 0) {
        pr_err("can't set SRG clock divider - pcm3168\n");
        return ret;
    }
#endif

    return 0;
}

static struct snd_soc_ops pcm3168_ops = {
    .hw_params = pcm3168_hw_params,
};

/* Digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link pcm3168_dai = {
    .name = "PCM3168",
    .stream_name = "PCM3168",
    .cpu_dai_name = "omap-mcbsp.3",
    .platform_name = "omap-pcm-audio",
    .codec_dai_name = "pcm3168-hifi",
    .codec_name = "pcm3168-codec.0",
    .ops = &pcm3168_ops,
};

/* Audio machine driver */
static struct snd_soc_card snd_soc_pcm3168 = {
    .name = "pcm3168",
    .owner = THIS_MODULE,
    .dai_link = &pcm3168_dai,
    .num_links = 1,
};

struct platform_device pcm3168_codec = {
        .name = "pcm3168-codec",
        .id = 0,
};

struct platform_device pcm3168_soc_audio = {
        .name = "pcm3168-soc-audio",
        .id = 0,
};

static int __devinit pcm3168_soc_probe(struct platform_device *pdev)
{
    struct snd_soc_card *card = &snd_soc_pcm3168;
    int ret;

    pr_info("OMAP3 Beagle - PCM3168 ASoC init\n");
    card->dev = &pdev->dev;

    ret = snd_soc_register_card(card);
    if (ret) {
        dev_err(&pdev->dev, "snd_soc_register_card() failed: %d -
pcm3168\n",
            ret);
        return ret;
    }
    return 0;
}

static int __devexit pcm3168_soc_remove(struct platform_device *pdev)
{
    struct snd_soc_card *card = platform_get_drvdata(pdev);
    snd_soc_unregister_card(card);

    return 0;
}

static struct platform_driver pcm3168_driver = {
    .driver = {
        .name = "pcm3168-soc-audio",
        .owner = THIS_MODULE,
    },
    .probe = pcm3168_soc_probe,
    .remove = __devexit_p(pcm3168_soc_remove),
};

static int __init pcm3168_soc_init(void)
{
    platform_device_register(&pcm3168_codec);
    platform_device_register(&pcm3168_soc_audio);
    return platform_driver_register(&pcm3168_driver);
}
module_init(pcm3168_soc_init);

static void __exit pcm3168_soc_exit(void)
{
    platform_driver_unregister(&pcm3168_driver);
    platform_device_unregister(&pcm3168_soc_audio);
    platform_device_unregister(&pcm3168_codec);
}
module_exit(pcm3168_soc_exit);

MODULE_AUTHOR("Klimann Wendelin <wklimann@hotmail.com>");
MODULE_DESCRIPTION("ALSA SoC PCM3168 add on Soundcard");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:pcm3168-soc-audio");
