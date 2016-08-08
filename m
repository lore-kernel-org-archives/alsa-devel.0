From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on tas5086" to the asoc tree
Date: Mon, 08 Aug 2016 12:05:23 +0100
Message-ID: <E1bWiN1-0003vO-SX@debutante>
References: <87vazb7iks.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vazb7iks.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on tas5086

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9a9a069c4445122b98025e8b1003caf5e0eba037 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:55:41 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 tas5086

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5086.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index d49d25d51957..c297b9fc8bf6 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -890,12 +890,14 @@ static struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
 	.remove			= tas5086_remove,
 	.suspend		= tas5086_soc_suspend,
 	.resume			= tas5086_soc_resume,
-	.controls		= tas5086_controls,
-	.num_controls		= ARRAY_SIZE(tas5086_controls),
-	.dapm_widgets		= tas5086_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(tas5086_dapm_widgets),
-	.dapm_routes		= tas5086_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(tas5086_dapm_routes),
+	.component_driver = {
+		.controls		= tas5086_controls,
+		.num_controls		= ARRAY_SIZE(tas5086_controls),
+		.dapm_widgets		= tas5086_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(tas5086_dapm_widgets),
+		.dapm_routes		= tas5086_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(tas5086_dapm_routes),
+	},
 };
 
 static const struct i2c_device_id tas5086_i2c_id[] = {
-- 
2.8.1
