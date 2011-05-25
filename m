From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: sam9g20_wm8731: use the proper
	SYSCKL value
Date: Wed, 25 May 2011 19:15:46 +0800
Message-ID: <20110525111545.GD10797@opensource.wolfsonmicro.com>
References: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A15E810387C
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 13:15:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2011 at 11:51:16AM +0200, Nicolas Ferre wrote:
> at91sam9g20 is providing master clock to wm8731: not using a crystal but an
> external MCLK. We can avoid conflict and save power using WM8731_SYSCLK_MCLK as
> we do not need oscillator to be powered.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Adding Liam.

> ---
>  sound/soc/atmel/sam9g20_wm8731.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 28afbbf..95572d2 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -146,7 +146,7 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
>  			"at91sam9g20ek_wm8731 "
>  			": at91sam9g20ek_wm8731_init() called\n");
>  
> -	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
> +	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_MCLK,
>  		MCLK_RATE, SND_SOC_CLOCK_IN);
>  	if (ret < 0) {
>  		printk(KERN_ERR "Failed to set WM8731 SYSCLK: %d\n", ret);
> -- 
> 1.7.3
> 
