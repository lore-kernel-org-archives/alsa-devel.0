From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings file for CS35L32
Date: Tue, 29 Jul 2014 15:02:43 -0500
Message-ID: <1406664163-10506-2-git-send-email-brian.austin@cirrus.com>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406664163-10506-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree bindings file for the Cirrus Logic CS35L32 Boosted Amplifier

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs35l32.txt          |   69 ++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l32.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l32.txt b/Documentation/devicetree/bindings/sound/cs35l32.txt
new file mode 100644
index 0000000..d3a8a51
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l32.txt
@@ -0,0 +1,69 @@
+CS35L32 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs35l32"
+
+  - reg : the I2C address of the device for I2C. Address is determined by the level
+  of the AD0 pin. Level 0 is 0x40 while Level 1 is 0x41.
+
+  - VA-supply : power supply for the device,
+  as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Optional properties:
+
+  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
+  deasserted before communication to the codec starts.
+
+  - cirrus,boost-manager : Boost voltage control.
+  0 = Automatically managed.  Boost-converter output voltage is the higher
+  of the two: Class G or adaptive LED voltage.
+  1 = Automatically managed irrespective of audio, adapting for low-power
+  dissipation when LEDs are ON, and operating in Fixed-Boost Bypass Mode
+  if LEDs are OFF (VBST = VP).
+  2 = (Default) Boost voltage fixed in Bypass Mode (VBST = VP).
+  3 = Boost voltage fixed at 5 V.
+
+  - cirrus,sdout-datacfg : Data configuration for dual CS35L32 applications only.
+  Determines the data packed in a two-CS35L32 configuration.
+  0 = Left/right channels VMON[11:0], IMON[11:0], VPMON[7:0].
+  1 = Left/right channels VMON[11:0], IMON[11:0], STATUS.
+  2 = (Default) left/right channels VMON[15:0], IMON [15:0].
+  3 = Left/right channels VPMON[7:0], STATUS.
+
+  - cirrus,sdout-share : SDOUT sharing. Determines whether one or two CS35L32
+  devices are on board sharing SDOUT.
+  0 = (Default) One IC.
+  1 = Two IC's.
+
+  - cirrus,gain-manager : Audio-gain management when LEDs are active.
+  0 = (Default) Automatically reduces audio volume once by 3 dB, only if needed
+  to avoid thermal shutdown or current limiting the boost converter.
+  If the condition persists, the CS35L32 examine s ILED_MNG and responds accordingly.
+  Audio recovers to original volume automatically at the end of the LED event.
+  1 = User controls volume (nonautomatic).
+
+  - cirrus,battery-recovery : Low battery nominal recovery threshold, rising VP.
+  0 = 3.1V
+  1 = 3.2V
+  2 = 3.3V (Default)
+  3 = 3.4V
+
+  - cirrus,battery-threshold : Low battery nominal threshold, falling VP.
+  0 = 3.1V
+  1 = 3.2V
+  2 = 3.3V
+  3 = 3.4V (Default)
+  4 = 3.5V
+  5 = 3.6V
+
+Example:
+
+codec: codec@40 {
+	compatible = "cirrus,cs35l32";
+	reg = <0x40>;
+	reset-gpios = <&gpio 10 0>;
+	cirrus,boost-manager = <0x03>;
+	cirrus,sdout-datacfg = <0x02>;
+	VA-supply = <&reg_audio>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
