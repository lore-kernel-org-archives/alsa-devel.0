From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 7/8] ARM: dts: Enable SGTL5000 codec based audio driver node for VF610.
Date: Fri, 1 Nov 2013 15:04:54 +0800
Message-ID: <1383289495-24523-8-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patch add and enable SGTL5000 codec support, and also specified
the corresponding SAI node.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Signed-off-by: Alison Wang <b18965@freescale.com
---
 arch/arm/boot/dts/vf610-twr.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e4106dd..a2d9214 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,19 @@
 		};
 	};
 
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
 
 &fec0 {
@@ -55,6 +68,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_1>;
 	status = "okay";
+
+	codec: sgtl5000@0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks VF610_CLK_SAI2>;
+	};
 };
 
 &sai2 {
-- 
1.8.4
