From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-spdif: big-endian support
Date: Tue, 11 Feb 2014 15:10:35 +0800
Message-ID: <20140211071034.GA18803@MrMyself>
References: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 05306261645
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 08:15:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>, shawn.guo@linaro.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 11, 2014 at 01:41:15PM +0800, Xiubo Li wrote:
> For most platforms, the CPU and SPDIF device is in the same endianess
> mode. While for the LS1 platform, the CPU is in LE mode and the SPDIF
> is in BE mode.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.txt | 4 ++++
>  sound/soc/fsl/fsl_spdif.c                             | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> index f2ae335..433ad00 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -29,6 +29,10 @@ Required properties:
>  			can also be referred to TxClk_Source
>  			bit of register SPDIF_STC.
>  
> +   - big-endian : If this property is absent, the native endian mode will
> +   be in use as default, or the big endian mode will be in use for all the
> +   device registers.
> +

@Shawn
Does DT have an existing approach to determine if the current SoC this IP
uses is BE or LE? I am thinking the scenario that if all drivers support
BE/LE while the SoC is big-endian, all the nodes in the DT would have to
include a duplicated property (big-endian).

>  Example:
>  
>  spdif: spdif@02004000 {
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 8f36f49..2f8ad75 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -83,6 +83,8 @@ struct fsl_spdif_priv {
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  
> +	bool big_endian;
> +
>  	/* The name space will be allocated dynamically */
>  	char name[0];
>  };
> @@ -985,7 +987,7 @@ static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static const struct regmap_config fsl_spdif_regmap_config = {
> +static struct regmap_config fsl_spdif_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> @@ -1105,6 +1107,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
>  	spdif_priv->cpu_dai_drv.name = spdif_priv->name;
>  
> +	spdif_priv->big_endian = of_property_read_bool(np, "big-endian");
> +	if (spdif_priv->big_endian)
> +		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;

Why not just:
	if (of_property_read_bool(np, "big-endian"))
		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;

> +
>  	/* Get the addresses and IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	regs = devm_ioremap_resource(&pdev->dev, res);
> -- 
> 1.8.4
> 
> 
