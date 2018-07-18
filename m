From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: add axg tdm formatters DT bindings documentation" to the asoc tree
Date: Wed, 18 Jul 2018 13:25:10 +0100
Message-ID: <E1fflW2-000788-CV@debutante>
References: <20180717153643.8806-9-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-9-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: add axg tdm formatters DT bindings documentation

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

>From 7713a70034f2cb54168d134ac523fdfcdda92a13 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:56 +0200
Subject: [PATCH] ASoC: meson: add axg tdm formatters DT bindings documentation

Add the DT bindings documentation for axg's TDM formatters: TDMIN
and TDMOUT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../sound/amlogic,axg-tdm-formatters.txt      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
new file mode 100644
index 000000000000..1c1b7490554e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -0,0 +1,28 @@
+* Amlogic Audio TDM formatters
+
+Required properties:
+- compatible: 'amlogic,axg-tdmin' or
+	      'amlogic,axg-tdmout'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"     : peripheral clock.
+  * "sclk"     : bit clock.
+  * "sclk_sel" : bit clock input multiplexer.
+  * "lrclk"    : sample clock
+  * "lrclk_sel": sample clock input multiplexer
+
+Example of TDMOUT_A on the A113 SoC:
+
+tdmout_a: audio-controller@500 {
+	compatible = "amlogic,axg-tdmout";
+	reg = <0x0 0x500 0x0 0x40>;
+	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+	clock-names = "pclk", "sclk", "sclk_sel",
+		      "lrclk", "lrclk_sel";
+};
-- 
2.18.0
