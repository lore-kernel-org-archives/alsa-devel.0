From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v7 13/17] ASoC: madera: Add DT bindings for
	Cirrus Logic Madera codecs
Date: Mon, 15 Jan 2018 12:42:01 +0000
Message-ID: <20180115124205.29042-14-rf@opensource.wolfsonmicro.com>
References: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D37F26752C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 13:42:14 +0100 (CET)
In-Reply-To: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic Madera codecs are a family of related codecs with
extensive digital and analogue I/O, digital mixing and routing,
signal processing and programmable DSPs.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/madera.txt | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 include/dt-bindings/sound/madera.h                 | 27 +++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/madera.txt
 create mode 100644 include/dt-bindings/sound/madera.h

diff --git a/Documentation/devicetree/bindings/sound/madera.txt b/Documentation/devicetree/bindings/sound/madera.txt
new file mode 100644
index 000000000000..1114fcf1aa4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/madera.txt
@@ -0,0 +1,67 @@
+Cirrus Logic Madera class audio codecs
+
+This describes audio configuration bindings for these codecs.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+and defines for values used in these bindings:
+include/dt-bindings/sound/madera.h
+
+These properties are all contained in the parent MFD node.
+
+Optional properties:
+  - cirrus,dmic-ref : Indicates how the MICBIAS pins have been externally
+    connected to DMICs on each input, one cell per input.
+    <IN1 IN2 IN3 ...>
+    A value of 0 indicates MICVDD and is the default, other values depend on the
+    codec:
+    For CS47L35 one of the CS47L35_DMIC_REF_xxx values
+    For all other codecs one of the MADERA_DMIC_REF_xxx values
+    Also see the datasheet for a description of the INn_DMIC_SUP field.
+
+  - cirrus,inmode : A list of input mode settings for each input. A maximum of
+    16 cells, with four cells per input in the order INnAL, INnAR INnBL INnBR.
+    For non-muxed inputs the first two cells for that input set the mode for
+    the left and right channel and the second two cells must be 0.
+    For muxed inputs the first two cells for that input set the mode of the
+    left and right A inputs and the second two cells set the mode of the left
+    and right B inputs.
+    Valid mode values are one of the MADERA_INMODE_xxx. If the array is shorter
+    than the number of inputs the unspecified inputs default to
+    MADERA_INMODE_DIFF.
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
+cs47l35@0 {
+	compatible = "cirrus,cs47l35";
+
+	cirrus,dmic-ref = <0 0 CS47L35_DMIC_REF_MICBIAS1B 0>;
+	cirrus,inmode = <
+		MADERA_INMODE_DMIC MADERA_INMODE_DMIC /* IN1A digital */
+		MADERA_INMODE_SE   MADERA_INMODE_SE   /* IN1B single-ended */
+		MADERA_INMODE_DIFF MADERA_INMODE_DIFF /* IN2 differential */
+		0 0 	/* not used on this codec */
+	>;
+	cirrus,out-mono = <0 0 0 0 0 0>;
+	cirrus,max-channels-clocked = <2 0 0>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index b179fee1bba7..49f1ca1698ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3497,6 +3497,7 @@ W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+F:	include/dt-bindings/sound/madera*
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
 F:	drivers/gpio/gpio-madera*
diff --git a/include/dt-bindings/sound/madera.h b/include/dt-bindings/sound/madera.h
new file mode 100644
index 000000000000..5c05b7a9bab8
--- /dev/null
+++ b/include/dt-bindings/sound/madera.h
@@ -0,0 +1,27 @@
+/*
+ * Device Tree defines for Madera codecs
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef DT_BINDINGS_SOUND_MADERA_H
+#define DT_BINDINGS_SOUND_MADERA_H
+
+#define MADERA_INMODE_DIFF		0
+#define MADERA_INMODE_SE		1
+#define MADERA_INMODE_DMIC		2
+
+#define MADERA_DMIC_REF_MICVDD		0
+#define MADERA_DMIC_REF_MICBIAS1	1
+#define MADERA_DMIC_REF_MICBIAS2	2
+#define MADERA_DMIC_REF_MICBIAS3	3
+
+#define CS47L35_DMIC_REF_MICBIAS1B	1
+#define CS47L35_DMIC_REF_MICBIAS2A	2
+#define CS47L35_DMIC_REF_MICBIAS2B	3
+
+#endif
-- 
2.11.0
