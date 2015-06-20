From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fsl_asrc: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 13:27:05 -0700
Message-ID: <20150620202705.GA7632@Asurada>
References: <1434825674-8618-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A25D2604D6
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 22:27:19 +0200 (CEST)
Received: by paceq1 with SMTP id eq1so82536177pac.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 13:27:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434825674-8618-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 20, 2015 at 03:41:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index c068494..37dde26 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -931,14 +931,22 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  static int fsl_asrc_runtime_resume(struct device *dev)
>  {
>  	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
> -	int i;
> +	int i, ret;
>  
> -	clk_prepare_enable(asrc_priv->mem_clk);
> -	clk_prepare_enable(asrc_priv->ipg_clk);
> +	ret = clk_prepare_enable(asrc_priv->mem_clk);
> +	if (ret)
> +		return ret;
> +	ret = clk_prepare_enable(asrc_priv->ipg_clk);
> +	if (ret)
> +		goto disable_mem_clk;

>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
>  		clk_prepare_enable(asrc_priv->asrck_clk[i]);

How about these clocks?

disable_clk:
	for (i--; i >= 0; i--)
		clk_disable_unprepare(asrc_priv->asrc_clk[i]);

Might be better?

Thank you
Nicolin
