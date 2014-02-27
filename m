From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
Date: Thu, 27 Feb 2014 02:08:45 +0000
Message-ID: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EAC82657AD
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 03:08:49 +0100 (CET)
In-Reply-To: <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
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
To: Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


> @@ -134,6 +115,15 @@ struct fsl_ssi_rxtx_reg_val {
>  	struct fsl_ssi_reg_val rx;
>  	struct fsl_ssi_reg_val tx;
>  };
> +static const struct regmap_config fsl_ssi_regconfig = {
> +	.max_register = CCSR_SSI_SACCDIS,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +#ifdef PPC
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +#endif

Is this really needed for your PPC platforms?

If so, I think this should depend on one specified platform, which
the CPU is in LE mode while the SSI is in BE mode...


Thanks,

--
Best Regards,
Xiubo
