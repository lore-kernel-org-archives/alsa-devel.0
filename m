From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: Use devm_clk_get()
Date: Tue, 11 Jun 2013 08:44:40 +0800
Message-ID: <20130611004437.GA12514@S2101-09.ap.freescale.net>
References: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 7231C26169D
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 02:44:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 10, 2013 at 01:26:05PM -0300, Fabio Estevam wrote:
> Commit 9e13f345 (ASoC: sgtl5000: Let the codec acquire its clock) removed the 
> clk_put calls.
> 
> Let's use devm_clk_get() instead, so that we do not need to call them anymore.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/fsl/imx-sgtl5000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 823151b..7a8bc12 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -128,7 +128,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> +	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);

I do not think the change is correct.  It only works if the struct *dev
is what imx_sgtl5000 platform_device points to, that is pdev->dev here.
However what you pass here is codec's.  So when imx_sgtl5000_probe()
fails or imx_sgtl5000 module is removed, clk_put() will not be called.
And if I remember correctly, that's the reason why devm_clk_get() wasn't
used here in the first place.

Shawn

>  	if (IS_ERR(data->codec_clk))
>  		goto fail;
>  
> -- 
> 1.8.1.2
> 
> 
