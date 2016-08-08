From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on pistachio-internal-dac" to the asoc tree
Date: Mon, 08 Aug 2016 12:06:37 +0100
Message-ID: <E1bWiOE-0004H8-06@debutante>
References: <87twev8xjn.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87twev8xjn.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on pistachio-internal-dac

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

>From 90eb10fc4fc2d5977879489324e5c4abe099e650 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:46:59 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 pistachio-internal-dac

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/pistachio-internal-dac.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/img/pistachio-internal-dac.c b/sound/soc/img/pistachio-internal-dac.c
index 162a0fd68c7b..53e11c6d4e22 100644
--- a/sound/soc/img/pistachio-internal-dac.c
+++ b/sound/soc/img/pistachio-internal-dac.c
@@ -134,12 +134,14 @@ static int pistachio_internal_dac_codec_probe(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver pistachio_internal_dac_driver = {
 	.probe = pistachio_internal_dac_codec_probe,
 	.idle_bias_off = true,
-	.controls = pistachio_internal_dac_snd_controls,
-	.num_controls = ARRAY_SIZE(pistachio_internal_dac_snd_controls),
-	.dapm_widgets = pistachio_internal_dac_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(pistachio_internal_dac_widgets),
-	.dapm_routes = pistachio_internal_dac_routes,
-	.num_dapm_routes = ARRAY_SIZE(pistachio_internal_dac_routes),
+	.component_driver = {
+		.controls		= pistachio_internal_dac_snd_controls,
+		.num_controls		= ARRAY_SIZE(pistachio_internal_dac_snd_controls),
+		.dapm_widgets		= pistachio_internal_dac_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(pistachio_internal_dac_widgets),
+		.dapm_routes		= pistachio_internal_dac_routes,
+		.num_dapm_routes	= ARRAY_SIZE(pistachio_internal_dac_routes),
+	},
 };
 
 static int pistachio_internal_dac_probe(struct platform_device *pdev)
-- 
2.8.1
