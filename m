From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: call
	dma_request_slave_channel()
Date: Mon, 22 Apr 2013 16:16:02 +0200
Message-ID: <51754622.3050801@metafoo.de>
References: <1366639044-27695-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-213.synserver.de (smtp-out-213.synserver.de
 [212.40.185.213])
 by alsa0.perex.cz (Postfix) with ESMTP id 9436E261690
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 16:22:43 +0200 (CEST)
In-Reply-To: <1366639044-27695-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/22/2013 03:57 PM, Shawn Guo wrote:
> dma_request_slave_channel() is a more appropriate API for dmaengine
> clients that adopt generic DMA bindings to call.  Let's use it instead
> of of_dma_request_slave_channel() to save <linux/of_dma.h> include.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'm not a 100% convinced about this one, but I guess it wont hurt, so

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/soc-generic-dmaengine-pcm.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 98e1310..e29ec3c 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -21,7 +21,6 @@
>  #include <sound/soc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> -#include <linux/of_dma.h>
>  
>  #include <sound/dmaengine_pcm.h>
>  
> @@ -219,19 +218,19 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
>  };
>  
>  static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
> -	struct device_node *of_node)
> +	struct device *dev)
>  {
>  	unsigned int i;
>  
> -	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || !of_node)
> +	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || !dev->of_node)
>  		return;
>  
>  	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
> -		pcm->chan[0] = of_dma_request_slave_channel(of_node, "rx-tx");
> +		pcm->chan[0] = dma_request_slave_channel(dev, "rx-tx");
>  		pcm->chan[1] = pcm->chan[0];
>  	} else {
>  		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> -			pcm->chan[i] = of_dma_request_slave_channel(of_node,
> +			pcm->chan[i] = dma_request_slave_channel(dev,
>  					dmaengine_pcm_dma_channel_names[i]);
>  		}
>  	}
> @@ -255,7 +254,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>  	pcm->config = config;
>  	pcm->flags = flags;
>  
> -	dmaengine_pcm_request_chan_of(pcm, dev->of_node);
> +	dmaengine_pcm_request_chan_of(pcm, dev);
>  
>  	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
>  		return snd_soc_add_platform(dev, &pcm->platform,
