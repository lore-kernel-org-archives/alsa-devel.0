From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 5/9] ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
Date: Wed, 8 Nov 2017 15:25:01 -0600
Message-ID: <20171108212505.28320-6-afd@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108212505.28320-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpio", fix this here.

Fixes: d763762e3b58 ("ARM: dts: imx6: add ZII RDU2 boards")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index eeb7679fd348..261e6896b286 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -337,7 +337,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		reset-gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
 	};
 
 	accel@1c {
@@ -525,7 +525,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		reset-gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	};
 
 	touchscreen@20 {
-- 
2.15.0
