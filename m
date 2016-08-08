From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on pcm512x" to the asoc tree
Date: Mon, 08 Aug 2016 12:04:48 +0100
Message-ID: <E1bWiMS-0003ko-Db@debutante>
References: <87eg5z7iek.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87eg5z7iek.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on pcm512x

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

>From d25f113f969eb9a0ae3a61d3937a0fbfe7ecdbdd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:59:23 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 pcm512x

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 047c48953a20..72b19e62f626 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1348,12 +1348,14 @@ static struct snd_soc_codec_driver pcm512x_codec_driver = {
 	.set_bias_level = pcm512x_set_bias_level,
 	.idle_bias_off = true,
 
-	.controls = pcm512x_controls,
-	.num_controls = ARRAY_SIZE(pcm512x_controls),
-	.dapm_widgets = pcm512x_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(pcm512x_dapm_widgets),
-	.dapm_routes = pcm512x_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(pcm512x_dapm_routes),
+	.component_driver = {
+		.controls		= pcm512x_controls,
+		.num_controls		= ARRAY_SIZE(pcm512x_controls),
+		.dapm_widgets		= pcm512x_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(pcm512x_dapm_widgets),
+		.dapm_routes		= pcm512x_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(pcm512x_dapm_routes),
+	},
 };
 
 static const struct regmap_range_cfg pcm512x_range = {
-- 
2.8.1
