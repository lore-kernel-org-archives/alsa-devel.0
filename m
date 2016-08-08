From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ak4104" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:34 +0100
Message-ID: <E1bWiLG-0003Ov-Qd@debutante>
References: <87eg5z63h5.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87eg5z63h5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ak4104

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

>From 1cd5e361736664302285850a327d52ef7f70e74a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:07:11 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ak4104

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4104.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 595d02d7602c..bdca8793e630 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -245,10 +245,12 @@ static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
 	.suspend = ak4104_soc_suspend,
 	.resume = ak4104_soc_resume,
 
-	.dapm_widgets = ak4104_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
-	.dapm_routes = ak4104_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(ak4104_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= ak4104_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ak4104_dapm_widgets),
+		.dapm_routes		= ak4104_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(ak4104_dapm_routes),
+	}
 };
 
 static const struct regmap_config ak4104_regmap = {
-- 
2.8.1
