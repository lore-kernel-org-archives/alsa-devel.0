From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 2/4] ASoC: esai: Add Vybird and LS1+
	compatibles support.
Date: Thu, 3 Apr 2014 19:19:13 +0800
Message-ID: <20140403111911.GB32081@MrMyself>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id A0ED926262D
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 13:30:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396516257-25354-3-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 03, 2014 at 05:10:55PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 8efc89e..b84951b 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -818,6 +818,8 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id fsl_esai_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-esai", },
> +	{ .compatible = "fsl,vybird-esai", },

vybird or vybrid?

> +	{ .compatible = "fsl,ls1+-esai", },

Does ls1 differ vybrid on esai part? If not, it should be enough to use
vybrid for both of them, just like imx6q and imx6dl can also use imx35
compatible.

Thanks,
Nicolin

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
> -- 
> 1.8.4
> 
> 
