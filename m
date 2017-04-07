From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/16] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Fri, 7 Apr 2017 11:11:45 +0200
Message-ID: <CACRpkdatoJOg1U218Q-NteRdz6B+w_yr1PWvnfa1P1EgGm7zug@mail.gmail.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com> <1491386884-30689-11-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1491386884-30689-11-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> This adds support for the GPIOs on Cirrus Logic Madera class codecs.

A bit terse commit message, could you elaborate a bit on their
specifics?

>  .../devicetree/bindings/gpio/gpio-madera.txt       |  24 +++

Again should probably be a separate patch. Again, I don't care much
as long as the DT people are happy.

> +++ b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
> @@ -0,0 +1,24 @@
> +Cirrus Logic Madera class audio codecs gpio driver
> +
> +This is a subnode of the parent mfd node.
> +
> +See also the core bindings for the parent MFD driver:
> +See Documentation/devicetree/bindings/mfd/madera.txt
> +
> +Required properties:
> +  - compatible : must be "cirrus,madera-gpio"
> +  - gpio-controller : Indicates this device is a GPIO controller.
> +  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
> +    is reserved for future use and must be zero
> +
> +Example:
> +
> +codec: cs47l85@0 {
> +       compatible = "cirrus,cs47l85";
> +
> +       gpio {
> +               compatible = "cirrus,madera-gpio";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       }

Maybe you want to use the gpio-line-names = ; property in the example
to show how nice it is to name the lines?

> +config GPIO_MADERA
> +       tristate "Cirrus Logic Madera class codecs"
> +       depends on MFD_MADERA
> +       help
> +         Support for GPIOs on Cirrus Logic Madera class codecs.

I wonder if you should not depend on the pin controller instead.
It seems closer and also likely to act as a back-end for the
GPIOs.

> +static int madera_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
> +       struct madera *madera = madera_gpio->madera;
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(madera->regmap,
> +                         MADERA_GPIO1_CTRL_1 + (2 * offset), &val);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (val & MADERA_GP1_LVL_MASK)
> +               return 1;
> +       else
> +               return 0;

Just do this:

return !!(val & MADERA_GP1_LVL_MASK);

> +static struct gpio_chip template_chip = {
> +       .label                  = "madera",
> +       .owner                  = THIS_MODULE,
> +       .direction_input        = madera_gpio_direction_in,
> +       .get                    = madera_gpio_get,
> +       .direction_output       = madera_gpio_direction_out,
> +       .set                    = madera_gpio_set,
> +       .can_sleep              = true,
> +};

- Implement .get_direction()

Also consider implementing:

- request/free/set_config looking like this:

.request = gpiochip_generic_request,
.free = gpiochip_generic_free,
.set_config = gpiochip_generic_config,

If you also implement the corresponding
.pin_config_set in struct pinconf_ops and
.gpio_request_enable() and .gpio_disable_free()
in struct pinmux_ops, you get a pin control back-end
that will mux in the pins to GPIO mode if they are wrong
set, and also set up debounce and/or open drain for the
GPIO line using the standard GPIO callbacks with pin
control as a back-end.

If you also specify "strict" in struct pinmux_ops you block
the collisions between users of GPIO and other functions
in the pin control driver.

(Please go back and look at your pin control driver
for this.)

Example driver using pin control as GPIO back-end:
drivers/pinctrl/intel/pinctrl-intel.c

Other than this it looks fine.

Yours,
Linus Walleij
