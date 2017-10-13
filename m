From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Fri, 13 Oct 2017 14:26:43 -0500
Message-ID: <20171013192643.lw6w2qs2bcs66hyx@rob-hp-laptop>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-2-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
> channels, and control channel. Control channel has messages to do
> device-enumeration, messages to send/receive control-data to/from
> slimbus devices, messages for port/channel management, and messages to
> do bandwidth allocation.
> The framework supports multiple instances of the bus (1 controller per
> bus), and multiple slave devices per controller.
> 
> This patch does device enumeration, logical address assignment,
> informing device when the device reports present/absent etc.
> Reporting present may need the driver to do the needful (e.g. turning
> on voltage regulators powering the device). Additionally device is
> probed when it reports present if that device doesn't need any such
> steps mentioned above.
> 
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++

Split to separate patch.

>  Documentation/slimbus/summary                     | 109 ++++
>  drivers/Kconfig                                   |   2 +
>  drivers/Makefile                                  |   1 +
>  drivers/slimbus/Kconfig                           |  11 +
>  drivers/slimbus/Makefile                          |   5 +
>  drivers/slimbus/slim-core.c                       | 695 ++++++++++++++++++++++
>  include/linux/mod_devicetable.h                   |  13 +
>  include/linux/slimbus.h                           | 299 ++++++++++
>  9 files changed, 1192 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>  create mode 100644 Documentation/slimbus/summary
>  create mode 100644 drivers/slimbus/Kconfig
>  create mode 100644 drivers/slimbus/Makefile
>  create mode 100644 drivers/slimbus/slim-core.c
>  create mode 100644 include/linux/slimbus.h
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
> new file mode 100644
> index 0000000..cb658bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/slimbus/bus.txt
> @@ -0,0 +1,57 @@
> +SLIM(Serial Low Power Interchip Media Bus) bus
> +
> +SLIMbus is a 2-wire bus, and is used to communicate with peripheral
> +components like audio-codec.
> +
> +Controller is a normal device using binding for whatever bus it is
> +on (e.g. platform bus).

I can't have a PCI based slimbus controller? "platform bus" is a 
Linuxism.

> +Required property for SLIMbus controller node:
> +- compatible	- name of SLIMbus controller following generic names
> +		recommended practice.

generic names aren't recommended. Allowed with some conditons, yes.

> +- #address-cells - should be 2

You used 4 for your controller.

> +- #size-cells	- should be 0
> +
> +No other properties are required in the SLIMbus controller bus node.

That's not a useful statement. Almost every controller probably has 
other required properties.

> +
> +Child nodes:
> +Every SLIMbus controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SLIMbus slave device is
> +uniquely determined by the enumeration address containing 4 fields:
> +Manufacturer ID, Product code, Device index, and Instance value for
> +the device.
> +If child node is not present and it is instantiated after device
> +discovery (slave device reporting itself present).
> +
> +In some cases it may be necessary to describe non-probeable device
> +details such as non-standard ways of powering up a device. In
> +such cases, child nodes for those devices will be present as
> +slaves of the slimbus-controller, as detailed below.
> +
> +Required property for SLIMbus child node if it is present:
> +- reg		- Is Duplex (Device index, Instance ID) from Enumeration
> +		  Address.
> +		  Device Index Uniquely identifies multiple Devices within
> +		  a single Component.
> +		  Instance ID Is for the cases where multiple Devices of the
> +		  same type or Class are attached to the bus.
> +
> +- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
> +	 	  Product Code, shall be in lower case hexadecimal with leading
> +		  zeroes suppressed
> +
> +SLIMbus example for Qualcomm's slimbus manager component:
> +
> +	slim@28080000 {
> +		compatible = "qcom,slim-msm";
> +		reg = <0x28080000 0x2000>,
> +		interrupts = <0 33 0>;
> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names = "iface_clk", "core_clk";
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		codec: wcd9310@1{

Is '1' by itself unique enough because you have 2 address cells. The 
unit-address is typically split up into fields with commas unless it's 
just a memory address. Anyway, you need to define the unit address 
format in this doc.

> +			compatible = "slim217,60"";
> +			reg = <1 0>;
> +		};
> +	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
