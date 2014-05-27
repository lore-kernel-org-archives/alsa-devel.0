From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Use adsp_err/warn instead of
	dev_err/warn
Date: Tue, 27 May 2014 13:08:43 +0100
Message-ID: <1401192523-5750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17750261A0D
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 14:16:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We have defines for adsp messages best to consistently use them.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ff15eec..0600271 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1543,16 +1543,16 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 		ret = regmap_read(dsp->regmap,
 				  dsp->base + ADSP2_CLOCKING, &val);
 		if (ret != 0) {
-			dev_err(dsp->dev, "Failed to read clocking: %d\n", ret);
+			adsp_err(dsp, "Failed to read clocking: %d\n", ret);
 			return;
 		}
 
 		if ((val & ADSP2_CLK_SEL_MASK) >= 3) {
 			ret = regulator_enable(dsp->dvfs);
 			if (ret != 0) {
-				dev_err(dsp->dev,
-					"Failed to enable supply: %d\n",
-					ret);
+				adsp_err(dsp,
+					 "Failed to enable supply: %d\n",
+					 ret);
 				return;
 			}
 
@@ -1560,9 +1560,9 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 						    1800000,
 						    1800000);
 			if (ret != 0) {
-				dev_err(dsp->dev,
-					"Failed to raise supply: %d\n",
-					ret);
+				adsp_err(dsp,
+					 "Failed to raise supply: %d\n",
+					 ret);
 				return;
 			}
 		}
@@ -1672,15 +1672,15 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			ret = regulator_set_voltage(dsp->dvfs, 1200000,
 						    1800000);
 			if (ret != 0)
-				dev_warn(dsp->dev,
-					 "Failed to lower supply: %d\n",
-					 ret);
+				adsp_warn(dsp,
+					  "Failed to lower supply: %d\n",
+					  ret);
 
 			ret = regulator_disable(dsp->dvfs);
 			if (ret != 0)
-				dev_err(dsp->dev,
-					"Failed to enable supply: %d\n",
-					ret);
+				adsp_err(dsp,
+					 "Failed to enable supply: %d\n",
+					 ret);
 		}
 
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
@@ -1732,28 +1732,25 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
 		if (IS_ERR(adsp->dvfs)) {
 			ret = PTR_ERR(adsp->dvfs);
-			dev_err(adsp->dev, "Failed to get DCVDD: %d\n", ret);
+			adsp_err(adsp, "Failed to get DCVDD: %d\n", ret);
 			return ret;
 		}
 
 		ret = regulator_enable(adsp->dvfs);
 		if (ret != 0) {
-			dev_err(adsp->dev, "Failed to enable DCVDD: %d\n",
-				ret);
+			adsp_err(adsp, "Failed to enable DCVDD: %d\n", ret);
 			return ret;
 		}
 
 		ret = regulator_set_voltage(adsp->dvfs, 1200000, 1800000);
 		if (ret != 0) {
-			dev_err(adsp->dev, "Failed to initialise DVFS: %d\n",
-				ret);
+			adsp_err(adsp, "Failed to initialise DVFS: %d\n", ret);
 			return ret;
 		}
 
 		ret = regulator_disable(adsp->dvfs);
 		if (ret != 0) {
-			dev_err(adsp->dev, "Failed to disable DCVDD: %d\n",
-				ret);
+			adsp_err(adsp, "Failed to disable DCVDD: %d\n", ret);
 			return ret;
 		}
 	}
-- 
1.7.2.5
