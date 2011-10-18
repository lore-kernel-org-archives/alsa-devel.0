From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: ad193x: Use snd_soc_update_bits
 for read-modify-write
Date: Tue, 18 Oct 2011 17:47:20 +0200
Message-ID: <4E9D9F88.109@metafoo.de>
References: <1318890308.15935.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-054.synserver.de (smtp-out-070.synserver.de
	[212.40.185.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 192F310384D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 17:47:12 +0200 (CEST)
In-Reply-To: <1318890308.15935.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/18/2011 12:25 AM, Axel Lin wrote:
> Use snd_soc_update_bits for read-modify-write register access instead of
> open-coding it using snd_soc_read and snd_soc_write
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  sound/soc/codecs/ad193x.c |   31 +++++++++++++++----------------
>  1 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
> index 39056ce..1206021 100644
> --- a/sound/soc/codecs/ad193x.c
> +++ b/sound/soc/codecs/ad193x.c
> @@ -103,12 +103,14 @@ static const struct snd_soc_dapm_route audio_paths[] = {
>  static int ad193x_mute(struct snd_soc_dai *dai, int mute)
>  {
>  	struct snd_soc_codec *codec = dai->codec;
> -	int reg;
>  
> -	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
> -	reg = (mute > 0) ? reg | AD193X_DAC_MASTER_MUTE : reg &
> -		(~AD193X_DAC_MASTER_MUTE);
> -	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
> +	if (mute)
> +		snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
> +				    AD193X_DAC_MASTER_MUTE,
> +				    AD193X_DAC_MASTER_MUTE);
> +	else
> +		snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
> +				    AD193X_DAC_MASTER_MUTE, 0);
>  
>  	return 0;
>  }
> @@ -262,7 +264,7 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
>  		struct snd_pcm_hw_params *params,
>  		struct snd_soc_dai *dai)
>  {
> -	int word_len = 0, reg = 0, master_rate = 0;
> +	int word_len = 0, master_rate = 0;
>  
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_codec *codec = rtd->codec;
> @@ -297,18 +299,15 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  	}
>  
> -	reg = snd_soc_read(codec, AD193X_PLL_CLK_CTRL0);
> -	reg = (reg & (~AD193X_PLL_INPUT_MASK)) | master_rate;
> -	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);
> +	snd_soc_update_bits(codec, AD193X_PLL_CLK_CTRL0,
> +			    AD193X_PLL_INPUT_MASK, master_rate);
>  
> -	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
> -	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
> -		| (word_len << AD193X_DAC_WORD_LEN_SHFT);
> -	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
> +	snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
> +			    AD193X_DAC_WORD_LEN_MASK,
> +			    word_len << AD193X_DAC_WORD_LEN_SHFT);
>  
> -	reg = snd_soc_read(codec, AD193X_ADC_CTRL1);
> -	reg = (reg & (~AD193X_ADC_WORD_LEN_MASK)) | word_len;
> -	snd_soc_write(codec, AD193X_ADC_CTRL1, reg);
> +	snd_soc_update_bits(codec, AD193X_ADC_CTRL1,
> +			    AD193X_ADC_WORD_LEN_MASK, word_len);
>  
>  	return 0;
>  }
