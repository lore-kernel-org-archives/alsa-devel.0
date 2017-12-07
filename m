From: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v9 10/13] dt-bindings: Add qcom slimbus controller bindings
Date: Thu,  7 Dec 2017 10:27:17 +0000
Message-ID: <20171207102720.21071-11-srinivas.kandagatla@linaro.org>
References: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171207102720.21071-1-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, pombredanne-od1rfyK75/E@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

This patch add device tree bindings for Qualcomm slimbus controller.

Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
new file mode 100644
index 000000000000..922dcb8ff24a
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
@@ -0,0 +1,39 @@
+Qualcomm SLIMbus controller
+This controller is used if applications processor driver controls SLIMbus
+master component.
+
+Required properties:
+
+ - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
+ - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
+
+ - reg : Offset and length of the register region(s) for the device
+ - reg-names : Register region name(s) referenced in reg above
+	 Required register resource entries are:
+	 "ctrl": Physical address of controller register blocks
+ 	 "slew": required for "qcom,apq8064-slim" SOC.
+ - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
+ 		followed by "qcom,slim" for fallback.
+ - interrupts : Interrupt number used by this controller
+ - clocks : Interface and core clocks used by this SLIMbus controller
+ - clock-names : Required clock-name entries are:
+	"iface" : Interface clock for this controller
+	"core" : Interrupt for controller core's BAM
+
+Example:
+
+	slim@28080000 {
+		compatible = "qcom,apq8064-slim", "qcom,slim";
+		reg = <0x28080000 0x2000>, <0x80207C 4>;
+		reg-names = "ctrl", "slew";
+		interrupts = <0 33 0>;
+		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+		clock-names = "iface", "core";
+		#address-cells = <2>;
+		#size-cell = <0>;
+
+		wcd9310: audio-codec@1,0{
+			compatible = "slim217,60";
+			reg = <1 0>;
+		};
+	};
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
