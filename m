From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 03/17] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
Date: Sat, 2 Dec 2017 13:10:04 +0100
Message-ID: <CACRpkdZ4QuOhk1LuGftcFozUKdZ4vFAO3omkQ004k39J=jKL7g@mail.gmail.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
 <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com> <CACRpkdaxKjPd_k8tuO3R4+5LFT4_37zn6ruDRPd5j9xNAH4+Dw@mail.gmail.com>
 <1eff5a38-cff3-449b-bda4-047f50a9f1d4@EX17.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1eff5a38-cff3-449b-bda4-047f50a9f1d4-MRjWshV2NDGMZzV0eMwobdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Nikesh Oswal <Nikesh.Oswal-UVNVL95qEvAciDkP5Hr2oA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 29, 2017 at 12:36 PM, Richard Fitzgerald
<rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On 29/11/17 10:18, Linus Walleij wrote:
>>
>> On Thu, Nov 23, 2017 at 6:13 PM, Richard Fitzgerald
>> <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>>
>>> +config MFD_MADERA_I2C
>>> +       bool "Cirrus Logic Madera codecs with I2C"
>>> +       select MFD_MADERA
>>> +       select REGMAP_I2C
>>> +       depends on I2C
>>> +       depends on PINCTRL
>>> +       help
>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>> +         core functionality controlled via I2C.
>>> +
>>> +config MFD_MADERA_SPI
>>> +       bool "Cirrus Logic Madera codecs with SPI"
>>> +       select MFD_MADERA
>>> +       select REGMAP_SPI
>>> +       depends on SPI_MASTER
>>> +       depends on PINCTRL
>>> +       help
>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>> +         core functionality controlled via SPI.
>>
>>
>> Why do the I2C and SPI subdrivers depend on PINCTRL?
>>
>> They sure don't seem to be using any pinctrl-specific APIs.
>>
>
> They require PINCTRL even if they don't call any functions on it because the
> chip won't work correctly if there isn't a PINCTRL driver to apply the
> correct pinmux configuration.

Apply the configuration to what? Sorry I don't get it.

You can't be referring to the internal pin controller of the Madera, since
that has to come up before its pin controller can even be communicated
with.

If you mean it is to apply the configuration to the system SoC where
this coded is connected, this is wrong. There may very well be systems
which have dedicated pins for the codec, atleast in theory. The fact
that your reference board needs this is not a universal requirement,
it should be set up in the machine-specific Kconfig for the reference
board in that case.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
