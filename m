From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm-formatter: add reset" to the asoc tree
Date: Thu,  4 Jul 2019 13:24:54 +0100 (BST)
Message-ID: <20190704122454.725B0274389B@ypsilon.sirena.org.uk>
References: <20190703120749.32341-3-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703120749.32341-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-tdm-formatter: add reset

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 751bd5db52604f3f71d54dbad82707ef2475b707 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 3 Jul 2019 14:07:49 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: add reset

Add the optional reset line handling which is present on the new SoC
families, such as the g12a. Triggering this reset is not critical but
it helps solve a channel shift issue on the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190703120749.32341-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 0c6cce5c5773..2e498201139f 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <sound/soc.h>
 
 #include "axg-tdm-formatter.h"
@@ -20,6 +21,7 @@ struct axg_tdm_formatter {
 	struct clk *lrclk;
 	struct clk *sclk_sel;
 	struct clk *lrclk_sel;
+	struct reset_control *reset;
 	bool enabled;
 	struct regmap *map;
 };
@@ -75,6 +77,24 @@ static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 	if (formatter->enabled)
 		return 0;
 
+	/*
+	 * On the g12a (and possibly other SoCs), when a stream using
+	 * multiple lanes is restarted, it will sometimes not start
+	 * from the first lane, but randomly from another used one.
+	 * The result is an unexpected and random channel shift.
+	 *
+	 * The hypothesis is that an HW counter is not properly reset
+	 * and the formatter simply starts on the lane it stopped
+	 * before. Unfortunately, there does not seems to be a way to
+	 * reset this through the registers of the block.
+	 *
+	 * However, the g12a has indenpendent reset lines for each audio
+	 * devices. Using this reset before each start solves the issue.
+	 */
+	ret = reset_control_reset(formatter->reset);
+	if (ret)
+		return ret;
+
 	/*
 	 * If sclk is inverted, invert it back and provide the inversion
 	 * required by the formatter
@@ -306,6 +326,15 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Formatter dedicated reset line */
+	formatter->reset = reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(formatter->reset)) {
+		ret = PTR_ERR(formatter->reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get reset: %d\n", ret);
+		return ret;
+	}
+
 	return devm_snd_soc_register_component(dev, drv->component_drv,
 					       NULL, 0);
 }
-- 
2.20.1
