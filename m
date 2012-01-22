From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm5100: Move regulator supplies over
	to DAPM infrastructure
Date: Sun, 22 Jan 2012 15:53:39 +0000
Message-ID: <1327247619-19958-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327247619-19958-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6B992469A
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 16:53:57 +0100 (CET)
In-Reply-To: <1327247619-19958-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Saves a nice block of code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  131 ++++-----------------------------------------
 1 files changed, 10 insertions(+), 121 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index f916043..ba852f2 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -56,9 +56,6 @@ struct wm5100_priv {
 	struct snd_soc_codec *codec;
 
 	struct regulator_bulk_data core_supplies[WM5100_NUM_CORE_SUPPLIES];
-	struct regulator *cpvdd;
-	struct regulator *dbvdd2;
-	struct regulator *dbvdd3;
 
 	int rev;
 
@@ -813,85 +810,6 @@ static int wm5100_out_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wm5100_cp_ev(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *kcontrol,
-			int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		ret = regulator_enable(wm5100->cpvdd);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to enable CPVDD: %d\n",
-				ret);
-			return ret;
-		}
-		return ret;
-
-	case SND_SOC_DAPM_POST_PMD:
-		ret = regulator_disable_deferred(wm5100->cpvdd, 20);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to disable CPVDD: %d\n",
-				ret);
-			return ret;
-		}
-		return ret;
-
-	default:
-		BUG();
-		return 0;
-	}
-}
-
-static int wm5100_dbvdd_ev(struct snd_soc_dapm_widget *w,
-			   struct snd_kcontrol *kcontrol,
-			   int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	struct regulator *regulator;
-	int ret;
-
-	switch (w->shift) {
-	case 2:
-		regulator = wm5100->dbvdd2;
-		break;
-	case 3:
-		regulator = wm5100->dbvdd3;
-		break;
-	default:
-		BUG();
-		return 0;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		ret = regulator_enable(regulator);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to enable DBVDD%d: %d\n",
-				w->shift, ret);
-			return ret;
-		}
-		return ret;
-
-	case SND_SOC_DAPM_POST_PMD:
-		ret = regulator_disable(regulator);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to enable DBVDD%d: %d\n",
-				w->shift, ret);
-			return ret;
-		}
-		return ret;
-
-	default:
-		BUG();
-		return 0;
-	}
-}
-
 static void wm5100_log_status3(struct wm5100_priv *wm5100, int val)
 {
 	if (val & WM5100_SPK_SHUTDOWN_WARN_EINT)
@@ -972,18 +890,16 @@ SND_SOC_DAPM_SUPPLY("SYSCLK", WM5100_CLOCKING_3, WM5100_SYSCLK_ENA_SHIFT, 0,
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", WM5100_CLOCKING_6, WM5100_ASYNC_CLK_ENA_SHIFT,
 		    0, NULL, 0),
 
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0),
+
 SND_SOC_DAPM_SUPPLY("CP1", WM5100_HP_CHARGE_PUMP_1, WM5100_CP1_ENA_SHIFT, 0,
-		    wm5100_cp_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+		    NULL, 0),
 SND_SOC_DAPM_SUPPLY("CP2", WM5100_MIC_CHARGE_PUMP_1, WM5100_CP2_ENA_SHIFT, 0,
 		    NULL, 0),
 SND_SOC_DAPM_SUPPLY("CP2 Active", WM5100_MIC_CHARGE_PUMP_1,
-		    WM5100_CP2_BYPASS_SHIFT, 1, wm5100_cp_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-SND_SOC_DAPM_SUPPLY("DBVDD2", SND_SOC_NOPM, 2, 0, wm5100_dbvdd_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-SND_SOC_DAPM_SUPPLY("DBVDD3", SND_SOC_NOPM, 3, 0, wm5100_dbvdd_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+		    WM5100_CP2_BYPASS_SHIFT, 1, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("MICBIAS1", WM5100_MIC_BIAS_CTRL_1, WM5100_MICB1_ENA_SHIFT,
 		    0, NULL, 0),
@@ -1215,6 +1131,9 @@ SND_SOC_DAPM_POST("Post", wm5100_post_ev),
 };
 
 static const struct snd_soc_dapm_route wm5100_dapm_routes[] = {
+	{ "CP1", NULL, "CPVDD" },
+	{ "CP2 Active", NULL, "CPVDD" },
+
 	{ "IN1L", NULL, "SYSCLK" },
 	{ "IN1R", NULL, "SYSCLK" },
 	{ "IN2L", NULL, "SYSCLK" },
@@ -2729,33 +2648,12 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap;
 	}
 
-	wm5100->cpvdd = regulator_get(&i2c->dev, "CPVDD");
-	if (IS_ERR(wm5100->cpvdd)) {
-		ret = PTR_ERR(wm5100->cpvdd);
-		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
-		goto err_core;
-	}
-
-	wm5100->dbvdd2 = regulator_get(&i2c->dev, "DBVDD2");
-	if (IS_ERR(wm5100->dbvdd2)) {
-		ret = PTR_ERR(wm5100->dbvdd2);
-		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
-		goto err_cpvdd;
-	}
-
-	wm5100->dbvdd3 = regulator_get(&i2c->dev, "DBVDD3");
-	if (IS_ERR(wm5100->dbvdd3)) {
-		ret = PTR_ERR(wm5100->dbvdd3);
-		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
-		goto err_dbvdd2;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
 				    wm5100->core_supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable core supplies: %d\n",
 			ret);
-		goto err_dbvdd3;
+		goto err_core;
 	}
 
 	if (wm5100->pdata.ldo_ena) {
@@ -2924,12 +2822,6 @@ err_ldo:
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
 			       wm5100->core_supplies);
-err_dbvdd3:
-	regulator_put(wm5100->dbvdd3);
-err_dbvdd2:
-	regulator_put(wm5100->dbvdd2);
-err_cpvdd:
-	regulator_put(wm5100->cpvdd);
 err_core:
 	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
 			    wm5100->core_supplies);
@@ -2955,9 +2847,6 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *i2c)
 		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
 		gpio_free(wm5100->pdata.ldo_ena);
 	}
-	regulator_put(wm5100->dbvdd3);
-	regulator_put(wm5100->dbvdd2);
-	regulator_put(wm5100->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
 			    wm5100->core_supplies);
 	regmap_exit(wm5100->regmap);
-- 
1.7.7.3
