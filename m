From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 4/4] ARM: dts: Enable SGTL5000 codec based audio driver node for VF610 TOWER.
Date: Wed, 8 Jan 2014 15:02:36 +0800
Message-ID: <1389164556-2728-4-git-send-email-Li.Xiubo@freescale.com>
References: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch adds and enables SGTL5000 codec support, and also specified
the corresponding SAI node.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e60c20c..f7a1be7 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,43 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "vf610-sgtl5000";
+		simple-audio-card,routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Ext Spk", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			master-clkdir-out;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+
 };
 
 &dspi0 {
@@ -72,9 +109,19 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_1>;
 	status = "okay";
+
+	codec: sgtl5000@0a {
+	       #sound-dai-cells = <0>;
+	       compatible = "fsl,sgtl5000";
+	       reg = <0x0a>;
+	       VDDA-supply = <&reg_3p3v>;
+	       VDDIO-supply = <&reg_3p3v>;
+	       clocks = <&clks VF610_CLK_SAI2>;
+	};
 };
 
 &sai2 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai2_1>;
 	status = "okay";
-- 
1.8.4


