From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: rx1950_uda1380: Don't modify
	runtime->hw
Date: Mon, 3 Feb 2014 19:55:52 +0300
Message-ID: <CA+E=qVcFwpz97U4wQuGHMXGdfcGKf=05S4TZd+SSmr_1K4VoOg@mail.gmail.com>
References: <1391444662-11933-1-git-send-email-lars@metafoo.de>
 <1391444662-11933-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 151172608CF
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 17:56:13 +0100 (CET)
Received: by mail-ob0-f172.google.com with SMTP id vb8so8138887obc.17
 for <alsa-devel@alsa-project.org>; Mon, 03 Feb 2014 08:56:12 -0800 (PST)
In-Reply-To: <1391444662-11933-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 3, 2014 at 7:24 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Individual components are not supposed to modify the runtime->hw struct itself
> as it is manged by the ASoC core. If a component wants to limit the list of
> supported rates it should set a rate constraint. The rx1950_uda1380 already does
> this, so it is safe to just remove the code that modifies runtime->hw.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Both patches looks OK to me.
For both:

Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>


> ---
>  sound/soc/samsung/rx1950_uda1380.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
> index f69da8f..2311c88 100644
> --- a/sound/soc/samsung/rx1950_uda1380.c
> +++ b/sound/soc/samsung/rx1950_uda1380.c
> @@ -131,10 +131,6 @@ static int rx1950_startup(struct snd_pcm_substream *substream)
>  {
>         struct snd_pcm_runtime *runtime = substream->runtime;
>
> -       runtime->hw.rate_min = hw_rates.list[0];
> -       runtime->hw.rate_max = hw_rates.list[hw_rates.count - 1];
> -       runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
> -
>         return snd_pcm_hw_constraint_list(runtime, 0,
>                                         SNDRV_PCM_HW_PARAM_RATE,
>                                         &hw_rates);
> --
> 1.8.0
>
