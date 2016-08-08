From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on wm0010" to the asoc tree
Date: Mon, 08 Aug 2016 12:00:16 +0100
Message-ID: <E1bWiI4-0002R0-1i@debutante>
References: <87oa531usw.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87oa531usw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on wm0010

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

>From 022f86d6f3b15bcd4865bccf837d309eb336f5a2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:28:08 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 wm0010

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index e3c34bdc2772..4ef6919ab1a1 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -795,10 +795,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm0010 = {
 	.set_sysclk = wm0010_set_sysclk,
 	.idle_bias_off = true,
 
-	.dapm_widgets = wm0010_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm0010_dapm_widgets),
-	.dapm_routes = wm0010_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm0010_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= wm0010_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(wm0010_dapm_widgets),
+		.dapm_routes		= wm0010_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(wm0010_dapm_routes),
+	},
 };
 
 #define WM0010_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
-- 
2.8.1
