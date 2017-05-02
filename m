From: George Makdessi <george@gdis.se>
Subject: Fwd: new codec tda1543
Date: Tue, 2 May 2017 06:30:12 +0000
Message-ID: <35AA64A2-B4B2-4564-AD2C-5206426C5643@gdis.se>
References: <E7739485E9662B49B106BDE88BAB14C5018B118B7D@GDis-mail.gdis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-p-mailout03.sth.basefarm.net
 (ch-sth2-lb01-mailout-snat1.sth.basefarm.net [164.40.177.83])
 by alsa0.perex.cz (Postfix) with ESMTP id A25432668F0
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 08:39:20 +0200 (CEST)
Received: from c83-248-145-189.bredband.comhem.se ([83.248.145.189]:58703
 helo=GDis-mail.gdis.se)
 by ch-p-mailout03.sth.basefarm.net with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.84) (envelope-from <george@gdis.se>) id 1d5RSZ-000EEm-9i
 for alsa-devel@alsa-project.org; Tue, 02 May 2017 08:38:57 +0200
In-Reply-To: <E7739485E9662B49B106BDE88BAB14C5018B118B7D@GDis-mail.gdis.se>
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

Hi
Just reminder.


Vidarebefordrat brev:

Fr=E5n: George Makdessi <george@gdis.se<mailto:george@gdis.se>>
Datum: 25 april 2017 21:05:43 CEST
Till: "alsa-devel@alsa-project.org<mailto:alsa-devel@alsa-project.org>" <al=
sa-devel@alsa-project.org<mailto:alsa-devel@alsa-project.org>>
=C4mne: new codec tda1543

Commit 9f79c0289fa4b02544c6a51c789c84edd6a479fc ("audio: add support for ph=
ilips tda1543 dac chip") new simple driver for the old well known philips t=
da1543 dac chip.


Hello,

We would like to contribute with an audio codec file for the well known Phi=
lips TDA1543 dac chip. We have already made a PR for Raspbian with Raspberr=
y Pi specific driver that is well suited together with this codec. We have =
already got OK confirmation for our PR request and we just need to upstream=
 this codec to finalize the system for our new commersial dac module for Ra=
spberyy PI.
https://github.com/McDaisy/linux-1/commit/9f79c0289fa4b02544c6a51c789c84edd=
6a479fc

Thanks!

BR
George




The code:

/*
 * Driver for the tda1543 codec
 *
 * Author:    Georgios F <georgios@gdis.se<mailto:georgios@gdis.se>>
 *                Copyright 2017
 *                based on code by Florian Meier <florian.meier@koalo.de<ma=
ilto:florian.meier@koalo.de>>
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

static struct snd_soc_dai_driver tda1543_dai =3D {
    .name =3D "tda1543-hifi",
    .playback =3D {
        .channels_min =3D 2,
        .channels_max =3D 2,
        .rates =3D SNDRV_PCM_RATE_8000_192000,
        .formats =3D SNDRV_PCM_FMTBIT_S16_LE |
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

static const struct of_device_id tda1543_of_match[] =3D {
    { .compatible =3D "ti,tda1543", },
    { }
};
MODULE_DEVICE_TABLE(of, tda1543_of_match);

static struct platform_driver tda1543_codec_driver =3D {
    .probe         =3D tda1543_probe,
    .remove     =3D tda1543_remove,
    .driver        =3D {
        .name    =3D "tda1543-codec",
        .owner    =3D THIS_MODULE,
        .of_match_table =3D of_match_ptr(tda1543_of_match),
    },
};

module_platform_driver(tda1543_codec_driver);

MODULE_AUTHOR("Georgios F <georgios@gdis.se<mailto:georgios@gdis.se>>");
MODULE_DESCRIPTION("ASoC tda1543 codec driver");
MODULE_LICENSE("GPL v2");
