From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on wm8804" to the asoc tree
Date: Mon, 08 Aug 2016 12:06:20 +0100
Message-ID: <E1bWiNw-0004Bk-CN@debutante>
References: <87mvkn8xgt.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87mvkn8xgt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on wm8804

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

>From f1d13276e1856814ac02c077ba0829f6d16b9468 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:48:42 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 wm8804

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8804.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 8d914702cae4..af95d648265b 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -545,10 +545,12 @@ static struct snd_soc_dai_driver wm8804_dai = {
 static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.idle_bias_off = true,
 
-	.dapm_widgets = wm8804_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm8804_dapm_widgets),
-	.dapm_routes = wm8804_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm8804_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= wm8804_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(wm8804_dapm_widgets),
+		.dapm_routes		= wm8804_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(wm8804_dapm_routes),
+	},
 };
 
 const struct regmap_config wm8804_regmap_config = {
-- 
2.8.1
