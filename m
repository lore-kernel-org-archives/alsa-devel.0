From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 1/2] ASoC: codecs: add TA5720 digital amplifier DT bindings
Date: Mon, 21 Mar 2016 12:08:26 -0500
Message-ID: <1458580107-4632-2-git-send-email-dannenberg@ti.com>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Andreas Dannenberg <dannenberg@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Texas Instruments TAS5720L/M device is a high-efficiency mono
Class-D audio power amplifier optimized for high transient power
capability to use the dynamic power headroom of small loudspeakers.
Its digital time division multiplexed (TDM) interface enables up to
16 devices to share the same bus.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/sound/tas5720.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt

diff --git a/Documentation/devicetree/bindings/sound/tas5720.txt b/Documentation/devicetree/bindings/sound/tas5720.txt
new file mode 100644
index 0000000..276b258
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas5720.txt
@@ -0,0 +1,37 @@
+Texas Instruments TAS5720 Mono Audio amplifier
+
+The TAS5720 serial control bus communicates through the I2C protocol only.
+
+Required properties:
+
+- compatible : "ti,tas5720"
+- reg : I2C slave address
+
+Optional properties:
+
+- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
+- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
+- interrupts  : reference to a GPIO pin connected to the TAS5720 FAULTZ pin for
+                error reporting purposes
+
+Note that in case of codec errors the driver relies on the TAS5720 datasheet-
+proposed "Auto Recovery Circuit" (connection between the FAULTZ and SDZ device
+pins) for continued operation. This connection should always be made independent
+of whether the optional interrupt-based fault-reporting feature is used.
+
+For more product information please see the links below:
+
+http://www.ti.com/product/TAS5720L
+http://www.ti.com/product/TAS5720M
+
+Example:
+
+tas5720: tas5720@6c {
+	status = "okay";
+	compatible = "ti,tas5720";
+	reg = <0x6c>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&tas572x_int_pin>;
+	interrupts-extended = <&gpio1 28 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.6.4
