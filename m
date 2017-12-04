From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 10/13] dt-bindings: Add qcom slimbus controller
 bindings
Date: Mon, 4 Dec 2017 15:28:29 -0600
Message-ID: <20171204212829.bmcp5dktc5w46rom@rob-hp-laptop>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
 <20171130174200.6684-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171130174200.6684-11-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 30, 2017 at 05:41:57PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> This patch add device tree bindings for Qualcomm slimbus controller.
> 
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> new file mode 100644
> index 000000000000..93a6fdaf09b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> @@ -0,0 +1,39 @@
> +Qualcomm SLIMbus controller
> +This controller is used if applications processor driver controls SLIMbus
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
> +	 "ctrl": Physical address of controller register blocks
> + 	 "slew": required for "qcom,apq8064-slim" SOC.
> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
> + 		followed by "qcom,slim" for fallback.
> + - interrupts : Interrupt number used by this controller
> + - clocks : Interface and core clocks used by this SLIMbus controller
> + - clock-names : Required clock-name entries are:
> +	"iface_clk" : Interface clock for this controller
> +	"core_clk" : Interrupt for controller core's BAM

Doesn't match the example. You should drop the '_clk'. With that,

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +
> +Example:
> +
> +	slim@28080000 {
> +		compatible = "qcom,apq8064-slim", "qcom,slim";
> +		reg = <0x28080000 0x2000>, <0x80207C 4>;
> +		reg-names = "ctrl", "slew";
> +		interrupts = <0 33 0>;
> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names = "iface", "core";
> +		#address-cells = <2>;
> +		#size-cell = <0>;
> +
> +		wcd9310: audio-codec@1,0{
> +			compatible = "slim217,60";
> +			reg = <1 0>;
> +		};
> +	};
> -- 
> 2.15.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
