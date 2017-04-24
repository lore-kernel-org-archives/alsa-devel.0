From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 13/18] dt-bindings: gpio: Add bindings for GPIO on Cirrus Logic Madera codecs
Date: Mon, 24 Apr 2017 17:08:39 +0100
Message-ID: <1493050124-5970-14-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic Madera codecs have a range of GPIO pins that can be
used as single-bit logic input or output. These are presented as a
standard GPIO binding.

The second cell in a GPIO binding is currently reserved for future use
as chip-specific flags.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
Changes from V1:
- moved out of main gpio patch into a separate patch
- added gpio-line-names as an optional property

 .../devicetree/bindings/gpio/gpio-madera.txt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-madera.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-madera.txt b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
new file mode 100644
index 0000000..6254f5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
@@ -0,0 +1,27 @@
+Cirrus Logic Madera class audio codecs gpio driver
+
+This is a subnode of the parent mfd node.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+Required properties:
+  - compatible : must be "cirrus,madera-gpio"
+  - gpio-controller : Indicates this device is a GPIO controller.
+  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
+    is reserved for future use and must be zero
+
+Optional properties:
+  - gpio-line-names : as described in bindings/gpio/gpio.txt
+
+Example:
+
+cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	gpio {
+		compatible = "cirrus,madera-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	}
+};
-- 
1.9.1

