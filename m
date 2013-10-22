From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: Use filter_data rather
 than dma_data for compat requests
Date: Tue, 22 Oct 2013 13:30:56 +0200
Message-ID: <526661F0.8000709@metafoo.de>
References: <1382215106-31069-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-203.synserver.de (smtp-out-203.synserver.de
 [212.40.185.203])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DFBD2610A1
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 13:31:03 +0200 (CEST)
In-Reply-To: <1382215106-31069-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 10:38 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> When using the legacy filter function channel requests we currently pass
> the audio specific struct snd_dmaengine_dai_dma_data which isn't likely to
> be helpful for actual filtering. Since there's already a field in the
> structure called filter_data clearly intended for use here convert the
> driver to use that.
> 
> All existing users of plain filter functions have been converted to use
> an explict compat function to override this behaviour except i.MX which

typo: explicit

> is working around this issue in its filter function and is updated to
> just use filter_data directly here.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/fsl/imx-pcm-dma.c           | 4 +---
>  sound/soc/soc-generic-dmaengine-pcm.c | 5 ++++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index 4dc1296..aee2307 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -25,12 +25,10 @@
>  
>  static bool filter(struct dma_chan *chan, void *param)
>  {
> -	struct snd_dmaengine_dai_dma_data *dma_data = param;
> -
>  	if (!imx_dma_is_general_purpose(chan))
>  		return false;
>  
> -	chan->private = dma_data->filter_data;
> +	chan->private = param;
>  
>  	return true;
>  }
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index e29ec3c..17dd379 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -126,6 +126,9 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
>  	struct snd_pcm_substream *substream)
>  {
>  	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> +	struct snd_dmaengine_dai_dma_data *dma_data;
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>  
>  	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
>  		return pcm->chan[0];
> @@ -134,7 +137,7 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
>  		return pcm->config->compat_request_channel(rtd, substream);
>  
>  	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
> -		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
> +						 dma_data->filter_data);
>  }
>  
>  static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
> 
