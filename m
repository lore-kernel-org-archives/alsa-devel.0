From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 10/13] dt-bindings: Add qcom slimbus controller bindings
Date: Wed, 15 Nov 2017 14:10:40 +0000
Message-ID: <20171115141043.29202-11-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

This patch add device tree bindings for Qualcomm slimbus controller.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
new file mode 100644
index 000000000000..e4d28910b2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
@@ -0,0 +1,43 @@
+Qualcomm SLIMBUS controller
+This controller is used if applications processor driver controls slimbus
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
+ - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
+ 		followed by "qcom,slim" for fallback.
+ - interrupts : Interrupt number used by this controller
+ - clocks : Interface and core clocks used by this slimbus controller
+ - clock-names : Required clock-name entries are:
+	"iface_clk" : Interface clock for this controller
+	"core_clk" : Interrupt for controller core's BAM
+
+
+Optional property:
+ - reg entry for slew rate : If slew rate control register is provided, this
+	entry should be used.
+ - reg-name for slew rate: "slew"
+
+Example:
+
+	slim@28080000 {
+		compatible = "qcom,apq8064-slim", "qcom,slim";
+		reg = <0x28080000 0x2000>,
+		interrupts = <0 33 0>;
+		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+		clock-names = "iface", "core";
+		#address-cells = <2>;
+		#size-cell = <0>;
+
+		codec: wcd9310@1,0{
+			compatible = "slim217,60";
+			reg = <1 0>;
+		};
+	};
-- 
2.15.0
