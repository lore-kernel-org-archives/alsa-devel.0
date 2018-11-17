From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/3] ASoC: Intel: fix interface for Chromebook
	machine drivers
Date: Fri, 16 Nov 2018 18:47:05 -0600
Message-ID: <20181117004706.15911-3-pierre-louis.bossart@linux.intel.com>
References: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A0DD02679F4
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 01:47:17 +0100 (CET)
In-Reply-To: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
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

The changes for HDaudio overlooked the fact that the machine drivers
used for Chromebooks rely on the dmic number information passed as
pdata.

Add dmic_num field to standard interface and use standard interface
instead of SKL-specific one.

Also clean-up pdata definition to remove fields that are no longer
used.

Fixes: 842bb5135f10 ('ASoC: Intel: use standard interface for Hdaudio machine driver')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h                            |  1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 10 +++++-----
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 10 +++++-----
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 10 +++++-----
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       | 10 +++++-----
 sound/soc/intel/skylake/skl.c                       |  2 +-
 sound/soc/intel/skylake/skl.h                       |  3 ---
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 5154c6359609..266e64e3c24c 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -48,6 +48,7 @@ struct snd_soc_acpi_mach_params {
 	u32 acpi_ipc_irq_index;
 	const char *platform;
 	u32 codec_mask;
+	u32 dmic_num;
 };
 
 /**
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 6ea969c0a5fb..c2a96940f9f2 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -25,9 +25,9 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5663.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -969,7 +969,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_rt5663_private *ctx;
-	struct skl_machine_pdata *pdata;
+	struct snd_soc_acpi_mach *mach;
 	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -984,9 +984,9 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (pdata)
-		dmic_constraints = pdata->dmic_num == 2 ?
+	mach = dev_get_drvdata(&pdev->dev);
+	if (mach)
+		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
 	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index a737c915d46a..d7df307b406f 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -26,10 +26,10 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/rt5514.h"
 #include "../../codecs/rt5663.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 
 #define KBL_REALTEK_CODEC_DAI "rt5663-aif"
 #define KBL_REALTEK_DMIC_CODEC_DAI "rt5514-aif1"
@@ -648,7 +648,7 @@ static struct snd_soc_card kabylake_audio_card = {
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
-	struct skl_machine_pdata *pdata;
+	struct snd_soc_acpi_mach *mach;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -659,9 +659,9 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&kabylake_audio_card, ctx);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (pdata)
-		dmic_constraints = pdata->dmic_num == 2 ?
+	mach = dev_get_drvdata(&pdev->dev);
+	if (mach)
+		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
 	return devm_snd_soc_register_card(&pdev->dev, &kabylake_audio_card);
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 552958ce736d..931890f9aa74 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -21,9 +21,9 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_MAXIM_CODEC_DAI "HiFi"
@@ -641,7 +641,7 @@ static struct snd_soc_card skylake_audio_card = {
 static int skylake_audio_probe(struct platform_device *pdev)
 {
 	struct skl_nau8825_private *ctx;
-	struct skl_machine_pdata *pdata;
+	struct snd_soc_acpi_mach *mach;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -652,9 +652,9 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (pdata)
-		dmic_constraints = pdata->dmic_num == 2 ?
+	mach = dev_get_drvdata(&pdev->dev);
+	if (mach)
+		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index f985b30a1d0e..657c650766fc 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -23,11 +23,11 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_SSM_CODEC_DAI	"ssm4567-hifi"
@@ -694,7 +694,7 @@ static struct snd_soc_card skylake_audio_card = {
 static int skylake_audio_probe(struct platform_device *pdev)
 {
 	struct skl_nau88125_private *ctx;
-	struct skl_machine_pdata *pdata;
+	struct snd_soc_acpi_mach *mach;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -705,9 +705,9 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (pdata)
-		dmic_constraints = pdata->dmic_num == 2 ?
+	mach = dev_get_drvdata(&pdev->dev);
+	if (mach)
+		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ac0b4ff21acc..c05618c6392f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -515,7 +515,7 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 	if (pdata) {
 		skl->use_tplg_pcm = pdata->use_tplg_pcm;
-		pdata->dmic_num = skl_get_dmic_geo(skl);
+		mach->mach_params.dmic_num = skl_get_dmic_geo(skl);
 	}
 
 	return 0;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 8d48cd7c56c8..85f8bb6687dc 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -119,10 +119,7 @@ struct skl_dma_params {
 };
 
 struct skl_machine_pdata {
-	u32 dmic_num;
 	bool use_tplg_pcm; /* use dais and dai links from topology */
-	const char *platform;
-	u32 codec_mask;
 };
 
 struct skl_dsp_ops {
-- 
2.17.1
