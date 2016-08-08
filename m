From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on sgtl5000" to the asoc tree
Date: Mon, 08 Aug 2016 12:04:57 +0100
Message-ID: <E1bWiMb-0003ni-A9@debutante>
References: <87invb7ig2.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87invb7ig2.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on sgtl5000

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

>From a324dbe5201aadbd96063404162d996ec8a6ad9e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:58:28 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 sgtl5000

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 527b759c1562..a635bd09d637 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1151,12 +1151,14 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.remove = sgtl5000_remove,
 	.set_bias_level = sgtl5000_set_bias_level,
 	.suspend_bias_off = true,
-	.controls = sgtl5000_snd_controls,
-	.num_controls = ARRAY_SIZE(sgtl5000_snd_controls),
-	.dapm_widgets = sgtl5000_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(sgtl5000_dapm_widgets),
-	.dapm_routes = sgtl5000_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(sgtl5000_dapm_routes),
+	.component_driver = {
+		.controls		= sgtl5000_snd_controls,
+		.num_controls		= ARRAY_SIZE(sgtl5000_snd_controls),
+		.dapm_widgets		= sgtl5000_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(sgtl5000_dapm_widgets),
+		.dapm_routes		= sgtl5000_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(sgtl5000_dapm_routes),
+	},
 };
 
 static const struct regmap_config sgtl5000_regmap = {
-- 
2.8.1
