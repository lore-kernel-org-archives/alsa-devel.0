From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on hdmi-codec" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:04 +0100
Message-ID: <E1bWiJo-0002xZ-4P@debutante>
References: <8760rb4ogu.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8760rb4ogu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on hdmi-codec

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

>From 88b0f761e296682f24639e9d9fc0122e7a7695c1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:16:40 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 hdmi-codec

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f64ecaa0141a..b904492d7744 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -375,13 +375,13 @@ static int hdmi_of_xlate_dai_name(struct snd_soc_component *component,
 }
 
 static struct snd_soc_codec_driver hdmi_codec = {
-	.controls = hdmi_controls,
-	.num_controls = ARRAY_SIZE(hdmi_controls),
-	.dapm_widgets = hdmi_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes = hdmi_routes,
-	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
 	.component_driver = {
+		.controls		= hdmi_controls,
+		.num_controls		= ARRAY_SIZE(hdmi_controls),
+		.dapm_widgets		= hdmi_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
+		.dapm_routes		= hdmi_routes,
+		.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
 		.of_xlate_dai_name	= hdmi_of_xlate_dai_name,
 	},
 };
-- 
2.8.1
