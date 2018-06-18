From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v5 4/5] ARM: dts: at91: sama5d2: add nodes for
	I2S controllers
Date: Mon, 18 Jun 2018 17:12:38 +0300
Message-ID: <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa4.microchip.iphmx.com (esa4.microchip.iphmx.com
 [68.232.154.123])
 by alsa0.perex.cz (Postfix) with ESMTP id 497C42675EC
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 16:13:55 +0200 (CEST)
In-Reply-To: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@microchip.com, boris.brezillon@bootlin.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org, broonie@kernel.org, sboyd@kernel.org
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Cristian.Birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
each I2S node.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu@microchip.com: added phandle to new mux clock]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

The bindings for the I2S node are applied to broonie/sound.git .

Changes in v5:
	- the previous name was:
	  [PATCH v4 6/7] ARM: dts: at91: sama5d2: add nodes for I2S controllers

 arch/arm/boot/dts/sama5d2.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index eeb6afa1cda7..eca73ce40bc5 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -58,6 +58,8 @@
 		serial1 = &uart3;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2s0 = &i2s0;
+		i2s1 = &i2s1;
 	};
 
 	cpus {
@@ -1313,6 +1315,22 @@
 				clocks = <&clk32k>;
 			};
 
+			i2s0: i2s@f8050000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xf8050000 0x100>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(31))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(32))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
+				clock-names = "pclk", "gclk", "aclk", "muxclk";
+				status = "disabled";
+			};
+
 			can0: can@f8054000 {
 				compatible = "bosch,m_can";
 				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
@@ -1506,6 +1524,22 @@
 				status = "disabled";
 			};
 
+			i2s1: i2s@fc04c000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xfc04c000 0x100>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(33))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(34))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s1_clk>, <&i2s1_gclk>, <&audio_pll_pmc>, <&i2s1muxck>;
+				clock-names = "pclk", "gclk", "aclk", "muxclk";
+				status = "disabled";
+			};
+
 			can1: can@fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.17.1
