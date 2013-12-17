From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: Add config parameter NULL
 check.
Date: Tue, 17 Dec 2013 08:12:17 +0100
Message-ID: <52AFF951.9020201@metafoo.de>
References: <1387264600-14225-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-177.synserver.de
 [212.40.185.177])
 by alsa0.perex.cz (Postfix) with ESMTP id AC34D260850
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 09:11:22 +0100 (CET)
In-Reply-To: <1387264600-14225-1-git-send-email-Li.Xiubo@freescale.com>
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

On 12/17/2013 08:16 AM, Xiubo Li wrote:
> Because the "ASoC: dmaengine-pcm: Provide default config" has provided
> us one defualt config of DMA. When using this, the config parameter of
> devm_snd_dmaengine_pcm_register() will be NULL, so here we need to have
> a check before using it.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 7483922..2a6c569 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -299,7 +299,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
>  	    !dev->of_node)
>  		return 0;
>  
> -	if (config->dma_dev) {
> +	if (config && config->dma_dev) {
>  		/*
>  		 * If this warning is seen, it probably means that your Linux
>  		 * device structure does not match your HW device structure.
> @@ -317,7 +317,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
>  			name = "rx-tx";
>  		else
>  			name = dmaengine_pcm_dma_channel_names[i];
> -		if (config->chan_names[i])
> +		if (config && config->chan_names[i])
>  			name = config->chan_names[i];
>  		chan = dma_request_slave_channel_reason(dev, name);
>  		if (IS_ERR(chan)) {
> 
