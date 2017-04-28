From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 12/18] gpio: madera: Support Cirrus
	Logic Madera class codecs
Date: Fri, 28 Apr 2017 09:46:49 +0200
Message-ID: <CACRpkdbkvG+P2=4yPgQdo4cfZ708QbzdT=GSw_EcZP9K+BeHVA@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdbhgkwtPygfRL6JXc7syi4MqSUXx2jrVzp7q9FPOWX6OQ@mail.gmail.com>
 <1493131461.4826.66.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F52D26680F
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 09:46:51 +0200 (CEST)
Received: by mail-it0-f41.google.com with SMTP id f187so31734058ite.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 00:46:51 -0700 (PDT)
In-Reply-To: <1493131461.4826.66.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 25, 2017 at 4:44 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:
> On Tue, 2017-04-25 at 16:13 +0200, Linus Walleij wrote:
>> On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
>> <rf@opensource.wolfsonmicro.com> wrote:
>>
>> > This adds support for the GPIOs on Cirrus Logic Madera class codecs.
>> > Any pins not used for special functions (see the pinctrl driver) can be
>> > used as general single-bit input or output lines. The number of available
>> > GPIOs varies between codecs.
>> >
>> > Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
>> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>> > ---
>> > Changes from V1:
>> > - dt bindings moved to a separate patch
>> > - dependent on pinctrl driver instead of parent MFD
>> > - added get_direction function
>> > - added .request / .free / .set_config to work with pinctrl driver
>> > - register range with pinctrl driver
>>
>> Nice, but...
>>
>> > +       ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
>> > +                                    0, 0, madera_gpio->gpio_chip.ngpio);
>> > +       if (ret) {
>> > +               dev_warn(&pdev->dev, "Failed to add pin range (%d)\n", ret);
>> > +               return ret;
>> > +       }
>>
>> This is all fine, but we have generic code for adding ranges from
>> the device tree, see
>> Documentation/devicetree/bindings/gpio/gpio.txt
>>
>
> The range of gpio pins is a fixed property of the chip, and so is the
> combination of gpio+pinctrl drivers.

Well so is the IRQ number, but we still put that in the device tree.

> I think the general principle of the DT maintainers is that DT should be
> used for things that the drivers don't already know and can't figure
> out.

It's a grayzone. People use ranges in the device tree for example when
there are several instances of the same GPIO block with different
ranges into a single pin controller and then it makes sense.

But in this case you have your separate chip with one instance so
it doesn't make sense, keep it like this.

Also it is necessary to proble from boardfiles as you explained in the
pinctrl patch.

Good job, it's a nice driver. Also the pinctrl driver is very nice.

Yours,
Linus Walleij
