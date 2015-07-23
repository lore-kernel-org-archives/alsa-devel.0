From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: tas5086: Improve the logic for
 de-emphasis sampling rate selection
Date: Thu, 23 Jul 2015 17:35:13 +0200
Message-ID: <55B109B1.4000003@zonque.org>
References: <1437664416.20606.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 675E1260711
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:35:15 +0200 (CEST)
In-Reply-To: <1437664416.20606.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/2015 05:13 PM, Axel Lin wrote:
> Slightly improve the logic for de-emphasis sampling rate selection by break
> out the loop if the rate is matched.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Daniel Mack <daniel@zonque.org>


Thanks,
Daniel


> ---
>  sound/soc/codecs/tas5086.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
> index 0a49fc8..d49d25d 100644
> --- a/sound/soc/codecs/tas5086.c
> +++ b/sound/soc/codecs/tas5086.c
> @@ -266,10 +266,14 @@ static int tas5086_set_deemph(struct snd_soc_codec *codec)
>  	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
>  	int i, val = 0;
>  
> -	if (priv->deemph)
> -		for (i = 0; i < ARRAY_SIZE(tas5086_deemph); i++)
> -			if (tas5086_deemph[i] == priv->rate)
> +	if (priv->deemph) {
> +		for (i = 0; i < ARRAY_SIZE(tas5086_deemph); i++) {
> +			if (tas5086_deemph[i] == priv->rate) {
>  				val = i;
> +				break;
> +			}
> +		}
> +	}
>  
>  	return regmap_update_bits(priv->regmap, TAS5086_SYS_CONTROL_1,
>  				  TAS5086_DEEMPH_MASK, val);
> 
