From: George Makdessi <george@gdis.se>
Subject: new codec tda1543
Date: Tue, 25 Apr 2017 19:05:43 +0000
Message-ID: <E7739485E9662B49B106BDE88BAB14C5018B118B7D@GDis-mail.gdis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-p-mailout03.sth.basefarm.net
 (ch-sth2-lb01-mailout-snat1.sth.basefarm.net [164.40.177.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 544CA266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 21:13:59 +0200 (CEST)
Received: from c83-248-145-189.bredband.comhem.se ([83.248.145.189]:44215
 helo=GDis-mail.gdis.se)
 by ch-p-mailout03.sth.basefarm.net with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.84) (envelope-from <george@gdis.se>) id 1d35u8-000Gof-B1
 for alsa-devel@alsa-project.org; Tue, 25 Apr 2017 21:13:43 +0200
Content-Language: sv-SE
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

Commit 9f79c0289fa4b02544c6a51c789c84edd6a479fc ("audio: add support for philips tda1543 dac chip") new simple driver for the old well known philips tda1543 dac chip.


Hello,

We would like to contribute with an audio codec file for the well known Philips TDA1543 dac chip. We have already made a PR for Raspbian with Raspberry Pi specific driver that is well suited together with this codec. We have already got OK confirmation for our PR request and we just need to upstream this codec to finalize the system for our new commersial dac module for Raspberyy PI.
https://github.com/McDaisy/linux-1/commit/9f79c0289fa4b02544c6a51c789c84edd6a479fc

Thanks!

BR
George




The code:

/*
 * Driver for the tda1543 codec
 *
 * Author:    Georgios F <georgios@gdis.se>
 *                Copyright 2017
 *                based on code by Florian Meier <florian.meier@koalo.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 */


#include <linux/init.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <sound/soc.h>

static struct snd_soc_dai_driver tda1543_dai = {
    .name = "tda1543-hifi",
    .playback = {
        .channels_min = 2,
        .channels_max = 2,
        .rates = SNDRV_PCM_RATE_8000_192000,
        .formats = SNDRV_PCM_FMTBIT_S16_LE |
               SNDRV_PCM_FMTBIT_S24_LE
    },
};

static struct snd_soc_codec_driver soc_codec_dev_tda1543;

static int tda1543_probe(struct platform_device *pdev)
{
    return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_tda1543,
            &tda1543_dai, 1);
}

static int tda1543_remove(struct platform_device *pdev)
{
    snd_soc_unregister_codec(&pdev->dev);
    return 0;
}

static const struct of_device_id tda1543_of_match[] = {
    { .compatible = "ti,tda1543", },
    { }
};
MODULE_DEVICE_TABLE(of, tda1543_of_match);

static struct platform_driver tda1543_codec_driver = {
    .probe         = tda1543_probe,
    .remove     = tda1543_remove,
    .driver        = {
        .name    = "tda1543-codec",
        .owner    = THIS_MODULE,
        .of_match_table = of_match_ptr(tda1543_of_match),
    },
};

module_platform_driver(tda1543_codec_driver);

MODULE_AUTHOR("Georgios F <georgios@gdis.se>");
MODULE_DESCRIPTION("ASoC tda1543 codec driver");
MODULE_LICENSE("GPL v2");
