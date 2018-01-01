From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1 05/15] ASoC: fsl_ssi: Clean up helper
 functions of trigger()
Date: Mon, 1 Jan 2018 22:59:30 +0100
Message-ID: <59aa58b7-aeda-ef87-e150-9fec9c6229ae@maciej.szmigiero.name>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-6-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A1A266FDE
 for <alsa-devel@alsa-project.org>; Mon,  1 Jan 2018 22:59:38 +0100 (CET)
In-Reply-To: <1513702819-42310-6-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 19.12.2017 18:00, Nicolin Chen wrote:
> The trigger() calls fsl_ssi_tx_config() and fsl_ssi_rx_config(),
> and both of them jump to fsl_ssi_config(). And fsl_ssi_config()
> later calls another fsl_ssi_rxtx_config().
> 
> However, the whole routine, especially fsl_ssi_config() function,
> is too complicated because of the folowing reasons:
> 1) It has to handle the concern of the opposite stream.
> 2) It has to handle cases of offline configurations support.
> 3) It has to handle enable and disable operations while they're
>    mostly different.
> 
> Since the enable and disable routines have more differences than
> TX and RX rountines, this patch simplifies these helper functions
> with the following changes:
> - Changing to two helper functions of enable and disable instead
>   of TX and RX.
> - Removing fsl_ssi_rxtx_config() by separately integrating it to
>   two newly introduced enable & disable functions.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 254 +++++++++++++++++++++++-------------------------
>  1 file changed, 119 insertions(+), 135 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 0f09caf..d8c8656 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -378,31 +378,81 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
>  }
>  
>  /**
> - * Enable or disable all rx/tx config flags at once
> + * Set SCR, SIER, STCR and SRCR registers with cached values in regvals
> + *
> + * Notes:
> + * 1) For offline_config SoCs, enable all necessary bits of both streams
> + *    when 1st stream starts, even if the opposite stream will not start
> + * 2) It also clears FIFO before setting regvals; SOR is safe to set online
>   */
> -static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
> +static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)
>  {
> -	struct regmap *regs = ssi->regs;
>  	struct fsl_ssi_regvals *vals = ssi->regvals;
> +	u32 sier, srcr, stcr;
>  
> -	if (enable) {
> -		regmap_update_bits(regs, REG_SSI_SIER,
> -				   vals[RX].sier | vals[TX].sier,
> -				   vals[RX].sier | vals[TX].sier);
> -		regmap_update_bits(regs, REG_SSI_SRCR,
> -				   vals[RX].srcr | vals[TX].srcr,
> -				   vals[RX].srcr | vals[TX].srcr);
> -		regmap_update_bits(regs, REG_SSI_STCR,
> -				   vals[RX].stcr | vals[TX].stcr,
> -				   vals[RX].stcr | vals[TX].stcr);
> +	/* Clear dirty data in the FIFO; It also prevents channel slipping */
> +	regmap_update_bits(ssi->regs, REG_SSI_SOR,
> +			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
> +
> +	/*
> +	 * On offline_config SoCs, SxCR and SIER are already configured when
> +	 * the previous stream started. So skip all SxCR and SIER settings
> +	 * to prevent online reconfigurations, then jump to set SCR directly
> +	 */
> +	if (ssi->soc->offline_config && ssi->streams)
> +		goto enable_scr;
> +
> +	if (ssi->soc->offline_config) {
> +		/*
> +		 * Online reconfiguration not supported, so enable all bits for
> +		 * both streams at once to avoid necessity of reconfigurations
> +		 */
> +		srcr = vals[RX].srcr | vals[TX].srcr;
> +		stcr = vals[RX].stcr | vals[TX].stcr;
> +		sier = vals[RX].sier | vals[TX].sier;
>  	} else {
> -		regmap_update_bits(regs, REG_SSI_SRCR,
> -				   vals[RX].srcr | vals[TX].srcr, 0);
> -		regmap_update_bits(regs, REG_SSI_STCR,
> -				   vals[RX].stcr | vals[TX].stcr, 0);
> -		regmap_update_bits(regs, REG_SSI_SIER,
> -				   vals[RX].sier | vals[TX].sier, 0);
> +		/* Otherwise, only set bits for the current stream */
> +		srcr = vals[tx].srcr;
> +		stcr = vals[tx].stcr;
> +		sier = vals[tx].sier;

Implicit assumption here that RX == 0, TX == 1, as in the 03 patch.

>  	}
> +
> +	/* Configure SRCR, STCR and SIER at once */
> +	regmap_update_bits(ssi->regs, REG_SSI_SRCR, srcr, srcr);
> +	regmap_update_bits(ssi->regs, REG_SSI_STCR, stcr, stcr);
> +	regmap_update_bits(ssi->regs, REG_SSI_SIER, sier, sier);
> +
> +enable_scr:
> +	/*
> +	 * Start DMA before setting TE to avoid FIFO underrun
> +	 * which may cause a channel slip or a channel swap
> +	 *
> +	 * TODO: FIQ cases might also need this upon testing
> +	 */
> +	if (ssi->use_dma && tx) {
> +		int try = 100;
> +		u32 sfcsr;
> +
> +		/* Enable SSI first to send TX DMA request */
> +		regmap_update_bits(ssi->regs, REG_SSI_SCR,
> +				   SSI_SCR_SSIEN, SSI_SCR_SSIEN);
> +
> +		/* Busy wait until TX FIFO not empty -- DMA working */
> +		do {
> +			regmap_read(ssi->regs, REG_SSI_SFCSR, &sfcsr);
> +			if (SSI_SFCSR_TFCNT0(sfcsr))
> +				break;
> +		} while (--try);
> +
> +		/* FIFO still empty -- something might be wrong */
> +		if (!SSI_SFCSR_TFCNT0(sfcsr))
> +			dev_warn(ssi->dev, "Timeout waiting TX FIFO filling\n");
> +	}
> +	/* Enable all remaining bits in SCR */
> +	regmap_update_bits(ssi->regs, REG_SSI_SCR, vals[tx].scr, vals[tx].scr);

Ditto.

> +
> +	/* Log the enabled stream to the mask */
> +	ssi->streams |= BIT(tx);

Ditto.

>  }
>  
>  /**
> @@ -426,65 +476,50 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
>  	((vals) & _ssi_xor_shared_bits(vals, avals, aactive))
>  
>  /**
> - * Enable or disable SSI configuration.
> + * Unset SCR, SIER, STCR and SRCR registers with cached values in regvals
> + *
> + * Notes:
> + * 1) For offline_config SoCs, to avoid online reconfigurations, disable all
> + *    bits of both streams at once when the last stream is abort to end
> + * 2) It also clears FIFO after unsetting regvals; SOR is safe to set online
>   */
> -static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
> -			   struct fsl_ssi_regvals *vals)
> +static void fsl_ssi_config_disable(struct fsl_ssi *ssi, bool tx)
>  {
> -	bool tx = &ssi->regvals[TX] == vals;
> -	struct regmap *regs = ssi->regs;
> -	struct fsl_ssi_regvals *avals;
> +	struct fsl_ssi_regvals *avals, *vals = &ssi->regvals[tx];

Ditto.

> +	u32 sier, srcr, stcr, scr;
>  	bool aactive;
>  
>  	/* Check if the opposite stream is active */
>  	aactive = ssi->streams & BIT(!tx);
>  
> -	/* Get the opposite direction to keep its values untouched */
> -	if (&ssi->regvals[RX] == vals)
> -		avals = &ssi->regvals[TX];
> -	else
> -		avals = &ssi->regvals[RX];
> -
> -	if (!enable) {
> -		/*
> -		 * To keep the other stream safe, exclude shared bits between
> -		 * both streams, and get safe bits to disable current stream
> -		 */
> -		u32 scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
> -		/* Safely disable SCR register for the stream */
> -		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
> -
> -		/* Log the disabled stream to the mask */
> -		ssi->streams &= ~BIT(tx);
> -	}
> +	/* Get regvals of the opposite stream to keep opposite stream safe */
> +	avals = &ssi->regvals[!tx];

Ditto.

>  
>  	/*
> -	 * For cases where online configuration is not supported,
> -	 * 1) Enable all necessary bits of both streams when 1st stream starts
> -	 *    even if the opposite stream will not start
> -	 * 2) Disable all remaining bits of both streams when last stream ends
> +	 * To keep the other stream safe, exclude shared bits between
> +	 * both streams, and get safe bits to disable current stream
>  	 */
> -	if (ssi->soc->offline_config) {
> -		if ((enable && !ssi->streams) || (!enable && !aactive))
> -			fsl_ssi_rxtx_config(ssi, enable);
> +	scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
>  
> -		goto config_done;
> -	}
> +	/* Disable safe bits of SCR register for the current stream */
> +	regmap_update_bits(ssi->regs, REG_SSI_SCR, scr, 0);
>  
> -	/* Online configure single direction while SSI is running */
> -	if (enable) {
> -		/* Clear FIFO to prevent dirty data or channel slipping */
> -		regmap_update_bits(ssi->regs, REG_SSI_SOR,
> -				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
> +	/* Log the disabled stream to the mask */
> +	ssi->streams &= ~BIT(tx);

Ditto.

Maciej
