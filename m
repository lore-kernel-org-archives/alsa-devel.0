From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/8] ASoC: tlv320aic31xx: Fix typo in DT binding documentation
Date: Wed, 29 Nov 2017 11:13:52 -0600
Message-ID: <20171129171359.29382-2-afd@ti.com>
References: <20171129171359.29382-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129171359.29382-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The property used to specify a GPIO intended for reset is "reset-gpios",
this binding uses "gpio-reset", as almost all other bindings use the
former name this use of the latter was certainly not intended. It is not
compatible with newer methods used to fetch GPIO pins and to prevent the
spread of this error to other bindings lets fix this here.

We also standardize the pin as active-low, different device trees have
marked the GPIO different ways, luckily the driver currently uses the
low-level GPIO set function which does not respect the active-low flag,
but future changes may change this. This is an active-low reset, mark
it as such.

Lastly, add an example of use for this property.

Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 6fbba562eaa7..5b3c33bb99e5 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -22,7 +22,7 @@ Required properties:
 
 Optional properties:
 
-- gpio-reset - gpio pin number used for codec reset
+- reset-gpios - GPIO specification for the active low RESET input.
 - ai31xx-micbias-vg - MicBias Voltage setting
         1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
         2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
@@ -30,6 +30,10 @@ Optional properties:
 	If this node is not mentioned or if the value is unknown, then
 	micbias	is set to 2.0V.
 
+Deprecated properties:
+
+- gpio-reset - gpio pin number used for codec reset
+
 CODEC output pins:
   * HPL
   * HPR
@@ -48,6 +52,7 @@ CODEC input pins:
 The pins can be used in referring sound node's audio-routing property.
 
 Example:
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/tlv320aic31xx-micbias.h>
 
 tlv320aic31xx: tlv320aic31xx@18 {
@@ -56,6 +61,8 @@ tlv320aic31xx: tlv320aic31xx@18 {
 
 	ai31xx-micbias-vg = <MICBIAS_OFF>;
 
+	reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
 	HPVDD-supply = <&regulator>;
 	SPRVDD-supply = <&regulator>;
 	SPLVDD-supply = <&regulator>;
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
