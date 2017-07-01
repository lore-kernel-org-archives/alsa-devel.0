From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: add check on
	platform_get_irq return value
Date: Fri, 30 Jun 2017 21:51:41 -0700
Message-ID: <20170701045140.GA9664@Asurada>
References: <20170630221735.GA17951@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B5A4B266847
 for <alsa-devel@alsa-project.org>; Sat,  1 Jul 2017 06:51:50 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id z6so19191722pfk.3
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 21:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170630221735.GA17951@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 30, 2017 at 05:17:35PM -0500, Gustavo A. R. Silva wrote:
> Check return value from call to platform_get_irq(),
> so in case of failure print error message and propagate
> the return value.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/imx-ssi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index b95132e..0679061 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -527,6 +527,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  	}
>  
>  	ssi->irq = platform_get_irq(pdev, 0);
> +	if (ssi->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
> +		return ssi->irq;
> +	}
>  
>  	ssi->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(ssi->clk)) {
> -- 
> 2.5.0
> 
