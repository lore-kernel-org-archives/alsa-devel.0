From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ads117x" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:45 +0100
Message-ID: <E1bWiKT-0003A5-3v@debutante>
References: <87popj4ont.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87popj4ont.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ads117x

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

>From 940b816f905eddf6c61db150b4833cd0c7eb61d8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:12:30 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ads117x

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ads117x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index c5be1bdc2c9a..90c756d183b4 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -59,10 +59,12 @@ static struct snd_soc_dai_driver ads117x_dai = {
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_ads117x = {
-	.dapm_widgets = ads117x_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ads117x_dapm_widgets),
-	.dapm_routes = ads117x_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(ads117x_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= ads117x_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ads117x_dapm_widgets),
+		.dapm_routes		= ads117x_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(ads117x_dapm_routes),
+	},
 };
 
 static int ads117x_probe(struct platform_device *pdev)
-- 
2.8.1
