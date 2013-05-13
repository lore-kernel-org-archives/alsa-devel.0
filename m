From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/8] ASoC: ep93xx: Setup dma data in DAI
 probe
Date: Mon, 13 May 2013 09:27:09 +0200
Message-ID: <519095CD.3080606@metafoo.de>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-047.synserver.de
 [212.40.185.47])
 by alsa0.perex.cz (Postfix) with ESMTP id E9D31261635
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 09:27:37 +0200 (CEST)
In-Reply-To: <1366478947-9377-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/20/2013 07:29 PM, Lars-Peter Clausen wrote:
> This allows us to access the DAI DMA data when we create the PCM. We'll use
> this when converting ep39xx to generic DMA engine PCM driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 

Hi Mark,

it looks like this patch was lost. The next one in this series which has a
dependency on this one was applied though. Should I resend the patch?

- Lars


> ---
> Changes since v1:
> 	* Fix a mis-rebase which mixed up bits from this patch with the next one
> ---
>  sound/soc/cirrus/ep93xx-ac97.c | 14 ++++----------
>  sound/soc/cirrus/ep93xx-i2s.c  | 14 ++++----------
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
> index 8d30886..38cf335 100644
> --- a/sound/soc/cirrus/ep93xx-ac97.c
> +++ b/sound/soc/cirrus/ep93xx-ac97.c
> @@ -314,22 +314,15 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> -static int ep93xx_ac97_startup(struct snd_pcm_substream *substream,
> -			       struct snd_soc_dai *dai)
> +static int ep93xx_ac97_dai_probe(struct snd_soc_dai *dai)
>  {
> -	struct ep93xx_dma_data *dma_data;
> +	dai->playback_dma_data = &ep93xx_ac97_pcm_out;
> +	dai->capture_dma_data = &ep93xx_ac97_pcm_in;
>  
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -		dma_data = &ep93xx_ac97_pcm_out;
> -	else
> -		dma_data = &ep93xx_ac97_pcm_in;
> -
> -	snd_soc_dai_set_dma_data(dai, substream, dma_data);
>  	return 0;
>  }
>  
>  static const struct snd_soc_dai_ops ep93xx_ac97_dai_ops = {
> -	.startup	= ep93xx_ac97_startup,
>  	.trigger	= ep93xx_ac97_trigger,
>  };
>  
> @@ -337,6 +330,7 @@ static struct snd_soc_dai_driver ep93xx_ac97_dai = {
>  	.name		= "ep93xx-ac97",
>  	.id		= 0,
>  	.ac97_control	= 1,
> +	.probe		= ep93xx_ac97_dai_probe,
>  	.playback	= {
>  		.stream_name	= "AC97 Playback",
>  		.channels_min	= 2,
> diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
> index 83075b3..e17b905 100644
> --- a/sound/soc/cirrus/ep93xx-i2s.c
> +++ b/sound/soc/cirrus/ep93xx-i2s.c
> @@ -60,7 +60,6 @@ struct ep93xx_i2s_info {
>  	struct clk			*mclk;
>  	struct clk			*sclk;
>  	struct clk			*lrclk;
> -	struct ep93xx_dma_data		*dma_data;
>  	void __iomem			*regs;
>  };
>  
> @@ -139,15 +138,11 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
>  	}
>  }
>  
> -static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
> -			      struct snd_soc_dai *dai)
> +static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	dai->playback_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> +	dai->capture_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
>  
> -	snd_soc_dai_set_dma_data(cpu_dai, substream,
> -				 &info->dma_data[substream->stream]);
>  	return 0;
>  }
>  
> @@ -338,7 +333,6 @@ static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
>  #endif
>  
>  static const struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
> -	.startup	= ep93xx_i2s_startup,
>  	.shutdown	= ep93xx_i2s_shutdown,
>  	.hw_params	= ep93xx_i2s_hw_params,
>  	.set_sysclk	= ep93xx_i2s_set_sysclk,
> @@ -349,6 +343,7 @@ static const struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
>  
>  static struct snd_soc_dai_driver ep93xx_i2s_dai = {
>  	.symmetric_rates= 1,
> +	.probe		= ep93xx_i2s_dai_probe,
>  	.suspend	= ep93xx_i2s_suspend,
>  	.resume		= ep93xx_i2s_resume,
>  	.playback	= {
> @@ -403,7 +398,6 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
>  	}
>  
>  	dev_set_drvdata(&pdev->dev, info);
> -	info->dma_data = ep93xx_i2s_dma_data;
>  
>  	err = snd_soc_register_dai(&pdev->dev, &ep93xx_i2s_dai);
>  	if (err)
