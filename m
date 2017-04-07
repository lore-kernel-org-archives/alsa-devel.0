From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 09/16] pinctrl: madera: Add driver for Cirrus Logic
 Madera codecs
Date: Fri, 7 Apr 2017 10:43:04 +0100
Message-ID: <1491558184.4096.35.camel@rf-debian.wolfsonmicro.main>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
         <1491386884-30689-10-git-send-email-rf@opensource.wolfsonmicro.com>
         <CACRpkdZK3QXu4t2jud0-LPDj0LDVruAm33N4Lazjk44C3ndwwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZK3QXu4t2jud0-LPDj0LDVruAm33N4Lazjk44C3ndwwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-04-07 at 10:54 +0200, Linus Walleij wrote:
> On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
> <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> 
> > These codecs have a variable number of I/O lines each of which
> > is individually selectable to a wide range of possible functions.
> >
> > The functionality is slightly different from the traditional muxed
> > GPIO since most of the functions can be mapped to any pin (and even
> > the same function to multiple pins). Most pins have a dedicated
> > "alternate" function that is only available on that pin. The
> > alternate functions are usually a group of signals, though it is
> > not always necessary to enable the full group, depending on the
> > alternate function and how it is to be used. The mapping between
> > alternate functions and GPIO pins varies between codecs depending
> > on the number of alternate functions and available pins.
> >
> > Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> 
> >  .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  103 ++
> 
> This should ideally be split into its own patch but I don't care
> much if the DT people are happy.
> 
> > +See also
> > +  the core bindings for the parent MFD driver:
> > +    Documentation/devicetree/bindings/mfd/madera.txt
> > +
> > +  the generic pinmix bindings:
> > +    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> 
> Nice.
> 
> > +Required properties of parent mfd node:
> > +  - pinctrl-names : must be "defaults"
> 
> Do you mean "default"

Yes. I'll fix that.

> 
> Apart from this the bindings and example look very good to
> me, good job! I like it when people "just get it" with pin control
> and that is where we need to be with this subsystem.
> 
> > +config PINCTRL_MADERA
> > +       bool
> > +       default y if MFD_MADERA=y
> 

There was something special to do with the way dependencies are
processed, but I can't remember right now what that was. I'd have to
take another look at this to see if this "default y" pattern is still
necessary for this driver.

> Isn't it even proper for MFD_MADERA to explicitly
> select this driver. I see it hard how the chip would even
> work without this. (Maybe it already does select it but then
> default y is not necessary.)
> > +config PINCTRL_CS47L35
> > +       bool
> > +       default y if MFD_CS47L35=y
> 
> Similar comment for the subdrivers.
> 
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_AMD)     += pinctrl-amd.o
> >  obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
> >  obj-$(CONFIG_PINCTRL_DIGICOLOR)        += pinctrl-digicolor.o
> >  obj-$(CONFIG_PINCTRL_FALCON)   += pinctrl-falcon.o
> > +obj-$(CONFIG_PINCTRL_MADERA)   += pinctrl-madera.o
> 
> Is it all in one file... despite all the Kconfig symbols... hm.
> I guess we can create drivers/pinctrl/cirrus the day we need more
> space.
> 

I have no objection to moving the source into pinctrl/cirrus

> > +/*
> > + * Pins are named after their GPIO number
> 
> So don't they have real names? Like the pin name on the underside of
> the chip? That is what this naming convention is actually for.
> 

Those are real names. Each pin is dual labelled with a "GPIOn" name and
also its alternate function (if it has one). The mapping of alternate
functions to GPIO pins isn't 1:1 across codecs. The GPIOn name is
consistent across codecs. If your pinctrl config is needing to refer to
the pin name, instead of the alternate function group, it can only be to
use it as a GPIO so the GPIO name is more relevant. This is what I was
trying to imply in my comment but using fewer words.

> > +/*
> > + * All single-pin functions can be mapped to any GPIO, however pinmux applies
> > + * functions to pin groups and only those groups declared as supporting that
> > + * function. To make this work we must put each pin in its own dummy group so
> > + * that the functions can be described as applying to all pins.
> > + * Since these do not correspond to anything in the actual hardware - they are
> > + * merely an adaptation to pinctrl's view of the world - we use the same name
> > + * as the pin to avoid confusion when comparing with datasheet instructions
> > + */
> > +static const char * const madera_pin_single_group_names[] = {
> > +       "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",  "gpio7",
> > +       "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
> > +       "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
> > +       "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
> > +       "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
> > +       "gpio36", "gpio37", "gpio38", "gpio39", "gpio40",
> > +};
> 
> If they are called "gpioN" in the datasheet I guess it is all right.
> That is how e.g. the Qualcomm driver is done.
> 
> > +#ifdef CONFIG_PINCTRL_CS47L85
> 
> So this makes me feel maybe we should create drivers/pinctrl/cirrus
> and split this driver into subdrivers per chip like others do.
> 
> The coding style document does say that ifdefs are ugly.
> 
> Would you consider splitting it up?
> 

I can do that.

> > +static void madera_pin_dbg_show(struct pinctrl_dev *pctldev,
> > +                               struct seq_file *s,
> > +                               unsigned int offset)
> > +{
> > +       seq_puts(s, " madera-pinctrl");
> > +}
> 
> I don't think the pinctrl debugfs callback is compulsory.
> It would be nice if this added some actual useful information
> about the pin.
> 

Yes, I'll add some info

> 
> > +               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +                       mask[0] |= MADERA_GP1_OP_CFG_MASK;
> > +                       conf[0] |= MADERA_GP1_OP_CFG;
> > +                       break;
> > +               case PIN_CONFIG_DRIVE_PUSH_PULL:
> > +                       mask[0] |= MADERA_GP1_OP_CFG_MASK;
> > +                       conf[0] &= ~MADERA_GP1_OP_CFG;
> > +                       break;
> 
> This will be possible to reuse from a GPIO driver as back-end, nice!
> 
> 
> > +               case PIN_CONFIG_INPUT_DEBOUNCE:
> > +                       mask[0] |= MADERA_GP1_DB_MASK;
> > +
> > +                       /*
> > +                        * we can't configure debounce time per-pin so value
> > +                        * is just a flag
> > +                        */
> > +                       val = pinconf_to_config_argument(*configs);
> > +                       if (val)
> > +                               conf[0] |= MADERA_GP1_DB;
> > +                       else
> > +                               conf[0] &= ~MADERA_GP1_DB;
> > +                       break;
> 
> This too.
> 
> Overall it looks very nice.
> 
> Yours,
> Linus Walleij


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
