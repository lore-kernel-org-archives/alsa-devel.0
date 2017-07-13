From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 9/9] ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd
Date: Thu, 13 Jul 2017 09:49:27 +0200
Message-ID: <20170713074927.10882-10-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds the pin muxing for classd and enables it.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 2e2c3d1a1fa2..e92b030ca45a 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -355,6 +355,14 @@
 					bias-pull-up;
 				};
 
+				pinctrl_classd_default: classd_default {
+					pinmux = <PIN_PB1__CLASSD_R0>,
+						 <PIN_PB2__CLASSD_R1>,
+						 <PIN_PB3__CLASSD_R2>,
+						 <PIN_PB4__CLASSD_R3>;
+					bias-pull-up;
+				};
+
 				pinctrl_flx0_default: flx0_default {
 					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
 						 <PIN_PB29__FLEXCOM0_IO1>;
@@ -488,6 +496,14 @@
 
 			};
 
+			classd: classd@fc048000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_classd_default>;
+				atmel,pwm-type = "diff";
+				atmel,non-overlap-time = <10>;
+				status = "okay";
+			};
+
 			can1: can@fc050000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_default>;
-- 
2.11.0
