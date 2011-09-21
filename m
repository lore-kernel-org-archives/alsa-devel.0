From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Dynamically manage DBVDD2 and DBVDD3 on
	WM5100
Date: Wed, 21 Sep 2011 17:59:38 +0100
Message-ID: <1316624378-27138-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7D6A243FB
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 18:59:41 +0200 (CEST)
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

Allow the DBVDD2 and DBVDD3 rails to be powered down when idle, helping
fully power down connected devices when idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   82 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index a30b0bf..eff252b 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -55,6 +55,8 @@ struct wm5100_priv {
 
 	struct regulator_bulk_data core_supplies[WM5100_NUM_CORE_SUPPLIES];
 	struct regulator *cpvdd;
+	struct regulator *dbvdd2;
+	struct regulator *dbvdd3;
 
 	int rev;
 
@@ -804,6 +806,52 @@ static int wm5100_cp_ev(struct snd_soc_dapm_widget *w,
 	}
 }
 
+static int wm5100_dbvdd_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol,
+			   int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct regulator *regulator;
+	int ret;
+
+	switch (w->shift) {
+	case 2:
+		regulator = wm5100->dbvdd2;
+		break;
+	case 3:
+		regulator = wm5100->dbvdd3;
+		break;
+	default:
+		BUG();
+		return 0;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regulator_enable(regulator);
+		if (ret != 0) {
+			dev_err(codec->dev, "Failed to enable DBVDD%d: %d\n",
+				w->shift, ret);
+			return ret;
+		}
+		return ret;
+
+	case SND_SOC_DAPM_POST_PMD:
+		ret = regulator_disable(regulator);
+		if (ret != 0) {
+			dev_err(codec->dev, "Failed to enable DBVDD%d: %d\n",
+				w->shift, ret);
+			return ret;
+		}
+		return ret;
+
+	default:
+		BUG();
+		return 0;
+	}
+}
+
 static void wm5100_log_status3(struct snd_soc_codec *codec, int val)
 {
 	if (val & WM5100_SPK_SHUTDOWN_WARN_EINT)
@@ -881,6 +929,10 @@ SND_SOC_DAPM_SUPPLY("CP2", WM5100_MIC_CHARGE_PUMP_1, WM5100_CP2_ENA_SHIFT, 0,
 SND_SOC_DAPM_SUPPLY("CP2 Active", WM5100_MIC_CHARGE_PUMP_1,
 		    WM5100_CP2_BYPASS_SHIFT, 1, wm5100_cp_ev,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("DBVDD2", SND_SOC_NOPM, 2, 0, wm5100_dbvdd_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("DBVDD3", SND_SOC_NOPM, 3, 0, wm5100_dbvdd_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_SUPPLY("MICBIAS1", WM5100_MIC_BIAS_CTRL_1, WM5100_MICB1_ENA_SHIFT,
 		    0, NULL, 0),
@@ -1123,10 +1175,14 @@ static const struct snd_soc_dapm_route wm5100_dapm_routes[] = {
 	{ "AIF1RX8", NULL, "SYSCLK" },
 
 	{ "AIF2RX1", NULL, "SYSCLK" },
+	{ "AIF2RX1", NULL, "DBVDD2" },
 	{ "AIF2RX2", NULL, "SYSCLK" },
+	{ "AIF2RX2", NULL, "DBVDD2" },
 
 	{ "AIF3RX1", NULL, "SYSCLK" },
+	{ "AIF3RX1", NULL, "DBVDD3" },
 	{ "AIF3RX2", NULL, "SYSCLK" },
+	{ "AIF3RX2", NULL, "DBVDD3" },
 
 	{ "AIF1TX1", NULL, "SYSCLK" },
 	{ "AIF1TX2", NULL, "SYSCLK" },
@@ -1138,10 +1194,14 @@ static const struct snd_soc_dapm_route wm5100_dapm_routes[] = {
 	{ "AIF1TX8", NULL, "SYSCLK" },
 
 	{ "AIF2TX1", NULL, "SYSCLK" },
+	{ "AIF2TX1", NULL, "DBVDD2" },
 	{ "AIF2TX2", NULL, "SYSCLK" },
+	{ "AIF2TX2", NULL, "DBVDD2" },
 
 	{ "AIF3TX1", NULL, "SYSCLK" },
+	{ "AIF3TX1", NULL, "DBVDD3" },
 	{ "AIF3TX2", NULL, "SYSCLK" },
+	{ "AIF3TX2", NULL, "DBVDD3" },
 
 	{ "MICBIAS1", NULL, "CP2" },
 	{ "MICBIAS2", NULL, "CP2" },
@@ -2251,12 +2311,26 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 		goto err_core;
 	}
 
+	wm5100->dbvdd2 = regulator_get(&i2c->dev, "DBVDD2");
+	if (IS_ERR(wm5100->dbvdd2)) {
+		ret = PTR_ERR(wm5100->dbvdd2);
+		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
+		goto err_cpvdd;
+	}
+
+	wm5100->dbvdd3 = regulator_get(&i2c->dev, "DBVDD3");
+	if (IS_ERR(wm5100->dbvdd3)) {
+		ret = PTR_ERR(wm5100->dbvdd3);
+		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
+		goto err_dbvdd2;
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
 				    wm5100->core_supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable core supplies: %d\n",
 			ret);
-		goto err_cpvdd;
+		goto err_dbvdd3;
 	}
 
 	if (wm5100->pdata.ldo_ena) {
@@ -2433,6 +2507,10 @@ err_ldo:
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
 			       wm5100->core_supplies);
+err_dbvdd3:
+	regulator_put(wm5100->dbvdd3);
+err_dbvdd2:
+	regulator_put(wm5100->dbvdd2);
 err_cpvdd:
 	regulator_put(wm5100->cpvdd);
 err_core:
@@ -2459,6 +2537,8 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
 		gpio_free(wm5100->pdata.ldo_ena);
 	}
+	regulator_put(wm5100->dbvdd3);
+	regulator_put(wm5100->dbvdd2);
 	regulator_put(wm5100->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
 			    wm5100->core_supplies);
-- 
1.7.6.3
