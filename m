From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 10/10] ARM: dts: Model IPQ LPASS audio hardware
Date: Wed, 24 Dec 2014 08:42:10 -0800
Message-ID: <1419439330-2303-11-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the LPASS audio hardware for the IPQ806X.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146f563b541e4994697af5ee1bbb41a4abd1..f34f29c5683908a5d33c5e1ff14d2c4fb05737df 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -66,6 +67,21 @@
 		ranges;
 		compatible = "simple-bus";
 
+		lpass-cpu-mi2s {
+			compatible = "qcom,lpass-cpu-mi2s";
+			status = "disabled";
+			clocks = <&lcc AHBIX_CLK>,
+					<&lcc MI2S_OSR_CLK>,
+					<&lcc MI2S_BIT_CLK>;
+			clock-names = "ahbix_clk",
+					"mi2s_osr_clk",
+					"mi2s_bit_clk";
+			interrupts = <0 85 1>;
+			interrupt-names = "lpass-lpaif-irq";
+			reg = <0x28100000 0x10000>;
+			reg-names = "lpass-lpaif-mem";
+		};
+
 		qcom_pinmux: pinmux@800000 {
 			compatible = "qcom,ipq8064-pinctrl";
 			reg = <0x800000 0x4000>;
@@ -279,5 +295,12 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		lcc: clock-controller@28000000 {
+			compatible = "qcom,lcc-ipq8064";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
1.8.2.1
