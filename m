From: Fabio Estevam <festevam@gmail.com>
Subject: Re: sgtl5000 fails after suspend/resume
Date: Thu, 15 Feb 2018 14:36:00 -0200
Message-ID: <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
References: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3617A267C5D
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 17:36:01 +0100 (CET)
Received: by mail-ot0-f195.google.com with SMTP id q12so229875otg.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 08:36:01 -0800 (PST)
In-Reply-To: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Eric Nelson <eric@nelint.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>, Stefan Agner <stefan@agner.ch>, Gary Bisson <gary.bisson@boundarydevices.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 15, 2018 at 11:35 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> I noticed that sgtl5000 does not work after a suspend/resume cycle:
>
> # aplay /media/a2002011001-e02.wav
> Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
> Endian, Rate 44100 Hz, Stereo
> aplay: pcm_write:2051: write error: Input/output error
>
> Tested several 4.16-rc1 (and also previous kernels like 4.4) and all
> of them failed.
>
> I think it worked in some point in time.
>
> Tested on a imx53qsb and imx6 wandboard.
>
> Does anyone have any suggestions?

Reverting the commit below on top of 4.16-rc1 makes sgtl5000
suspend/resume to work again:

commit 8419caa7270291e26f8b34b12b29680586c85d30
Author: Eric Nelson <eric@nelint.com>
Date:   Tue Jun 7 01:14:52 2016 +0200

    ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF

    Disabling the SGTL5000 through regulators would certainly save more
    power than simply disabling the reference voltages as described in the
    data sheet, but won't properly restore things on resume.

    This driver does not support active regulators. So we simply disable the
    reference bias currents.

    Signed-off-by: Eric Nelson <eric@nelint.com>
    Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
    Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Or if I do the change below against linux-next it also works:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -880,8 +880,6 @@ static int sgtl5000_set_bias_level(struct
snd_soc_component *component,
                                    SGTL5000_REFTOP_POWERUP);
                break;
        case SND_SOC_BIAS_OFF:
-               snd_soc_component_update_bits(component,
SGTL5000_CHIP_ANA_POWER,
-                                   SGTL5000_REFTOP_POWERUP, 0);
                break;
        }

Any suggestions for a proper fix? Eric?

Thanks
