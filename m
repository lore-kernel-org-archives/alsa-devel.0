From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm-formatter: free reset on device removal" to the asoc tree
Date: Tue, 20 Aug 2019 14:14:20 +0100 (BST)
Message-ID: <20190820131420.8F31F274314E@ypsilon.sirena.org.uk>
References: <20190820123413.22249-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820123413.22249-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-tdm-formatter: free reset on device removal

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

>From 18dd62ae3bc31baa0473e4a09e46c02e0bdc57a0 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 20 Aug 2019 14:34:13 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: free reset on device removal

Use the devm variant to get the formatter reset so it is properly freed
on device removal

Fixes: 751bd5db5260 ("ASoC: meson: axg-tdm-formatter: add reset")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190820123413.22249-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 2e498201139f..1a0bf9d3836d 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -327,7 +327,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	}
 
 	/* Formatter dedicated reset line */
-	formatter->reset = reset_control_get_optional_exclusive(dev, NULL);
+	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(formatter->reset)) {
 		ret = PTR_ERR(formatter->reset);
 		if (ret != -EPROBE_DEFER)
-- 
2.20.1
