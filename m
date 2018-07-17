From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH RESEND 01/15] ASoC: meson: add axg fifos DT binding documentation
Date: Tue, 17 Jul 2018 17:42:50 +0200
Message-ID: <20180717154304.9973-2-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add the DT bindings documentation for axg's FIFOs: TODDR and FRDDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/amlogic,axg-fifo.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
new file mode 100644
index 000000000000..3dfc2515e5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -0,0 +1,23 @@
+* Amlogic Audio FIFO controllers
+
+Required properties:
+- compatible: 'amlogic,axg-toddr' or
+	      'amlogic,axg-frddr'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- interrupts: interrupt specifier for the fifo.
+- clocks: phandle to the fifo peripheral clock provided by the audio
+	  clock controller.
+- resets: phandle to memory ARB line provided by the arb reset controller.
+- #sound-dai-cells: must be 0.
+
+Example of FRDDR A on the A113 SoC:
+
+frddr_a: audio-controller@1c0 {
+	compatible = "amlogic,axg-frddr";
+	reg = <0x0 0x1c0 0x0 0x1c>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+	resets = <&arb AXG_ARB_FRDDR_A>;
+};
-- 
2.14.4
