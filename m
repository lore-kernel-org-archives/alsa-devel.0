From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 7/8] ARM: dts: imx: Fix the audio CODEC's
	reset pin
Date: Wed, 29 Nov 2017 11:13:58 -0600
Message-ID: <20171129171359.29382-8-afd@ti.com>
References: <20171129171359.29382-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 94262267913
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 18:14:03 +0100 (CET)
In-Reply-To: <20171129171359.29382-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 50bffb78e2ee ("ARM: dts: imx: add Gateworks Ventana GW5903 support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 444425153fc7..16299103a941 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -310,7 +310,7 @@
 	tlv320aic3105: codec@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
 		/* Regulators */
-- 
2.15.0
