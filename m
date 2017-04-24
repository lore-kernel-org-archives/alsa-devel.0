From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: bytcr_rt5640: log quirk configuration
	errors
Date: Mon, 24 Apr 2017 16:34:33 -0500
Message-ID: <20170424213433.21962-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A356266AF7
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 23:34:48 +0200 (CEST)
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

Now that quirks can be overridden with a module parameter,
log errors so that non-sensical quirks introduced by mistake
are identified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 100 +++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b1f0ccb..44ec96a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -57,6 +57,7 @@ enum {
 struct byt_rt5640_private {
 	struct clk *mclk;
 };
+static bool is_bytcr;
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 static unsigned int quirk_override;
@@ -65,30 +66,79 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
-	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC1_MAP)
-		dev_info(dev, "quirk DMIC1_MAP enabled");
-	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC2_MAP)
-		dev_info(dev, "quirk DMIC2_MAP enabled");
-	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN1_MAP)
-		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN3_MAP)
-		dev_info(dev, "quirk IN3_MAP enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN)
-		dev_info(dev, "quirk DMIC enabled");
+	int map;
+	bool has_dmic = false;
+	bool has_mclk = false;
+	bool has_ssp0 = false;
+	bool has_ssp0_aif1 = false;
+	bool has_ssp0_aif2 = false;
+	bool has_ssp2_aif2 = false;
+
+	map = BYT_RT5640_MAP(byt_rt5640_quirk);
+	switch (map) {
+	case BYT_RT5640_DMIC1_MAP:
+		dev_info(dev, "quirk DMIC1_MAP enabled\n");
+		has_dmic = true;
+		break;
+	case BYT_RT5640_DMIC2_MAP:
+		dev_info(dev, "quirk DMIC2_MAP enabled\n");
+		has_dmic = true;
+		break;
+	case BYT_RT5640_IN1_MAP:
+		dev_info(dev, "quirk IN1_MAP enabled\n");
+		break;
+	case BYT_RT5640_IN3_MAP:
+		dev_info(dev, "quirk IN3_MAP enabled\n");
+		break;
+	default:
+		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
+		break;
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
+		if (has_dmic)
+			dev_info(dev, "quirk DMIC enabled\n");
+		else
+			dev_err(dev, "quirk DMIC enabled but no DMIC input set, will be ignored\n");
+	}
 	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
-		dev_info(dev, "quirk MONO_SPEAKER enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
-		dev_info(dev, "quirk DIFF_MIC enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2)
-		dev_info(dev, "quirk SSP2_AIF2 enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1)
-		dev_info(dev, "quirk SSP0_AIF1 enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)
-		dev_info(dev, "quirk SSP0_AIF2 enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
-		dev_info(dev, "quirk MCLK_EN enabled");
-	if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ)
-		dev_info(dev, "quirk MCLK_25MHZ enabled");
+		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
+		if (!has_dmic)
+			dev_info(dev, "quirk DIFF_MIC enabled\n");
+		else
+			dev_info(dev, "quirk DIFF_MIC enabled but DMIC input selected, will be ignored\n");
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) {
+		dev_info(dev, "quirk SSP0_AIF1 enabled\n");
+		has_ssp0 = true;
+		has_ssp0_aif1 = true;
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2) {
+		dev_info(dev, "quirk SSP0_AIF2 enabled\n");
+		has_ssp0 = true;
+		has_ssp0_aif2 = true;
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) {
+		dev_info(dev, "quirk SSP2_AIF2 enabled\n");
+		has_ssp2_aif2 = true;
+	}
+	if (is_bytcr && !has_ssp0)
+		dev_err(dev, "Invalid routing, bytcr detected but no SSP0-based quirk, audio cannot work with SSP2 on bytcr\n");
+	if (has_ssp0_aif1 && has_ssp0_aif2)
+		dev_err(dev, "Invalid routing, SSP0 cannot be connected to both AIF1 and AIF2\n");
+	if (has_ssp0 && has_ssp2_aif2)
+		dev_err(dev, "Invalid routing, cannot have both SSP0 and SSP2 connected to codec\n");
+
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
+		dev_info(dev, "quirk MCLK_EN enabled\n");
+		has_mclk = true;
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ) {
+		if (has_mclk)
+			dev_info(dev, "quirk MCLK_25MHZ enabled\n");
+		else
+			dev_err(dev, "quirk MCLK_25MHZ enabled but quirk MCLK not selected, will be ignored\n");
+	}
 }
 
 
@@ -132,7 +182,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 			ret = clk_prepare_enable(priv->mclk);
 			if (ret < 0) {
 				dev_err(card->dev,
-					"could not configure MCLK state");
+					"could not configure MCLK state\n");
 				return ret;
 			}
 		}
@@ -714,8 +764,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	int i;
 	int dai_index;
 	struct byt_rt5640_private *priv;
-	bool is_bytcr = false;
 
+	is_bytcr = false;
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv)
 		return -ENOMEM;
-- 
2.9.3
