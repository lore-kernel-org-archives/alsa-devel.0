From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on tas5720" to the asoc tree
Date: Mon, 08 Aug 2016 12:05:29 +0100
Message-ID: <E1bWiN7-0003x7-SZ@debutante>
References: <87y4477ilt.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y4477ilt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on tas5720

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

>From a8f552df807d0c809ec529c8e998a6abbf40f324 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:55:04 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 tas5720

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5720.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index f54fb46b77c2..c65b917598d2 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -489,12 +489,14 @@ static struct snd_soc_codec_driver soc_codec_dev_tas5720 = {
 	.suspend = tas5720_suspend,
 	.resume = tas5720_resume,
 
-	.controls = tas5720_snd_controls,
-	.num_controls = ARRAY_SIZE(tas5720_snd_controls),
-	.dapm_widgets = tas5720_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(tas5720_dapm_widgets),
-	.dapm_routes = tas5720_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(tas5720_audio_map),
+	.component_driver = {
+		.controls		= tas5720_snd_controls,
+		.num_controls		= ARRAY_SIZE(tas5720_snd_controls),
+		.dapm_widgets		= tas5720_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(tas5720_dapm_widgets),
+		.dapm_routes		= tas5720_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(tas5720_audio_map),
+	},
 };
 
 /* PCM rates supported by the TAS5720 driver */
-- 
2.8.1
