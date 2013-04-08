From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Sun, 07 Apr 2013 19:18:50 -0500
Message-ID: <51620CEA.3010703@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id D6BA72651D0
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 02:18:53 +0200 (CEST)
In-Reply-To: <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
> Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
> and the SIER flags are set differently.

So just to be clear, this is interrupt-driven SSI audio?  So you're 
generating an interrupt every time the transmit FIFO goes below the threshold?

I wonder if it makes sense to enable both FIFOs, so that you take half as 
many interrupts per second.

>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   sound/soc/fsl/fsl_ssi.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 7decbd9..afb5a23 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -120,10 +120,12 @@ struct fsl_ssi_private {
>
>   	bool new_binding;
>   	bool ssi_on_imx;
> +	bool dma;

Can you rename this to "use_dma" or something like that?

>   	struct clk *clk;
>   	struct platform_device *imx_pcm_pdev;
>   	struct imx_pcm_dma_params dma_params_tx;
>   	struct imx_pcm_dma_params dma_params_rx;
> +	struct imx_pcm_fiq_params fiq_params;
>
>   	struct {
>   		unsigned int rfrc;
> @@ -353,7 +355,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
>   		 */
>
>   		/* Enable the interrupts and DMA requests */
> -		write_ssi(SIER_FLAGS, &ssi->sier);
> +		if (ssi_private->dma)
> +			write_ssi(SIER_FLAGS, &ssi->sier);
>
>   		/*
>   		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
> @@ -520,6 +523,18 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>   		return -EINVAL;
>   	}
>
> +	if (!ssi_private->dma) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
> +			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN,
> +					&ssi->sier);
> +		} else {
> +			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
> +			write_ssi(CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN,
> +					&ssi->sier);
> +		}
> +	}
> +
>   	return 0;
>   }
>
> @@ -680,6 +695,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>   	       sizeof(fsl_ssi_dai_template));
>   	ssi_private->cpu_dai_drv.name = ssi_private->name;
>
> +	ssi_private->dma = !of_property_read_bool(np, "fsl,imx-fiq");

Instead of looking for the FIQ property, maybe you should just look for 
the absence of a DMA property/node, and then default to interrupts if 
there is no DMA.  That would make it more generic, and even work on 
non-IMX systems.

-- 
Timur Tabi
