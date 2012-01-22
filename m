From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8996: Switch to using common code
	for managing CPVDD supply
Date: Sun, 22 Jan 2012 15:53:38 +0000
Message-ID: <1327247619-19958-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327247619-19958-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C616424699
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

Nice code saving.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 390ccdd..ed7af8c 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -73,7 +73,6 @@ struct wm8996_priv {
 
 	struct regulator_bulk_data supplies[WM8996_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8996_NUM_SUPPLIES];
-	struct regulator *cpvdd;
 	int bg_ena;
 
 	struct wm8996_pdata pdata;
@@ -792,29 +791,18 @@ static int bg_event(struct snd_soc_dapm_widget *w,
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
 	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		ret = regulator_enable(wm8996->cpvdd);
-		if (ret != 0)
-			dev_err(codec->dev, "Failed to enable CPVDD: %d\n",
-				ret);
-		break;
 	case SND_SOC_DAPM_POST_PMU:
 		msleep(5);
 		break;
-	case SND_SOC_DAPM_POST_PMD:
-		regulator_disable_deferred(wm8996->cpvdd, 20);
-		break;
 	default:
 		BUG();
 		ret = -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rmv_short_event(struct snd_soc_dapm_widget *w,
@@ -1116,12 +1104,12 @@ SND_SOC_DAPM_INPUT("IN2RP"),
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
 
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
 SND_SOC_DAPM_SUPPLY_S("SYSCLK", 1, WM8996_AIF_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("SYSDSPCLK", 2, WM8996_CLOCKING_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
-		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		      SND_SOC_DAPM_POST_PMD),
+		      SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_SUPPLY("Bandgap", SND_SOC_NOPM, 0, 0, bg_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
@@ -1280,6 +1268,7 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "AIFCLK", NULL, "SYSCLK" },
 	{ "SYSDSPCLK", NULL, "SYSCLK" },
 	{ "Charge Pump", NULL, "SYSCLK" },
+	{ "Charge Pump", NULL, "CPVDD" },
 
 	{ "MICB1", NULL, "LDO2" },
 	{ "MICB1", NULL, "MICB1 Audio" },
@@ -3038,7 +3027,6 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
 		regulator_unregister_notifier(wm8996->supplies[i].consumer,
 					      &wm8996->disable_nb[i]);
-	regulator_put(wm8996->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
 	return 0;
@@ -3160,18 +3148,11 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		goto err_gpio;
 	}
 
-	wm8996->cpvdd = regulator_get(&i2c->dev, "CPVDD");
-	if (IS_ERR(wm8996->cpvdd)) {
-		ret = PTR_ERR(wm8996->cpvdd);
-		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
-		goto err_get;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8996->supplies),
 				    wm8996->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_cpvdd;
+		goto err_get;
 	}
 
 	if (wm8996->pdata.ldo_ena > 0) {
@@ -3233,8 +3214,6 @@ err_enable:
 	if (wm8996->pdata.ldo_ena > 0)
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-err_cpvdd:
-	regulator_put(wm8996->cpvdd);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 err_gpio:
@@ -3251,7 +3230,6 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	wm8996_free_gpio(wm8996);
-	regulator_put(wm8996->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 	regmap_exit(wm8996->regmap);
 	if (wm8996->pdata.ldo_ena > 0) {
-- 
1.7.7.3
