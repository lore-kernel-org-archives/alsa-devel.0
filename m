From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V4 10/10] ARM: dts: Model IPQ LPASS audio hardware
Date: Thu,  5 Feb 2015 12:53:46 -0800
Message-ID: <1423169626-22166-11-git-send-email-kwestfie@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the Qualcomm Technologies LPASS hardware for
the ipq806x SOC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146f563b541e4994697af5ee1bbb41a4abd1..c608575e3d184a5d84d550d47af8c597e022ba4a 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -118,6 +119,21 @@
 			regulator;
 		};
 
+		lpass-cpu@28100000 {
+			compatible = "qcom,lpass-cpu";
+			status = "disabled";
+			clocks = <&lcc AHBIX_CLK>,
+					<&lcc MI2S_OSR_CLK>,
+					<&lcc MI2S_BIT_CLK>;
+			clock-names = "ahbix-clk",
+					"mi2s-osr-clk",
+					"mi2s-bit-clk";
+			interrupts = <0 85 1>;
+			interrupt-names = "lpass-irq-lpaif";
+			reg = <0x28100000 0x10000>, <0x28400000 0x4000>;
+			reg-names = "lpass-lpaif", "lpass-lpm";
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			reg = <0x12480000 0x100>;
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
