From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH] ALSA: pxa2xx: fix ac97 cold reset for
	pxa27x
Date: Sat, 05 Jan 2013 09:32:27 -0800
Message-ID: <50E863AB.2000706@newsguy.com>
References: <1356707815-3235-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id D20B5261723
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 18:32:10 +0100 (CET)
In-Reply-To: <1356707815-3235-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Igor Grinberg <grinberg@compulab.co.il>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Please don't apply this patch.  It works, but there is a better way to
accomplish the same goal by fixing another problem and also keeping things
consistent among the pxa siblings.  Patches to follow.

Thanks again Igor.

Mike


On 12/28/2012 07:16 AM, Mike Dunn wrote:
> Currently, ac97 reset is broken on PXA27x.  Through trial-and-error (the pxa270
> developer's manual is mostly incoherent on the topic of ac97 reset), I fixed it
> by setting the WARM_RST bit in the GCR register at the end of the cold reset,
> and then skipping the warm reset if the link is already up and running.
> 
> It appears that setting the WARM_RST bit is a necessary final step during cold
> reset.  I think that the PXA25x and PXA3xx may currently be working correctly
> because WARM_RST is set within the warm reset routine, and the codec drivers
> always follow a cold reset with a warm reset during their initialization. so
> this combination effectively completes a cold reset.  This doesn't work on the
> PXA27x because its warm reset routine contains additional code for working
> around a hardware bug in the warm reset sequence, which causes the reset
> sequence to fail.  I only have a PXA27x platform for testing, so this patch only
> affects the PXA27x.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> 
> As an aside... I don't understand how always following a cold reset with a warm
> reset (as the codec drivers do) makes sense.  Unless I'm mistaken, a warm reset
> can only occur on a link that's currently down.  All the timing diagrams I've
> seen for reset (warm and cold) show the link down (BITCLK stopped) at the start
> of the reset sequence.  The SYNC line is used to effect the warm reset, and SYNC
> is already pulsing every frame on a link that's up and running, so it seems
> physically impossible to do a warm reset on a link that's currently up.  But I'm
> no ac97 expert, so I may just be embarassing myself.  Any insight gratefully
> received.  Thanks!
> 
>  sound/arm/pxa2xx-ac97-lib.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 6fc0ae9..aa242ff 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -138,6 +138,10 @@ static inline void pxa_ac97_warm_pxa27x(void)
>  {
>  	gsr_bits = 0;
>  
> +	/* don't attempt warm reset if link is up */
> +	if (GSR & (GSR_SCR | GSR_PCR))
> +		return;
> +
>  	/* warm reset broken on Bulverde, so manually keep AC97 reset high */
>  	pxa27x_assert_ac97reset(reset_gpio, 1);
>  	udelay(10);
> @@ -148,6 +152,8 @@ static inline void pxa_ac97_warm_pxa27x(void)
>  
>  static inline void pxa_ac97_cold_pxa27x(void)
>  {
> +	unsigned int timeout;
> +
>  	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
>  	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
>  
> @@ -159,6 +165,15 @@ static inline void pxa_ac97_cold_pxa27x(void)
>  	clk_disable(ac97conf_clk);
>  	GCR = GCR_COLD_RST;
>  	udelay(50);
> +
> +	/*
> +	 * Setting the WARM_RST bit is a necessary part of a cold reset, at
> +	 * least on the buggy and poorly documented PXA27x ac97 controller.
> +	 */
> +	GCR |= GCR_WARM_RST;
> +	timeout = 100;     /* wait for the codec-ready bit to be set */
> +	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
> +		mdelay(1);
>  }
>  #endif
>  
