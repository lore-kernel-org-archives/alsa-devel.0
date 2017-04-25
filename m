From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 12/18] gpio: madera: Support Cirrus
 Logic Madera class codecs
Date: Tue, 25 Apr 2017 15:44:21 +0100
Message-ID: <1493131461.4826.66.camel@rf-debian.wolfsonmicro.main>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdbhgkwtPygfRL6JXc7syi4MqSUXx2jrVzp7q9FPOWX6OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 598F0266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 16:44:39 +0200 (CEST)
In-Reply-To: <CACRpkdbhgkwtPygfRL6JXc7syi4MqSUXx2jrVzp7q9FPOWX6OQ@mail.gmail.com>
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
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open
 list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-04-25 at 16:13 +0200, Linus Walleij wrote:
> On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
> 
> > This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> > Any pins not used for special functions (see the pinctrl driver) can be
> > used as general single-bit input or output lines. The number of available
> > GPIOs varies between codecs.
> >
> > Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> > Changes from V1:
> > - dt bindings moved to a separate patch
> > - dependent on pinctrl driver instead of parent MFD
> > - added get_direction function
> > - added .request / .free / .set_config to work with pinctrl driver
> > - register range with pinctrl driver
> 
> Nice, but...
> 
> > +       ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
> > +                                    0, 0, madera_gpio->gpio_chip.ngpio);
> > +       if (ret) {
> > +               dev_warn(&pdev->dev, "Failed to add pin range (%d)\n", ret);
> > +               return ret;
> > +       }
> 
> This is all fine, but we have generic code for adding ranges from
> the device tree, see
> Documentation/devicetree/bindings/gpio/gpio.txt
> 

The range of gpio pins is a fixed property of the chip, and so is the
combination of gpio+pinctrl drivers.

I think the general principle of the DT maintainers is that DT should be
used for things that the drivers don't already know and can't figure
out.

> With that this range should not even be needed.
> Apart from that it looks pretty solid.
> 
> Yours,
> Linus Walleij
