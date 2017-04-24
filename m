From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/16] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
Date: Mon, 24 Apr 2017 11:03:52 +0100
Message-ID: <20170424100352.emgsv5akhfz3a7gg@dell>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-3-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170412125455.qi6rilfy2bffbxtp@dell>
 <1492620124.4826.47.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492620124.4826.47.camel-WeElTRBN8n0bEPBeyYQi64iQ8/zYDDdY1BehtkLrGTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Apr 2017, Richard Fitzgerald wrote:

> On Wed, 2017-04-12 at 13:54 +0100, Lee Jones wrote:
> > On Wed, 05 Apr 2017, Richard Fitzgerald wrote:
> > 
> > > This adds the generic core support for Cirrus Logic "Madera" class codecs.
> > > These are complex audio codec SoCs with a variety of digital and analogue
> > > I/O, onboard audio processing and DSPs, and other features.
> > > 
> > > These codecs are all based off a common set of hardware IP so can be
> > > supported by a core of common code (with a few minor device-to-device
> > > variations).
> > > 
> > > Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > > Signed-off-by: Nikesh Oswal <Nikesh.Oswal-UVNVL95qEvAciDkP5Hr2oA@public.gmane.org>
> > > Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/madera.txt |  79 +++
> > >  MAINTAINERS                                      |   3 +
> > >  drivers/mfd/Kconfig                              |  23 +
> > >  drivers/mfd/Makefile                             |   4 +
> > >  drivers/mfd/madera-core.c                        | 689 +++++++++++++++++++++++
> > >  drivers/mfd/madera-i2c.c                         | 130 +++++
> > >  drivers/mfd/madera-spi.c                         | 131 +++++
> > >  drivers/mfd/madera.h                             |  52 ++
> > >  include/linux/mfd/madera/core.h                  | 175 ++++++
> > >  include/linux/mfd/madera/pdata.h                 |  88 +++
> > >  10 files changed, 1374 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
> > >  create mode 100644 drivers/mfd/madera-core.c
> > >  create mode 100644 drivers/mfd/madera-i2c.c
> > >  create mode 100644 drivers/mfd/madera-spi.c
> > >  create mode 100644 drivers/mfd/madera.h
> > >  create mode 100644 include/linux/mfd/madera/core.h
> > >  create mode 100644 include/linux/mfd/madera/pdata.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
> > > new file mode 100644
> > > index 0000000..a6c3260
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/madera.txt
> > > @@ -0,0 +1,79 @@
> > > +Cirrus Logic Madera class audio codecs multi-function device
> > > +
> > > +These devices are audio SoCs with extensive digital capabilities and a range
> > > +of analogue I/O.
> > > +
> > > +See also the child driver bindings in:
> > > +bindings/extcon/extcon-madera.txt
> > > +bindings/gpio/gpio-madera.txt
> > > +bindings/interrupt-controller/cirrus,madera.txt
> > > +bindings/pinctrl/cirrus,madera-pinctrl.txt
> > > +bindings/regulator/madera-ldo1.txt
> > > +bindings/regulator/madera-micsupp.txt
> > > +bindings/sound/madera.txt
> > > +
> > > +Required properties:
> > > +
> > > +  - compatible : One of the following chip-specific strings:
> > > +        "cirrus,cs47l35"
> > > +        "cirrus,cs47l85"
> > > +        "cirrus,cs47l90"
> > > +        "cirrus,cs47l91"
> > > +        "cirrus,wm1840"
> > > +
> > > +  - reg : I2C slave address when connected using I2C, chip select number when
> > > +    using SPI.
> > > +
> > > +  - DCVDD-supply : Power supply for the device as defined in
> > > +    bindings/regulator/regulator.txt
> > > +    Mandatory on CS47L35, CS47L90, CS47L91
> > > +    Optional on CS47L85, WM1840
> > > +
> > > +  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
> > > +    Power supplies for the device
> > > +
> > > +  - DBVDD3-supply, DBVDD4-supply : Power supplies for the device
> > > +    (CS47L85, CS47L90, CS47L91, WM1840)
> > > +
> > > +  - SPKVDDL-supply, SPKVDDR-supply : Power supplies for the device
> > > +    (CS47L85, WM1840)
> > > +
> > > +  - SPKVDD-supply : Power supply for the device
> > > +    (CS47L35)
> > > +
> > > +Optional properties:
> > > +
> > > +  - MICVDD-supply : Power supply, only need to be specified if
> > > +    powered externally
> > > +
> > > +  - reset-gpios : One entry specifying the GPIO controlling /RESET.
> > > +    As defined in bindings/gpio.txt.
> > > +    Although optional, it is strongly recommended to use a hardware reset
> > > +
> > > +  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
> > > +    Documentation/devicetree/bindings/regulator/regulator.txt.
> > > +    One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
> > > +    (all codecs)
> > > +
> > > +    One for each output pin (MICBIAS1A, MIBCIAS1B, MICBIAS2A, ...)
> > > +    (all except CS47L85, WM1840)
> > > +
> > > +    The following following additional property is supported for the generator
> > > +    nodes:
> > > +      - cirrus,ext-cap : Set to 1 if the MICBIAS has external decoupling
> > > +        capacitors attached.
> > > +
> > > +Example:
> > > +
> > > +codec: cs47l85@0 {
> > 
> > Node names should be generic.
> > 
> > You can swap these round if you want, so:
> > 
> > cs47l85: codec@0 {
> > 
> > ... is valid.
> > 
> > > +	compatible = "cirrus,cs47l85";
> > > +	reg = <0>;
> > > +
> > > +	reset-gpios = <&gpio 0>;
> > > +
> > > +	MICBIAS1 {
> > > +		regulator-min-microvolt = <900000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		cirrus,ext-cap = <1>;
> > > +	};
> > > +};
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 02995c9..d28e53f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3266,7 +3266,10 @@ L:	patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
> > >  T:	git https://github.com/CirrusLogic/linux-drivers.git
> > >  W:	https://github.com/CirrusLogic/linux-drivers/wiki
> > >  S:	Supported
> > > +F:	Documentation/devicetree/bindings/mfd/madera.txt
> > >  F:	include/linux/mfd/madera/*
> > > +F:	drivers/mfd/madera*
> > > +F:	drivers/mfd/cs47l*
> > >  
> > >  CLEANCACHE API
> > >  M:	Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index ce3a918..f0f9979 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -203,6 +203,29 @@ config MFD_CROS_EC_SPI
> > >  	  response time cannot be guaranteed, we support ignoring
> > >  	  'pre-amble' bytes before the response actually starts.
> > >  
> > > +config MFD_MADERA
> > > +	bool
> > > +	select REGMAP
> > > +	select MFD_CORE
> > > +
> > > +config MFD_MADERA_I2C
> > > +	tristate "Cirrus Logic Madera codecs with I2C"
> > > +	select MFD_MADERA
> > > +	select REGMAP_I2C
> > > +	depends on I2C
> > > +	help
> > > +	  Support for the Cirrus Logic Madera platform audio SoC
> > > +	  core functionality controlled via I2C.
> > > +
> > > +config MFD_MADERA_SPI
> > > +	tristate "Cirrus Logic Madera codecs with SPI"
> > > +	select MFD_MADERA
> > > +	select REGMAP_SPI
> > > +	depends on SPI_MASTER
> > > +	help
> > > +	  Support for the Cirrus Logic Madera platform audio SoC
> > > +	  core functionality controlled via SPI.
> > > +
> > >  config MFD_ASIC3
> > >  	bool "Compaq ASIC3"
> > >  	depends on GPIOLIB && ARM
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index fa86dbe..c41f6c9 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -72,6 +72,10 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
> > >  wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
> > >  obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
> > >  
> > > +obj-$(CONFIG_MFD_MADERA)	+= madera-core.o
> > > +obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
> > > +obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
> > > +
> > >  obj-$(CONFIG_TPS6105X)		+= tps6105x.o
> > >  obj-$(CONFIG_TPS65010)		+= tps65010.o
> > >  obj-$(CONFIG_TPS6507X)		+= tps6507x.o
> > > diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> > > new file mode 100644
> > > index 0000000..ab5fe9b
> > > --- /dev/null
> > > +++ b/drivers/mfd/madera-core.c
> > > @@ -0,0 +1,689 @@
> > > +/*
> > > + * Core MFD support for Cirrus Logic Madera codecs
> > > + *
> > > + * Copyright 2015-2017 Cirrus Logic
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/gpio.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/regulator/machine.h>
> > > +#include <linux/regulator/of_regulator.h>
> > > +
> > > +#include <linux/mfd/madera/core.h>
> > > +#include <linux/mfd/madera/registers.h>
> > > +
> > > +#include "madera.h"
> > > +
> > > +#define CS47L35_SILICON_ID	0x6360
> > > +#define CS47L85_SILICON_ID	0x6338
> > > +#define CS47L90_SILICON_ID	0x6364
> > > +
> > > +#define MADERA_32KZ_MCLK2	1
> > > +
> > > +static const char * const madera_core_supplies[] = {
> > > +	"AVDD",
> > > +	"DBVDD1",
> > > +};
> > > +
> > > +static const struct mfd_cell madera_ldo1_devs[] = {
> > > +	{ .name = "madera-ldo1", .of_compatible = "cirrus,madera-ldo1" },
> > > +};
> > > +
> > > +static const struct mfd_cell cs47l35_devs[] = {
> > > +	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
> > > +	{ .name = "madera-irq", },
> > 
> > I believe this should be "interrupt-controller".
> > 
> 
> I don't think that's the case. I checked other irchip drivers and they
> have no particular standard naming. At least one is called
> "something-irq", none are called "something-interrupt-controller"
> 
> > irq is ambiguous.
> > 
> 
> I can't really see what other driver this could be confused with,
> especially as it's specified as madera-* so the alternative drivers are
> limited. Given the limited set of drivers I think it's clear enough it's
> the driver for the IRQ and a longer name doesn't add information.
> 
> > Same goes for the ones below.
> > 
> 
> Ditto. madera-micsupp will be replaced by the existing arizona-micsupp.
> Most gpio drivers are called "something-gpio". Extcon is the name of a
> driver subsystem so should be sufficiently clear. Likewise madera-codec.

I meant just the "-irq" entries.

... but I'm not 100% convinced that calling it "-irq" a terrible idea,
just that "irq-controller" or "interrupt-controller" would be better.

Either way, it's not a blocking point.

> > > +	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
> > > +	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
> > > +	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
> > > +	{ .name = "cs47l35-codec",  .of_compatible = "cirrus,cs47l35-codec" },
> > > +	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
> > > +};
> > > +
> > > +static const struct mfd_cell cs47l85_devs[] = {
> > > +	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
> > > +	{ .name = "madera-irq", },
> > > +	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
> > > +	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
> > > +	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
> > > +	{ .name = "cs47l85-codec",  .of_compatible = "cirrus,cs47l85-codec" },
> > > +	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
> > > +};
> > > +
> > > +static const struct mfd_cell cs47l90_devs[] = {
> > > +	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
> > > +	{ .name = "madera-irq", },
> > > +	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
> > > +	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
> > > +	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
> > > +	{ .name = "cs47l90-codec",  .of_compatible = "cirrus,cs47l90-codec" },
> > > +	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
> > > +};
> > > +
> > > +const char *madera_name_from_type(enum madera_type type)
> > > +{
> > > +	switch (type) {
> > > +	case CS47L35:
> > > +		return "CS47L35";
> > > +	case CS47L85:
> > > +		return "CS47L85";
> > > +	case CS47L90:
> > > +		return "CS47L90";
> > > +	case CS47L91:
> > > +		return "CS47L91";
> > > +	case WM1840:
> > > +		return "WM1840";
> > > +	default:
> > > +		return "Unknown";
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(madera_name_from_type);
> > > +
> > > +#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
> > > +#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
> > > +
> > > +static int madera_wait_for_boot(struct madera *madera)
> > > +{
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * We can't use an interrupt as we need to runtime resume to do so,
> > > +	 * so we poll the status bit. This won't race with the interrupt
> > > +	 * handler because it will be blocked on runtime resume.
> > > +	 */
> > > +	ret = regmap_read_poll_timeout(madera->regmap,
> > > +				       MADERA_IRQ1_RAW_STATUS_1,
> > > +				       val,
> > > +				       (val & MADERA_BOOT_DONE_STS1),
> > > +				       MADERA_BOOT_POLL_MAX_INTERVAL_US,
> > > +				       MADERA_BOOT_POLL_TIMEOUT_US);
> > > +	/*
> > > +	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
> > > +	 * Do this unconditionally to avoid interrupt storms
> > > +	 */
> > > +	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
> > > +		     MADERA_BOOT_DONE_EINT1);
> > > +
> > > +	if (ret)
> > > +		dev_err(madera->dev, "Polling BOOT_DONE_STS failed: %d\n", ret);
> > 
> > Why isn't this under the call to regmap_read_poll_timeout()?
> > 
> 
> It was intended to make it clear that we must ack the BOOT_DONE now no
> matter what and to avoid the potential with them the other way around of
> someone adding more code in the if (or just a ret) and so accidentally
> failing to do the ack. I could swap them but I think I prefer keeping
> them this way and changing the comment to say this.

Okay.

I'm going to assume that we are in agreement for all points that you
did not answer (which is good).  I look forward to the next version.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
