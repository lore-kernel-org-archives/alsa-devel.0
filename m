From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/16] pinctrl: madera: Add driver for Cirrus Logic Madera codecs
Date: Fri, 7 Apr 2017 10:54:32 +0200
Message-ID: <CACRpkdZK3QXu4t2jud0-LPDj0LDVruAm33N4Lazjk44C3ndwwQ@mail.gmail.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com> <1491386884-30689-10-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1491386884-30689-10-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> These codecs have a variable number of I/O lines each of which
> is individually selectable to a wide range of possible functions.
>
> The functionality is slightly different from the traditional muxed
> GPIO since most of the functions can be mapped to any pin (and even
> the same function to multiple pins). Most pins have a dedicated
> "alternate" function that is only available on that pin. The
> alternate functions are usually a group of signals, though it is
> not always necessary to enable the full group, depending on the
> alternate function and how it is to be used. The mapping between
> alternate functions and GPIO pins varies between codecs depending
> on the number of alternate functions and available pins.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

>  .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  103 ++

This should ideally be split into its own patch but I don't care
much if the DT people are happy.

> +See also
> +  the core bindings for the parent MFD driver:
> +    Documentation/devicetree/bindings/mfd/madera.txt
> +
> +  the generic pinmix bindings:
> +    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Nice.

> +Required properties of parent mfd node:
> +  - pinctrl-names : must be "defaults"

Do you mean "default"

Apart from this the bindings and example look very good to
me, good job! I like it when people "just get it" with pin control
and that is where we need to be with this subsystem.

> +config PINCTRL_MADERA
> +       bool
> +       default y if MFD_MADERA=y

Isn't it even proper for MFD_MADERA to explicitly
select this driver. I see it hard how the chip would even
work without this. (Maybe it already does select it but then
default y is not necessary.)

> +config PINCTRL_CS47L35
> +       bool
> +       default y if MFD_CS47L35=y

Similar comment for the subdrivers.

> @@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_AMD)     += pinctrl-amd.o
>  obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
>  obj-$(CONFIG_PINCTRL_DIGICOLOR)        += pinctrl-digicolor.o
>  obj-$(CONFIG_PINCTRL_FALCON)   += pinctrl-falcon.o
> +obj-$(CONFIG_PINCTRL_MADERA)   += pinctrl-madera.o

Is it all in one file... despite all the Kconfig symbols... hm.
I guess we can create drivers/pinctrl/cirrus the day we need more
space.

> +/*
> + * Pins are named after their GPIO number

So don't they have real names? Like the pin name on the underside of
the chip? That is what this naming convention is actually for.

> +/*
> + * All single-pin functions can be mapped to any GPIO, however pinmux applies
> + * functions to pin groups and only those groups declared as supporting that
> + * function. To make this work we must put each pin in its own dummy group so
> + * that the functions can be described as applying to all pins.
> + * Since these do not correspond to anything in the actual hardware - they are
> + * merely an adaptation to pinctrl's view of the world - we use the same name
> + * as the pin to avoid confusion when comparing with datasheet instructions
> + */
> +static const char * const madera_pin_single_group_names[] = {
> +       "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",  "gpio7",
> +       "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
> +       "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
> +       "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
> +       "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
> +       "gpio36", "gpio37", "gpio38", "gpio39", "gpio40",
> +};

If they are called "gpioN" in the datasheet I guess it is all right.
That is how e.g. the Qualcomm driver is done.

> +#ifdef CONFIG_PINCTRL_CS47L85

So this makes me feel maybe we should create drivers/pinctrl/cirrus
and split this driver into subdrivers per chip like others do.

The coding style document does say that ifdefs are ugly.

Would you consider splitting it up?

> +static void madera_pin_dbg_show(struct pinctrl_dev *pctldev,
> +                               struct seq_file *s,
> +                               unsigned int offset)
> +{
> +       seq_puts(s, " madera-pinctrl");
> +}

I don't think the pinctrl debugfs callback is compulsory.
It would be nice if this added some actual useful information
about the pin.


> +               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +                       mask[0] |= MADERA_GP1_OP_CFG_MASK;
> +                       conf[0] |= MADERA_GP1_OP_CFG;
> +                       break;
> +               case PIN_CONFIG_DRIVE_PUSH_PULL:
> +                       mask[0] |= MADERA_GP1_OP_CFG_MASK;
> +                       conf[0] &= ~MADERA_GP1_OP_CFG;
> +                       break;

This will be possible to reuse from a GPIO driver as back-end, nice!


> +               case PIN_CONFIG_INPUT_DEBOUNCE:
> +                       mask[0] |= MADERA_GP1_DB_MASK;
> +
> +                       /*
> +                        * we can't configure debounce time per-pin so value
> +                        * is just a flag
> +                        */
> +                       val = pinconf_to_config_argument(*configs);
> +                       if (val)
> +                               conf[0] |= MADERA_GP1_DB;
> +                       else
> +                               conf[0] &= ~MADERA_GP1_DB;
> +                       break;

This too.

Overall it looks very nice.

Yours,
Linus Walleij
