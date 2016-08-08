From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on cx20442" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:27 +0100
Message-ID: <E1bWiKB-000350-KL@debutante>
References: <87h9av4okr.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h9av4okr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on cx20442

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

>From a2c9c0f9729be9b0c5d410fd3f9ba2b335d5e868 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:14:19 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 cx20442

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index fb3885fe0afb..2c12471e42a6 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -407,10 +407,12 @@ static struct snd_soc_codec_driver cx20442_codec_dev = {
 	.reg_word_size = sizeof(u8),
 	.read = cx20442_read_reg_cache,
 	.write = cx20442_write,
-	.dapm_widgets = cx20442_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(cx20442_dapm_widgets),
-	.dapm_routes = cx20442_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(cx20442_audio_map),
+	.component_driver = {
+		.dapm_widgets		= cx20442_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(cx20442_dapm_widgets),
+		.dapm_routes		= cx20442_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(cx20442_audio_map),
+	},
 };
 
 static int cx20442_platform_probe(struct platform_device *pdev)
-- 
2.8.1
