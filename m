From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: cs4265: Add native 32bit I2S
	transport
Date: Mon, 27 Aug 2018 09:28:43 +0100
Message-ID: <20180827082843.GU32322@imbe.wolfsonmicro.main>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180826225844.13754-2-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9815A267846
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 10:28:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180826225844.13754-2-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2018 at 08:58:43AM +1000, Matt Flax wrote:
> The cs4265 uses 32 bit transport on the I2S bus. This patch enables native
> 32 bit mode for machine drivers which use this sound card driver.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/cs4265.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 15b4ae04..17d7e6f0 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -495,7 +495,8 @@ static int cs4265_set_bias_level(struct snd_soc_component *component,
>  			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
>  
>  #define CS4265_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE | \
> -			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_U24_LE)
> +			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_U24_LE | \
> +			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE)

Are you sure this is correct? The datasheet for the part only
says it supports up to 24-bit audio and I thought the defines
SNDRV_PCM_FMTBIT_S24_LE and U24 are expected to have 32-bits
in the slot whilst on the bus.

>  
>  static const struct snd_soc_dai_ops cs4265_ops = {
>  	.hw_params	= cs4265_pcm_hw_params,
> -- 
> 2.17.1

Thanks,
Charles
