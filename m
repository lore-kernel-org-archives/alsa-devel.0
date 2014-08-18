From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ASoC: fsl-asrc: Convert to use regmap
 framework's endianness method.
Date: Mon, 18 Aug 2014 10:51:55 +0100
Message-ID: <20140818095155.GD14559@leverpostej>
References: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 42BC52654BB
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 11:52:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "varkabhadram@gmail.com" <varkabhadram@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 18, 2014 at 09:56:55AM +0100, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> 
> This is depended on the following regmap framework patches, which have
> just been merged into linux-next tree:
> 
> https://lkml.org/lkml/2014/7/15/6
> https://lkml.org/lkml/2014/7/15/5
> https://lkml.org/lkml/2014/7/15/7
> 
> 
> 
> 
> 
> 
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++---
>  sound/soc/fsl/fsl_asrc.c                             |  6 +-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index b93362a..791f372 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -26,9 +26,12 @@ Required properties:
>  	"ipg"		  Peripheral clock to driver module.
>  	"asrck_<0-f>"	  Clock sources for input and output clock.
>  
> -   - big-endian		: If this property is absent, the little endian mode
> -			  will be in use as default. Otherwise, the big endian
> -			  mode will be in use for all the device registers.
> +   - big-endian		: If this property is absent, the native endian mode
> +			  (same with CPU) will be in use as default. Otherwise,
> +			  the big endian mode will be in use for all the device
> +			  registers.
> +			  See Documentation/devicetree/bindings/regmap/regmap.txt
> +			  for more detail.

Why does this have to change the semantics of the DT binding?

Mark.

>  
>     - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
>  
> @@ -56,5 +59,6 @@ asrc: asrc@02034000 {
>  		"txa", "txb", "txc";
>  	fsl,asrc-rate  = <48000>;
>  	fsl,asrc-width = <16>;
> +	big-endian;
>  	status = "okay";
>  };
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 8221104..3b14531 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -684,7 +684,7 @@ static bool fsl_asrc_writeable_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static struct regmap_config fsl_asrc_regmap_config = {
> +static const struct regmap_config fsl_asrc_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> @@ -802,10 +802,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  
>  	asrc_priv->paddr = res->start;
>  
> -	/* Register regmap and let it prepare core clock */
> -	if (of_property_read_bool(np, "big-endian"))
> -		fsl_asrc_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> -
>  	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
>  						      &fsl_asrc_regmap_config);
>  	if (IS_ERR(asrc_priv->regmap)) {
> -- 
> 1.8.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
