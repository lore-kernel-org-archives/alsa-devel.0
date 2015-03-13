From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH V8 5/5] ARM: dts: Model IPQ LPASS audio hardware
Date: Fri, 13 Mar 2015 01:01:08 -0700
Message-ID: <1426233668-30593-6-git-send-email-kwestfie@codeaurora.org>
References: <1426233668-30593-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1426233668-30593-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the Qualcomm Technologies LPASS hardware for
the ipq806x SOC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225dafe97cd83c9ae4cc19482ed55d4a71b8b3..d5fad10722a5cf2c62ac4026c31a98bbf8068447 100644
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
+		};
+
 		qcom_pinmux: pinmux@800000 {
 			compatible = "qcom,ipq8064-pinctrl";
 			reg = <0x800000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
