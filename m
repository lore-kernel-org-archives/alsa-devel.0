From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 10/16] gpio: madera: Support Cirrus Logic Madera class
 codecs
Date: Fri, 7 Apr 2017 10:54:29 +0100
Message-ID: <1491558869.4096.43.camel@rf-debian.wolfsonmicro.main>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
         <1491386884-30689-11-git-send-email-rf@opensource.wolfsonmicro.com>
         <CACRpkdatoJOg1U218Q-NteRdz6B+w_yr1PWvnfa1P1EgGm7zug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdatoJOg1U218Q-NteRdz6B+w_yr1PWvnfa1P1EgGm7zug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-04-07 at 11:11 +0200, Linus Walleij wrote:
> On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
> <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> 
> > This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> 
> A bit terse commit message, could you elaborate a bit on their
> specifics?
> 

Sure.

> >  .../devicetree/bindings/gpio/gpio-madera.txt       |  24 +++
> 
> Again should probably be a separate patch. Again, I don't care much
> as long as the DT people are happy.
> 
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
> > @@ -0,0 +1,24 @@
> > +Cirrus Logic Madera class audio codecs gpio driver
> > +
> > +This is a subnode of the parent mfd node.
> > +
> > +See also the core bindings for the parent MFD driver:
> > +See Documentation/devicetree/bindings/mfd/madera.txt
> > +
> > +Required properties:
> > +  - compatible : must be "cirrus,madera-gpio"
> > +  - gpio-controller : Indicates this device is a GPIO controller.
> > +  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
> > +    is reserved for future use and must be zero
> > +
> > +Example:
> > +
> > +codec: cs47l85@0 {
> > +       compatible = "cirrus,cs47l85";
> > +
> > +       gpio {
> > +               compatible = "cirrus,madera-gpio";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       }
> 
> Maybe you want to use the gpio-line-names = ; property in the example
> to show how nice it is to name the lines?
> 

I'll take a look at that.

> > +config GPIO_MADERA
> > +       tristate "Cirrus Logic Madera class codecs"
> > +       depends on MFD_MADERA
> > +       help
> > +         Support for GPIOs on Cirrus Logic Madera class codecs.
> 
> I wonder if you should not depend on the pin controller instead.
> It seems closer and also likely to act as a back-end for the
> GPIOs.
> 
> > +static int madera_gpio_get(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
> > +       struct madera *madera = madera_gpio->madera;
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       ret = regmap_read(madera->regmap,
> > +                         MADERA_GPIO1_CTRL_1 + (2 * offset), &val);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (val & MADERA_GP1_LVL_MASK)
> > +               return 1;
> > +       else
> > +               return 0;
> 
> Just do this:
> 
> return !!(val & MADERA_GP1_LVL_MASK);
> 

Ok. Personally I like the clarity of the more verbose version rather
than the !! but I can change it.

> > +static struct gpio_chip template_chip = {
> > +       .label                  = "madera",
> > +       .owner                  = THIS_MODULE,
> > +       .direction_input        = madera_gpio_direction_in,
> > +       .get                    = madera_gpio_get,
> > +       .direction_output       = madera_gpio_direction_out,
> > +       .set                    = madera_gpio_set,
> > +       .can_sleep              = true,
> > +};
> 
> - Implement .get_direction()
> 

Ok


> Also consider implementing:
> 
> - request/free/set_config looking like this:
> 
> .request = gpiochip_generic_request,
> .free = gpiochip_generic_free,
> .set_config = gpiochip_generic_config,
> 
> If you also implement the corresponding
> .pin_config_set in struct pinconf_ops and
> .gpio_request_enable() and .gpio_disable_free()
> in struct pinmux_ops, you get a pin control back-end
> that will mux in the pins to GPIO mode if they are wrong
> set, and also set up debounce and/or open drain for the
> GPIO line using the standard GPIO callbacks with pin
> control as a back-end.
> 
> If you also specify "strict" in struct pinmux_ops you block
> the collisions between users of GPIO and other functions
> in the pin control driver.
> 
> (Please go back and look at your pin control driver
> for this.)
> 

I'll take a look at these things.

> Example driver using pin control as GPIO back-end:
> drivers/pinctrl/intel/pinctrl-intel.c
> 
> Other than this it looks fine.
> 
> Yours,
> Linus Walleij


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
