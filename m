From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [v5 RESEND 10/17] pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
Date: Mon, 20 Nov 2017 14:10:44 +0000
Message-ID: <20171120141051.29467-11-rf@opensource.cirrus.com>
References: <20171120141051.29467-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171120141051.29467-1-rf@opensource.cirrus.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

This is the binding description of the pinctrl driver for Cirru Logic
Madera codecs. The binding uses the generic pinctrl binding so  the main
purpose here is to describe the device-specific names for groups and
functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
new file mode 100644
index 000000000000..b0e36cf0d289
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
2.11.0

