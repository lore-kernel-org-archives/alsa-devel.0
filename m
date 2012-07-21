From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] ARM: mx28evk: add missed clkmux select
 for saif
Date: Sat, 21 Jul 2012 15:40:04 +0800
Message-ID: <20120721074002.GC923@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-5-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 by alsa0.perex.cz (Postfix) with ESMTP id A50F9264F00
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 09:39:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1342776027-31758-5-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 20, 2012 at 05:20:27PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Added missed clkmux setting for mx28evk.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 8cac94b..82f27a4 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -21,6 +21,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <mach/common.h>
> +#include <mach/digctl.h>
>  
>  static int __init mxs_icoll_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
> @@ -79,6 +80,8 @@ static void __init imx28_evk_init(void)
>  	clk = clk_get_sys("enet_out", NULL);
>  	if (!IS_ERR(clk))
>  		clk_prepare_enable(clk);
> +
> +	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);

Is this a board specific setup?  Or every single imx28 based board that
wants recording function is going to need this setup?

BTW, the patch needs to get rebased on v3.6-rc1, where mach-mxs.c will
have some context update.

Regards,
Shawn

>  }
>  
>  static void __init mxs_machine_init(void)
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
