From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v2 15/18] dt-bindings: sound: Add bindings for Cirrus Logic Madera codecs
Date: Mon, 24 Apr 2017 17:08:41 +0100
Message-ID: <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493050124-5970-1-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic Madera codecs are a family of related codecs with
extensive digital and analogue I/O, digital mixing and routing,
signal processing and programmable DSPs.

Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
Changes since V1:
- these bindings split out from the main source patch
- some minor edits to the property descriptions to match the pdata
  descriptions

 Documentation/devicetree/bindings/sound/madera.txt | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/madera.txt

diff --git a/Documentation/devicetree/bindings/sound/madera.txt b/Documentation/devicetree/bindings/sound/madera.txt
new file mode 100644
index 0000000..b114f7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/madera.txt
@@ -0,0 +1,66 @@
+Cirrus Logic Madera class audio codecs
+
+This is a subnode of the parent mfd node.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+Required properties:
+  - compatible : One of the following chip-specific strings:
+        "cirrus,cs47l35-codec"
+        "cirrus,cs47l85-codec"
+        "cirrus,cs47l90-codec"
+
+Optional properties:
+  - cirrus,dmic-ref : DMIC bias reference for each input, one cell per input
+    <IN1 IN2 IN3 ...>
+    A value of 0 indicates MICVDD and is the default, other values depend on the
+    codec - see the datasheet for the INn_DMIC_SUP field
+
+  - cirrus,inmode : A list of input mode settings for each input. A maximum of
+    16 cells, with four cells per input in the order INnAL, INnAR INnBL INnBR.
+    For non-muxed inputs the first two cells for that input set the mode for
+    the left and right channel and the second two cells must be 0.
+    For muxed inputs the first two cells for that input set the mode of the
+    left and right A inputs and the second two cells set the mode of the left
+    and right B inputs.
+    Valid mode values are one of the MADERA_INMODE_xxx (see
+    include/dt-bindings/sound/madera.h). If the array is shorter than the number
+    of inputs the unspecified inputs default to MADERA_INMODE_DIFF.
+
+  - cirrus,out-mono : Mono bit for each output, must contain six cells if
+    specified. A non-zero value indicates the corresponding output is mono.
+
+  - cirrus,max-channels-clocked : Maximum number of channels that I2S clocks
+    will be generated for. Useful when clock master for systems where the I2S
+    bus has multiple data lines.
+    One cell for each AIF, use a value of zero for AIFs that should be handled
+    normally.
+
+  - cirrus,pdm-fmt : PDM speaker data format, must contain 2 cells
+    (OUT5 and OUT6). See the PDM_SPKn_FMT field in the datasheet for a
+    description of this value.
+    The second cell is ignored for codecs that do not have OUT6.
+
+  - cirrus,pdm-mute : PDM mute format, must contain 2 cells
+    (OUT5 and OUT6). See the PDM_SPKn_CTRL_1 register in the datasheet for a
+    description of this value.
+    The second cell is ignored for codecs that do not have OUT6.
+
+Example:
+
+codec: cs47l35@0 {
+	compatible = "cirrus,cs47l35";
+
+	codec {
+		compatible = "cirrus,cs47l35-codec";
+		cirrus,dmic-ref = <0 0 1 0>;
+		cirrus,dmic-clksrc = <0 0 0 0>;
+		cirrus,inmode = <
+			2 2 1 1 /* IN1A digital, IN1B single-ended */
+			0 0 0 0	/* IN2 differential */
+		>;
+		cirrus,out-mono = <0 0 0 0 0 0>;
+		cirrus,max-channels-clocked = <2 0 0>;
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
