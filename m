From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ak5386" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:46 +0100
Message-ID: <E1bWiLS-0003SM-He@debutante>
References: <87k2fr63j8.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k2fr63j8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ak5386

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

>From 5bc4f738018ddcb86b7ac5894d4a9e416dbb65b0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:05:56 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ak5386

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5386.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index afa95360826d..0ef2df223336 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -74,10 +74,12 @@ static struct snd_soc_codec_driver soc_codec_ak5386 = {
 	.remove = ak5386_soc_remove,
 	.suspend = ak5386_soc_suspend,
 	.resume = ak5386_soc_resume,
-	.dapm_widgets = ak5386_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ak5386_dapm_widgets),
-	.dapm_routes = ak5386_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(ak5386_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= ak5386_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ak5386_dapm_widgets),
+		.dapm_routes		= ak5386_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(ak5386_dapm_routes),
+	},
 };
 
 static int ak5386_set_dai_fmt(struct snd_soc_dai *codec_dai,
-- 
2.8.1
