From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ASoC: fsl-sai: using 'lsb-first' property
 instead of 'big-endian-data'.
Date: Tue, 26 Aug 2014 10:04:26 +0100
Message-ID: <20140826090426.GA31558@leverpostej>
References: <1408950961-19177-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id CD3BE261A7E
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 11:04:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1408950961-19177-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <Pawel.Moll@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "timur@tabi.org" <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 08:16:01AM +0100, Xiubo Li wrote:
> This property used for configuring whether the LSB or the MSB is transmitted
> first for the fifo data.

I don't follow the rationale for this change.

This looks like a pointless renaming.

Why is this any better?

Thanks,
Mark.

> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
>  sound/soc/fsl/fsl_sai.c                             | 6 +++---
>  sound/soc/fsl/fsl_sai.h                             | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 06a405e..4956b14 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -20,9 +20,9 @@ Required properties:
>    See ../pinctrl/pinctrl-bindings.txt for details of the property values.
>  - big-endian: Boolean property, required if all the FTM_PWM registers
>    are big-endian rather than little-endian.
> -- big-endian-data: If this property is absent, the little endian mode will
> -  be in use as default, or the big endian mode will be in use for all the
> -  fifo data.
> +- lsb-first: Configures whether the LSB or the MSB is transmitted first for
> +  the fifo data. If this property is absent, the MSB is transmitted first as
> +  default, or the LSB is transmitted first.
>  - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
>    that SAI will work in the synchronous mode (sync Tx with Rx) which means
>    both the transimitter and receiver will send and receive data by following
> @@ -53,5 +53,5 @@ sai2: sai@40031000 {
>  	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
>  		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
>  	      big-endian;
> -	      big-endian-data;
> +	      lsb-first;
>  };
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a6eb784..7eeb1dd 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -175,7 +175,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>  	bool tx = fsl_dir == FSL_FMT_TRANSMITTER;
>  	u32 val_cr2 = 0, val_cr4 = 0;
>  
> -	if (!sai->big_endian_data)
> +	if (!sai->is_lsb_first)
>  		val_cr4 |= FSL_SAI_CR4_MF;
>  
>  	/* DAI mode */
> @@ -304,7 +304,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
>  	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
>  
> -	if (sai->big_endian_data)
> +	if (sai->is_lsb_first)
>  		val_cr5 |= FSL_SAI_CR5_FBT(0);
>  	else
>  		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
> @@ -573,7 +573,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
>  		sai->sai_on_imx = true;
>  
> -	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
> +	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 2cded44..3466720 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -132,7 +132,7 @@ struct fsl_sai {
>  	struct clk *bus_clk;
>  	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
>  
> -	bool big_endian_data;
> +	bool is_lsb_first;
>  	bool is_dsp_mode;
>  	bool sai_on_imx;
>  	bool synchronous[2];
> -- 
> 1.8.5
> 
> 
