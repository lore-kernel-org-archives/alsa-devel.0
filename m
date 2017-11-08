From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/9] ASoC: tlv320aic31xx: Fix typo in DT binding documentation
Date: Wed, 8 Nov 2017 15:24:57 -0600
Message-ID: <20171108212505.28320-2-afd@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108212505.28320-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The property used to specify a GPIO intended for reset is "reset-gpio",
this binding uses "gpio-reset", as almost all other bindings use the
former name this use of the latter is certainly not intended and
was a typo. It is not compatible with newer methods used to fetch
GPIO pins and to prevent the spread of this error to other bindings
lets fix this here.

We also standardize the pin as active-low, different device trees have
marked the GPIO different ways, luckily the driver currently uses the
low-level GPIO set function which does not respect the active-low flag,
but future changes may change this. This is an active-low reset, mark
it as such.

Lastly, add an example of use for this property.

Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 6fbba562eaa7..4c4e77f97d87 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -22,7 +22,7 @@ Required properties:
 
 Optional properties:
 
-- gpio-reset - gpio pin number used for codec reset
+- reset-gpio - GPIO specification for the active low RESET input.
 - ai31xx-micbias-vg - MicBias Voltage setting
         1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
         2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
@@ -48,6 +48,7 @@ CODEC input pins:
 The pins can be used in referring sound node's audio-routing property.
 
 Example:
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/tlv320aic31xx-micbias.h>
 
 tlv320aic31xx: tlv320aic31xx@18 {
@@ -56,6 +57,8 @@ tlv320aic31xx: tlv320aic31xx@18 {
 
 	ai31xx-micbias-vg = <MICBIAS_OFF>;
 
+	reset-gpio = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
 	HPVDD-supply = <&regulator>;
 	SPRVDD-supply = <&regulator>;
 	SPLVDD-supply = <&regulator>;
-- 
2.15.0
