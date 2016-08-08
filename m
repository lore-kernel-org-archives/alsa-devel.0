From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on adau1781" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:53 +0100
Message-ID: <E1bWiKb-0003Ck-RK@debutante>
References: <87twev4opa.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87twev4opa.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on adau1781

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

>From dbd33b16d68bf3ff93fb7965a2e87878ee091e94 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:11:36 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 adau1781

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1781.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index bc1bb56dae63..546071c6c0d0 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -432,12 +432,14 @@ static const struct snd_soc_codec_driver adau1781_codec_driver = {
 	.set_bias_level = adau1781_set_bias_level,
 	.suspend_bias_off = true,
 
-	.controls = adau1781_controls,
-	.num_controls = ARRAY_SIZE(adau1781_controls),
-	.dapm_widgets = adau1781_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(adau1781_dapm_widgets),
-	.dapm_routes = adau1781_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(adau1781_dapm_routes),
+	.component_driver = {
+		.controls		= adau1781_controls,
+		.num_controls		= ARRAY_SIZE(adau1781_controls),
+		.dapm_widgets		= adau1781_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(adau1781_dapm_widgets),
+		.dapm_routes		= adau1781_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(adau1781_dapm_routes),
+	},
 };
 
 #define ADAU1781_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
-- 
2.8.1
