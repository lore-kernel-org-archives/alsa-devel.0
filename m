From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 12/18] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Tue, 25 Apr 2017 16:13:57 +0200
Message-ID: <CACRpkdbhgkwtPygfRL6JXc7syi4MqSUXx2jrVzp7q9FPOWX6OQ@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com> <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493050124-5970-13-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
<rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:

> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.
>
> Signed-off-by: Nariman Poushin <nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
> Changes from V1:
> - dt bindings moved to a separate patch
> - dependent on pinctrl driver instead of parent MFD
> - added get_direction function
> - added .request / .free / .set_config to work with pinctrl driver
> - register range with pinctrl driver

Nice, but...

> +       ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
> +                                    0, 0, madera_gpio->gpio_chip.ngpio);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "Failed to add pin range (%d)\n", ret);
> +               return ret;
> +       }

This is all fine, but we have generic code for adding ranges from
the device tree, see
Documentation/devicetree/bindings/gpio/gpio.txt

With that this range should not even be needed.
Apart from that it looks pretty solid.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
