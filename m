From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: use correct direction
	enum type
Date: Wed, 19 Apr 2017 23:43:21 -0700
Message-ID: <20170420064320.GA7912@Asurada>
References: <20170420063607.23990-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C047F266954
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 08:43:27 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id a189so6223530oib.0
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 23:43:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170420063607.23990-1-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 19, 2017 at 11:36:07PM -0700, Stefan Agner wrote:
> The direction argument is of type enum dma_transfer_direction, and
> not enum dma_data_direction. The enumeration values are the same
> so this did not had an effect in practise.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_asrc_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index dc30d780f874..282d841840b1 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -76,7 +76,7 @@ static int fsl_asrc_dma_prepare_and_submit(struct snd_pcm_substream *substream)
>  			pair->dma_chan[!dir], runtime->dma_addr,
>  			snd_pcm_lib_buffer_bytes(substream),
>  			snd_pcm_lib_period_bytes(substream),
> -			dir == OUT ? DMA_TO_DEVICE : DMA_FROM_DEVICE, flags);
> +			dir == OUT ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM, flags);
>  	if (!pair->desc[!dir]) {
>  		dev_err(dev, "failed to prepare slave DMA for Front-End\n");
>  		return -ENOMEM;
> -- 
> 2.12.2
> 
