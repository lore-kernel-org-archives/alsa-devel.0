From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ssm2518" to the asoc tree
Date: Mon, 08 Aug 2016 12:00:48 +0100
Message-ID: <E1bWiIa-0002ag-5K@debutante>
References: <874m6v39iz.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874m6v39iz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ssm2518

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

>From 96107bbaf32ab93bd359c7741f3611aff08e144b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:24:44 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ssm2518

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2518.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index e2e0bfa7ec20..38a85f3adc80 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -715,12 +715,14 @@ static struct snd_soc_codec_driver ssm2518_codec_driver = {
 	.set_sysclk = ssm2518_set_sysclk,
 	.idle_bias_off = true,
 
-	.controls = ssm2518_snd_controls,
-	.num_controls = ARRAY_SIZE(ssm2518_snd_controls),
-	.dapm_widgets = ssm2518_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ssm2518_dapm_widgets),
-	.dapm_routes = ssm2518_routes,
-	.num_dapm_routes = ARRAY_SIZE(ssm2518_routes),
+	.component_driver = {
+		.controls		= ssm2518_snd_controls,
+		.num_controls		= ARRAY_SIZE(ssm2518_snd_controls),
+		.dapm_widgets		= ssm2518_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ssm2518_dapm_widgets),
+		.dapm_routes		= ssm2518_routes,
+		.num_dapm_routes	= ARRAY_SIZE(ssm2518_routes),
+	},
 };
 
 static const struct regmap_config ssm2518_regmap_config = {
-- 
2.8.1
