From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 10/18] pinctrl: madera: Add driver for Cirrus Logic
 Madera codecs
Date: Tue, 25 Apr 2017 11:41:59 +0200
Message-ID: <CACRpkdYtuu4mFf9bjz-z_kNhbgmuw7TQdQqBc66iWfFP5wp_fw@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com> <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
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
> Note on the Kconfig options:
> The formula "default y if..." is used for PINCTRL_MADERA so that its
> select options will be processed, allowing us to group selects for
> pinctrl into the pinctrl Kconfig where they logically belong instead
> of accumulating under the parent MFD Kconfig.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
(...)

> Changes since V1:

This is starting to look good!

In fact, kind of finished. Except:

> +       if (pdata) {
> +               ret = pinctrl_register_mappings(pdata->gpio_configs,
> +                                               pdata->n_gpio_configs);
> +               if (ret) {
> +                       dev_err(priv->dev,
> +                               "Failed to register pdata mappings (%d)\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }

What is this? It looks like boardfile support which we do not like to
encourage. Why are the mappings not exclusively set up from
device tree or similar?

Yours,
Linus Walleij
