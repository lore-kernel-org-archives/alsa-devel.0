From: wendelin klimann <wklimann@gmail.com>
Subject: Re: ASoC: BeagleBoard driver development (PCM3168)
Date: Fri, 1 Mar 2013 21:00:28 +0100
Message-ID: <CAGxc5aBQcHE7qWNZrQHqJ8g5o2E85uXCaQv2W4GV17Z_AMFCkQ@mail.gmail.com>
References: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
 <5118F700.90006@ti.com>
 <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
 <51235D8E.7040705@ti.com>
 <CAGxc5aDQ5btyvhcEnCcvNJZhRuCZWz8XS9SxOqcgmgBSx+bYZQ@mail.gmail.com>
 <5124D1EB.9030404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4069D260202
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 21:00:29 +0100 (CET)
Received: by mail-la0-f54.google.com with SMTP id gw10so3251798lab.41
 for <alsa-devel@alsa-project.org>; Fri, 01 Mar 2013 12:00:28 -0800 (PST)
In-Reply-To: <5124D1EB.9030404@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello and thanks for the support


I would advice to update. Eventually you want to upstream the codec driver,
> so
> it is going to be easier for you.
>

Well i followed your advice and updated to kernel version 3.7.4+ and to
ALSA version k3.7.4+, and i will be glad to upstram the finalized driver.
As you recommended i am using your omap_twl4030.c file as a starting-point
for my driver development, and i am trying to get the adapted machine
driver to run but without success.
The machine driver is not even going into

*   static __devinit int omap_pcm3168_probe(struct platform_device *pdev)*

and i am really stuck at this point.

It would be really nice if you could help me.


Regards
Wendelin


File:

/*
 * omap-pcm3168.c  --  PCM3168 ASoC driver for the BeagleBoard.
 *
 * based on:
 *    > omap-twl4030.c  --  SoC audio for TI SoC based boards with twl4030
codec
 *    >
 *    > Copyright (C) 2012 Texas Instruments Incorporated -
http://www.ti.com
 *    > All rights reserved.
 *    >
 *    > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
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

#include <linux/platform_device.h>
//#include <linux/platform_data/omap-twl4030.h>
#include <linux/module.h>
#include <linux/of.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>

#include "omap-mcbsp.h"
#include "omap-pcm.h"

static int omap_pcm3168_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *codec_dai = rtd->codec_dai;
    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
    struct snd_soc_codec *codec = rtd->codec;
    struct snd_soc_card *card = codec->card;
    unsigned int fmt;
    int ret;

    fmt =    SND_SOC_DAIFMT_DSP_B     |
            SND_SOC_DAIFMT_CBM_CFM  |
            SND_SOC_DAIFMT_IB_NF;

    /* Set codec DAI configuration */
    ret = snd_soc_dai_set_fmt(codec_dai, fmt);
    if (ret < 0) {
        dev_err(card->dev, "can't set codec DAI configuration\n");
        return ret;
    }

    /* Set cpu DAI configuration */
    ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
    if (ret < 0) {
        dev_err(card->dev, "can't set cpu DAI configuration\n");
        return ret;
    }

    return 0;
}

static struct snd_soc_ops omap_pcm3168_ops = {
    .hw_params = omap_pcm3168_hw_params,
};

/* Digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link omap_pcm3168_dai_links[] = {
    {
        .name = "PCM3168",
        .stream_name = "PCM3168",
        .cpu_dai_name = "omap-mcbsp.3",
        .codec_dai_name = "pcm3168-hifi",
        .platform_name = "omap-pcm-audio",
        .codec_name = "pcm3168-codec.0",
        .ops = &omap_pcm3168_ops,
    },
};

/* Audio machine driver */
static struct snd_soc_card omap_pcm3168_card = {
    .owner = THIS_MODULE,
    .dai_link = omap_pcm3168_dai_links,
    .num_links = ARRAY_SIZE(omap_pcm3168_dai_links),
};

static __devinit int omap_pcm3168_probe(struct platform_device *pdev)
{
    printk("in __devinit omap_pcm3168_probe -> by kli");

    struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
    struct device_node *node = pdev->dev.of_node;
    struct snd_soc_card *card = &omap_pcm3168_card;
    int ret = 0;

    card->dev = &pdev->dev;

    if (node) {
        struct device_node *dai_node;

        if (snd_soc_of_parse_card_name(card, "ti,model")) {
            dev_err(&pdev->dev, "Card name is not provided\n");
            return -ENODEV;
        }

        dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
        if (!dai_node) {
            dev_err(&pdev->dev, "McBSP node is not provided\n");
            return -EINVAL;
        }
        omap_pcm3168_dai_links[0].cpu_dai_name  = NULL;
        omap_pcm3168_dai_links[0].cpu_of_node = dai_node;

    }
    /*else if (pdata) {
        if (pdata->card_name) {
            card->name = pdata->card_name;
        } else {
            dev_err(&pdev->dev, "Card name is not provided\n");
            return -ENODEV;
        }
    }*/
    else {
        dev_err(&pdev->dev, "Missing pdata\n");
        return -ENODEV;
    }

    ret = snd_soc_register_card(card);
    if (ret) {
        dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
            ret);
        return ret;
    }

    return 0;
}

static int __devexit omap_pcm3168_remove(struct platform_device *pdev)
{
    struct snd_soc_card *card = platform_get_drvdata(pdev);

    snd_soc_unregister_card(card);

    return 0;
}


static const struct of_device_id omap_pcm3168_of_match[] = {
    {.compatible = "ti,omap-pcm3168", },
    { },
};
MODULE_DEVICE_TABLE(of, omap_pcm3168_of_match);

static struct platform_driver omap_pcm3168_driver = {
    .driver = {
        .name = "omap-pcm3168",
        .owner = THIS_MODULE,
//        .pm = &snd_soc_pm_ops,
//        .of_match_table = omap_pcm3168_of_match,
    },
    .probe = omap_pcm3168_probe,
    .remove = __devexit_p(omap_pcm3168_remove),
};

module_platform_driver(omap_pcm3168_driver);

MODULE_AUTHOR("Klimann Wendelin <wklimann@hotmail.com>");
MODULE_DESCRIPTION("ALSA SoC PCM3168 add on Soundcard");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:omap-pcm3168");
