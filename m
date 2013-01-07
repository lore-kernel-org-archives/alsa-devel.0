From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/4] ALSA: pxa2xx: fix ac97 cold reset
Date: Mon, 07 Jan 2013 11:16:55 +0200
Message-ID: <50EA9287.5030304@compulab.co.il>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-2-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1357499640-13871-2-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/06/13 21:13, Mike Dunn wrote:
> Cold reset on the pxa27x currently fails and
> 
>      pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> 
> appears in the kernel log.  Through trial-and-error (the pxa270 developer's
> manual is mostly incoherent on the topic of ac97 reset), I got cold reset to
> complete by setting the WARM_RST bit in the GCR register (and later noticed that
> pxa3xx does this for cold reset as well).  Also, a timeout loop is needed to
> wait for the reset to complete.
> 
> Tested on a palm treo 680 machine.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>  sound/arm/pxa2xx-ac97-lib.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 6fc0ae9..1ecd0a66 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -148,6 +148,8 @@ static inline void pxa_ac97_warm_pxa27x(void)
>  
>  static inline void pxa_ac97_cold_pxa27x(void)
>  {
> +	unsigned int timeout;
> +
>  	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
>  	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
>  
> @@ -157,8 +159,10 @@ static inline void pxa_ac97_cold_pxa27x(void)
>  	clk_enable(ac97conf_clk);
>  	udelay(5);
>  	clk_disable(ac97conf_clk);
> -	GCR = GCR_COLD_RST;
> -	udelay(50);
> +	GCR = GCR_COLD_RST | GCR_WARM_RST;
> +	timeout = 100;     /* wait for the codec-ready bit to be set */
> +	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
> +		mdelay(1);

Can we use msleep() instead?
May be this will require to change the granularity to 10...

>  }
>  #endif
>  

-- 
Regards,
Igor.
