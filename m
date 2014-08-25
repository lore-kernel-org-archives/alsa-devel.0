From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCHv3 1/4] ASoC: fsl-asrc: Convert to use regmap framework's
 endianness method.
Date: Sun, 24 Aug 2014 21:11:01 -0700
Message-ID: <20140825041100.GA2126@Alpha>
References: <1408937462-18727-1-git-send-email-Li.Xiubo@freescale.com>
 <1408937462-18727-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408937462-18727-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, timur@tabi.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, galak@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 11:30:59AM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 8221104..3b14531 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -802,10 +802,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  
>  	asrc_priv->paddr = res->start;
>  
> -	/* Register regmap and let it prepare core clock */

Oops, I didn't notice this change. This should be needless.

Otherwise, the whole change within sound/soc/fsl by this series looks fine.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> -	if (of_property_read_bool(np, "big-endian"))
> -		fsl_asrc_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> -
 
