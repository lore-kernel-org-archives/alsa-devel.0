From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v4 3/7] ARM: dts: at91: sama5d2: add I2S clock muxing nodes
Date: Fri, 25 May 2018 15:34:24 +0300
Message-ID: <1527251668-31396-4-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@microchip.com, boris.brezillon@bootlin.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org, broonie@kernel.org
Cc: Cristian.Birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

This patch adds two clock muxes for the two I2S
buses present on sama5d2 platforms.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5..eeb6afa 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -992,6 +992,24 @@
 						atmel,clk-output-range = <0 100000000>;
 					};
 				};
+
+				i2s_clkmux {
+					compatible = "atmel,sama5d2-clk-i2s-mux";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					i2s0muxck: i2s0_muxclk {
+						clocks = <&i2s0_clk>, <&i2s0_gclk>;
+						#clock-cells = <0>;
+						reg = <0>;
+					};
+
+					i2s1muxck: i2s1_muxclk {
+						clocks = <&i2s1_clk>, <&i2s1_gclk>;
+						#clock-cells = <0>;
+						reg = <1>;
+					};
+				};
 			};
 
 			qspi0: spi@f0020000 {
-- 
2.7.4
