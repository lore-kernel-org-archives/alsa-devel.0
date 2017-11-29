From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/8] ASoC: tlv320aic3x: Fix typo in DT binding documentation
Date: Wed, 29 Nov 2017 11:13:53 -0600
Message-ID: <20171129171359.29382-3-afd@ti.com>
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

Fixes: c24fdc886fde ("ASoC: tlv320aic3x: Add device tree bindings")

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index ba5b45c483f5..9796c4639262 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -17,7 +17,7 @@ Required properties:
 
 Optional properties:
 
-- gpio-reset - gpio pin number used for codec reset
+- reset-gpios - GPIO specification for the active low RESET input.
 - ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
 				    - Not supported on tlv320aic3104
 - ai3x-micbias-vg - MicBias Voltage required.
@@ -34,6 +34,10 @@ Optional properties:
 - AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
   device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
+Deprecated properties:
+
+- gpio-reset - gpio pin number used for codec reset
+
 CODEC output pins:
   * LLOUT
   * RLOUT
@@ -61,10 +65,14 @@ The pins can be used in referring sound node's audio-routing property.
 
 Example:
 
+#include <dt-bindings/gpio/gpio.h>
+
 tlv320aic3x: tlv320aic3x@1b {
 	compatible = "ti,tlv320aic3x";
 	reg = <0x1b>;
 
+	reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
 	AVDD-supply = <&regulator>;
 	IOVDD-supply = <&regulator>;
 	DRVDD-supply = <&regulator>;
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
