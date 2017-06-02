From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v3 10/17] pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
Date: Fri, 2 Jun 2017 16:03:03 +0100
Message-ID: <1496415790-19164-11-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1496415790-19164-1-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This is the binding description of the pinctrl driver for Cirru Logic
Madera codecs. The binding uses the generic pinctrl binding so  the main
purpose here is to describe the device-specific names for groups and
functions.

Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
Changes since V2:
- Edits to take account of change requested by DT maintainer to keep the child
  bindings are part of the parent MFD node instead of per-driver child nodes
  
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
new file mode 100644
index 0000000..b0e36cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
@@ -0,0 +1,99 @@
+Cirrus Logic Madera class audio codecs pinctrl driver
+
+The Cirrus Logic Madera codecs provide a number of GPIO functions for
+interfacing to external hardware and to provide logic outputs to other devices.
+Certain groups of GPIO pins also have an alternate function, normally as an
+audio interface.
+
+The set of available GPIOs, functions and alternate function groups differs
+between codecs so refer to the datasheet for the codec for further information
+on what is supported on that device.
+
+The properties for this driver exist within the parent MFD driver node.
+
+See also
+  the core bindings for the parent MFD driver:
+    Documentation/devicetree/bindings/mfd/madera.txt
+
+  the generic pinmix bindings:
+    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Required properties of parent mfd node:
+  - pinctrl-names : must be "default"
+  - pinctrl-0 : a phandle to the node containing the subnodes containing default
+      configurations
+
+Required subnodes:
+  One subnode is required to contain the default settings. It contains an
+  arbitrary number of configuration subnodes, one for each group or pin
+  configuration you want to apply as a default.
+
+Required properties of configuration subnodes:
+  - groups : name of one pin group to configure. One of:
+	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
+	dmic4, dmic5, dmic6,
+	gpio1, gpio2, ..., gpio40
+    The gpioN groups select the single pin of this name for configuration
+
+Optional properties of configuration subnodes:
+  Any configuration option not explicitly listed in the dts will be left at
+  chip default setting.
+
+  - function : name of function to assign to this group. One of:
+	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
+	dmic3, dmic4, dmic5, dmic6,
+	io, dsp-gpio, irq1, irq2,
+	fll1-clk, fll1-lock, fll2-clk, fll2-lock, fll3-clk, fll3-lock,
+	fllao-clk, fllao-lock,
+	opclk, opclk-async, pwm1, pwm2, spdif,
+	asrc1-in1-lock, asrc1-in2-lock, asrc2-in1-lock, asrc2-in2-lock,
+	spkl-short-circuit, spkr-short-circuit, spk-shutdown,
+	spk-overheat-shutdown, spk-overheat-warn,
+	timer1-sts, timer2-sts, timer3-sts, timer4-sts, timer5-sts, timer6-sts,
+	timer7-sts, timer8-sts,
+	log1-fifo-ne, log2-fifo-ne, log3-fifo-ne, log4-fifo-ne, log5-fifo-ne,
+	log6-fifo-ne, log7-fifo-ne, log8-fifo-ne,
+
+  - bias-disable : disable pull-up and pull-down
+  - bias-bus-hold : enable buskeeper
+  - bias-pull-up : output is pulled-up
+  - bias-pull-down : output is pulled-down
+  - drive-push-pull : CMOS output
+  - drive-open-drain : open-drain output
+  - drive-strength : drive strength in mA. Valid values are 4 or 8
+  - input-schmitt-enable : enable schmitt-trigger mode
+  - input-schmitt-disable : disable schmitt-trigger mode
+  - input-debounce : A value of 0 disables debounce, a value !=0 enables
+	debounce
+  - output-low : set the pin to output mode with low level
+  - output-high : set the pin to output mode with high level
+
+Example:
+
+cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cs47l85_defaults>;
+
+	cs47l85_defaults: cs47l85-gpio-defaults {
+		aif1 {
+			groups = "aif1";
+			function = "aif1";
+			bias-bus-hold;
+		};
+
+		aif2 {
+			groups = "aif2";
+			function = "aif2";
+			bias-bus-hold;
+		};
+
+		opclk {
+			groups = "gpio1";
+			function = "opclk";
+			bias-pull-up;
+			drive-strength = <8>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
