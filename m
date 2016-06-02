From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter DT bindings
Date: Thu,  2 Jun 2016 14:19:41 +0200
Message-ID: <1464869982-6722-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The ADAU7002 takes a stereo PDM signal (e.g. from two digital microphones)
and converts it into a I2S/TDM PCM stream. The chip does not have a
control interface and has a single power supply that is modeled in the
devicetree.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 .../devicetree/bindings/sound/adi,adau7002.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau7002.txt b/Documentation/devicetree/bindings/sound/adi,adau7002.txt
new file mode 100644
index 0000000..f144ee1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau7002.txt
@@ -0,0 +1,19 @@
+Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
+
+Required properties:
+
+ - compatible: Must be "adi,adau7002"
+
+Optional properties:
+
+ - IOVDD-supply: Phandle and specifier for the power supply providing the IOVDD
+	supply as covered in Documentation/devicetree/bindings/regulator/regulator.txt
+
+	If this property is not present it is assumed that the supply pin is
+	hardwired to always on.
+
+Example:
+	adau7002: pdm-to-i2s {
+		compatible = "adi,adau7002";
+		IOVDD-supply = <&supply>;
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
