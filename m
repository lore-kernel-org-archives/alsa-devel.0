From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on sun4i-codec" to the asoc tree
Date: Mon, 08 Aug 2016 12:06:40 +0100
Message-ID: <E1bWiOG-0004I0-Tg@debutante>
References: <87vazb8xk6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vazb8xk6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on sun4i-codec

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

>From 180f58fece4be11125e663983ee3388e6512f159 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:46:41 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 sun4i-codec

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 44f170c73b06..0e19c5070005 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -628,12 +628,14 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
-	.controls		= sun4i_codec_widgets,
-	.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
-	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
-	.dapm_routes		= sun4i_codec_codec_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	.component_driver = {
+		.controls		= sun4i_codec_widgets,
+		.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
+		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+		.dapm_routes		= sun4i_codec_codec_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	},
 };
 
 static const struct snd_soc_component_driver sun4i_codec_component = {
-- 
2.8.1
