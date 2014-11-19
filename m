From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 9/9] ARM: dts: Model IPQ LPASS audio hardware
Date: Wed, 19 Nov 2014 10:52:49 -0800
Message-ID: <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Model the LPASS audio hardware for the IPQ806X.

Change-Id: Ide1aa0d09c23d4496aa9c40e3c9878a968261f11
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146f563b541e4994697af5ee1bbb41a4abd1..0e5b3b625f0442964aa7fbbc993c6c818fe99041 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -66,6 +67,38 @@
 		ranges;
 		compatible = "simple-bus";
 
+		sound {
+			compatible = "qcom,ipq806x-snd-card";
+			status = "disabled";
+			clocks = <&lcc AHBIX_CLK>;
+			clock-names = "ahbix_clk";
+			asoc-platform = <&pcm0>;
+			asoc-platform-names = "lpass-pcm-mi2s";
+			asoc-cpu = <&dai_mi2s>;
+			asoc-cpu-names = "lpass-cpu-dai";
+		};
+
+		lpass-lpaif {
+			compatible = "qcom,lpass-lpaif";
+			status = "disabled";
+			reg = <0x28100000 0x10000>;
+			reg-names = "lpass-lpaif-mem";
+			interrupts = <0 85 1>;
+			interrupt-names = "lpass-lpaif-irq";
+		};
+
+		dai_mi2s: lpass-cpu-dai {
+			compatible = "qcom,lpass-cpu-dai";
+			status = "disabled";
+			clocks = <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+			clock-names = "mi2s_osr_clk", "mi2s_bit_clk";
+		};
+
+		pcm0: lpass-pcm-mi2s {
+			compatible = "qcom,lpass-pcm-mi2s";
+			status = "disabled";
+		};
+
 		qcom_pinmux: pinmux@800000 {
 			compatible = "qcom,ipq8064-pinctrl";
 			reg = <0x800000 0x4000>;
-- 
1.8.2.1
