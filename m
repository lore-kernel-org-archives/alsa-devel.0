From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on cs42l73" to the asoc tree
Date: Mon, 08 Aug 2016 12:04:15 +0100
Message-ID: <E1bWiLv-0003an-OP@debutante>
References: <87y44763of.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y44763of.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on cs42l73

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

>From 951cd7e6ffda4dc86ed6fb6ff10e0ca8f3b67c2b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:02:48 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 cs42l73

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 42a8fd4e1f9b..01b573ab7036 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1257,13 +1257,14 @@ static const struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
 	.set_bias_level = cs42l73_set_bias_level,
 	.suspend_bias_off = true,
 
-	.dapm_widgets = cs42l73_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(cs42l73_dapm_widgets),
-	.dapm_routes = cs42l73_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
-
-	.controls = cs42l73_snd_controls,
-	.num_controls = ARRAY_SIZE(cs42l73_snd_controls),
+	.component_driver = {
+		.controls		= cs42l73_snd_controls,
+		.num_controls		= ARRAY_SIZE(cs42l73_snd_controls),
+		.dapm_widgets		= cs42l73_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(cs42l73_dapm_widgets),
+		.dapm_routes		= cs42l73_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(cs42l73_audio_map),
+	},
 };
 
 static const struct regmap_config cs42l73_regmap = {
-- 
2.8.1
