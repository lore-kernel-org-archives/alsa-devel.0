From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on tas571x" to the asoc tree
Date: Mon, 08 Aug 2016 12:05:26 +0100
Message-ID: <E1bWiN4-0003wH-Us@debutante>
References: <87wpjr7il9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wpjr7il9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on tas571x

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

>From d75a9df6927363e5c4a41477db39e5332aa6bf73 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:55:21 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 tas571x

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index d8baca3f8413..df5e5cb33baa 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -658,10 +658,12 @@ static const struct snd_soc_codec_driver tas571x_codec = {
 	.set_bias_level = tas571x_set_bias_level,
 	.idle_bias_off = true,
 
-	.dapm_widgets = tas571x_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(tas571x_dapm_widgets),
-	.dapm_routes = tas571x_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(tas571x_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= tas571x_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(tas571x_dapm_widgets),
+		.dapm_routes		= tas571x_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(tas571x_dapm_routes),
+	},
 };
 
 static struct snd_soc_dai_driver tas571x_dai = {
@@ -754,8 +756,8 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
-	priv->codec_driver.controls = priv->chip->controls;
-	priv->codec_driver.num_controls = priv->chip->num_controls;
+	priv->codec_driver.component_driver.controls = priv->chip->controls;
+	priv->codec_driver.component_driver.num_controls = priv->chip->num_controls;
 
 	if (priv->chip->vol_reg_size == 2) {
 		/*
-- 
2.8.1
