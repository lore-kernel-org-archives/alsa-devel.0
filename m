From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ad193x" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:11 +0100
Message-ID: <E1bWiKt-0003Hr-CA@debutante>
References: <8737mf63cv.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737mf63cv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ad193x

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

>From 1d09e8c35626ea0b899c1cd1922d8802bd169868 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:09:43 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ad193x

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 3a3f3f2343d7..d643557d89a7 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -410,12 +410,14 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.probe = ad193x_codec_probe,
-	.controls = ad193x_snd_controls,
-	.num_controls = ARRAY_SIZE(ad193x_snd_controls),
-	.dapm_widgets = ad193x_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ad193x_dapm_widgets),
-	.dapm_routes = audio_paths,
-	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+	.component_driver = {
+		.controls		= ad193x_snd_controls,
+		.num_controls		= ARRAY_SIZE(ad193x_snd_controls),
+		.dapm_widgets		= ad193x_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ad193x_dapm_widgets),
+		.dapm_routes		= audio_paths,
+		.num_dapm_routes	= ARRAY_SIZE(audio_paths),
+	},
 };
 
 const struct regmap_config ad193x_regmap_config = {
-- 
2.8.1
