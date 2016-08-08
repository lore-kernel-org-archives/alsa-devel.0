From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on wm98357a" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:46 +0100
Message-ID: <E1bWiJW-0002sP-Jl@debutante>
References: <87wpjr39tc.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wpjr39tc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on wm98357a

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

>From b071a0bc0fdc03c4a97020ffcb5d529a02b3b564 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:18:31 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 wm98357a

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 5b1dfb1518fb..6a6b68a4cb52 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -74,10 +74,12 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver max98357a_codec_driver = {
 	.probe			= max98357a_codec_probe,
-	.dapm_widgets		= max98357a_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
-	.dapm_routes		= max98357a_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= max98357a_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
+		.dapm_routes		= max98357a_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
+	},
 };
 
 static const struct snd_soc_dai_ops max98357a_dai_ops = {
-- 
2.8.1
