From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/8] mfd: da9055: Add DT support for PMIC
Date: Fri, 7 Feb 2014 11:03:20 +0000
Message-ID: <20140207110320.GM14727@lee--X1>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <46f41a14205ac39de3adb8c87d2a6dba557ad8d1.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46f41a14205ac39de3adb8c87d2a6dba557ad8d1.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9055.txt |   73 ++++++++++++=
++++++++++
>  drivers/mfd/da9055-i2c.c                         |    8 +++

Can you break this up please.

Bindings should be separate to the binding document.

>  2 files changed, 81 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9055.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9055.txt b/Docum=
entation/devicetree/bindings/mfd/da9055.txt
> new file mode 100644
> index 0000000..f903c3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/da9055.txt
> @@ -0,0 +1,73 @@
> +* Dialog DA9055 Power Management Integrated Circuit (PMIC)
> +
> +DA9055 consists of a large and varied group of sub-devices (I2C Only=
):
> +
> +Device			 Supply Names	 Description
> +------			 ------------	 -----------
> +da9055-gpio		:		: GPIOs
> +da9055-regulator	:		: Regulators
> +da9055-onkey		:		: On key
> +da9055-rtc		:		: RTC
> +da9055-hwmon		:		: ADC
> +da9055-watchdog		:		: Watchdog
> +
> +The CODEC device in DA9055 has a separate, configurable I2C address =
and so
> +is instantiated separately from the PMIC.
> +
> +For details on accompanying CODEC I2C device, see the following:
> +Documentation/devicetree/bindings/sound/da9055.txt
> +
> +=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +- compatible : Should be "dlg,da9055-pmic"
> +- reg: Specifies the I2C slave address (defaults to 0x5a but can be =
modified)
> +- interrupt-parent: Specifies the phandle of the interrupt controlle=
r to which
> +  the IRQs from da9055 are delivered to.
> +- interrupts: IRQ line info for da9055 chip.
> +- interrupt-controller: da9055 has internal IRQs (has own IRQ domain=
).
> +- #interrupt-cells: Should be 1, is the local IRQ number for da9055.
> +
> +Sub-nodes:
> +- regulators : Contain the regulator nodes. The DA9055 regulators ar=
e
> +  bound using their names as listed below:
> +
> +    buck1     : regulator BUCK1
> +    buck2     : regulator BUCK2
> +    ldo1      : regulator LDO1
> +    ldo2      : regulator LDO2
> +    ldo3      : regulator LDO3
> +    ldo4      : regulator LDO4
> +    ldo5      : regulator LDO5
> +    ldo6      : regulator LDO6
> +
> +  The bindings details of individual regulator device can be found i=
n:
> +  Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +
> +Example:
> +
> +	pmic: da9055-pmic@5a {
> +		compatible =3D "dlg,da9055-pmic";
> +		reg =3D <0x5a>;
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <5 0x8>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-min-microvolt =3D <725000>;
> +				regulator-max-microvolt =3D <2075000>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-min-microvolt =3D <925000>;
> +				regulator-max-microvolt =3D <2500000>;
> +			};
> +			ldo1: LDO1 {
> +				regulator-min-microvolt =3D <900000>;
> +				regulator-max-microvolt =3D <3300000>;
> +			};
> +		};
> +	};
> diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
> index 8103e43..366a3e2 100644
> --- a/drivers/mfd/da9055-i2c.c
> +++ b/drivers/mfd/da9055-i2c.c
> @@ -15,6 +15,8 @@
>  #include <linux/device.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>=20
>  #include <linux/mfd/da9055/core.h>
>=20
> @@ -66,6 +68,11 @@ static struct i2c_device_id da9055_i2c_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
>=20
> +static const struct of_device_id da9055_of_match[] =3D {
> +	{ .compatible =3D "dlg,da9055-pmic", .data =3D (void *)&da9055_i2c_=
id[0] },

Entangling the i2c_device_id table with the of_device_id table sounds
a bit too wacky for my liking. Where do you even use it?

> +	{ }
> +};
> +
>  static struct i2c_driver da9055_i2c_driver =3D {
>  	.probe =3D da9055_i2c_probe,
>  	.remove =3D da9055_i2c_remove,
> @@ -73,6 +80,7 @@ static struct i2c_driver da9055_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "da9055-pmic",
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(da9055_of_match),
>  	},
>  };
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
