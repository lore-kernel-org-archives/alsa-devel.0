From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on da7219" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:15 +0100
Message-ID: <E1bWiJz-00031Y-Sx@debutante>
References: <87bn134oiv.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87bn134oiv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on da7219

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

>From b0d9df4dc5f3a690c460bb1bb0799ed85255448e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:15:27 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 da7219

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ea94317cb3..b6411bd3c4f2 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,13 +1767,14 @@ static struct snd_soc_codec_driver soc_codec_dev_da7219 = {
 	.resume			= da7219_resume,
 	.set_bias_level		= da7219_set_bias_level,
 
-	.controls		= da7219_snd_controls,
-	.num_controls		= ARRAY_SIZE(da7219_snd_controls),
-
-	.dapm_widgets		= da7219_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(da7219_dapm_widgets),
-	.dapm_routes		= da7219_audio_map,
-	.num_dapm_routes	= ARRAY_SIZE(da7219_audio_map),
+	.component_driver = {
+		.controls		= da7219_snd_controls,
+		.num_controls		= ARRAY_SIZE(da7219_snd_controls),
+		.dapm_widgets		= da7219_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(da7219_dapm_widgets),
+		.dapm_routes		= da7219_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(da7219_audio_map),
+	},
 };
 
 
-- 
2.8.1
