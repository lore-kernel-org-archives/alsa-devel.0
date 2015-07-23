From: Marek Belisko <marek.belisko@streamunlimited.com>
Subject: Re: [PATCH 2/2] ASoC: pcm1681: Improve the logic for
 de-emphasis sampling rate selection
Date: Thu, 23 Jul 2015 21:48:45 +0200
Message-ID: <55B1451D.2020202@streamunlimited.com>
References: <1437664946.20606.5.camel@ingics.com>
 <1437665015.20606.6.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp8.bon.at [213.33.87.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 34FD12659B0
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 21:48:52 +0200 (CEST)
In-Reply-To: <1437665015.20606.6.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Axel,

On 23.07.2015 17:23, Axel Lin wrote:
> Slightly improve the logic for de-emphasis sampling rate selection by break
> out the loop if the rate is matched.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   sound/soc/codecs/pcm1681.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
> index 1011142..5832523 100644
> --- a/sound/soc/codecs/pcm1681.c
> +++ b/sound/soc/codecs/pcm1681.c
> @@ -95,17 +95,22 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
>   	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
>   	int i = 0, val = -1, enable = 0;
>
> -	if (priv->deemph)
> -		for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++)
> -			if (pcm1681_deemph[i] == priv->rate)
> +	if (priv->deemph) {
> +		for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++) {
> +			if (pcm1681_deemph[i] == priv->rate) {
>   				val = i;
> +				break;
> +			}
> +		}
> +	}
^^^^^^^
I think we don't need those brackets only for if statement (where you 
add break)
>
>   	if (val != -1) {
>   		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
>   				   PCM1681_DEEMPH_RATE_MASK, val << 3);
>   		enable = 1;
> -	} else
> +	} else {
>   		enable = 0;
> +	}
^^^ same here
>
>   	/* enable/disable deemphasis functionality */
>   	return regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
>

BR,

marek
