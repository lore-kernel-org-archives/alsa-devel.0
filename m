From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 6/9] ARM: dts: imx: Fix the audio CODEC's reset pin
Date: Wed, 8 Nov 2017 15:25:02 -0600
Message-ID: <20171108212505.28320-7-afd@ti.com>
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

Fixes: 50bffb78e2ee ("ARM: dts: imx: add Gateworks Ventana GW5903 support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 444425153fc7..b41ba46508db 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -310,7 +310,7 @@
 	tlv320aic3105: codec@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		reset-gpio = <&gpio5 17 GPIO_ACTIVE_LOW>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
 		/* Regulators */
-- 
2.15.0
