From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/6] ASoC: Intel: bytcr_rt5640: change quirk
	position
Date: Thu,  3 Mar 2016 21:36:37 -0600
Message-ID: <1457062599-10032-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 56AC2265373
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 04:36:50 +0100 (CET)
In-Reply-To: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

No added functionality

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 9a1752d..a06cd1f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -32,6 +32,18 @@
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-acpi.h"
 
+enum {
+	BYT_RT5640_DMIC1_MAP,
+	BYT_RT5640_DMIC2_MAP,
+	BYT_RT5640_IN1_MAP,
+};
+
+#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5640_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_DMIC_EN;
+
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -70,18 +82,6 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
-enum {
-	BYT_RT5640_DMIC1_MAP,
-	BYT_RT5640_DMIC2_MAP,
-	BYT_RT5640_IN1_MAP,
-};
-
-#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
-#define BYT_RT5640_DMIC_EN	BIT(16)
-
-static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
-					BYT_RT5640_DMIC_EN;
-
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -174,7 +174,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	dmi_check_system(byt_rt5640_quirk_table);
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_IN1_MAP:
 		custom_map = byt_rt5640_intmic_in1_map;
@@ -351,6 +350,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		 "%s%s%s", "i2c-", mach->id, ":00");
 	byt_rt5640_dais[MERR_DPCM_COMPR+1].codec_name = byt_rt5640_codec_name;
 
+	/* check quirks before creating card */
+	dmi_check_system(byt_rt5640_quirk_table);
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
1.9.1
