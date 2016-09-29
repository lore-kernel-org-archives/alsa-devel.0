From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: fsl: Fix lockups with recent cache
	changes
Date: Thu, 29 Sep 2016 21:23:49 +0200
Message-ID: <0a653c4f-f0e4-b2f4-78f3-93acb5755e88@denx.de>
References: <20160929182754.28719-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id BE842264EFA
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 21:23:52 +0200 (CEST)
In-Reply-To: <20160929182754.28719-1-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/29/2016 08:27 PM, Mark Brown wrote:
> The recent series of changes to the caching in the SSI driver have
> caused a number of problems to appear in some test systems.  These are
> still not fully understood but we're coming up to the merge window so
> for now let's revert commit 7de2763d9b3 (ASoC: fsl_ssi: Remove
> .num_reg_defaults_raw from regmap_config) as backing that out seems to
> resolve the problem on affected systems.
> 
> Reported-by: Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

I'll keep my eyes peeled for the issue, thanks for all the time you and
Lars invested.

> ---
>  sound/soc/fsl/fsl_ssi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index b73c102f1cf2..50349437d961 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -177,6 +177,7 @@ static const struct regmap_config fsl_ssi_regconfig = {
>  	.val_bits = 32,
>  	.reg_stride = 4,
>  	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / sizeof(uint32_t) + 1,
>  	.readable_reg = fsl_ssi_readable_reg,
>  	.volatile_reg = fsl_ssi_volatile_reg,
>  	.precious_reg = fsl_ssi_precious_reg,
> @@ -1500,6 +1501,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  		 * don't have SACC{ST,EN,DIS} regs.
>  		 */
>  		regconfig.max_register = CCSR_SSI_SRMSK;
> +		regconfig.num_reg_defaults_raw =
> +			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
>  	}
>  
>  	ret = of_property_match_string(np, "clock-names", "ipg");
> 


-- 
Best regards,
Marek Vasut
