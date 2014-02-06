From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 0/8] da9055: Driver initialisation fixes, add DT support
Date: Wed, 5 Feb 2014 16:54:06 -0800
Message-ID: <20140206005406.GC1308@roeck-us.net>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1391614923.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 05, 2014 at 05:48:28PM +0000, Adam Thomson wrote:
> This patch series provides the following updates for DA9055 drivers:
> 
>  - Fixes an issue with da9055 driver initialisation (conflicting device ids) of
>    PMIC (MFD) and CODEC drivers.
>  - Add initial DT support for DA9055 related drivers, including binding
>    documentation.
>  - Remove conflicting use of platform_get_irq_byname() in driver probes.

Adam,

You don't really explain what the problem actually is. Can you elaborate ?

Also, I have been using platform_get_irq() to get the interrupt resource
in mfd client drivers and similar situations. Wouldn't this work here as well
if you don't want to use platform_get_irq_byname() ?

Thanks,
Guenter

>  - Remove unnecessary resource structures for MFD cells as a result of removing
>    use of platform_get_irq_byname().
> 
> Adam Thomson (8):
>   ASoC: da9055: Fix device registration of PMIC and CODEC devices
>   ASoC: da9055: Add DT support for CODEC
>   mfd: da9055: Add DT support for PMIC
>   regulator: da9055: Add DT support
>   onkey: da9055: Remove use of platform_get_irq_byname()
>   hwmon: da9055: Remove use of platform_get_irq_byname()
>   rtc: da9055: Remove use of platform_get_irq_byname()
>   mfd: da9055: Remove unused resource structures for mfd cells.
> 
>  Documentation/devicetree/bindings/mfd/da9055.txt   |   73 ++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/da9055.txt |   22 ++++++
>  drivers/hwmon/da9055-hwmon.c                       |    7 +--
>  drivers/input/misc/da9055_onkey.c                  |    9 +--
>  drivers/mfd/da9055-core.c                          |   46 ------------
>  drivers/mfd/da9055-i2c.c                           |   20 +++++-
>  drivers/regulator/da9055-regulator.c               |   59 ++++++++++++++--
>  drivers/rtc/rtc-da9055.c                           |    3 +-
>  sound/soc/codecs/da9055.c                          |   19 +++++-
>  9 files changed, 188 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9055.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
