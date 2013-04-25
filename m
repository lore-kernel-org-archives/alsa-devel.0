From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/4] ASoC: imx-sgtl5000: Do not enter
 the error path on success
Date: Thu, 25 Apr 2013 13:05:57 +0800
Message-ID: <20130425050555.GA1389@S2101-09.ap.freescale.net>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B41265D36
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 07:06:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366815286-31820-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 11:54:43AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Return on success instead of entering the error path.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> Changes since v1:
> - Keep of_node_put in the success path.
> 
>  sound/soc/fsl/imx-sgtl5000.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 9584e78..5a6aaa3 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -174,6 +174,11 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> +	of_node_put(ssi_np);
> +	of_node_put(codec_np);
> +
> +	return 0;
> +
>  clk_fail:
>  	clk_put(data->codec_clk);
>  fail:
> -- 
> 1.7.9.5
> 
