From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: update DT binding with new compatible and supplies" to the asoc tree
Date: Tue, 03 Jul 2018 16:34:09 +0100
Message-ID: <E1faNJh-0003hp-1Y@debutante>
References: <20180703150600.17697-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703150600.17697-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: update DT binding with new compatible and supplies

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

>From c9445d94d7fc60e7b0290df9e109daef85d26bd4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 17:05:58 +0200
Subject: [PATCH] ASoC: es7134: update DT binding with new compatible and
 supplies

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..091666069bde 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,10 +1,15 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+- VDD-supply : regulator phandle for the VDD supply
+- PVDD-supply: regulator phandle for the PVDD supply for the es7154
 
 Example:
 
 i2s_codec: external-codec {
 	compatible = "everest,es7134";
+	VDD-supply = <&vcc_5v>;
 };
-- 
2.18.0.rc2
