From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V6 10/10] ARM: dts: Model IPQ LPASS audio hardware
Date: Tue, 24 Feb 2015 22:39:45 -0800
Message-ID: <1424846385-23700-11-git-send-email-kwestfie@codeaurora.org>
References: <1424846385-23700-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424846385-23700-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the Qualcomm Technologies LPASS hardware for
the ipq806x SOC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225dafe97cd83c9ae4cc19482ed55d4a71b8b3..dd5cbb33cc2d89be57494e05b7477352358affa5 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -96,6 +97,24 @@
 			cpu-offset = <0x80000>;
 		};
 
+		lpass@28100000 {
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
+			reg = <0x28100000 0x10000>;
+			reg-names = "lpass-lpaif";
+			qcom,adsp {
+				status = "disabled";
+			};
+		};
+
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
@@ -273,6 +292,13 @@
 			qcom,controller-type = "pmic-arbiter";
 		};
 
+		lcc: clock-controller@28000000 {
+			compatible = "qcom,lcc-ipq8064";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-ipq8064";
 			reg = <0x00900000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
