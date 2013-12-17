From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 6/7] ARM: dts: Enable SGTL5000 codec based audio driver node for VF610 TOWER.
Date: Tue, 17 Dec 2013 11:24:43 +0800
Message-ID: <1387250684-23406-7-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, timur@tabi.org, perex@perex.cz
Cc: r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds and enables SGTL5000 codec support, and also specified
the corresponding SAI node.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e60c20c..6a8ee0a 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,31 @@
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
+		compatible = "fsl,vf610-sgtl5000";
+		model = "vf610-sgtl5000";
+		saif-controller = <&sai2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Ext Spk", "LINE_OUT";
+	};
+
 };
 
 &dspi0 {
@@ -72,6 +97,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_1>;
 	status = "okay";
+
+	codec: sgtl5000@0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		clocks = <&clks VF610_CLK_SAI2>;
+	};
 };
 
 &sai2 {
-- 
1.8.4
