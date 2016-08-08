From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on da7210" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:24 +0100
Message-ID: <E1bWiK8-000348-Mv@debutante>
References: <87fuqf4oka.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuqf4oka.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on da7210

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

>From 57329a3a419273e765f5654c3c8cad9266c5b6f2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:14:35 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 da7210

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7210.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index af23a61b7b28..17053dfc94cf 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1167,13 +1167,14 @@ static int da7210_probe(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.probe			= da7210_probe,
 
-	.controls		= da7210_snd_controls,
-	.num_controls		= ARRAY_SIZE(da7210_snd_controls),
-
-	.dapm_widgets		= da7210_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(da7210_dapm_widgets),
-	.dapm_routes		= da7210_audio_map,
-	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
+	.component_driver = {
+		.controls		= da7210_snd_controls,
+		.num_controls		= ARRAY_SIZE(da7210_snd_controls),
+		.dapm_widgets		= da7210_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(da7210_dapm_widgets),
+		.dapm_routes		= da7210_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
+	},
 };
 
 #if IS_ENABLED(CONFIG_I2C)
-- 
2.8.1
