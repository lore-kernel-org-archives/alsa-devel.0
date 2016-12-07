From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/1 linux-next] ASoC: samsung: include gpio consumer.h
Date: Wed, 7 Dec 2016 19:55:02 +0200
Message-ID: <20161207175502.GA13187@kozik-lap>
References: <1481096342-19104-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481096342-19104-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2016 at 08:39:02AM +0100, Fabian Frederick wrote:
> Fix the following build errors

I couldn't reproduce it on default config. Can you mention the necessary
environment/defconfig/arch etc.?

Patch itself looks needed. However shouldn't the driver depend also on
GPIOLIB?

Best regards,
Krzysztof

> sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration
> of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
> sound/soc/samsung/tm2_wm5110.c:438:24: error: implicit declaration
> of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  sound/soc/samsung/tm2_wm5110.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
> index 5cdf7d1..24cc9d6 100644
> --- a/sound/soc/samsung/tm2_wm5110.c
> +++ b/sound/soc/samsung/tm2_wm5110.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <sound/pcm_params.h>
> -- 
> 2.7.4
> 
