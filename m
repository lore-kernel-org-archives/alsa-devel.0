From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 linux-next] ASoC: cs53l30: include gpio/consumer.h
Date: Mon, 6 Jun 2016 10:36:12 -0700
Message-ID: <20160606173612.GA32417@Asurada-Nvidia>
References: <1465232753-32492-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465232753-32492-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2016 at 07:05:53PM +0200, Fabian Frederick wrote:
> cs53l30 breaks kernel compilation when CONFIG_GPIOLIB is disabled.
> 
> sound/soc/codecs/cs53l30.c:931:2: error: implicit declaration of
> function devm_gpiod_get_optional [-Werror=implicit-function-declaration]
>   cs53l30->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>   ^
> sound/soc/codecs/cs53l30.c:932:13: error: GPIOD_OUT_LOW undeclared
> (first use in this function)
> 
> Including gpio/consumer.h declares minimal functions in that case.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> ---
> V2:
> 	Add in alphabetical order (suggested by Nicolin Chen)
> 
>  sound/soc/codecs/cs53l30.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
> index ac90dd7..4f6ede9 100644
> --- a/sound/soc/codecs/cs53l30.c
> +++ b/sound/soc/codecs/cs53l30.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
> -- 
> 2.1.4
> 
