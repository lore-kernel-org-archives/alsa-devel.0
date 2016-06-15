From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 4/4] ARM: sun7i: Add DAI nodes
Date: Wed, 15 Jun 2016 23:11:23 +0200
Message-ID: <20160615211123.31068-5-maxime.ripard@free-electrons.com>
References: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Code Kipper <codekipper@gmail.com>, gianfranco@moddevices.com, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Add the new DAI blocks to the device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 603fda5b7f94..b656bc20ce59 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1361,6 +1361,32 @@
 			status = "disabled";
 		};
 
+		i2s1: i2s@01c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 4>, <&i2s1_clk>;
+			clock-names = "apb", "mod";
+			dmas = <&dma SUN4I_DMA_NORMAL 4>,
+			       <&dma SUN4I_DMA_NORMAL 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2s0: i2s@01c22400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-i2s";
+			reg = <0x01c22400 0x400>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 3>, <&i2s0_clk>;
+			clock-names = "apb", "mod";
+			dmas = <&dma SUN4I_DMA_NORMAL 3>,
+			       <&dma SUN4I_DMA_NORMAL 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		lradc: lradc@01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
@@ -1386,6 +1412,19 @@
 			reg = <0x01c23800 0x200>;
 		};
 
+		i2s2: i2s@01c24400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-i2s";
+			reg = <0x01c24400 0x400>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 8>, <&i2s2_clk>;
+			clock-names = "apb", "mod";
+			dmas = <&dma SUN4I_DMA_NORMAL 6>,
+			       <&dma SUN4I_DMA_NORMAL 6>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		rtp: rtp@01c25000 {
 			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
-- 
2.9.0
