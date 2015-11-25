From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2] sound: codecs: pcm1792a: clean function
	exit
Date: Wed, 25 Nov 2015 09:18:46 +0100
Message-ID: <CAOf5uwn3R+Q=3TbkZfLtTUr=xhCovG1LNy6aaiEhpszwH5iR=g@mail.gmail.com>
References: <1448439009-9778-1-git-send-email-poggi.raph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 00AE0261736
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 09:18:50 +0100 (CET)
Received: by igbxm8 with SMTP id xm8so32859545igb.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 00:18:48 -0800 (PST)
In-Reply-To: <1448439009-9778-1-git-send-email-poggi.raph@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raphael Poggi <poggi.raph@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, Nov 25, 2015 at 9:10 AM, Raphael Poggi <poggi.raph@gmail.com> wrote:
> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
> ---
>  sound/soc/codecs/pcm1792a.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
> index 08bb486..27d54bc 100644
> --- a/sound/soc/codecs/pcm1792a.c
> +++ b/sound/soc/codecs/pcm1792a.c
> @@ -91,14 +91,9 @@ static int pcm1792a_digital_mute(struct snd_soc_dai *dai, int mute)
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
> -       int ret;
>
> -       ret = regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
> +       return regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
>                                  PCM1792A_MUTE_MASK, !!mute);
> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
>  }
>
>  static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
> @@ -107,7 +102,7 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>  {
>         struct snd_soc_codec *codec = dai->codec;
>         struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
> -       int val = 0, ret;
> +       int val = 0;
>
>         priv->rate = params_rate(params);
>
> @@ -145,12 +140,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>
>         val = val << PCM1792A_FMT_SHIFT | PCM1792A_ATLD_ENABLE;
>
> -       ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
> +       return regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
>  }
>
>  static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
> --
> 2.1.0
>

It's fine for me

reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
