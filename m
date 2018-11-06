From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: use standard interface for
	Hdaudio machine driver" to the asoc tree
Date: Tue,  6 Nov 2018 18:05:02 +0000 (GMT)
Message-ID: <20181106180502.A5D19112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B23EA2678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 19:05:03 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: use standard interface for Hdaudio machine driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 842bb5135f1016151235413726e4956210a79664 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 1 Nov 2018 16:34:49 -0500
Subject: [PATCH] ASoC: Intel: use standard interface for Hdaudio machine
 driver

Don't rely on internal Skylake-specific data structures, use
generic interface to let other drivers use the same machine driver
as is, e.g. SOF to support HDaudio codecs and HDMI outputs.

Tested on LeafHill CRB board, no regression seen with this change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 20 ++++++++++----------
 sound/soc/intel/skylake/skl.c                | 10 +++-------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index b415dd4c85f5..b6f287fa9505 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -12,8 +12,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
 
 static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
@@ -101,17 +101,17 @@ static struct snd_soc_card hda_soc_card = {
 #define IDISP_ROUTE_COUNT	(IDISP_DAI_COUNT * 2)
 #define IDISP_CODEC_MASK	0x4
 
-static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
+static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params *mach_params)
 {
 	struct snd_soc_card *card = &hda_soc_card;
 	struct snd_soc_dai_link *dai_link;
 	u32 codec_count, codec_mask;
 	int i, num_links, num_route;
 
-	codec_mask = pdata->codec_mask;
+	codec_mask = mach_params->codec_mask;
 	codec_count = hweight_long(codec_mask);
 
-	if (codec_count == 1 && pdata->codec_mask & IDISP_CODEC_MASK) {
+	if (codec_count == 1 && codec_mask & IDISP_CODEC_MASK) {
 		num_links = IDISP_DAI_COUNT;
 		num_route = IDISP_ROUTE_COUNT;
 	} else if (codec_count == 2 && codec_mask & IDISP_CODEC_MASK) {
@@ -127,14 +127,14 @@ static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
 	card->num_dapm_routes = num_route;
 
 	for_each_card_prelinks(card, i, dai_link)
-		dai_link->platform_name = pdata->platform;
+		dai_link->platform_name = mach_params->platform;
 
 	return 0;
 }
 
 static int skl_hda_audio_probe(struct platform_device *pdev)
 {
-	struct skl_machine_pdata *pdata;
+	struct snd_soc_acpi_mach *mach;
 	struct skl_hda_private *ctx;
 	int ret;
 
@@ -146,11 +146,11 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (!pdata)
+	mach = dev_get_drvdata(&pdev->dev);
+	if (!mach)
 		return -EINVAL;
 
-	ret = skl_hda_fill_card_info(pdata);
+	ret = skl_hda_fill_card_info(&mach->mach_params);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unsupported HDAudio/iDisp configuration found\n");
 		return ret;
@@ -158,7 +158,7 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	ctx->pcm_count = hda_soc_card.num_links;
 	ctx->dai_index = 1; /* hdmi codec dai name starts from index 1 */
-	ctx->platform_name = pdata->platform;
+	ctx->platform_name = mach->mach_params.platform;
 
 	hda_soc_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&hda_soc_card, ctx);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 29225623b4b4..ebab04b51bc1 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -525,7 +525,6 @@ static int skl_machine_device_register(struct skl *skl)
 {
 	struct snd_soc_acpi_mach *mach = skl->mach;
 	struct hdac_bus *bus = skl_to_bus(skl);
-	struct skl_machine_pdata *pdata;
 	struct platform_device *pdev;
 	int ret;
 
@@ -542,12 +541,9 @@ static int skl_machine_device_register(struct skl *skl)
 		return -EIO;
 	}
 
-	if (mach->pdata) {
-		pdata = (struct skl_machine_pdata *)mach->pdata;
-		pdata->platform = dev_name(bus->dev);
-		pdata->codec_mask = bus->codec_mask;
-		dev_set_drvdata(&pdev->dev, mach->pdata);
-	}
+	mach->mach_params.platform = dev_name(bus->dev);
+	mach->mach_params.codec_mask = bus->codec_mask;
+	dev_set_drvdata(&pdev->dev, mach);
 
 	skl->i2s_dev = pdev;
 
-- 
2.19.0.rc2
