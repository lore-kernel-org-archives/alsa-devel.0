From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 17/17] ASoC: Intel: bytcr_rt5640: log quirks
Date: Fri, 12 Aug 2016 16:28:00 -0500
Message-ID: <1471037280-17433-18-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id F1144266EE6
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:50 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

use dev_info to provide better support for autodetection
and DMI-based quirks, no functional changes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032abfe..09ec3d7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -61,6 +61,35 @@ static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN |
 					BYT_RT5640_MCLK_EN;
 
+static void log_quirks(struct device *dev)
+{
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC1_MAP)
+		dev_info(dev, "quirk DMIC1_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC2_MAP)
+		dev_info(dev, "quirk DMIC2_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN1_MAP)
+		dev_info(dev, "quirk IN1_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN3_MAP)
+		dev_info(dev, "quirk IN3_MAP enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN)
+		dev_info(dev, "quirk DMIC enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
+		dev_info(dev, "quirk MONO_SPEAKER enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+		dev_info(dev, "quirk DIFF_MIC enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2)
+		dev_info(dev, "quirk SSP2_AIF2 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1)
+		dev_info(dev, "quirk SSP0_AIF1 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)
+		dev_info(dev, "quirk SSP0_AIF2 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
+		dev_info(dev, "quirk MCLK_EN enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ)
+		dev_info(dev, "quirk MCLK_25MHZ enabled");
+}
+
+
 #define BYT_CODEC_DAI1	"rt5640-aif1"
 #define BYT_CODEC_DAI2	"rt5640-aif2"
 
@@ -702,6 +731,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
+	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
 	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-- 
2.5.0
