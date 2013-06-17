From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v8 02/11] ASoC: imx-pcm-fiq: Introduce
	pcm-fiq-params
Date: Mon, 17 Jun 2013 06:39:55 -0500
Message-ID: <51BEF58B.8070405@tabi.org>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
 <1371389117-19729-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 61B11261B1A
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 13:39:58 +0200 (CEST)
In-Reply-To: <1371389117-19729-3-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
>   #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
> -int imx_pcm_fiq_init(struct platform_device *pdev);
> +int imx_pcm_fiq_init(struct platform_device *pdev,
> +		struct imx_pcm_fiq_params *params);
>   void imx_pcm_fiq_exit(struct platform_device *pdev);
>   #else
> -static inline int imx_pcm_fiq_init(struct platform_device *pdev)
> +static inline int imx_pcm_fiq_init(struct platform_device *pdev,
> +		struct imx_pcm_fiq_params *params);
>   {
>   	return -ENODEV;
>   }

This won't compile on PowerPC, because of the ;

In file included from 
/home/b04825/git/linux.alsa2/sound/soc/fsl/fsl_ssi.c:53:0:
/home/b04825/git/linux.alsa2/sound/soc/fsl/imx-pcm.h:65:1: error: expected 
identifier or '(' before '{' token
/home/b04825/git/linux.alsa2/sound/soc/fsl/imx-pcm.h:63:19: warning: 
'imx_pcm_fiq_init' used but never defined


-- 
Timur Tabi
