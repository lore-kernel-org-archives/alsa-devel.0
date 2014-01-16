From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Fix possible NULL pointer
 dereference of pcm->config
Date: Thu, 16 Jan 2014 10:19:06 +0100
Message-ID: <52D7A40A.3010202@metafoo.de>
References: <1389859684-27456-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 09BC4260815
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 10:16:51 +0100 (CET)
In-Reply-To: <1389859684-27456-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/16/2014 09:08 AM, Xiubo Li wrote:
> Since the soc generic dmaengine pcm driver allows using the defualt settings,
> so the pcm->config maybe NULL.
>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks. I actually had the very same patch locally, but overlooked it. It would 
be good if this could make it into 3.14, since the jz4740 conversion to the 
generic dmaengine driver needs this.

> ---
>   sound/soc/soc-generic-dmaengine-pcm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 560a778..5bace12 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -176,17 +176,20 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
>   {
>   	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
>   	struct snd_dmaengine_dai_dma_data *dma_data;
> +	dma_filter_fn fn = NULL;
>
>   	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>
>   	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
>   		return pcm->chan[0];
>
> -	if (pcm->config->compat_request_channel)
> +	if (pcm->config && pcm->config->compat_request_channel)
>   		return pcm->config->compat_request_channel(rtd, substream);
>
> -	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
> -						 dma_data->filter_data);
> +	if (pcm->config)
> +		fn = pcm->config->compat_filter_fn;
> +
> +	return snd_dmaengine_pcm_request_channel(fn, dma_data->filter_data);
>   }
>
>   static bool dmaengine_pcm_can_report_residue(struct dma_chan *chan)
>
