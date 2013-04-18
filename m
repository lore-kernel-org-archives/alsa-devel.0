From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: imx-sgtl5000: Do not enter the
 error path on success
Date: Thu, 18 Apr 2013 09:29:40 +0800
Message-ID: <20130418012938.GC20563@S2101-09.ap.freescale.net>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 90DF22625D4
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 03:30:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366242921-16376-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 08:55:18PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Return on success instead of entering the error path.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/fsl/imx-sgtl5000.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 9584e78..88fc02c 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -174,6 +174,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +

This does not look correct.  Doing so will skip clk_put() and
of_node_put() on success.

Shawn

>  clk_fail:
>  	clk_put(data->codec_clk);
>  fail:
> -- 
> 1.7.9.5
> 
