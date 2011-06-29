From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: atmel_ssc_dai/atmel-pcm: adapt
 to dmaengine usage
Date: Wed, 29 Jun 2011 10:59:09 -0700
Message-ID: <20110629175905.GC13051@opensource.wolfsonmicro.com>
References: <7fd26c605d5cfa422d0fc37a7b790fb9a837d7e3.1309368631.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC5B6103915
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 22:57:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7fd26c605d5cfa422d0fc37a7b790fb9a837d7e3.1309368631.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2011 at 08:00:18PM +0200, Nicolas Ferre wrote:

> +static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |

The naming here looks a bit undescriptive but I'm not sure what a better
name would be - obviously both DMA controllers are DMA controllers.  It
feels like it would be more sensible to just write a separate DMA driver
as I'm not sure how much code actually ends up being shared here but it
looks pretty small from the diff...

> +static bool filter(struct dma_chan *chan, void *slave)
> +{
> +	struct	at_dma_slave		*sl = slave;
> +

Odd whitespace here.

> +static int atmel_pcm_dma_alloc(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct atmel_runtime_data *prtd = runtime->private_data;
> +	struct ssc_device *ssc = prtd->params->ssc;
> +	struct at_dma_slave *sdata = NULL;
> +
> +	if (ssc->pdev)
> +		sdata = ssc->pdev->dev.platform_data;

Why wouldn't we have a device, and why is there a separate copy of the
device?

> +	if (!prtd->dma_chan) {
> +		pr_err("atmel-pcm: "
> +			"DMA channel not available, unable to use SSC-audio\n");
> +		return -EBUSY;

dev_err() and don't split strings over lines.

> +	switch (prtd->params->data_xfer_size) {
> +	case 1:
> +		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +		break;
> +	case 2:
> +		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +		break;
> +	case 4:
> +		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;
> +	default:
> +		return;
> +	}

It strikes me that this mapping of bytes to DMA_SLAVE_ is likely to be
quite common and might be nice as a helper in dmaengine.

I'd also expect to see something complain (even if just with BUG()) if we
hit the default case.
