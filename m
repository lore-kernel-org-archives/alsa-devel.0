From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on jz4740" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:58 +0100
Message-ID: <E1bWiJi-0002vq-9e@debutante>
References: <8737mf4ofu.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737mf4ofu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on jz4740

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

>From af15dc71b0c343279678af50543f6a64e84fb569 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:17:19 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 jz4740

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4740.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 1f5ab99956ed..0290fab383da 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -298,12 +298,14 @@ static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.set_bias_level = jz4740_codec_set_bias_level,
 	.suspend_bias_off = true,
 
-	.controls = jz4740_codec_controls,
-	.num_controls = ARRAY_SIZE(jz4740_codec_controls),
-	.dapm_widgets = jz4740_codec_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(jz4740_codec_dapm_widgets),
-	.dapm_routes = jz4740_codec_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(jz4740_codec_dapm_routes),
+	.component_driver = {
+		.controls		= jz4740_codec_controls,
+		.num_controls		= ARRAY_SIZE(jz4740_codec_controls),
+		.dapm_widgets		= jz4740_codec_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(jz4740_codec_dapm_widgets),
+		.dapm_routes		= jz4740_codec_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(jz4740_codec_dapm_routes),
+	},
 };
 
 static const struct regmap_config jz4740_codec_regmap_config = {
-- 
2.8.1
