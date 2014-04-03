From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 3/4] ASoC: spdif: Sort the header files
	alphabetically.
Date: Thu, 3 Apr 2014 19:21:52 +0800
Message-ID: <20140403112150.GC32081@MrMyself>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-4-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id B58E42619F4
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 13:33:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396516257-25354-4-git-send-email-Li.Xiubo@freescale.com>
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

On Thu, Apr 03, 2014 at 05:10:56PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Thank you.

> ---
>  sound/soc/fsl/fsl_spdif.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 6452ca8..173553c 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -13,18 +13,18 @@
>   * kind, whether express or implied.
>   */
>  
> -#include <linux/module.h>
> +#include <linux/bitrev.h>
>  #include <linux/clk.h>
>  #include <linux/clk-private.h>
> -#include <linux/bitrev.h>
> -#include <linux/regmap.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/regmap.h>
>  
>  #include <sound/asoundef.h>
> -#include <sound/soc.h>
>  #include <sound/dmaengine_pcm.h>
> +#include <sound/soc.h>
>  
>  #include "fsl_spdif.h"
>  #include "imx-pcm.h"
> -- 
> 1.8.4
> 
> 
