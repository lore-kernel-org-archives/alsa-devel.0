From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 03/18] dt-bindings: mfd: Add bindings for Cirrus Logic
 Madera codecs
Date: Mon, 22 May 2017 18:40:53 +0100
Message-ID: <20170522174053.kdwralsl4pivhkrq@dell>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493050124-5970-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Apr 2017, Richard Fitzgerald wrote:

> Specification of the bindings for the parent MFD driver component
> of the Cirrus Logic Madera codec drivers.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes since V1:
> - split out from main MFD patch
> - moved interrupt control binding descriptions into here
> - added description of the regulator child nodes
> - fixed the node name of the example
> - removed the MICBIAS from the example, these have been removed from the code
> 
>  Documentation/devicetree/bindings/mfd/madera.txt | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
> new file mode 100644
> index 0000000..af9b85f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/madera.txt
> @@ -0,0 +1,96 @@
> +Cirrus Logic Madera class audio codecs multi-function device

Nit: Multi-Functional Device

Other than that:

Acked-by: Lee Jones <lee.jones@linaro.org>

> +These devices are audio SoCs with extensive digital capabilities and a range
> +of analogue I/O.
> +
> +See also the child driver bindings in:
> +bindings/gpio/gpio-madera.txt
> +bindings/pinctrl/cirrus,madera-pinctrl.txt
> +bindings/regulator/arizona-regulator.txt
> +bindings/sound/madera.txt
> +
> +Required properties:
> +
> +  - compatible : One of the following chip-specific strings:
> +        "cirrus,cs47l35"
> +        "cirrus,cs47l85"
> +        "cirrus,cs47l90"
> +        "cirrus,cs47l91"
> +        "cirrus,wm1840"
> +
> +  - reg : I2C slave address when connected using I2C, chip select number when
> +    using SPI.
> +
> +  - DCVDD-supply : Power supply for the device as defined in
> +    bindings/regulator/regulator.txt
> +    Mandatory on CS47L35, CS47L90, CS47L91
> +    Optional on CS47L85, WM1840
> +
> +  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
> +    Power supplies for the device
> +
> +  - DBVDD3-supply, DBVDD4-supply : Power supplies for the device
> +    (CS47L85, CS47L90, CS47L91, WM1840)
> +
> +  - SPKVDDL-supply, SPKVDDR-supply : Power supplies for the device
> +    (CS47L85, WM1840)
> +
> +  - SPKVDD-supply : Power supply for the device
> +    (CS47L35)
> +
> +  - interrupt-controller : Madera class devices contain interrupt controllers
> +    and may provide interrupt services to other devices.
> +
> +  - #interrupt-cells: the number of cells to describe an IRQ, must be 2.
> +    The first cell is the IRQ number.
> +    The second cell is the flags, encoded as the trigger masks from
> +    bindings/interrupt-controller/interrupts.txt
> +
> +  - interrupt-parent : The parent interrupt controller.
> +
> +  - interrupts : The interrupt line the /IRQ signal for the device is
> +    connected to.
> +
> +Optional properties:
> +
> +  - MICVDD-supply : Power supply, only need to be specified if
> +    powered externally
> +
> +  - reset-gpios : One entry specifying the GPIO controlling /RESET.
> +    As defined in bindings/gpio.txt.
> +    Although optional, it is strongly recommended to use a hardware reset
> +
> +  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
> +    Documentation/devicetree/bindings/regulator/regulator.txt.
> +    One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
> +    (all codecs)
> +
> +    One for each output pin (MICBIAS1A, MIBCIAS1B, MICBIAS2A, ...)
> +    (all except CS47L85, WM1840)
> +
> +    The following following additional property is supported for the generator
> +    nodes:
> +      - cirrus,ext-cap : Set to 1 if the MICBIAS has external decoupling
> +        capacitors attached.
> +
> +Optional child nodes:
> +    micvdd : Node containing initialization data for the micvdd regulator
> +    See bindings/regulator/arizona-regulator.txt
> +
> +    ldo1 : Node containing initialization data for the LDO1 regulator
> +    See bindings/regulator/arizona-regulator.txt
> +    (cs47l85, wm1840)
> +
> +Example:
> +
> +cs47l85@0 {
> +	compatible = "cirrus,cs47l85";
> +	reg = <0>;
> +
> +	reset-gpios = <&gpio 0>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	interrupts = <&host_irq1>;
> +	interrupt-parent = <&gic>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
