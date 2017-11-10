From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/2] ASoC: codecs: Add PCM186x binding
	documentation
Date: Fri, 10 Nov 2017 13:57:10 -0600
Message-ID: <20171110195711.24210-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id EA94326705F
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 20:57:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Add the dt-binding documentation for the TI PCM186x 2ch and 4ch Audio
ADCs With Universal Front End.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/sound/pcm186x.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
new file mode 100644
index 000000000000..0bc7d265c7bd
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
+	pcm186x: pcm186x@4a {
+		compatible = "ti,pcm1865";
+		reg = <0x4a>;
+
+		avdd-supply = <&reg_3v3_analog>;
+		dvdd-supply = <&reg_3v3>;
+		iovdd-supply = <&reg_1v8>;
+	};
-- 
2.15.0
