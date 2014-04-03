From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: spdif: Add Vybird and LS1+
	compatibles support.
Date: Thu, 3 Apr 2014 20:45:15 +0800
Message-ID: <20140403124514.GA32327@MrMyself>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-5-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8B22610A0
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 15:04:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396516257-25354-5-git-send-email-Li.Xiubo@freescale.com>
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

On Thu, Apr 03, 2014 at 05:10:57PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_spdif.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 173553c..5c958ca 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1186,6 +1186,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id fsl_spdif_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-spdif", },
> +	{ .compatible = "fsl,vybird-spdif", },
> +	{ .compatible = "fsl,ls1+-spdif", },

Same comments here.

And just a little reminder:
You are using "fsl,vf610-sai" for fsl_sai.c. I was wondering if you'd better
use "fsl,vf610-spdif" over here as well.

Best regards,
Nicolin

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
> -- 
> 1.8.4
> 
> 
