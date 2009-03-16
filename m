From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: twl4030 - Fix build error
Date: Mon, 16 Mar 2009 09:01:11 +0200
Message-ID: <bd7b27490903160001q64ae952fh30f74b2799bb663e@mail.gmail.com>
References: <4e1455be0903152013kf2158fdpc339a682111417c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f174.google.com (mail-bw0-f174.google.com
	[209.85.218.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 8972C103804
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 08:01:12 +0100 (CET)
Received: by bwz22 with SMTP id 22so3191258bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 00:01:11 -0700 (PDT)
In-Reply-To: <4e1455be0903152013kf2158fdpc339a682111417c3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  sound/soc/codecs/twl4030.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index ce4b43b..5ed5f1b 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -1383,6 +1383,12 @@ static int twl4030_set_dai_fmt(struct
> snd_soc_dai *codec_dai,
>  #define TWL4030_RATES   (SNDRV_PCM_RATE_8000_48000)
>  #define TWL4030_FORMATS         (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FORMAT_S24_LE)
>
> +static struct snd_soc_dai_ops twl4030_dai_ops = {
> +       .hw_params      = twl4030_hw_params,
> +       .set_sysclk     = twl4030_set_dai_sysclk,
> +       .set_fmt        = twl4030_set_dai_fmt,
> +};
> +
>  struct snd_soc_dai twl4030_dai = {
>        .name = "twl4030",
>        .playback = {
> @@ -1397,11 +1403,7 @@ struct snd_soc_dai twl4030_dai = {
>                .channels_max = 2,
>                .rates = TWL4030_RATES,
>                .formats = TWL4030_FORMATS,},
> -       .ops = {
> -               .hw_params = twl4030_hw_params,
> -               .set_sysclk = twl4030_set_dai_sysclk,
> -               .set_fmt = twl4030_set_dai_fmt,
> -       }
> +       .ops = &twl4030_dai_ops,
>  };
>  EXPORT_SYMBOL_GPL(twl4030_dai);
>
>
Looks like a valid fix but note there is line wrapping and tabs are
converted
into spaces so patch doesn't apply.


Jarkko
