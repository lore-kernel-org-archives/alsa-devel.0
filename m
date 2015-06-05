From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v3 2/3] ASoC: rt5645: change gpio to gpiod APIs
Date: Fri, 5 Jun 2015 13:24:16 +0800
Message-ID: <1433481857-28437-2-git-send-email-bardliao@realtek.com>
References: <1433481857-28437-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AB9726671A
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 07:24:31 +0200 (CEST)
In-Reply-To: <1433481857-28437-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, drinkcat@chromium.org, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Move gpio to gpio_desc and use gpiod APIs in codec driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* Change gpio name from rt5645 to hp-detect
* Use devm_gpiod_get API to get gpiod
---
 include/sound/rt5645.h    |  3 ---
 sound/soc/codecs/rt5645.c | 47 ++++++++++++-----------------------------------
 sound/soc/codecs/rt5645.h |  1 +
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 652cb9e..22734bc 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -20,9 +20,6 @@ struct rt5645_platform_data {
 	unsigned int dmic2_data_pin;
 	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
 
-	unsigned int hp_det_gpio;
-	bool gpio_hp_det_active_high;
-
 	unsigned int jd_mode;
 };
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d12da40..27a9492 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2939,17 +2939,11 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
-		if (gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
-			gpio_state = gpio_get_value(rt5645->pdata.hp_det_gpio);
-			dev_dbg(rt5645->codec->dev, "gpio = %d(%d)\n",
-				rt5645->pdata.hp_det_gpio, gpio_state);
-		}
-		if ((rt5645->pdata.gpio_hp_det_active_high && gpio_state) ||
-			(!rt5645->pdata.gpio_hp_det_active_high &&
-			 !gpio_state)) {
-			report = rt5645_jack_detect(rt5645->codec, 1);
-		} else {
-			report = rt5645_jack_detect(rt5645->codec, 0);
+		if (rt5645->gpiod_hp_det) {
+			gpio_state = gpiod_get_value(rt5645->gpiod_hp_det);
+			dev_dbg(rt5645->codec->dev, "gpio_state = %d\n",
+				gpio_state);
+			report = rt5645_jack_detect(rt5645->codec, gpio_state);
 		}
 		snd_soc_jack_report(rt5645->hp_jack,
 				    report, SND_JACK_HEADPHONE);
@@ -3239,7 +3233,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	struct rt5645_priv *rt5645;
 	int ret;
 	unsigned int val;
-	struct gpio_desc *gpiod;
 
 	rt5645 = devm_kzalloc(&i2c->dev, sizeof(struct rt5645_priv),
 				GFP_KERNEL);
@@ -3254,19 +3247,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	} else {
 		if (dmi_check_system(dmi_platform_intel_braswell)) {
 			rt5645->pdata = *rt5645_pdata;
-			gpiod = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);
-
-			if (IS_ERR(gpiod) || gpiod_direction_input(gpiod)) {
-				rt5645->pdata.hp_det_gpio = -1;
-				dev_err(&i2c->dev, "failed to initialize gpiod\n");
-			} else {
-				rt5645->pdata.hp_det_gpio = desc_to_gpio(gpiod);
-				rt5645->pdata.gpio_hp_det_active_high
-						= !gpiod_is_active_low(gpiod);
-			}
 		}
 	}
 
+	rt5645->gpiod_hp_det = devm_gpiod_get(&i2c->dev, "hp-detect", GPIOD_IN);
+
+	if (IS_ERR(rt5645->gpiod_hp_det)) {
+		rt5645->gpiod_hp_det = NULL;
+		dev_err(&i2c->dev, "failed to initialize gpiod\n");
+	}
+
 	rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
 	if (IS_ERR(rt5645->regmap)) {
 		ret = PTR_ERR(rt5645->regmap);
@@ -3426,16 +3416,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
-	if (gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
-		ret = gpio_request(rt5645->pdata.hp_det_gpio, "rt5645");
-		if (ret)
-			dev_err(&i2c->dev, "Fail gpio_request hp_det_gpio\n");
-
-		ret = gpio_direction_input(rt5645->pdata.hp_det_gpio);
-		if (ret)
-			dev_err(&i2c->dev, "Fail gpio_direction hp_det_gpio\n");
-	}
-
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
@@ -3451,9 +3431,6 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 
-	if (gpio_is_valid(rt5645->pdata.hp_det_gpio))
-		gpio_free(rt5645->pdata.hp_det_gpio);
-
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 9ec4e89..0353a6a 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2182,6 +2182,7 @@ struct rt5645_priv {
 	struct rt5645_platform_data pdata;
 	struct regmap *regmap;
 	struct i2c_client *i2c;
+	struct gpio_desc *gpiod_hp_det;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
-- 
1.8.1.1.439.g50a6b54
