From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 4/4] dts: bcm283x.dtsi: Add analog audio/headphone jack for bcm2835
Date: Sat, 11 Mar 2017 22:38:20 -0800
Message-ID: <20170312063820.19313-4-mzoran@crowfest.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170312063820.19313-1-mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-AbSShOkvfpQ@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add the DT nodes for the analog audio/headphone jack for the BCM2835

Signed-off-by: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9798bc9293d8..bf2cd463a6e6 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -338,7 +338,12 @@
 				brcm,pins = <42 43>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
-		};
+
+                        analog_audio_pins: analog_audio_pins {
+                                brcm,pins = <40 45>;
+                                brcm,function = <4 4>; /* Alt0 */
+                        };
+                };
 
 		uart0: serial@7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
@@ -464,6 +469,17 @@
 			status = "disabled";
 		};
 
+                analogaudio: analogaudio@7e20c000 {
+                        compatible = "brcm,bcm2835-analog-audio";
+                        reg = <0x7e20c000 0x28>;
+                        clocks = <&clocks BCM2835_CLOCK_PWM>;
+                        assigned-clocks = <&clocks BCM2835_CLOCK_PWM>;
+                        pinctrl-names = "default";
+                        pinctrl-0 = <&analog_audio_pins>;
+                        dmas = <&dma 5>;
+                        dma-names = "tx";
+                };
+
 		sdhci: sdhci@7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
