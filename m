From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: add axg fifos DT binding documentation" to the asoc tree
Date: Wed, 18 Jul 2018 13:27:06 +0100
Message-ID: <E1fflXu-0007H0-JJ@debutante>
References: <20180717153643.8806-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: add axg fifos DT binding documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:50 +0200
Subject: [PATCH] ASoC: meson: add axg fifos DT binding documentation

Add the DT bindings documentation for axg's FIFOs: TODDR and FRDDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-fifo.txt       | 23 +++++++++++++++++++
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
2.18.0
