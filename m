From: Rob Herring <robh@kernel.org>
Subject: Re: [Patch v6 3/7] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Fri, 13 Oct 2017 14:17:47 -0500
Message-ID: <20171013191747.o7bvb5urs5jt2x4l@rob-hp-laptop>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2017 at 05:51:32PM +0200, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> This controller driver programs manager, interface, and framer
> devices for Qualcomm's slimbus HW block.
> Manager component currently implements logical address setting,
> and messaging interface.
> Interface device reports bus synchronization information, and framer
> device clocks the bus from the time it's woken up, until clock-pause
> is executed by the manager device.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++

Version 6 and this is the first I see it? Where's the version history? 

Please split to separate patch.

>  drivers/slimbus/Kconfig                            |   9 +
>  drivers/slimbus/Makefile                           |   3 +
>  drivers/slimbus/slim-qcom-ctrl.c                   | 594 +++++++++++++++++++++
>  drivers/slimbus/slim-qcom.h                        |  63 +++
>  5 files changed, 712 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>  create mode 100644 drivers/slimbus/slim-qcom-ctrl.c
>  create mode 100644 drivers/slimbus/slim-qcom.h
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> new file mode 100644
> index 0000000..081110d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> @@ -0,0 +1,43 @@
> +Qualcomm SLIMBUS controller
> +This controller is used if applications processor driver controls slimbus
> +master component.
> +
> +Required properties:
> +
> + - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
> + - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
> +
> + - reg : Offset and length of the register region(s) for the device
> + - reg-names : Register region name(s) referenced in reg above
> +	 Required register resource entries are:
> +	 "ctrl": Physical adderess of controller register blocks
> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible or
> + 		"qcom,slim" if using generic qcom SLIM IP.

No such thing as generic IP.

Fine as a fallback, but not by itself.

> + - interrupts : Interrupt number used by this controller
> + - clocks : Interface and core clocks used by this slimbus controller
> + - clock-names : Required clock-name entries are:
> +	"iface_clk" : Interface clock for this controller
> +	"core_clk" : Interrupt for controller core's BAM

_clk is redundant.

> +
> +
> +Optional property:
> + - reg entry for slew rate : If slew rate control register is provided, this
> +	entry should be used.
> + - reg-name for slew rate: "slew"

Pointless to have -name when there is only one.

> +
> +Example:
> +	slim@28080000 {
> +		compatible = "qcom,slim";
> +		#address-cells = <4>;
> +		#size-cells = <0>;
> +		reg = <0x28080000 0x2000>, <0x80207C 4>;
> +		reg-names = "ctrl", "slew";
> +		interrupts = <0 33 0>;
> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names = "iface_clk", "core_clk";
> +
> +		codec: wcd9310@1{
> +			compatible = "slim217,60";
> +			reg = <1 0>;

This would not compile. You don't have 4 cells here.

> +		};
> +	};
