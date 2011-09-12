From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Disable WM8996 CPVDD supply when not
	in use
Date: Mon, 12 Sep 2011 17:59:17 +0100
Message-ID: <1315846757-21084-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1315846757-21084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D12A21038F9
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 18:59:25 +0200 (CEST)
In-Reply-To: <1315846757-21084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM8996 only requires CPVDD when the charge pump is active so control
it separately to the other supplies, only enabling it when the charge pump
is active. This will result in a small power saving on systems which are
able to provide independent software control of the supply.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index b3b0a9d..0fed436 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -41,12 +41,11 @@
 #define HPOUT2L 4
 #define HPOUT2R 8
 
-#define WM8996_NUM_SUPPLIES 4
+#define WM8996_NUM_SUPPLIES 3
 static const char *wm8996_supply_names[WM8996_NUM_SUPPLIES] = {
 	"DBVDD",
 	"AVDD1",
 	"AVDD2",
-	"CPVDD",
 };
 
 struct wm8996_priv {
@@ -71,6 +70,7 @@ struct wm8996_priv {
 
 	struct regulator_bulk_data supplies[WM8996_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8996_NUM_SUPPLIES];
+	struct regulator *cpvdd;
 
 	struct wm8996_pdata pdata;
 
@@ -112,7 +112,6 @@ static int wm8996_regulator_event_##n(struct notifier_block *nb, \
 WM8996_REGULATOR_EVENT(0)
 WM8996_REGULATOR_EVENT(1)
 WM8996_REGULATOR_EVENT(2)
-WM8996_REGULATOR_EVENT(3)
 
 static const u16 wm8996_reg[WM8996_MAX_REGISTER] = {
 	[WM8996_SOFTWARE_RESET] = 0x8996,
@@ -670,16 +669,29 @@ SOC_SINGLE_TLV("DSP2 EQ B5 Volume", WM8996_DSP2_RX_EQ_GAINS_2, 6, 31, 0,
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regulator_enable(wm8996->cpvdd);
+		if (ret != 0)
+			dev_err(codec->dev, "Failed to enable CPVDD: %d\n",
+				ret);
+		break;
 	case SND_SOC_DAPM_POST_PMU:
 		msleep(5);
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regulator_disable_deferred(wm8996->cpvdd, 20);
+		break;
 	default:
 		BUG();
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int rmv_short_event(struct snd_soc_dapm_widget *w,
@@ -988,7 +1000,8 @@ SND_SOC_DAPM_SUPPLY_S("SYSCLK", 1, WM8996_AIF_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("SYSDSPCLK", 2, WM8996_CLOCKING_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
-		      SND_SOC_DAPM_POST_PMU),
+		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		      SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICB1 Audio", WM8996_MICBIAS_1, 4, 1, NULL, 0),
@@ -2639,7 +2652,13 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	wm8996->disable_nb[0].notifier_call = wm8996_regulator_event_0;
 	wm8996->disable_nb[1].notifier_call = wm8996_regulator_event_1;
 	wm8996->disable_nb[2].notifier_call = wm8996_regulator_event_2;
-	wm8996->disable_nb[3].notifier_call = wm8996_regulator_event_3;
+
+	wm8996->cpvdd = regulator_get(&i2c->dev, "CPVDD");
+	if (IS_ERR(wm8996->cpvdd)) {
+		ret = PTR_ERR(wm8996->cpvdd);
+		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
+		goto err_get;
+	}
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++) {
@@ -2656,7 +2675,7 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 				    wm8996->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
+		goto err_cpvdd;
 	}
 
 	if (wm8996->pdata.ldo_ena >= 0) {
@@ -2899,6 +2918,8 @@ err_enable:
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
+err_cpvdd:
+	regulator_put(wm8996->cpvdd);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 err:
@@ -2922,6 +2943,7 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
 		regulator_unregister_notifier(wm8996->supplies[i].consumer,
 					      &wm8996->disable_nb[i]);
+	regulator_put(wm8996->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
 	return 0;
-- 
1.7.5.4
