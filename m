From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Fri, 17 May 2019 13:01:10 -0700
Message-ID: <20190517200110.GA22558@Asurada-Nvidia.nvidia.com>
References: <20190517030903.25731-1-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190517030903.25731-1-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 17, 2019 at 03:09:22AM +0000, S.j. Wang wrote:
> There is chip errata ERR008000, the reference doc is
> (https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf),
> 
> The issue is "While using ESAI transmit or receive and
> an underrun/overrun happens, channel swap may occur.
> The only recovery mechanism is to reset the ESAI."
> 
> In this commit add a tasklet to handle reset of ESAI
> after xrun happens
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 166 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 10d2210c91ef..149972894c95 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -52,17 +52,20 @@ struct fsl_esai {
>  	struct clk *extalclk;
>  	struct clk *fsysclk;
>  	struct clk *spbaclk;
> +	struct tasklet_struct task;
[...]
> +	u32 tx_channels;
[...]
> +	bool reset_at_xrun;

Please add descriptions for them in the comments of the struct.

  
> @@ -71,8 +74,14 @@ static irqreturn_t esai_isr(int irq, void *devid)
>  	struct fsl_esai *esai_priv = (struct fsl_esai *)devid;
>  	struct platform_device *pdev = esai_priv->pdev;
>  	u32 esr;
> +	u32 saisr;
>  
>  	regmap_read(esai_priv->regmap, REG_ESAI_ESR, &esr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
> +
> +	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE))
> +		&& esai_priv->reset_at_xrun)

Please follow the coding style:
+	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE)) &&
+	    esai_priv->reset_at_xrun)

> +		tasklet_schedule(&esai_priv->task);

And maybe a dev_dbg also to inform people it's recovering.

> @@ -552,6 +561,9 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
>  	u32 mask;
>  
> +	if (tx)
> +		esai_priv->tx_channels = channels;
> +
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
> @@ -585,10 +597,16 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
>  				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
>  
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> +				   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE);

A line of comments please.

> +static void fsl_esai_reset(unsigned long arg)
> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;

> +	u32 saisr;
> +	u32 tsma, tsmb, rsma, rsmb, tcr, rcr, tfcr, rfcr;

Could we merge these two lines?

> +	/*
> +	 * stop the tx & rx
> +	 */

Single-line style please.

> +	regmap_read(esai_priv->regmap, REG_ESAI_TSMA, &tsma);
> +	regmap_read(esai_priv->regmap, REG_ESAI_TSMB, &tsmb);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RSMA, &rsma);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RSMB, &rsmb);
> +
> +	regmap_read(esai_priv->regmap, REG_ESAI_TCR, &tcr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RCR, &rcr);
> +
> +	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);

I think this chunk is to save register values other than "stop".

> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +				ESAI_xCR_xEIE_MASK | ESAI_xCR_TE_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +				ESAI_xCR_xEIE_MASK | ESAI_xCR_RE_MASK, 0);

Indentation:
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+			   ESAI_xCR_xEIE_MASK | ESAI_xCR_RE_MASK, 0);

> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
> +				ESAI_xSMA_xS_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> +				ESAI_xSMB_xS_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
> +				ESAI_xSMA_xS_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> +				ESAI_xSMB_xS_MASK, 0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
> +				ESAI_xFCR_xFR | ESAI_xFCR_xFEN, ESAI_xFCR_xFR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
> +				ESAI_xFCR_xFR, 0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
> +				ESAI_xFCR_xFR | ESAI_xFCR_xFEN, ESAI_xFCR_xFR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
> +				ESAI_xFCR_xFR, 0);

Just a thought that I'd like to discuss: since these operations
are completely same as TRIGGER_STOP(tx) + TRIGGER_STOP(rx), can
we abstract a function of fsl_esai_trigger_stop(.., bool tx)?

Benefits would be A) easier to read B) Won't miss an operation,
as we might add something new to one of the stop routines while
forgetting the other side.

> +	/*
> +	 * reset the esai, and restore the registers
> +	 */
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_ECR,
> +				ESAI_ECR_ESAIEN_MASK | ESAI_ECR_ERST_MASK,
> +				ESAI_ECR_ESAIEN | ESAI_ECR_ERST);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_ECR,
> +				ESAI_ECR_ESAIEN_MASK | ESAI_ECR_ERST_MASK,
> +				ESAI_ECR_ESAIEN);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +				ESAI_xCR_xPR_MASK,
> +				ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +				ESAI_xCR_xPR_MASK,
> +				ESAI_xCR_xPR);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> +				ESAI_PRRC_PDC_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> +				ESAI_PCRC_PC_MASK, 0);

And this could be abstracted too by sharing with probe().

> +	/*
> +	 * Add fifo reset here, because the regcache_sync will
> +	 * write one more data to ETDR.
> +	 * Which will cause channel shift.

Sounds like a bug to me...should fix it first by marking the
data registers as volatile.

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
> +				ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
> +				ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR);
> +
> +	regcache_mark_dirty(esai_priv->regmap);
> +	regcache_sync(esai_priv->regmap);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
> +				ESAI_xFCR_xFR_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
> +				ESAI_xFCR_xFR_MASK, 0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +				ESAI_xCR_xPR_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +				ESAI_xCR_xPR_MASK, 0);

Also same as suspend()-resume().

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> +				ESAI_PRRC_PDC_MASK,
> +				ESAI_PRRC_PDC(ESAI_GPIO));
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> +				ESAI_PCRC_PC_MASK,
> +				ESAI_PCRC_PC(ESAI_GPIO));
> +
> +	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
> +
> +	/*
> +	 * restart tx / rx, if they already enabled
> +	 */
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
> +				ESAI_xFCR_xFEN_MASK, tfcr & ESAI_xFCR_xFEN);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
> +				ESAI_xFCR_xFEN_MASK, rfcr & ESAI_xFCR_xFEN);

Btw, this xFEN should be xFE...a typo in the driver itself...

> +
> +	/* Write initial words reqiured by ESAI as normal procedure */
> +	for (i = 0; i < esai_priv->tx_channels; i++)
> +		regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +				ESAI_xCR_TE_MASK,
> +				ESAI_xCR_TE_MASK & tcr);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +				ESAI_xCR_RE_MASK,
> +				ESAI_xCR_RE_MASK & rcr);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> +				ESAI_xSMB_xS_MASK,
> +				ESAI_xSMB_xS_MASK & tsmb);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
> +				ESAI_xSMA_xS_MASK,
> +				ESAI_xSMA_xS_MASK & tsma);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> +				ESAI_xSMB_xS_MASK,
> +				ESAI_xSMB_xS_MASK & rsmb);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
> +				ESAI_xSMA_xS_MASK,
> +				ESAI_xSMA_xS_MASK & rsma);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE & tcr);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE & rcr);

Similarly having an fsl_esai_trigger_start() could do:
	if (tfcr & ESAI_xFCR_xFE)
		fsl_esai_trigger_start(tx);
	if (rfcr & ESAI_xFCR_xFE)
		fsl_esai_trigger_start(rx);

Thank you
