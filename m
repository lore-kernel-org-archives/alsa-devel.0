From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/4] ASoC: s3c24xx 8 bit sound fix
Date: Wed, 12 Nov 2008 14:19:02 +0000
Message-ID: <20081112141902.GA15238@trinity.fluff.org>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
	<1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.145.97.151])
	by alsa0.perex.cz (Postfix) with ESMTP id EA08F1037EB
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 15:19:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Christian Pellegrin <chripell@gmail.com>, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 11:55:47AM +0000, Mark Brown wrote:
> From: Christian Pellegrin <chripell@gmail.com>
> 
> fixes playing/recording of 8 bit audio files.
> 
> Generated on  20081108  against v2.6.27
> 
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/s3c24xx/s3c24xx-i2s.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
> index ba4476b..c18977b 100644
> --- a/sound/soc/s3c24xx/s3c24xx-i2s.c
> +++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
> @@ -261,10 +261,17 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
>  
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S8:
> +		iismod &= ~S3C2410_IISMOD_16BIT;
> +		((struct s3c24xx_pcm_dma_params *)
> +		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
>  		break;
>  	case SNDRV_PCM_FORMAT_S16_LE:
>  		iismod |= S3C2410_IISMOD_16BIT;
> +		((struct s3c24xx_pcm_dma_params *)
> +		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
>  		break;
> +	default:
> +		return -EINVAL;
>  	}

Is playing with the dma parameters like that the correct way?
  
>  	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
> -- 
> 1.5.6.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
