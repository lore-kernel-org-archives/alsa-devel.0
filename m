From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 05/15] ASoC: meson: add axg spdif output DT bindings documentation
Date: Tue, 17 Jul 2018 17:36:30 +0200
Message-ID: <20180717153643.8806-7-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add the DT bindings documentation for axg's SPDIF output.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifout.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
new file mode 100644
index 000000000000..521c38ad89e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -0,0 +1,20 @@
+* Amlogic Audio SPDIF Output
+
+Required properties:
+- compatible: 'amlogic,axg-spdifout'
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "mclk" : master clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifout: audio-controller@480 {
+	compatible = "amlogic,axg-spdifout";
+	reg = <0x0 0x480 0x0 0x50>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+		 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+	clock-names = "pclk", "mclk";
+};
-- 
2.14.4
