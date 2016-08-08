From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on cs47l24" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:30 +0100
Message-ID: <E1bWiKE-00035q-H2@debutante>
References: <87invb4ola.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87invb4ola.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on cs47l24

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

>From 295f08154cc07db27c75e0c0ac4af9890b87f85b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:14:00 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 cs47l24

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 954a4f5d3338..779a7bfff1c3 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1190,12 +1190,14 @@ static struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	.set_sysclk = arizona_set_sysclk,
 	.set_pll = cs47l24_set_fll,
 
-	.controls = cs47l24_snd_controls,
-	.num_controls = ARRAY_SIZE(cs47l24_snd_controls),
-	.dapm_widgets = cs47l24_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(cs47l24_dapm_widgets),
-	.dapm_routes = cs47l24_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(cs47l24_dapm_routes),
+	.component_driver = {
+		.controls		= cs47l24_snd_controls,
+		.num_controls		= ARRAY_SIZE(cs47l24_snd_controls),
+		.dapm_widgets		= cs47l24_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(cs47l24_dapm_widgets),
+		.dapm_routes		= cs47l24_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(cs47l24_dapm_routes),
+	},
 };
 
 static struct snd_compr_ops cs47l24_compr_ops = {
-- 
2.8.1
