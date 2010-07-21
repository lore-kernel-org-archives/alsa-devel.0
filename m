From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] sound/soc/atmel: Remove dead
 CONFIG_AT32_ENHANCED_PORTMUX
Date: Wed, 21 Jul 2010 13:50:29 +0100
Message-ID: <20100721125029.GB15462@rakim.wolfsonmicro.main>
References: <cover.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<d2382c03db1d5b41a857b67688bf32838993d137.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B3DF10392E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:50:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d2382c03db1d5b41a857b67688bf32838993d137.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Geoffrey Wossum <gwossum@acm.org>, linux-kernel@vger.kernel.org, vamos-dev@i4.informatik.uni-erlangen.de, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 02:35:41PM +0200, Christian Dietrich wrote:
> CONFIG_AT32_ENCHANCED_PORTMUX doesn't exist in Kconfig or somewhere
> else, therefore removing all references for it from the source code.
> 
> Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>

Please remember to CC maintainers on patches - I've added Geoffrey.

> ---
>  sound/soc/atmel/playpaq_wm8510.c |    9 ---------
>  1 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
> index 9df4c68..fbd17e9 100644
> --- a/sound/soc/atmel/playpaq_wm8510.c
> +++ b/sound/soc/atmel/playpaq_wm8510.c
> @@ -425,11 +425,6 @@ static int __init playpaq_asoc_init(void)
>  	clk_set_rate(CODEC_CLK, 12000000);
>  	clk_enable(CODEC_CLK);
>  
> -#if defined CONFIG_AT32_ENHANCED_PORTMUX
> -	at32_select_periph(MCLK_PIN, MCLK_PERIPH, 0);
> -#endif
> -
> -
>  	/*
>  	 * Create and register platform device
>  	 */
> @@ -496,10 +491,6 @@ static void __exit playpaq_asoc_exit(void)
>  		_pll0 = NULL;
>  	}
>  
> -#if defined CONFIG_AT32_ENHANCED_PORTMUX
> -	at32_free_pin(MCLK_PIN);
> -#endif
> -
>  	platform_device_unregister(playpaq_snd_device);
>  	playpaq_snd_device = NULL;
>  }
> -- 
> 1.7.0.4
> 
