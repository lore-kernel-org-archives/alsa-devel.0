From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 03/17] mfd: madera: Add common support
 for Cirrus Logic Madera codecs
Date: Mon, 4 Dec 2017 09:47:00 +0000
Message-ID: <ce3772d8-3ae7-474f-b9c2-8008bb39fd0b@EX17.ad.cirrus.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
 <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com>
 <CACRpkdaxKjPd_k8tuO3R4+5LFT4_37zn6ruDRPd5j9xNAH4+Dw@mail.gmail.com>
 <1eff5a38-cff3-449b-bda4-047f50a9f1d4@EX17.ad.cirrus.com>
 <CACRpkdZ4QuOhk1LuGftcFozUKdZ4vFAO3omkQ004k39J=jKL7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E840A266C5E
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 10:47:05 +0100 (CET)
In-Reply-To: <CACRpkdZ4QuOhk1LuGftcFozUKdZ4vFAO3omkQ004k39J=jKL7g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 02/12/17 12:10, Linus Walleij wrote:
> On Wed, Nov 29, 2017 at 12:36 PM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
>> On 29/11/17 10:18, Linus Walleij wrote:
>>>
>>> On Thu, Nov 23, 2017 at 6:13 PM, Richard Fitzgerald
>>> <rf@opensource.wolfsonmicro.com> wrote:
>>>
>>>> +config MFD_MADERA_I2C
>>>> +       bool "Cirrus Logic Madera codecs with I2C"
>>>> +       select MFD_MADERA
>>>> +       select REGMAP_I2C
>>>> +       depends on I2C
>>>> +       depends on PINCTRL
>>>> +       help
>>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>>> +         core functionality controlled via I2C.
>>>> +
>>>> +config MFD_MADERA_SPI
>>>> +       bool "Cirrus Logic Madera codecs with SPI"
>>>> +       select MFD_MADERA
>>>> +       select REGMAP_SPI
>>>> +       depends on SPI_MASTER
>>>> +       depends on PINCTRL
>>>> +       help
>>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>>> +         core functionality controlled via SPI.
>>>
>>>
>>> Why do the I2C and SPI subdrivers depend on PINCTRL?
>>>
>>> They sure don't seem to be using any pinctrl-specific APIs.
>>>
>>
>> They require PINCTRL even if they don't call any functions on it because the
>> chip won't work correctly if there isn't a PINCTRL driver to apply the
>> correct pinmux configuration.
> 
> Apply the configuration to what? Sorry I don't get it.
> 
> You can't be referring to the internal pin controller of the Madera, since

Yes I am

> that has to come up before its pin controller can even be communicated
> with.

So?

The MFD driver powers up the chip before registering child drivers.

Also that's not entirely relevant, the pinctrl settings can still be 
written with the chip off because they will go into the regmap cache and 
be applied when the chip is next resumed.

> 
> If you mean it is to apply the configuration to the system SoC where
> this coded is connected, this is wrong. There may very well be systems
> which have dedicated pins for the codec, atleast in theory. The fact
> that your reference board needs this is not a universal requirement,
> it should be set up in the machine-specific Kconfig for the reference
> board in that case.
> 
> Yours,
> Linus Walleij
> 
