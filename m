From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v2 2/2] ASoC: Add bindings for PCM1789
Date: Mon,  5 Mar 2018 13:48:17 +0100
Message-ID: <20180305124817.7421-3-mylene.josserand@bootlin.com>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305124817.7421-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com, alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

Add a device-tree binding for Texas Instrument's PCM1789 codec.
For the moment, only I2C bus is supported but SPI could be added
in future.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 Documentation/devicetree/bindings/sound/pcm1789.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm1789.txt b/Documentation/devicetree/bindings/sound/pcm1789.txt
new file mode 100644
index 000000000000..a6cdc2c83c98
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm1789.txt
@@ -0,0 +1,21 @@
+Texas Instruments pcm1789 DT bindings
+
+This driver supports the I2C bus.
+
+Required properties:
+
+ - compatible: "ti,pcm1789"
+
+Required properties on I2C:
+
+ - reg: the I2C address
+ - reset-gpios: GPIO to control the RESET pin
+
+Examples:
+
+	codec: pcm1789@4c {
+		compatible = "ti,pcm1789";
+		reg = <0x4c>;
+		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+	};
-- 
2.11.0
