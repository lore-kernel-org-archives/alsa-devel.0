From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 08:47:14 +0200
Message-ID: <20120605064714.GL30400@pengutronix.de>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 122C72453B
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 08:47:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de, shawn.guo@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 04, 2012 at 09:42:53AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Rebase to 3.5rc1.
> 
>  sound/soc/fsl/fsl_ssi.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 4ed2afd..b10a427 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -725,7 +725,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>  		u32 dma_events[2];
>  		ssi_private->ssi_on_imx = true;
>  
> -		ssi_private->clk = clk_get(&pdev->dev, NULL);
> +		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);

Have you tried compiling this on PowerPC? devm_clk_get is only available
with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
