From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: cs4265: bindings: sound: Add binding for CS4265 CODEC.
Date: Mon, 23 Jun 2014 17:29:52 -0500
Message-ID: <1403562593-31952-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawl.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Paul Handrigan <paul.handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds binding documentation for the Cirrus Logic CS4265 I2C CODEC.

Changes for v2:

* Change DT reset pin name to "reset-gpios"

Signed-off-by: Paul Handrigan <paul.handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/cs4265.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4265.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4265.txt b/Documentation/devicetree/bindings/sound/cs4265.txt
new file mode 100644
index 0000000..380fff8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4265.txt
@@ -0,0 +1,29 @@
+CS4265 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "cirrus,cs4265"
+
+  - reg : the I2C address of the device for I2C. The I2C address depends on
+          the state of the AD0 pin.  If AD0 is high, the i2c address is 0x4f.
+          If it is low, the i2c address is 0x4e.
+
+Optional properties:
+
+  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
+		 deasserted before communication to the codec starts.
+
+Examples:
+
+codec_ad0_high: cs4265@4f { /* AD0 Pin is high */
+	compatible = "cirrus,cs4265";
+	reg = <0x4f>;
+};
+
+
+codec_ad0_low: cs4265@4e { /* AD0 Pin is low */
+	compatible = "cirrus,cs4265";
+	reg = <0x4e>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
