From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on 88pm860x-codec" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:08 +0100
Message-ID: <E1bWiKq-0003H1-FL@debutante>
References: <871t1z63cd.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871t1z63cd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on 88pm860x-codec

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

>From 33398b509aafe936ec57cb1023f7ff1ba9e48586 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:10:02 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 88pm860x-codec

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index e8bed6b0c9db..b013a4c62b63 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1361,12 +1361,14 @@ static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.set_bias_level	= pm860x_set_bias_level,
 	.get_regmap	= pm860x_get_regmap,
 
-	.controls = pm860x_snd_controls,
-	.num_controls = ARRAY_SIZE(pm860x_snd_controls),
-	.dapm_widgets = pm860x_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(pm860x_dapm_widgets),
-	.dapm_routes = pm860x_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(pm860x_dapm_routes),
+	.component_driver = {
+		.controls		= pm860x_snd_controls,
+		.num_controls		= ARRAY_SIZE(pm860x_snd_controls),
+		.dapm_widgets		= pm860x_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(pm860x_dapm_widgets),
+		.dapm_routes		= pm860x_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(pm860x_dapm_routes),
+	},
 };
 
 static int pm860x_codec_probe(struct platform_device *pdev)
-- 
2.8.1
