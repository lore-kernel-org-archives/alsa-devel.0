From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Mon, 16 Oct 2017 12:21:00 +0530
Message-ID: <20171016065100.GN30097@localhost>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E641266DCF
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 08:48:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171013104346.16818-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, broonie@kernel.org, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 13, 2017 at 12:43:46PM +0200, Lucas Stach wrote:
> The commit [1] which changed imx-pcm-dma to derive the pcm_config from the

Commit 70d435ba1cd6 (...) changed... please

> attached dmaengine introduced a regression on the supported sample formats,
> as imx-sdma doesn't properly advertise all the supported slave bus widths.
> 
> Fix this to restore full functionality of the imx sound subsystem.
> 
> [1] 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")

Fixes: 70d435ba1cd6 ... please

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a67ec1bdc4e0..e374183f19d0 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1851,8 +1851,12 @@ static int sdma_probe(struct platform_device *pdev)
>  	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
>  	sdma->dma_device.device_config = sdma_config;
>  	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
> -	sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> -	sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +					   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +					   BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +					   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +					   BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
>  	sdma->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	sdma->dma_device.device_issue_pending = sdma_issue_pending;
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
