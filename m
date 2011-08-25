From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC 1/2] ASoC: imx-ssi: use dma_writecombine
	consistently
Date: Thu, 25 Aug 2011 16:19:45 +0200
Message-ID: <20110825141945.GW31404@pengutronix.de>
References: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id ECD3E24478
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 16:19:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 25, 2011 at 03:54:55PM +0200, Wolfram Sang wrote:
> If the channel is allocated as writecombine, then mmaping it should also
> use writecombine. Also, add a proper device for the call. Ported from a
> similar fix for mach-mxs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

both:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  sound/soc/imx/imx-ssi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index 10a8e27..3b8d5cd 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -357,8 +357,8 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	int ret;
>  
> -	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area,
> -			runtime->dma_addr, runtime->dma_bytes);
> +	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
>  
>  	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
>  			runtime->dma_area,
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
