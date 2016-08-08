From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on dmic" to the asoc tree
Date: Mon, 08 Aug 2016 12:02:07 +0100
Message-ID: <E1bWiJr-0002yY-1U@debutante>
References: <877fbr4ohd.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <877fbr4ohd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on dmic

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

>From a73b8e8955fe7660455aaa20e8452f5322793fab Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:16:22 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 dmic

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index fde53251c047..c82b9dc41e9a 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -51,10 +51,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 };
 
 static struct snd_soc_codec_driver soc_dmic = {
-	.dapm_widgets = dmic_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(dmic_dapm_widgets),
-	.dapm_routes = intercon,
-	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.component_driver = {
+		.dapm_widgets		= dmic_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
+		.dapm_routes		= intercon,
+		.num_dapm_routes	= ARRAY_SIZE(intercon),
+	},
 };
 
 static int dmic_dev_probe(struct platform_device *pdev)
-- 
2.8.1
