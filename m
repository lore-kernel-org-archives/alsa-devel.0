From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 9/9] ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd
Date: Tue, 25 Jul 2017 09:37:10 +0200
Message-ID: <f2f55956879fd7e80cf0fb72ba743f8c5cb28fcc.1500968090.git-series.quentin.schulz@free-electrons.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
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
index 6eec8dc..c7e9ccf 100644
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
git-series 0.9.1
