From: Michael Stecklein <m-stecklein@ti.com>
Subject: [PATCH 1/2] dt-bindings: sound: add bindings for TAS6424
Date: Fri, 16 Jun 2017 10:33:39 -0500
Message-ID: <1497627220-7196-2-git-send-email-m-stecklein@ti.com>
References: <1497627220-7196-1-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497627220-7196-1-git-send-email-m-stecklein@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Michael Stecklein <m-stecklein@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the bindings for the TAS6424 digital amplifier.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
new file mode 100644
index 0000000..27227b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -0,0 +1,31 @@
+Texas Instruments TAS6424 Quad-Channel Audio amplifier
+
+The TAS6424 serial control bus communicates through I2C protocols.
+
+Required properties:
+	- compatible - One of: "ti,tas6424" - TAS6424
+	- reg - I2C slave address
+	- sound-dai-cells: must be equal to 0
+
+Optional properties:
+	- pinctrl-names, pinctrl-0 - Please refer to pinctrl-bindings.txt
+	- interrupts-extended - describe the interrupt line used to inform the
+	  host. Please refer to interrupt-controller/interrupts.txt
+
+Example:
+
+tas6424: tas6424@6a {
+	#sound-dai-cells = <0>;
+
+	status = "okay";
+
+	compatible = "ti,tas6424";
+	reg = <0x6a>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&tas6424_int_pin>;
+	interrupts-extended = <&gpio1 28 IRQ_TYPE_EDGE_FALLING>;
+};
+
+For more product information please see the link below:
+http://www.ti.com/product/TAS6424-Q1
-- 
2.7.4
