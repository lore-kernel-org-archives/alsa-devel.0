From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 11/18] dt-bindings: pinctrl: Add bindings
	for Cirrus Logic Madera codecs
Date: Mon, 24 Apr 2017 17:08:37 +0100
Message-ID: <1493050124-5970-12-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9776C266DE0
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 18:08:53 +0200 (CEST)
In-Reply-To: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
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
Cc: linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is the binding description of the pinctrl driver for Cirru Logic
Madera codecs. The binding uses the generic pinctrl binding so  the main
purpose here is to describe the device-specific names for groups and
functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
Changes since V1:
- split out from main pinctrl patch into a separate patch
- fixed typo in pinctrl-names property description

 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
new file mode 100644
index 0000000..0de91b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
@@ -0,0 +1,102 @@
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
+The root node for this driver must be a subnode of the parent MFD driver node.
+It contains one subnode that is a container for an arbitrary number of subnodes
+to configure each pin or function group.
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
+  - pinctrl-0 : a phandle to the node containing the configuration subnodes
+
+Required properties of pinctrl subnode:
+  - compatible : must be "cirrus,madera-pinctrl"
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
+	pinctrl-0 = <&cs47l85_gpio_defaults>;
+
+	pinctrl {
+		compatible = "cirrus,madera-pinctrl";
+
+		cs47l85_gpio_defaults: defaults {
+			aif1 {
+				groups = "aif1";
+				function = "aif1";
+				bias-bus-hold;
+			};
+
+			aif2 {
+				groups = "aif2";
+				function = "aif2";
+				bias-bus-hold;
+			};
+
+			opclk {
+				groups = "gpio1";
+				function = "opclk";
+				bias-pull-up;
+				drive-strength = <8>;
+			};
+		};
+	};
+};
-- 
1.9.1
