From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 03/17] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
Date: Wed, 29 Nov 2017 11:18:29 +0100
Message-ID: <CACRpkdaxKjPd_k8tuO3R4+5LFT4_37zn6ruDRPd5j9xNAH4+Dw@mail.gmail.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com> <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, alsa-devel@alsa-project.org, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 23, 2017 at 6:13 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> +config MFD_MADERA_I2C
> +       bool "Cirrus Logic Madera codecs with I2C"
> +       select MFD_MADERA
> +       select REGMAP_I2C
> +       depends on I2C
> +       depends on PINCTRL
> +       help
> +         Support for the Cirrus Logic Madera platform audio SoC
> +         core functionality controlled via I2C.
> +
> +config MFD_MADERA_SPI
> +       bool "Cirrus Logic Madera codecs with SPI"
> +       select MFD_MADERA
> +       select REGMAP_SPI
> +       depends on SPI_MASTER
> +       depends on PINCTRL
> +       help
> +         Support for the Cirrus Logic Madera platform audio SoC
> +         core functionality controlled via SPI.

Why do the I2C and SPI subdrivers depend on PINCTRL?

They sure don't seem to be using any pinctrl-specific APIs.

Yours,
Linus Walleij
