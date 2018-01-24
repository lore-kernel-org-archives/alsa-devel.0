From: Brian Norris <briannorris@chromium.org>
Subject: Re: Applied "ASoC: rt5514-spi: Check the validity of drvdata pointer
 on resume" to the asoc tree
Date: Wed, 24 Jan 2018 09:07:49 -0800
Message-ID: <CA+ASDXOo5W3z37bEFaMACvAjfcu0RWtYw_d=NJ56poY0EOu4fQ@mail.gmail.com>
References: <20171216011230.107527-1-briannorris@chromium.org> <E1eeN5q-0004lO-5c@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1eeN5q-0004lO-5c@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Hi Marc and Mark,

Mark already noticed this was no longer needed, but I just wanted to
note things for the record, since Marc seemed curious.

On Wed, Jan 24, 2018 at 7:36 AM, Mark Brown <broonie@kernel.org> wrote:
...
>
> From 509bf3a7d43ab173abc354df2a859229ede043c0 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Wed, 24 Jan 2018 14:50:00 +0000
> Subject: [PATCH] ASoC: rt5514-spi: Check the validity of drvdata pointer on
>  resume
>
> The rt5514-spi driver seem to assume the validity of the drvdata pointer
> on resume, which it may not be populated, leading to a not-so-nice crash.

This part was fixed with this:

346cccf88319 ASoC: rt5514: Add the sanity check for the driver_data in
the resume function

which is in 4.15-rc6

> This stems from the fact that rt5514_spi_pcm_probe() is never called on
> my system (a kevin Chromebook). No idea why, but if it can happen, it
> is worth fixing.

I believe the rk3399_gru_sound driver currently does not set up the
DAI links properly at the moment. This patch is still waiting, to fix
that:

https://patchwork.kernel.org/patch/10067725/
[PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailinkgi

Brian

> Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule data copy in resume function")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  sound/soc/codecs/rt5514-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
> index 2df91db765ac..9255afcf2c3a 100644
> --- a/sound/soc/codecs/rt5514-spi.c
> +++ b/sound/soc/codecs/rt5514-spi.c
> @@ -482,7 +482,7 @@ static int __maybe_unused rt5514_resume(struct device *dev)
>         if (device_may_wakeup(dev))
>                 disable_irq_wake(irq);
>
> -       if (rt5514_dsp->substream) {
> +       if (rt5514_dsp && rt5514_dsp->substream) {
>                 rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
>                 if (buf[0] & RT5514_IRQ_STATUS_BIT)
>                         rt5514_schedule_copy(rt5514_dsp);
> --
> 2.15.1
>
