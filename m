From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7241: add dt-bindings documentation for the es7241 adc" to the asoc tree
Date: Tue, 03 Jul 2018 16:34:28 +0100
Message-ID: <E1faNK0-0003rC-3E@debutante>
References: <20180703132845.26554-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703132845.26554-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7241: add dt-bindings documentation for the es7241 adc

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

>From 1b8fc56ed514f815c4779273348c3308fb263c87 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 15:28:44 +0200
Subject: [PATCH] ASoC: es7241: add dt-bindings documentation for the es7241
 adc

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/everest,es7241.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..28f82cf4959f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,28 @@
+ES7241 i2s AD converter
+
+Required properties:
+- compatible : "everest,es7241"
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+
+Optional properties:
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+- everest,sdout-pull-down:
+   Format used by the serial interface is controlled by pulling
+   the sdout. If the sdout is pulled down, leftj format is used.
+   If this property is not provided, sdout is assumed to pulled
+   up and i2s format is used
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
2.18.0.rc2
