From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: arizona: Support Cirrus Logic CS47L24 and
 WM1831
Date: Fri, 30 Oct 2015 18:29:41 +0000
Message-ID: <20151030182941.GI4058@x1>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1445264027-7357-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445264027-7357-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: linus.walleij@linaro.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Oct 2015, Richard Fitzgerald wrote:

> This patch adds the regmap configuration tables and
> core MFD handling for the CS47L24 and WM1831 codecs.
>=20
> Note that compared to the other Arizona codecs, these devices
> do not have an LDO1 or micsupp regulators, extcon driver, or
> the DCVDD isolation control.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt |    4 +-

Separate patch please.

>  drivers/mfd/Kconfig                               |   19 +-
>  drivers/mfd/Makefile                              |    3 +
>  drivers/mfd/arizona-core.c                        |   74 +-
>  drivers/mfd/arizona-irq.c                         |   40 +-
>  drivers/mfd/arizona-spi.c                         |    7 +
>  drivers/mfd/arizona.h                             |    4 +
>  drivers/mfd/cs47l24-tables.c                      | 1629 +++++++++++=
++++++++++
>  include/linux/mfd/arizona/core.h                  |    3 +
>  9 files changed, 1757 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/mfd/cs47l24-tables.c
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Docu=
mentation/devicetree/bindings/mfd/arizona.txt
> index a8fee60..73f28fa 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -1,4 +1,4 @@
> -Wolfson Arizona class audio SoCs
> +Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
> =20
>  These devices are audio SoCs with extensive digital capabilites and =
a range
>  of analogue I/O.
> @@ -12,6 +12,8 @@ Required properties:
>          "wlf,wm8997"
>          "wlf,wm8998"
>          "wlf,wm1814"
> +        "wlf,wm1831"
> +        "cirrus,cs47l24"
> =20
>    - reg : I2C slave address when connected using I2C, chip select nu=
mber when
>      using SPI.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4d92df6..d25bbb3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1370,24 +1370,24 @@ config MFD_ARIZONA
>  	bool
> =20
>  config MFD_ARIZONA_I2C
> -	tristate "Wolfson Microelectronics Arizona platform with I2C"
> +	tristate "Cirrus Logic/Wolfson Microelectronics Arizona platform wi=
th I2C"
>  	select MFD_ARIZONA
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	depends on I2C
>  	help
> -	  Support for the Wolfson Microelectronics Arizona platform audio S=
oC
> -	  core functionality controlled via I2C.
> +	  Support for the Cirrus Logic/Wolfson Microelectronics Arizona pla=
tform
> +	  audio SoC core functionality controlled via I2C.
> =20
>  config MFD_ARIZONA_SPI
> -	tristate "Wolfson Microelectronics Arizona platform with SPI"
> +	tristate "Cirrus Logic/Wolfson Microelectronics Arizona platform wi=
th SPI"
>  	select MFD_ARIZONA
>  	select MFD_CORE
>  	select REGMAP_SPI
>  	depends on SPI_MASTER
>  	help
> -	  Support for the Wolfson Microelectronics Arizona platform audio S=
oC
> -	  core functionality controlled via I2C.
> +	  Support for the Cirrus Logic/Wolfson Microelectronics Arizona pla=
tform
> +	  audio SoC core functionality controlled via I2C.
> =20
>  config MFD_WM5102
>  	bool "Wolfson Microelectronics WM5102"
> @@ -1414,6 +1414,13 @@ config MFD_WM8998
>  	help
>  	  Support for Wolfson Microelectronics WM8998 low power audio SoC
> =20
> +config MFD_CS47L24
> +	bool "Cirrus Logic CS47L24 and WM1831"
> +	depends on MFD_ARIZONA
> +	help
> +	  Support for Cirrus Logic CS47L24 and WM1831 low power audio SoC
> +
> +

Superflous '\n'.

[...]

> diff --git a/drivers/mfd/cs47l24-tables.c b/drivers/mfd/cs47l24-table=
s.c
> new file mode 100644
> index 0000000..f877586
> --- /dev/null
> +++ b/drivers/mfd/cs47l24-tables.c
> @@ -0,0 +1,1629 @@
> +/*
> + * cs47l24-tables.c  --  data tables for CS47L24 codec

Please remove this filename.

They have a habit of becoming unaligned.

> + * Copyright 2015 Cirrus Logic, Inc.
> + *
> + * Author: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
