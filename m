From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add DT documentation for the sound-name-prefix property" to the asoc tree
Date: Fri, 13 Jul 2018 16:10:14 +0100 (BST)
Message-ID: <20180713151014.D9E5444007E@finisterre.ee.mobilebroadband>
References: <20180713125043.13242-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713125043.13242-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add DT documentation for the sound-name-prefix property

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

>From d5418ae3f9443f911d4324c0cade988ced39cfbe Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 13 Jul 2018 14:50:42 +0200
Subject: [PATCH] ASoC: add DT documentation for the sound-name-prefix property

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/name-prefix.txt | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

diff --git a/Documentation/devicetree/bindings/sound/name-prefix.txt b/Documentation/devicetree/bindings/sound/name-prefix.txt
new file mode 100644
index 000000000000..645775908657
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/name-prefix.txt
@@ -0,0 +1,24 @@
+Name prefix:
+
+Card implementing the routing property define the connection between
+audio components as list of string pair. Component using the same
+sink/source names may use the name prefix property to prepend the
+name of their sinks/sources with the provided string.
+
+Optional name prefix property:
+- sound-name-prefix : string using as prefix for the sink/source names of
+		      the component.
+
+Example: Two instances of the same component.
+
+amp0: analog-amplifier@0 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+	sound-name-prefix = "FRONT";
+};
+
+amp1: analog-amplifier@1 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_4 0>;
+	sound-name-prefix = "BACK";
+};
-- 
2.18.0
