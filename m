From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: imx-ssi: Use clk_prepare_enable()
Date: Fri, 25 May 2012 22:10:13 +0200
Message-ID: <20120525201013.GU30400@pengutronix.de>
References: <1337976410-16894-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A604A103B5C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2012 22:10:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337976410-16894-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: philippe.retornaz@epfl.ch, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Fri, May 25, 2012 at 05:06:50PM -0300, Fabio Estevam wrote:
> Fix the following kernel crash:
> 
> This applies against linux-next.
> 
>  sound/soc/fsl/imx-ssi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index cf3ed03..9027a83 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -543,7 +543,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  			ret);
>  		goto failed_clk;
>  	}
> -	clk_enable(ssi->clk);
> +	clk_prepare_enable(ssi->clk);

You should use clk_disable_unprepare then aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
