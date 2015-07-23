From: Marek Belisko <marek.belisko@streamunlimited.com>
Subject: Re: [PATCH 1/2] ASoC: pcm1681: Fix setting de-emphasis
 sampling rate selection
Date: Thu, 23 Jul 2015 21:46:39 +0200
Message-ID: <55B1449F.3040603@streamunlimited.com>
References: <1437664946.20606.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp8.bon.at [213.33.87.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8663C2659A5
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 21:46:49 +0200 (CEST)
In-Reply-To: <1437664946.20606.5.camel@ingics.com>
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

On 23.07.2015 17:22, Axel Lin wrote:
> The de-emphasis sampling rate selection is controlled by BIT[3:4] of
> PCM1681_DEEMPH_CONTROL register. Do proper left shift to set it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   sound/soc/codecs/pcm1681.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
> index b2c990f..1011142 100644
> --- a/sound/soc/codecs/pcm1681.c
> +++ b/sound/soc/codecs/pcm1681.c
> @@ -102,7 +102,7 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
>
>   	if (val != -1) {
>   		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
> -					PCM1681_DEEMPH_RATE_MASK, val);
> +				   PCM1681_DEEMPH_RATE_MASK, val << 3);
Good catch. Acked-by: Marek Belisko <marek.belisko@streamunlimited.com>
>   		enable = 1;
>   	} else
>   		enable = 0;
>
