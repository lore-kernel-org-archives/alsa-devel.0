From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/7] ASoC: Intel: use standard interface for
	Hdaudio machine driver
Date: Thu,  1 Nov 2018 16:34:49 -0500
Message-ID: <20181101213454.18894-3-pierre-louis.bossart@linux.intel.com>
References: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 687FD2678EB
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 22:35:14 +0100 (CET)
In-Reply-To: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Don't rely on internal Skylake-specific data structures, use
generic interface to let other drivers use the same machine driver
as is, e.g. SOF to support HDaudio codecs and HDMI outputs.

Tested on LeafHill CRB board, no regression seen with this change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
