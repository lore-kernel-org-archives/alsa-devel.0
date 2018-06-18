From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v5 5/5] ARM: dts: at91: sama5d2 Xplained: add
	pin muxing for I2S
Date: Mon, 18 Jun 2018 17:12:39 +0300
Message-ID: <20180618141239.10892-6-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa1.microchip.iphmx.com (esa1.microchip.iphmx.com
 [68.232.147.91])
 by alsa0.perex.cz (Postfix) with ESMTP id F17692675FA
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 16:14:07 +0200 (CEST)
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

This patch sets the pin muxing for the I2S controllers

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu@microchip.com: added pin muxing for the second
controller]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v5:
	- Previous name was:
	  [PATCH v4 7/7] ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e4bbb7e0f793..03917312dec1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -281,6 +281,11 @@
 				status = "okay";
 			};
 
+			i2s0: i2s@f8050000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s0_default>;
+			};
+
 			can0: can@f8054000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_default>;
@@ -424,6 +429,24 @@
 					bias-disable;
 				};
 
+				pinctrl_i2s0_default: i2s0_default {
+					pinmux = <PIN_PC1__I2SC0_CK>,
+						 <PIN_PC2__I2SC0_MCK>,
+						 <PIN_PC3__I2SC0_WS>,
+						 <PIN_PC4__I2SC0_DI0>,
+						 <PIN_PC5__I2SC0_DO0>;
+					bias-disable;
+				};
+
+				pinctrl_i2s1_default: i2s1_default {
+					pinmux = <PIN_PA15__I2SC1_CK>,
+						 <PIN_PA14__I2SC1_MCK>,
+						 <PIN_PA16__I2SC1_WS>,
+						 <PIN_PA17__I2SC1_DI0>,
+						 <PIN_PA18__I2SC1_DO0>;
+					bias-disable;
+				};
+
 				pinctrl_key_gpio_default: key_gpio_default {
 					pinmux = <PIN_PB9__GPIO>;
 					bias-pull-up;
@@ -546,6 +569,11 @@
 				status = "okay";
 			};
 
+			i2s1: i2s@fc04c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s1_default>;
+			};
+
 			can1: can@fc050000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_default>;
-- 
2.17.1
