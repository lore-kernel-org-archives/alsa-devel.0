From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/10] ASoc: mxs: add mxs-pcm driver
Date: Sat, 9 Jul 2011 03:33:58 +0100
Message-ID: <20110709023358.GB26900@sirena.org.uk>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1310140790-2132-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 08, 2011 at 11:59:41PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

*Always* CC maintainers on patches.

> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * Refer to sound/soc/imx/imx-pcm-dma-mx2.c

Why?

> +	iprtd->buf = (unsigned int *)substream->dma_buffer.area;

This cast looks incredibly suspicious...

> +static int snd_mxs_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}
> +

Remove empty functions.

> +static int snd_mxs_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		dmaengine_submit(iprtd->desc);
> +
> +		break;
> +

Why the random blank line?

> +static struct platform_driver mxs_pcm_driver = {
> +	.driver = {
> +			.name = "mxs-pcm-audio",
> +			.owner = THIS_MODULE,

Indentation here is very odd...
