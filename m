From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ak4613" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:40 +0100
Message-ID: <E1bWiLM-0003Qd-NY@debutante>
References: <87h9av63i7.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h9av63i7.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ak4613

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

>From beb84f75c4d9d069172f32543544d757d59e114b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:06:34 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ak4613

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 97798d250f08..e819dd8c82fd 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -458,12 +458,14 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
 	.suspend		= ak4613_suspend,
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
-	.controls		= ak4613_snd_controls,
-	.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
-	.dapm_widgets		= ak4613_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
-	.dapm_routes		= ak4613_intercon,
-	.num_dapm_routes	= ARRAY_SIZE(ak4613_intercon),
+	.component_driver = {
+		.controls		= ak4613_snd_controls,
+		.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
+		.dapm_widgets		= ak4613_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
+		.dapm_routes		= ak4613_intercon,
+		.num_dapm_routes	= ARRAY_SIZE(ak4613_intercon),
+	},
 };
 
 static void ak4613_parse_of(struct ak4613_priv *priv,
-- 
2.8.1
