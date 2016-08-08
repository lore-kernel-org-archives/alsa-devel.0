From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on wm98095" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:49 +0100
Message-ID: <E1bWiJZ-0002tI-Gt@debutante>
References: <87y44739tw.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y44739tw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on wm98095

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

>From 7fb49ebab0a1e50848466096a217bd8f0aa729eb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:18:12 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 wm98095

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98095.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 3577003f39cf..6f8a757876ed 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2108,12 +2108,14 @@ static struct snd_soc_codec_driver soc_codec_dev_max98095 = {
 	.suspend = max98095_suspend,
 	.resume  = max98095_resume,
 	.set_bias_level = max98095_set_bias_level,
-	.controls = max98095_snd_controls,
-	.num_controls = ARRAY_SIZE(max98095_snd_controls),
-	.dapm_widgets	  = max98095_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(max98095_dapm_widgets),
-	.dapm_routes     = max98095_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(max98095_audio_map),
+	.component_driver = {
+		.controls		= max98095_snd_controls,
+		.num_controls		= ARRAY_SIZE(max98095_snd_controls),
+		.dapm_widgets		= max98095_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(max98095_dapm_widgets),
+		.dapm_routes		= max98095_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(max98095_audio_map),
+	},
 };
 
 static int max98095_i2c_probe(struct i2c_client *i2c,
-- 
2.8.1
