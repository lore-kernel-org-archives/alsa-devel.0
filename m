From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver for Cirrus
 Logic Madera codecs
Date: Mon, 10 Apr 2017 12:49:17 -0500
Message-ID: <20170410174917.dlklrvw2sraeq6xs@rob-hp-laptop>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.org, broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2017 at 11:07:54AM +0100, Richard Fitzgerald wrote:
> This patch adds a driver for the internal LDO1 regulator on
> some Cirrus Logic Madera class codecs.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  .../devicetree/bindings/regulator/madera-ldo1.txt  |  29 +++

cirrus-madera-ldo1.txt

Or perhaps a subdirectory. We should have done the same for arizona 
bindings.

Same question as Mark. Should this share bindings with arizona? The 
arizona one looks a bit strange, so not sure we'd want to just copy it.

>  MAINTAINERS                                        |   3 +
>  drivers/regulator/Kconfig                          |   8 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/madera-ldo1.c                    | 198 +++++++++++++++++++++
>  include/linux/regulator/madera-ldo1.h              |  24 +++
>  6 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/madera-ldo1.txt
>  create mode 100644 drivers/regulator/madera-ldo1.c
>  create mode 100644 include/linux/regulator/madera-ldo1.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/madera-ldo1.txt b/Documentation/devicetree/bindings/regulator/madera-ldo1.txt
> new file mode 100644
> index 0000000..688f21d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/madera-ldo1.txt
> @@ -0,0 +1,29 @@
> +Cirrus Logic Madera class audio codecs LDO1 regulator driver
> +
> +Only required if you are using the codec internal LDO1 regulator.
> +This is a subnode of the parent mfd node.
> +
> +See also the core bindings for the parent MFD driver:
> +See Documentation/devicetree/bindings/mfd/madera.txt
> +
> +Required properties:
> +  - compatible :  must be "cirrus,madera-ldo1"
> +  - LDOVDD-supply : Power supply for the LDO1 regulator.
> +
> +  - enable-gpio	: GPIO to use to enable/disable the regulator.

enable-gpios

And define whether active high or low.

> +    As defined in bindings/gpio.txt.
> +
> +Optional subnodes:
> +  Standard regulator bindings as described in bindings/regulator/regulator.txt
> +
> +Example:
> +
> +codec: cs47l85@0 {
> +	compatible = "cirrus,cs47l85";
> +
> +	ldo1 {
> +		compatible = "cirrus,madera-ldo1";
> +		LDOVDD-supply = <&pmic_vdd1>;
> +		enable-gpio = <&gpio 0>;
> +	};
> +};
