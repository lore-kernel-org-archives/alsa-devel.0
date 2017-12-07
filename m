From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 03/17] mfd: madera: Add common support
 for Cirrus Logic Madera codecs
Date: Thu, 7 Dec 2017 10:52:47 +0000
Message-ID: <e11d1657-0dfe-4de6-8928-0512ae3c1f1a@EX17.ad.cirrus.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
 <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com>
 <CACRpkdaxKjPd_k8tuO3R4+5LFT4_37zn6ruDRPd5j9xNAH4+Dw@mail.gmail.com>
 <1eff5a38-cff3-449b-bda4-047f50a9f1d4@EX17.ad.cirrus.com>
 <CACRpkdZ4QuOhk1LuGftcFozUKdZ4vFAO3omkQ004k39J=jKL7g@mail.gmail.com>
 <ce3772d8-3ae7-474f-b9c2-8008bb39fd0b@EX17.ad.cirrus.com>
 <CACRpkdb_i4k3F0fmDbQciPYTBUCcfpFkqM=5e3gr75-X51TTkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 194B5267A89
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 11:52:51 +0100 (CET)
In-Reply-To: <CACRpkdb_i4k3F0fmDbQciPYTBUCcfpFkqM=5e3gr75-X51TTkg@mail.gmail.com>
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

On 07/12/17 08:54, Linus Walleij wrote:
> On Mon, Dec 4, 2017 at 10:47 AM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
>> On 02/12/17 12:10, Linus Walleij wrote:
>>> On Wed, Nov 29, 2017 at 12:36 PM, Richard Fitzgerald
>>> <rf@opensource.wolfsonmicro.com> wrote:
>>>> On 29/11/17 10:18, Linus Walleij wrote:
>>>>> On Thu, Nov 23, 2017 at 6:13 PM, Richard Fitzgerald
>>>>> <rf@opensource.wolfsonmicro.com> wrote:
>>>>>
>>>>>> +config MFD_MADERA_I2C
>>>>>> +       bool "Cirrus Logic Madera codecs with I2C"
>>>>>> +       select MFD_MADERA
>>>>>> +       select REGMAP_I2C
>>>>>> +       depends on I2C
>>>>>> +       depends on PINCTRL
>>>>>> +       help
>>>>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>>>>> +         core functionality controlled via I2C.
>>>>>> +
>>>>>> +config MFD_MADERA_SPI
>>>>>> +       bool "Cirrus Logic Madera codecs with SPI"
>>>>>> +       select MFD_MADERA
>>>>>> +       select REGMAP_SPI
>>>>>> +       depends on SPI_MASTER
>>>>>> +       depends on PINCTRL
>>>>>> +       help
>>>>>> +         Support for the Cirrus Logic Madera platform audio SoC
>>>>>> +         core functionality controlled via SPI.
>>>>>
>>>>>
>>>>>
>>>>> Why do the I2C and SPI subdrivers depend on PINCTRL?
>>>>>
>>>>> They sure don't seem to be using any pinctrl-specific APIs.
>>>>>
>>>>
>>>> They require PINCTRL even if they don't call any functions on it because
>>>> the
>>>> chip won't work correctly if there isn't a PINCTRL driver to apply the
>>>> correct pinmux configuration.
>>>
>>>
>>> Apply the configuration to what? Sorry I don't get it.
>>>
>>> You can't be referring to the internal pin controller of the Madera, since
>>
>> Yes I am
> 
> You are saying that the I2C and SPI interface to the Madera codec
> depends on pin control.
> 
> It does not.
> 
> You can most certainly talk I2C and SPI to the coded without any
> pin control. Probably the MFD driver can come up without it.
> 
> If what you want is unconditional pin control enabled for this circuit,
> then have MFD_MADERA select PINCTRL.
> 
>>> that has to come up before its pin controller can even be communicated
>>> with.
>>
>>
>> So?
>>
>> The MFD driver powers up the chip before registering child drivers.
> 
> Including the pin controller. You just confirmed what I said: the
> I2C and SPI interfaces do not require pin control to talk to the
> chip.
> 
>> Also that's not entirely relevant, the pinctrl settings can still be written
>> with the chip off because they will go into the regmap cache and be applied
>> when the chip is next resumed.
> 
> You still have the dependencies wrong.
> 
> Yours,
> Linus Walleij
> 

So the short version of this email thread is that it should be "select 
PINCTRL" ?
