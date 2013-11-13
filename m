From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 09:44:34 -0600
Message-ID: <1384357474-28653-2-git-send-email-brian.austin@cirrus.com>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384357474-28653-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add Device Tree Binding for the CS42L52 Codec

v2 Adds clearer explaination of mic configs and select.
Renames bindings to '-' instead of '_'.
Definition of GPIO for reset pin.

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs42l52.txt          | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l52.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l52.txt b/Documentation/devicetree/bindings/sound/cs42l52.txt
new file mode 100644
index 0000000..bd91ecf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l52.txt
@@ -0,0 +1,48 @@
+CS42L52 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs42l52"
+
+  - reg : the I2C address of the device for I2C
+
+Optional properties:
+
+  - reset-gpio : GPIO controller's phandle and the number
+		 of the GPIO used to reset the codec.
+  - chgfreq    : Charge Pump Frequency values. Allowable values of
+		 0x00 through 0x0F.
+		 Frequency = (64xFs)/(N+2)
+  - mica-cfg   : MIC A single-ended or differential select.
+		 0x00 = Single-Ended
+		 0x01 = Differential
+  - micb-cfg   : MIC B single-ended or differential select.
+		 0x00 = Single-Ended
+		 0x01 = Differential
+  - mica-sel   : MIC A single ended input select.  For Single-Ended
+		 configuration, select which MIC to use.
+		 0x00 = MIC1
+		 0x01 = MIC2
+  - micb-sel   : MIC B single ended input select.  For Single-Ended
+		 configuration, select which MIC to use.
+		 0x00 = MIC1
+		 0x01 = MIC2
+  - micbias-lvl: Set the output voltage level on the MICBIAS Pin
+		 0x00 = 0.5 x VA
+		 0x01 = 0.6 x VA
+		 0x02 = 0.7 x VA
+		 0x03 = 0.8 x VA
+		 0x04 = 0.83 x VA
+		 0x05 = 0.91 x VA
+
+Example:
+
+codec: cs42l52@4a {
+	compatible = "cirrus,cs42l52";
+	reg = <0x4a>;
+	reset-gpio = <&gpio 10 0>;
+	chgfreq = <0x05>;
+	mica-cfg = <0x00>;
+	mica-sel = <0x01>;
+	micbias-lvl = <0x05>;
+};
-- 
1.8.4.rc3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
