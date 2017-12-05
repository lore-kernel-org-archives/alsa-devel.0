From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 1/2] ASoC: codecs: Add PCM186x binding documentation
Date: Tue, 5 Dec 2017 14:52:55 -0600
Message-ID: <20171205205256.14592-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Add the dt-binding documentation for the TI PCM186x 2ch and 4ch Audio
ADCs With Universal Front End.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes from v2:
 - None

Changes from v1:
 - pcm186x@4a -> audio-codec@4a
 - Added Acked-by

 .../devicetree/bindings/sound/pcm186x.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
new file mode 100644
index 000000000000..1087f4855980
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm186x.txt
@@ -0,0 +1,42 @@
+Texas Instruments PCM186x Universal Audio ADC
+
+These devices support both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+ - compatible : "ti,pcm1862",
+                "ti,pcm1863",
+                "ti,pcm1864",
+                "ti,pcm1865"
+
+ - reg : The I2C address of the device for I2C, the chip select
+         number for SPI.
+
+ - avdd-supply: Analog core power supply (3.3v)
+ - dvdd-supply: Digital core power supply
+ - iovdd-supply: Digital IO power supply
+        See regulator/regulator.txt for more information
+
+CODEC input pins:
+ * VINL1
+ * VINR1
+ * VINL2
+ * VINR2
+ * VINL3
+ * VINR3
+ * VINL4
+ * VINR4
+
+The pins can be used in referring sound node's audio-routing property.
+
+Example:
+
+	pcm186x: audio-codec@4a {
+		compatible = "ti,pcm1865";
+		reg = <0x4a>;
+
+		avdd-supply = <&reg_3v3_analog>;
+		dvdd-supply = <&reg_3v3>;
+		iovdd-supply = <&reg_1v8>;
+	};
-- 
2.15.0
