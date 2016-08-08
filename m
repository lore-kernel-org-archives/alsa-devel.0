From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on max98925" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:37 +0100
Message-ID: <E1bWiJN-0002pl-Rq@debutante>
References: <87shuf39rq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shuf39rq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on max98925

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

>From 4a4339d947e8989aa4f81dbc1cf086a11dbeeb89 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:19:29 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 max98925

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98925.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 5990de317999..327eaa25c9bd 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -540,12 +540,14 @@ static int max98925_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver soc_codec_dev_max98925 = {
 	.probe            = max98925_probe,
-	.controls = max98925_snd_controls,
-	.num_controls = ARRAY_SIZE(max98925_snd_controls),
-	.dapm_routes = max98925_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(max98925_audio_map),
-	.dapm_widgets = max98925_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(max98925_dapm_widgets),
+	.component_driver = {
+		.controls		= max98925_snd_controls,
+		.num_controls		= ARRAY_SIZE(max98925_snd_controls),
+		.dapm_routes		= max98925_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(max98925_audio_map),
+		.dapm_widgets		= max98925_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(max98925_dapm_widgets),
+	},
 };
 
 static const struct regmap_config max98925_regmap = {
-- 
2.8.1
