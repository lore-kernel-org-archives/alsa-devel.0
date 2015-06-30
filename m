From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] ASoC: tlv320aic32x4: Update devicetree documentation
Date: Tue, 30 Jun 2015 13:25:13 +0300
Message-ID: <50c8c9e1c2b60bc209d13ee4ae2272edfcc2f624.1435569929.git.kimmo.saarela@gmail.com>
References: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 143a192..0141aab 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -13,12 +13,33 @@ Required properties:
     If you supply ldoin, dv and av are optional. Otherwise they are required
    See regulator/regulator.txt for more information about the detailed binding
    format.
+ - input-use: Array of input pins used by the driver, shall contain 6 values.
+    Pin input order is lin1, rin1, lin2, rin2, lin3, rin3.
+    Each value can hold value for primary function in low nybble (x & 0xf) or
+    value for secondary function in high nybble (x & 0xf0).
+    Possible values are:
+    0 = input not in use
+    1 = input connected with 10k Ohm (0dB)
+    2 = input connected with 20k Ohm (-6dB)
+    3 = input connected with 40k Ohm (-12dB)
+    If value for pin is 0, driver connects the pin weakly to common mode
 
 Optional properties:
  - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
  - clocks/clock-names: Clock named 'mclk' for the master clock of the codec.
    See clock/clock-bindings.txt for information about the detailed format.
-
+ - swapdacs: Swap dac channel
+ - powercfg: Power configuration mask for codec
+ - cmode: Array of common mode setup data when channels are used in single
+    ended mode.
+    Parameter order is cmode1, cmode2.
+    Low nybble holds config for left channel and high nybble holds config for
+    right channel.
+    Possible values are:
+    0 = cmode not in use
+    1 = cmode connected with 10k Ohm (0dB)
+    2 = cmode connected with 20k Ohm (-6dB)
+    3 = cmode connected with 40k Ohm (-12dB)
 
 Example:
 
@@ -27,4 +48,6 @@ codec: tlv320aic32x4@18 {
 	reg = <0x18>;
 	clocks = <&clks 201>;
 	clock-names = "mclk";
+	input-use = <1 1 0 0 0 0>;
+	cmode = <0x11 0>;
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
