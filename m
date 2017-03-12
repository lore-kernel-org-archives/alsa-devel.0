From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 1/4] dt-bindings: Document the dmas and dma-names properties for bcm2835-analog-audio
Date: Sat, 11 Mar 2017 22:38:17 -0800
Message-ID: <20170312063820.19313-1-mzoran@crowfest.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-AbSShOkvfpQ@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add documentation for the DMA properties required when using the
PWM controller of the bcm2835 for analog audio output.

Signed-off-by: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index cf573e85b11d..08fc06fc083a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -1,14 +1,21 @@
 BCM2835 PWM controller (Raspberry Pi controller)
 
 Required properties:
-- compatible: should be "brcm,bcm2835-pwm"
+- compatible: should be "brcm,bcm2835-pwm" or "brcm,bcm2835-analog-audio"
 - reg: physical base address and length of the controller's registers
 - clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
+
+Required properties(PWM Output):
 - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
   the cells format.
 
+Required properties(Audio Output):
+- dmas: Should contain one entry pointing to the DMA channel used to
+	transfer audio data
+- dma-names:   Should contain "tx"
+
 Examples:
 
 pwm@2020c000 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
