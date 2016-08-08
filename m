From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on wm8974" to the asoc tree
Date: Mon, 08 Aug 2016 12:06:26 +0100
Message-ID: <E1bWiO2-0004DX-84@debutante>
References: <87popj8xhw.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87popj8xhw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on wm8974

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

>From 48b042380e970b70f1c5453d31c6bbff2114974e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:48:05 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 wm8974

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8974.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index dc8c3b1ebb6f..fbda6e3f8a9d 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -681,12 +681,14 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.set_bias_level = wm8974_set_bias_level,
 	.suspend_bias_off = true,
 
-	.controls = wm8974_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8974_snd_controls),
-	.dapm_widgets = wm8974_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm8974_dapm_widgets),
-	.dapm_routes = wm8974_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm8974_dapm_routes),
+	.component_driver = {
+		.controls		= wm8974_snd_controls,
+		.num_controls		= ARRAY_SIZE(wm8974_snd_controls),
+		.dapm_widgets		= wm8974_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(wm8974_dapm_widgets),
+		.dapm_routes		= wm8974_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(wm8974_dapm_routes),
+	},
 };
 
 static int wm8974_i2c_probe(struct i2c_client *i2c,
-- 
2.8.1
