From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with
 imx pcm and machine drivers
Date: Thu, 8 Mar 2012 14:45:29 -0600
Message-ID: <4F591A69.9060401@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe006.messaging.microsoft.com [213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 318941041F3
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 21:45:51 +0100 (CET)
In-Reply-To: <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:

> +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx1-ssi")) {

I wonder if the i.MX code should be protected by an #ifdef.  There's no
point in compiling this code on PowerPC.

> +		/*
> +		 * FIXME: The dma burst size must equal to ssi watermark
> +		 * setting on imx.  We have burstsize be "fifo_depth - 2"
> +		 * here because "fifo_depth - 2" rather than fifo_depth is
> +		 * being written into watermark register in fsl_ssi_startup().
> +		 * Is this something needs to be fixed for PowerPC?

Setting the watermark to fifo_depth-2 allows the SSI to continue storing
data into the FIFO (during capture) in the case the DMA engine isn't fast
enough.  I don't want the FIFO to be completely full before we start the DMA.

For playback, it's the same thing.  I can't be sure the FIFO is completely
empty when it's time to DMA more data.

> +		 */
> +		ssi_private->dma_params_tx.burstsize =
> +			ssi_private->fifo_depth - 2;
> +		ssi_private->dma_params_rx.burstsize =
> +			ssi_private->fifo_depth - 2;
> +		ssi_private->dma_params_tx.dma_addr =
> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
> +		ssi_private->dma_params_rx.dma_addr =
> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);

So I'm a little confused by this new binding.  I went through a lot of
work to remove DMA-specific data from the SSI driver, and here you are
adding a bunch of it back.  What you're doing here -- I'm doing it in the
DMA driver where it belongs.

> +		/*
> +		 * TODO: This is a temporary solution and should be changed
> +		 * to use generic DMA binding later when the helplers get in.
> +		 */
> +		ret = of_property_read_u32_array(pdev->dev.of_node,
> +					"fsl,ssi-dma-events", dma_events, 2);
> +		if (ret) {
> +			dev_err(&pdev->dev, "could not get dma events\n");
> +			goto error_irq;
> +		}
> +		ssi_private->dma_params_tx.dma = dma_events[0];
> +		ssi_private->dma_params_rx.dma = dma_events[1];

of_property_read_u32_array seems overkill for just two integers.

ssi_private->dma_params_tx.dma = be32_to_cpu(prop[0]);
ssi_private->dma_params_rx.dma = be32_to_cpu(prop[1]);

-- 
Timur Tabi
Linux kernel developer at Freescale
