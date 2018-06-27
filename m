From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-amplifier: remame dio2125 documentation" to the asoc tree
Date: Wed, 27 Jun 2018 12:30:27 +0100 (BST)
Message-ID: <20180627113027.6DABD440070@finisterre.ee.mobilebroadband>
References: <20180626121128.28564-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626121128.28564-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-amplifier: remame dio2125 documentation

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

>From 0ed03e6dc288c50b2e7d71523b99df1afd81cea1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 26 Jun 2018 14:11:26 +0200
Subject: [PATCH] ASoC: simple-amplifier: remame dio2125 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dio2125 is simple enough that we can make it a generic component.
Rename the the dio2125 documentation to simple-amplifier to
prepare this change.

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/dioo,dio2125.txt       | 12 ------------
 .../devicetree/bindings/sound/simple-amplifier.txt   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-amplifier.txt

diff --git a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
deleted file mode 100644
index 63dbfe0f11d0..000000000000
--- a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-DIO2125 Audio Driver
-
-Required properties:
-- compatible : "dioo,dio2125"
-- enable-gpios : the gpio connected to the enable pin of the dio2125
-
-Example:
-
-amp: analog-amplifier {
-	compatible = "dioo,dio2125";
-	enable-gpios = <&gpio GPIOH_3 0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
new file mode 100644
index 000000000000..8647edae7af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -0,0 +1,12 @@
+Simple Amplifier Audio Driver
+
+Required properties:
+- compatible : "dioo,dio2125" or "simple-audio-amplifier"
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
+
+Example:
+
+amp: analog-amplifier {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+};
-- 
2.17.1
