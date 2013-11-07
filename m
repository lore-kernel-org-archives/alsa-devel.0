From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] dt: binding: sound cs42l52 driver
Date: Thu, 7 Nov 2013 14:22:17 -0600
Message-ID: <1383855737-8499-2-git-send-email-brian.austin@cirrus.com>
References: <1383855737-8499-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383855737-8499-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add Device Tree Binding for the CS42L52 Codec

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs42l52.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l52.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l52.txt b/Documentation/devicetree/bindings/sound/cs42l52.txt
new file mode 100644
index 0000000..7540198
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l52.txt
@@ -0,0 +1,34 @@
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
+  - reset_gpio : a GPIO spec for the reset pin.
+  - chgfreq    : Charge Pump Frequency values 0x00-0x0F
+  - mica_sel   : MIC A single ended input select MIC1/MIC2
+  - micb_sel   : MIC B single ended input select MIC1/MIC2
+  - mica_cfg   : MIC A single-ended or differential select
+  - micb_cfg   : MIC A single-ended or differential select
+  - micbias_lvl: Set the output voltage level on the MICBIAS Pin
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
+	reset_gpio = <&gpio 10 0>;
+	chgfreq = <0x05>;
+	mica_sel = <0x01>;
+	micbias_lvl = <0x05>;
+};
-- 
1.8.4.rc3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
