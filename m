From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: Fix DMA channel leak in
	imx-pcm-dma-mx2 driver.
Date: Tue, 17 Jan 2012 09:19:51 +0100
Message-ID: <20120117081951.GT5446@pengutronix.de>
References: <1326367838-12947-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9BEEB2453E
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 09:19:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326367838-12947-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, arnaud.patard@rtp-net.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 12, 2012 at 12:30:38PM +0100, Javier Martin wrote:
> "snd_imx_pcm_hw_params" callback can be called
> several times by the user (i.e. OSS emulation)
> leading to a DMA channel leak.

Then maybe this means that imx_ssi_dma_alloc is called from the wrong
place. I think it should be called from the
snd_soc_platform_driver.pcm_new callback.

Sascha

> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  sound/soc/imx/imx-pcm-dma-mx2.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
> index 43fdc24..d2bb1cb 100644
> --- a/sound/soc/imx/imx-pcm-dma-mx2.c
> +++ b/sound/soc/imx/imx-pcm-dma-mx2.c
> @@ -88,11 +88,13 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
>  	iprtd->dma_data.dma_request = dma_params->dma;
>  
>  	/* Try to grab a DMA channel */
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
> -	if (!iprtd->dma_chan)
> -		return -EINVAL;
> +	if (!iprtd->dma_chan) {
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +		iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
> +		if (!iprtd->dma_chan)
> +			return -EINVAL;
> +	}
>  
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
