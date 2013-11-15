From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 2/2] dt: binding: sound cs42l52 driver
Date: Fri, 15 Nov 2013 09:35:34 -0600
Message-ID: <1384529734-9415-2-git-send-email-brian.austin@cirrus.com>
References: <1384529734-9415-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384529734-9415-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

v3 Adds better descriptors for platform data.
Change mic differential setting to boolean
Change chgfreq to chgfreq-divisor
Add vendor cirrus to properties
Chgfreq values in decimal

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs42l52.txt          | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l52.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l52.txt b/Documentation/devicetree/bindings/sound/cs42l52.txt
new file mode 100644
index 0000000..66ed1be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l52.txt
@@ -0,0 +1,46 @@
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
+  - cirrus,reset-gpio : GPIO controller's phandle and the number
+  of the GPIO used to reset the codec.
+
+  - cirrus,chgfreq-divisor : Values used to set the Charge Pump Frequency.
+  Allowable values of 0x00 through 0x0F. These are raw values written to the
+  register, not the actual frequency. The frequency is determined by the following.
+  Frequency = (64xFs)/(N+2)
+  N = chgfreq_val
+  Fs = Sample Rate (variable)
+
+  - cirrus,mica-differential-cfg : boolean, If present, then the MICA input is configured
+  as a differential input. If not present then the MICA input is configured as
+  Single-ended input. Single-ended mode allows for MIC1 or MIC2 muxing for input.
+
+  - cirrus,micb-differential-cfg : boolean, If present, then the MICB input is configured
+  as a differential input. If not present then the MICB input is configured as
+  Single-ended input. Single-ended mode allows for MIC1 or MIC2 muxing for input.
+
+  - cirrus,micbias-lvl: Set the output voltage level on the MICBIAS Pin
+  0 = 0.5 x VA
+  1 = 0.6 x VA
+  2 = 0.7 x VA
+  3 = 0.8 x VA
+  4 = 0.83 x VA
+  5 = 0.91 x VA
+
+Example:
+
+codec: codec@4a {
+	compatible = "cirrus,cs42l52";
+	reg = <0x4a>;
+	reset-gpio = <&gpio 10 0>;
+	cirrus,chgfreq-divisor = <0x05>;
+	cirrus.mica-differential-cfg;
+	cirrus,micbias-lvl = <5>;
+};
-- 
1.8.4.3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
