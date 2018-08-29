From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/4] ASoC: meson: add axg pdm input DT binding documentation
Date: Wed, 29 Aug 2018 17:00:50 +0200
Message-ID: <20180829150051.18190-4-jbrunet@baylibre.com>
References: <20180829150051.18190-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829150051.18190-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the DT binding documentation for axg's PDM input

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-pdm.txt        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
new file mode 100644
index 000000000000..5672d0bc5b16
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -0,0 +1,24 @@
+* Amlogic Audio PDM input
+
+Required properties:
+- compatible: 'amlogic,axg-pdm'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"   : peripheral clock.
+  * "dclk"   : pdm digital clock
+  * "sysclk" : dsp system clock
+- #sound-dai-cells: must be 0.
+
+Example of PDM on the A113 SoC:
+
+pdm: audio-controller@ff632000 {
+	compatible = "amlogic,axg-pdm";
+	reg = <0x0 0xff632000 0x0 0x34>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_PDM>,
+		 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+		 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+	clock-names = "pclk", "dclk", "sysclk";
+};
-- 
2.17.1
