From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 12/17] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Tue, 16 Jan 2018 10:27:03 +0100
Message-ID: <CACRpkdY4pNO6-oPJrJ2x_vai__9Dn1JDsRX2YJBNb6CJboK4Sw@mail.gmail.com>
References: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com> <20180115124205.29042-13-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180115124205.29042-13-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, linux-gpio@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 1:42 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.
>
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see Andy found more problems so fix those too..

> +#include <linux/device.h>
> +#include <linux/gpio.h>

Only
#include <linux/gpio/driver.h>

> +#include <linux/kernel.h>
> +#include <linux/module.h>

Not for bool drivers, right, as Andy pointed out.

> +static struct gpio_chip template_chip = {

Why is this named "template"?

There is nothing template about it, it is what you use.

If you keep it like this, name it madera_chip or something.

> +       .label                  = "madera",
> +       .owner                  = THIS_MODULE,
> +       .request                = gpiochip_generic_request,
> +       .free                   = gpiochip_generic_free,
> +       .get_direction          = madera_gpio_get_direction,
> +       .direction_input        = madera_gpio_direction_in,
> +       .get                    = madera_gpio_get,
> +       .direction_output       = madera_gpio_direction_out,
> +       .set                    = madera_gpio_set,
> +       .set_config             = gpiochip_generic_config,

Pretty cool! Have you tested this with e.g. open drain or debounce?

> +       ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
> +                                    0, 0, madera_gpio->gpio_chip.ngpio);

Are you using device tree for this?

In that case add the range in the device tree instead.

The gpiolib will pick that up for you by default and you don't even need
this code. See
git grep 'gpio-ranges' arch/arm/boot/dts

If you're also using this with platform data or ACPI or whatever, then
this is fine.

Yours,
Linus Walleij
