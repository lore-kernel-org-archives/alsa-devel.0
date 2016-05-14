From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v4 1/4] dt-bindings: sound: add bindings for the max9860 codec
Date: Sat, 14 May 2016 23:09:38 +0200
Message-ID: <1463260181-21344-2-git-send-email-peda@axentia.se>
References: <1463260181-21344-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463260181-21344-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Misbah Ullah Khan <Misbahk-RbfqNLLv1bh8UrSeD/g0lQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This adds the device tree binding documentation for the Maxim Integrated
MAX9860 mono audio voice codec.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../devicetree/bindings/sound/max9860.txt          | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt

diff --git a/Documentation/devicetree/bindings/sound/max9860.txt b/Documentation/devicetree/bindings/sound/max9860.txt
new file mode 100644
index 000000000000..e0d4e95e31b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max9860.txt
@@ -0,0 +1,28 @@
+MAX9860 Mono Audio Voice Codec
+
+Required properties:
+
+  - compatible : "maxim,max9860"
+
+  - reg : the I2C address of the device
+
+  - AVDD-supply, DVDD-supply and DVDDIO-supply : power supplies for
+    the device, as covered in bindings/regulator/regulator.txt
+
+  - clock-names : Required element: "mclk".
+
+  - clocks : A clock specifier for the clock connected as MCLK.
+
+Examples:
+
+	max9860: max9860@10 {
+		compatible = "maxim,max9860";
+		reg = <0x10>;
+
+		AVDD-supply = <&reg_1v8>;
+		DVDD-supply = <&reg_1v8>;
+		DVDDIO-supply = <&reg_3v0>;
+
+		clock-names = "mclk";
+		clocks = <&pck2>;
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
