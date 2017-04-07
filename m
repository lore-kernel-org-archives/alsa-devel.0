From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/16] mfd: madera: Add register definitions for Cirrus
 Logic Madera codecs
Date: Fri, 7 Apr 2017 11:12:53 +0200
Message-ID: <CACRpkdZLfL+dxMN-uaRp57u4yW4cLfLFoZVkNWFZL4eECOyR1A@mail.gmail.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdaYzPSVqqhbi2Zop7J9vzCqZZiN=9pAEw1vcWy_ove9Tg@mail.gmail.com>
 <CACRpkdY=cOhw59O8EE6J82aq897YKZkLsmUzeEnzkC5jtT6yyA@mail.gmail.com> <20170407084823.GB3412@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170407084823.GB3412@localhost.localdomain>
Sender: linux-gpio-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 7, 2017 at 10:48 AM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Fri, Apr 07, 2017 at 10:30:12AM +0200, Linus Walleij wrote:
>> On Fri, Apr 7, 2017 at 10:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
>> > <rf@opensource.wolfsonmicro.com> wrote:
>> >
>> >> This patch adds a header file of register definitions for Cirrus
>> >> Logic "Madera" class codecs. These codecs are all based off a common
>> >> set of hardware IP so have a common register map (with a few minor
>> >> device-to-device variations). These are complex devices with a large
>> >> mber of features and so have a correspondingly large register set.
>> >> The registers.h file has been auto-generated from the hardware register
>> >> definitions, stripped down to only registers we need to access from
>> >> the driver.
>> >>
>> >> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>> >
>> > This:
>> >  include/linux/mfd/madera/registers.h | 8832 ++++++++++++++++++++++++++++++++++
>> >
>> > Get included in all subdrivers I suppose?
>> >
>> > So you are broadcasting 8800+ lines into every subdriver across the
>> > entire kernel.
>> >
>> > Just the time spent in the preprocessor parsing this will affect compilation
>> > time.
>>
>> Or maybe this is a necessary sacrifice to get the regmap cache
>> centralized in MFD. I don't know. I feel stupid.
>>
>> I guess I should focus on "my" subsystems...
>>
>
> This only gets included in files that are part of this driver, it
> shouldn't affect compilation time for anyone not building the
> madera driver and even then it should only affect compilation
> times for the 10 or so C files that make up the driver. Also I
> don't really see any other way to specify the registers for the
> device.

No when using regmap cache this seems necessary.
I was just wrong.

Yours,
Linus Walleij
