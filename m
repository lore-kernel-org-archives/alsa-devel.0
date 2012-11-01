From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 1/2] ASoC: mxs-saif: Remove platform data
Date: Thu, 1 Nov 2012 09:35:16 +0800
Message-ID: <20121101013515.GD8358@S2100-06.ap.freescale.net>
References: <1351698925-25530-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 69D8E2616DA
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 02:09:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1351698925-25530-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, dong.aisheng@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 31, 2012 at 01:55:25PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> All MXS users have been converted to device tree and the board files have been
> removed.
> 
> No need to keep platform data in the driver.
>   
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> Changes since v2:
> - Also remove 'if (np)' as dt is the only probing mechanism.
> Changes since v1:
> - Also remove mxs_saif_platform_data and sound/saif.h, which was used only
> to include mxs_saif_platform_data definition.
>  include/sound/saif.h     |   16 ----------------
>  sound/soc/mxs/mxs-saif.c |   42 +++++++++++++++---------------------------
>  2 files changed, 15 insertions(+), 43 deletions(-)
>  delete mode 100644 include/sound/saif.h
> 
> diff --git a/include/sound/saif.h b/include/sound/saif.h
> deleted file mode 100644
> index f22f3e1..0000000
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index aa037b2..ab5bdec 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -32,7 +32,6 @@
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> -#include <sound/saif.h>
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
>  #include <mach/mxs.h>
> @@ -652,10 +651,9 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct resource *iores, *dmares;
>  	struct mxs_saif *saif;
> -	struct mxs_saif_platform_data *pdata;
>  	struct pinctrl *pinctrl;
>  	int ret = 0;
> -
> +	struct device_node *master;
>  
>  	if (!np && pdev->id >= ARRAY_SIZE(mxs_saif))
>  		return -EINVAL;
> @@ -664,31 +662,21 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  	if (!saif)
>  		return -ENOMEM;
>  
> -	if (np) {
> -		struct device_node *master;
> -		saif->id = of_alias_get_id(np, "saif");
> -		if (saif->id < 0)
> -			return saif->id;
> -		/*
> -		 * If there is no "fsl,saif-master" phandle, it's a saif
> -		 * master.  Otherwise, it's a slave and its phandle points
> -		 * to the master.
> -		 */
> -		master = of_parse_phandle(np, "fsl,saif-master", 0);
> -		if (!master) {
> -			saif->master_id = saif->id;
> -		} else {
> -			saif->master_id = of_alias_get_id(master, "saif");
> -			if (saif->master_id < 0)
> -				return saif->master_id;
> -		}
> +	saif->id = of_alias_get_id(np, "saif");
> +	if (saif->id < 0)
> +		return saif->id;
> +	/*
> +	 * If there is no "fsl,saif-master" phandle, it's a saif
> +	 * master.  Otherwise, it's a slave and its phandle points
> +	 * to the master.
> +	 */
> +	master = of_parse_phandle(np, "fsl,saif-master", 0);
> +	if (!master) {
> +		saif->master_id = saif->id;
>  	} else {
> -		saif->id = pdev->id;
> -		pdata = pdev->dev.platform_data;
> -		if (pdata && !pdata->master_mode)
> -			saif->master_id = pdata->master_id;
> -		else
> -			saif->master_id = saif->id;
> +		saif->master_id = of_alias_get_id(master, "saif");
> +		if (saif->master_id < 0)
> +			return saif->master_id;
>  	}
>  
>  	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
> -- 
> 1.7.9.5
> 
