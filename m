From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 10/13] dt-bindings: Add qcom slimbus
 controller bindings
Date: Wed, 15 Nov 2017 23:19:11 -0600
Message-ID: <20171116051911.tvl6mioxpbo4h72c@rob-hp-laptop>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A98C266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 06:19:13 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id a132so17630267oih.11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 21:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-11-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, broonie@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:40PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> This patch add device tree bindings for Qualcomm slimbus controller.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> new file mode 100644
> index 000000000000..e4d28910b2e0
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
> +	 "ctrl": Physical address of controller register blocks
> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
> + 		followed by "qcom,slim" for fallback.
> + - interrupts : Interrupt number used by this controller
> + - clocks : Interface and core clocks used by this slimbus controller
> + - clock-names : Required clock-name entries are:
> +	"iface_clk" : Interface clock for this controller
> +	"core_clk" : Interrupt for controller core's BAM
> +
> +
> +Optional property:
> + - reg entry for slew rate : If slew rate control register is provided, this
> +	entry should be used.
> + - reg-name for slew rate: "slew"

reg-names

I'd prefer it be explicit as to which compatibles do or don't have this 
register.

> +
> +Example:
> +
> +	slim@28080000 {
> +		compatible = "qcom,apq8064-slim", "qcom,slim";
> +		reg = <0x28080000 0x2000>,

error                                    ^

> +		interrupts = <0 33 0>;
> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names = "iface", "core";
> +		#address-cells = <2>;
> +		#size-cell = <0>;
> +
> +		codec: wcd9310@1,0{

Use generic node names:

wcd9310: audio-codec@1,0

> +			compatible = "slim217,60";
> +			reg = <1 0>;
> +		};
> +	};
> -- 
> 2.15.0
> 
