From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Fix 6pin mux
	configuration
Date: Tue, 07 Aug 2012 15:43:56 +0300
Message-ID: <50210D8C.8090303@bitmer.com>
References: <1344343067-27435-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A41A265F6C
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 19:49:35 +0200 (CEST)
In-Reply-To: <1344343067-27435-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@linux.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, "3.4+" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/07/2012 03:37 PM, Peter Ujfalusi wrote:
> The check for the mux_signal callback was wrong which prevents us to
> configure the 6pin port's FSR/CLKR signal mux.
> 
> Reported-by: CF Adad <cfadad@rocketmail.com>
> Cc: stable@kernel.org (3.4+)
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> 
> Hi Mark,
> 
> The omap-mcbsp FSR/CLKR mux configuration code seams to be broken since 3.4.
> Would it be possible to apply this patch for the 3.6 release?
> 
> CC-ing stable@kernel.org since this part is broken in 3.4 and 3.5 kernels as
> well.
> 
> Regards,
> Peter
> 
>  sound/soc/omap/mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 1b08d98..5bda7c9 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -766,7 +766,7 @@ int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
>  {
>  	const char *signal, *src;
>  
> -	if (mcbsp->pdata->mux_signal)
> +	if (!mcbsp->pdata->mux_signal)
>  		return -EINVAL;
>  
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
