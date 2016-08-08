From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on sti-sas" to the asoc tree
Date: Mon, 08 Aug 2016 12:05:17 +0100
Message-ID: <E1bWiMv-0003ti-Vl@debutante>
References: <87shuf7ijj.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shuf7ijj.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on sti-sas

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

>From 97bf5f33475c1d2db8a5173883acacb961f45563 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:56:24 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 sti-sas

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 160d61a66204..7b31ee9b82bc 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -591,11 +591,11 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 	sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].ops = drvdata->dev_data->dac_ops;
 
 	/* Set dapms*/
-	sti_sas_driver.dapm_widgets = drvdata->dev_data->dapm_widgets;
-	sti_sas_driver.num_dapm_widgets = drvdata->dev_data->num_dapm_widgets;
+	sti_sas_driver.component_driver.dapm_widgets = drvdata->dev_data->dapm_widgets;
+	sti_sas_driver.component_driver.num_dapm_widgets = drvdata->dev_data->num_dapm_widgets;
 
-	sti_sas_driver.dapm_routes = drvdata->dev_data->dapm_routes;
-	sti_sas_driver.num_dapm_routes = drvdata->dev_data->num_dapm_routes;
+	sti_sas_driver.component_driver.dapm_routes = drvdata->dev_data->dapm_routes;
+	sti_sas_driver.component_driver.num_dapm_routes = drvdata->dev_data->num_dapm_routes;
 
 	/* Store context */
 	dev_set_drvdata(&pdev->dev, drvdata);
-- 
2.8.1
