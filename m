From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add audio device tree bindings" to the asoc tree
Date: Tue, 19 Sep 2017 15:59:58 +0100
Message-ID: <E1duK0E-0002Gw-VP@debutante>
References: <20170904154154.4395-4-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904154154.4395-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add audio device tree bindings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9fda3b428a74339e358d4b0850427fa1ce1b4714 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 4 Sep 2017 16:41:50 +0100
Subject: [PATCH] ASoC: arizona: Add audio device tree bindings

In keeping with the style of the rest of this drivers device tree
bindings split the audio device tree bindings into their own document.
It should be noted this patch makes no change to the binding itself
just moves the documentation into a specific file for the audio
binding. For easy of merging a separate patch removes the current
documentation from the MFD binding documentation.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/wlf,arizona.txt      | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.txt b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
new file mode 100644
index 000000000000..4e67224488d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
@@ -0,0 +1,49 @@
+Cirrus Logic Arizona class audio SoCs
+
+These devices are audio SoCs with extensive digital capabilities and a range
+of analogue I/O.
+
+This document lists sound specific bindings, see the primary binding
+document:
+  ../mfd/arizona.txt
+
+Optional properties:
+
+  - wlf,inmode : A list of INn_MODE register values, where n is the number
+    of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
+    2 (Digital Microphone). If absent, INn_MODE registers set to 0 by default.
+    If present, values must be specified less than or equal to the number of
+    input signals. If values less than the number of input signals, elements
+    that have not been specified are set to 0 by default. Entries are:
+    <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280, wm8997)
+    <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
+  - wlf,out-mono : A list of boolean values indicating whether each output is
+    mono or stereo. Position within the list indicates the output affected
+    (eg. First entry in the list corresponds to output 1). A non-zero value
+    indicates a mono output. If present, the number of values should be less
+    than or equal to the number of outputs, if less values are supplied the
+    additional outputs will be treated as stereo.
+
+  - wlf,dmic-ref : DMIC reference voltage source for each input, can be
+    selected from either MICVDD or one of the MICBIAS's, defines
+    (ARIZONA_DMIC_xxxx) are provided in <dt-bindings/mfd/arizona.txt>. If
+    present, the number of values should be less than or equal to the
+    number of inputs, unspecified inputs will use the chip default.
+
+  - wlf,max-channels-clocked : The maximum number of channels to be clocked on
+    each AIF, useful for I2S systems with multiple data lines being mastered.
+    Specify one cell for each AIF to be configured, specify zero for AIFs that
+    should be handled normally.
+    If present, number of cells must be less than or equal to the number of
+    AIFs. If less than the number of AIFs, for cells that have not been
+    specified the corresponding AIFs will be treated as default setting.
+
+  - wlf,spk-fmt : PDM speaker data format, must contain 2 cells (OUT5 and OUT6).
+    See the datasheet for values.
+    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
+      wm8998, wm1814)
+
+  - wlf,spk-mute : PDM speaker mute setting, must contain 2 cells (OUT5 and OUT6).
+    See the datasheet for values.
+    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
+    wm8998, wm1814)
diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4b41b6..5824962f419f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14575,6 +14575,7 @@ F:	Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 F:	Documentation/devicetree/bindings/regulator/arizona-regulator.txt
 F:	Documentation/devicetree/bindings/mfd/arizona.txt
 F:	Documentation/devicetree/bindings/mfd/wm831x.txt
+F:	Documentation/devicetree/bindings/sound/wlf,arizona.txt
 F:	arch/arm/mach-s3c64xx/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
 F:	drivers/extcon/extcon-arizona.c
-- 
2.14.1
