From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 12/17] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Mon, 15 Jan 2018 21:44:41 +0200
Message-ID: <CAHp75VcS6y53oOogr5s2rygo6aOn0keijE=n23Ja=eOYETUsug@mail.gmail.com>
References: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com> <20180115124205.29042-13-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115124205.29042-13-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 2:42 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:
> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.

> +config GPIO_MADERA
> +       bool "Cirrus Logic Madera class codecs"

Not module?

> +/*
> + * GPIO support for Cirrus Logic Madera codecs
> + *
> + * Copyright 2015-2017 Cirrus Logic

SPDX ?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>

> +#include <linux/module.h>

?!?! Same to the MODULE_*() macros and Co.

> +static int madera_gpio_get_direction(struct gpio_chip *chip,
> +                                    unsigned int offset)
> +{

> +       ret = regmap_read(madera->regmap,

> +                         MADERA_GPIO1_CTRL_2 + (2 * offset), &val);

Redundant parens here and everywhere. * has higher priority and noone
I'm pretty sure can think other way.

> +       if (ret < 0)
> +               return ret;
> +
> +       return (val & MADERA_GP1_DIR_MASK) >> MADERA_GP1_DIR_SHIFT;

!! missed ?

> +}

> +static int madera_gpio_direction_out(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +{
> +       struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
> +       struct madera *madera = madera_gpio->madera;
> +       unsigned int regval;
> +       int ret;
> +
> +       if (value)
> +               regval = MADERA_GP1_LVL;
> +       else
> +               regval = 0;

Perhaps

regval = value ? ... : 0;

?

> +       if (value)
> +               regval = MADERA_GP1_LVL;
> +       else
> +               regval = 0;

Ditto.

> +static int madera_gpio_probe(struct platform_device *pdev)
> +{
> +       struct madera *madera = dev_get_drvdata(pdev->dev.parent);
> +       struct madera_pdata *pdata = dev_get_platdata(madera->dev);
> +       struct madera_gpio *madera_gpio;
> +       int ret;

> +       madera_gpio->madera = madera;
> +       madera_gpio->gpio_chip = template_chip;
> +       madera_gpio->gpio_chip.parent = &pdev->dev;
> +

> +       if (IS_ENABLED(CONFIG_OF_GPIO))
> +               madera_gpio->gpio_chip.of_node = madera->dev->of_node;

Isn't it done in GPIO core?

> +       if (pdata && pdata->gpio_base)
> +               madera_gpio->gpio_chip.base = pdata->gpio_base;

platform data in modern driver? Hmm...

> +       else
> +               madera_gpio->gpio_chip.base = -1;


> +
> +       ret = devm_gpiochip_add_data(&pdev->dev, &madera_gpio->gpio_chip,
> +                                    madera_gpio);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
> +                                    0, 0, madera_gpio->gpio_chip.ngpio);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "Failed to add pin range (%d)\n", ret);
> +               return ret;
> +       }

Consider if your messages above indeed make value. Hint: device core
prints a warning if ->probe() fails.


> +static struct platform_driver madera_gpio_driver = {
> +       .driver.name    = "madera-gpio",

Please, do in more portable way, i.e.
 .driver = {
   .name = "...",
 },

> +       .driver.owner   = THIS_MODULE,

Is this still needed? I suppose below macro does it for ya.

> +       .probe          = madera_gpio_probe,
> +};
> +
> +module_platform_driver(madera_gpio_driver);
> +

> +MODULE_DESCRIPTION("GPIO interface for Madera codecs");
> +MODULE_AUTHOR("Nariman Poushin <nariman@opensource.wolfsonmicro.com>");
> +MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:madera-gpio");

See above

-- 
With Best Regards,
Andy Shevchenko
