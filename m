From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 1/2] ASoC: es7241: add dt-bindings documentation for the es7241 adc
Date: Sat, 30 Jun 2018 19:22:40 +0200
Message-ID: <20180630172241.10806-2-jbrunet@baylibre.com>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180630172241.10806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/everest,es7241.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..adee52281b3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,23 @@
+ES7134 i2s DA converter
+
+Required properties:
+- compatible : "everest,es7241"
+
+Optional properties:
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+
+Example:
+
+linein: audio-codec@2 {
+	#sound-dai-cells = <0>;
+	compatible = "everest,es7241";
+	VDDA-supply = <&vcc_3v3>;
+	VDDP-supply = <&vcc_3v3>;
+	VDDD-supply = <&vcc_3v3>;
+	reset-gpios = <&gpio GPIOH_42>;
+};
-- 
2.14.4
