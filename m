From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on ak4554" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:37 +0100
Message-ID: <E1bWiLJ-0003Pl-PJ@debutante>
References: <87fuqf63hn.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuqf63hn.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on ak4554

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

>From 08c0ca5ebd361420d40a4c6970e3dd1a4c64306a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:06:52 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 ak4554

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4554.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index 298dedc05140..b92c548b9d29 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -65,10 +65,12 @@ static struct snd_soc_dai_driver ak4554_dai = {
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4554 = {
-	.dapm_widgets = ak4554_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
-	.dapm_routes = ak4554_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),
+	.component_driver = {
+		.dapm_widgets		= ak4554_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(ak4554_dapm_widgets),
+		.dapm_routes		= ak4554_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(ak4554_dapm_routes),
+	},
 };
 
 static int ak4554_soc_probe(struct platform_device *pdev)
-- 
2.8.1
