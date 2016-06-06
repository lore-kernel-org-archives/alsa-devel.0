From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [alsa-devel] [PATCH V2 linux-next] ASoC: cs53l30: include
 gpio/consumer.h
Date: Mon, 6 Jun 2016 17:30:31 +0000
Message-ID: <D37B1CA7.14680%Paul.Handrigan@cirrus.com>
References: <1465232753-32492-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465232753-32492-1-git-send-email-fabf@skynet.be>
Content-Language: en-US
Content-ID: <EAB89944596EF54FB4BFD7C9882B8BEF@ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 6/6/16, 12:05 PM, "Fabian Frederick" <fabf@skynet.be> wrote:

>cs53l30 breaks kernel compilation when CONFIG_GPIOLIB is disabled.
>
>sound/soc/codecs/cs53l30.c:931:2: error: implicit declaration of
>function devm_gpiod_get_optional [-Werror=implicit-function-declaration]
>  cs53l30->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>  ^
>sound/soc/codecs/cs53l30.c:932:13: error: GPIOD_OUT_LOW undeclared
>(first use in this function)
>
>Including gpio/consumer.h declares minimal functions in that case.
>
>Signed-off-by: Fabian Frederick <fabf@skynet.be>
>---
>V2:
>	Add in alphabetical order (suggested by Nicolin Chen)
>
> sound/soc/codecs/cs53l30.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index ac90dd7..4f6ede9 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -14,6 +14,7 @@
> 
> #include <linux/clk.h>
> #include <linux/delay.h>
>+#include <linux/gpio/consumer.h>
> #include <linux/i2c.h>
> #include <linux/module.h>
> #include <linux/of_gpio.h>
>-- 
>2.1.4
Thanks!

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
