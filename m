From: =?UTF-8?Q?Rapha=C3=ABl_Poggi?= <poggi.raph@gmail.com>
Subject: Re: [PATCH] sound: codecs: pcm1792x: clean function
	exit
Date: Wed, 27 Jan 2016 13:08:04 +0100
Message-ID: <CACqcpZAmFwK9N9g2d93Zb-zs32+Wzg-6abDybEqWPYKpxHh-Gg@mail.gmail.com>
References: <1452762028-43931-1-git-send-email-poggi.raph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C5E1C2604DD
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 13:08:44 +0100 (CET)
Received: by mail-yk0-f179.google.com with SMTP id y137so14708922yka.2
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 04:08:44 -0800 (PST)
In-Reply-To: <1452762028-43931-1-git-send-email-poggi.raph@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Michael Trimarchi <michael@amarulasolutions.com>, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

ping ?

2016-01-14 10:00 GMT+01:00 Raphael Poggi <poggi.raph@gmail.com>:
> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
> ---
>  sound/soc/codecs/pcm179x.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
> index a56c7b7..e04d13c 100644
> --- a/sound/soc/codecs/pcm179x.c
> +++ b/sound/soc/codecs/pcm179x.c
> @@ -91,14 +91,9 @@ static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> -       int ret;
>
> -       ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
> +       return regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
>                                  PCM179X_MUTE_MASK, !!mute);
> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
>  }
>
>  static int pcm179x_hw_params(struct snd_pcm_substream *substream,
> @@ -107,7 +102,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> -       int val = 0, ret;
> +       int val = 0;
>
>         priv->rate = params_rate(params);
>
> @@ -145,12 +140,8 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>
>         val = val << PCM179X_FMT_SHIFT | PCM179X_ATLD_ENABLE;
>
> -       ret = regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
> +       return regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
>                                  PCM179X_FMT_MASK | PCM179X_ATLD_ENABLE, val);
> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
>  }
>
>  static const struct snd_soc_dai_ops pcm179x_dai_ops = {
> --
> 2.1.0
>
