From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
 enabling/disabling order
Date: Tue, 28 May 2013 11:10:35 -0300
Message-ID: <CAOMZO5CpOz3PKiJ8-Ka+0nWN8BLquxHMcb8DZGvEE-cbeq3M8w@mail.gmail.com>
References: <1369366496-15329-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f178.google.com (mail-ve0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id F13A02610BA
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 16:10:35 +0200 (CEST)
Received: by mail-ve0-f178.google.com with SMTP id pb11so3763205veb.23
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 07:10:35 -0700 (PDT)
In-Reply-To: <1369366496-15329-1-git-send-email-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Marek,

On Fri, May 24, 2013 at 12:34 AM, Marek Vasut <marex@denx.de> wrote:
> The VAG_POWER must be enabled after all other bits in CHIP_ANA_POWER
> and disabled before any other bit in CHIP_ANA_POWER. See the SGTL5000
> datasheet (Table 31, BIT 7, page 42-43). Failing to follow this order
> will result in ugly loud "POP" noise at the end of playback.
>
> To achieve such order, use the _PRE and _POST DAPM widgets to trigger
> the power_vag_event, where the event type check has to be fixed
> accordingly as well.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Eric Nelson <eric.nelson@boundarydevices.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks, tested on a mx51evk and it removes an annoying 'click' after
an audio track is played.

> -       case SND_SOC_DAPM_POST_PMD:
> +       case SND_SOC_DAPM_PRE_PMD:
>                 snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
>                         SGTL5000_VAG_POWERUP, 0);
> -               msleep(400);
> +               mdelay(400);

What is the reasoning for this change?

Anyway:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
