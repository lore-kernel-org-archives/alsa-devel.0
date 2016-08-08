From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on rt5640" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:11 +0100
Message-ID: <E1bWiIx-0002he-Ge@debutante>
References: <87fuqf39n6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuqf39n6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on rt5640

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

>From b72aa483c4d3668b1e95a1d968e64262c7d876f1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:22:11 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 rt5640

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 09e8988bbb2d..fbe3af14bd13 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2261,12 +2261,14 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
 	.resume = rt5640_resume,
 	.set_bias_level = rt5640_set_bias_level,
 	.idle_bias_off = true,
-	.controls = rt5640_snd_controls,
-	.num_controls = ARRAY_SIZE(rt5640_snd_controls),
-	.dapm_widgets = rt5640_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(rt5640_dapm_widgets),
-	.dapm_routes = rt5640_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(rt5640_dapm_routes),
+	.component_driver = {
+		.controls		= rt5640_snd_controls,
+		.num_controls		= ARRAY_SIZE(rt5640_snd_controls),
+		.dapm_widgets		= rt5640_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(rt5640_dapm_widgets),
+		.dapm_routes		= rt5640_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(rt5640_dapm_routes),
+	},
 };
 
 static const struct regmap_config rt5640_regmap = {
-- 
2.8.1
