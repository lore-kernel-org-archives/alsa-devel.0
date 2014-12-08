From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 11/11] ARM: dts: Model IPQ LPASS audio hardware
Date: Mon,  8 Dec 2014 14:01:13 -0800
Message-ID: <1418076073-12623-12-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the LPASS audio hardware for the IPQ806X.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146f563b541e4994697af5ee1bbb41a4abd1..fb1d6f6e290b9c645eb82fc4403d0fba48305f81 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -66,6 +67,31 @@
 		ranges;
 		compatible = "simple-bus";
 
+		lpass_pcm_mi2s: lpass-pcm-mi2s {
+			compatible = "qcom,lpass-pcm-mi2s";
+			status = "disabled";
+		};
+
+		lpass_cpu_mi2s: lpass-cpu-mi2s {
+			compatible = "qcom,lpass-cpu-mi2s";
+			status = "disabled";
+			reg = <0x28100000 0x10000>;
+			reg-names = "lpass-lpaif-mem";
+			clocks = <&lcc AHBIX_CLK>,
+					<&lcc MI2S_OSR_CLK>,
+					<&lcc MI2S_BIT_CLK>;
+			clock-names = "ahbix_clk",
+					"mi2s_osr_clk",
+					"mi2s_bit_clk";
+			interrupts = <0 85 1>;
+			interrupt-names = "lpass-lpaif-irq";
+		};
+
+		max98357a_codec: max98357a-codec {
+			compatible = "qcom,max98357a-codec";
+			status = "disabled";
+		};
+
 		qcom_pinmux: pinmux@800000 {
 			compatible = "qcom,ipq8064-pinctrl";
 			reg = <0x800000 0x4000>;
@@ -234,6 +260,13 @@
 			};
 		};
 
+		lcc: clock-controller@28000000 {
+			compatible = "qcom,lcc-ipq8064";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		sata_phy: sata-phy@1b400000 {
 			compatible = "qcom,ipq806x-sata-phy";
 			reg = <0x1b400000 0x200>;
-- 
1.8.2.1
