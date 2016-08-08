From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on da7218" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:18 +0100
Message-ID: <E1bWiK2-00032O-QV@debutante>
References: <87d1lj4ojd.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1lj4ojd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on da7218

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

>From 91985829cc198dad64b29980aef226e4af2f65c6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:15:10 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 da7218

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 99ce23e113bf..dcdda6c15cf7 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3045,13 +3045,14 @@ static struct snd_soc_codec_driver soc_codec_dev_da7218 = {
 	.resume			= da7218_resume,
 	.set_bias_level		= da7218_set_bias_level,
 
-	.controls		= da7218_snd_controls,
-	.num_controls		= ARRAY_SIZE(da7218_snd_controls),
-
-	.dapm_widgets		= da7218_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(da7218_dapm_widgets),
-	.dapm_routes		= da7218_audio_map,
-	.num_dapm_routes	= ARRAY_SIZE(da7218_audio_map),
+	.component_driver = {
+		.controls		= da7218_snd_controls,
+		.num_controls		= ARRAY_SIZE(da7218_snd_controls),
+		.dapm_widgets		= da7218_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(da7218_dapm_widgets),
+		.dapm_routes		= da7218_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(da7218_audio_map),
+	},
 };
 
 
-- 
2.8.1
