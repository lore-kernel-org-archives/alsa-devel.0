From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] ASoC: cs53l30: include gpio/consumer.h
Date: Sun, 5 Jun 2016 22:06:47 -0700
Message-ID: <20160606050646.GA7872@Asurada>
References: <1465132260-6617-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465132260-6617-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 05, 2016 at 03:11:00PM +0200, Fabian Frederick wrote:
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
> ---
>  sound/soc/codecs/cs53l30.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
> index ac90dd7..4818324 100644
> --- a/sound/soc/codecs/cs53l30.c
> +++ b/sound/soc/codecs/cs53l30.c
> @@ -15,6 +15,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio/consumer.h>

Could you put it before i2c.h to order them alphabetically?

Thank you

>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/regulator/consumer.h>
> -- 
> 2.1.4
> 
