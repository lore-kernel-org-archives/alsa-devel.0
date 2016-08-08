From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on max9860" to the asoc tree
Date: Mon, 08 Aug 2016 12:04:36 +0100
Message-ID: <E1bWiMG-0003h9-59@debutante>
References: <878tw77ick.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <878tw77ick.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on max9860

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

>From 750a33e6173c5ac5f202f15bb092eb4965f4547d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:00:35 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 max9860

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 68074c92a7c0..499bdbfd0a2d 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -538,12 +538,14 @@ static struct snd_soc_codec_driver max9860_codec_driver = {
 	.set_bias_level = max9860_set_bias_level,
 	.idle_bias_off = true,
 
-	.controls = max9860_controls,
-	.num_controls = ARRAY_SIZE(max9860_controls),
-	.dapm_widgets = max9860_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(max9860_dapm_widgets),
-	.dapm_routes = max9860_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(max9860_dapm_routes),
+	.component_driver = {
+		.controls		= max9860_controls,
+		.num_controls		= ARRAY_SIZE(max9860_controls),
+		.dapm_widgets		= max9860_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(max9860_dapm_widgets),
+		.dapm_routes		= max9860_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(max9860_dapm_routes),
+	},
 };
 
 #ifdef CONFIG_PM
-- 
2.8.1
