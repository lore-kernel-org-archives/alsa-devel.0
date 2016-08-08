From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on adau1701" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:28 +0100
Message-ID: <E1bWiLA-0003NE-Uw@debutante>
References: <87bn1363g3.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87bn1363g3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on adau1701

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

>From 637591ecb4468c55489654b698319adb9fbfbe36 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:07:47 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 adau1701

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1701.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index de53c0d7bf10..3bad1bc8c00a 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -765,13 +765,14 @@ static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.set_bias_level		= adau1701_set_bias_level,
 	.idle_bias_off		= true,
 
-	.controls		= adau1701_controls,
-	.num_controls		= ARRAY_SIZE(adau1701_controls),
-	.dapm_widgets		= adau1701_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(adau1701_dapm_widgets),
-	.dapm_routes		= adau1701_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
-
+	.component_driver = {
+		.controls		= adau1701_controls,
+		.num_controls		= ARRAY_SIZE(adau1701_controls),
+		.dapm_widgets		= adau1701_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(adau1701_dapm_widgets),
+		.dapm_routes		= adau1701_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
+	},
 	.set_sysclk		= adau1701_set_sysclk,
 };
 
-- 
2.8.1
