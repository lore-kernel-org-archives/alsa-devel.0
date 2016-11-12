From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 09/10] ARM: dts: sun8i-h3: Add device nodes for audio codec and its analog controls
Date: Sat, 12 Nov 2016 14:46:47 +0800
Message-ID: <20161112064648.26779-10-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161112064648.26779-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Now that we support the audio codec found on the Allwinner H3 SoC, add
device nodes for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index c38b028cac83..ceec979f57e4 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -485,6 +485,20 @@
 			status = "disabled";
 		};
 
+		codec: codec@01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-codec";
+			reg = <0x01c22c00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -600,6 +614,11 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog@01f015c0 {
+			compatible = "allwinner,sun8i-h3-codec-analog";
+			reg = <0x01f015c0 0x4>;
+		};
+
 		ir: ir@01f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			clocks = <&apb0_gates 1>, <&ir_clk>;
-- 
2.10.2
