From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH v2 2/2] ASoC: rt5645: Add regulator support
Date: Fri, 17 Jul 2015 11:33:12 +0800
Message-ID: <1437103992-61518-2-git-send-email-koro.chen@mediatek.com>
References: <1437103992-61518-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437103992-61518-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com
Cc: srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bardliao@realtek.com, oder_chiou@realtek.com, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

This adds basic regulator support for rt5645.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
Change since v1:
 - none
---
 sound/soc/codecs/rt5645.c | 61 ++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5645.h | 26 --------------------
 2 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 56e8c31..7a68d47 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/regulator/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -223,6 +224,38 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xff, 0x6308 },
 };
 
+static const char *const rt5645_supply_names[] = {
+	"avdd",
+	"cpvdd",
+};
+
+struct rt5645_priv {
+	struct snd_soc_codec *codec;
+	struct rt5645_platform_data pdata;
+	struct regmap *regmap;
+	struct i2c_client *i2c;
+	struct gpio_desc *gpiod_hp_det;
+	struct snd_soc_jack *hp_jack;
+	struct snd_soc_jack *mic_jack;
+	struct snd_soc_jack *btn_jack;
+	struct delayed_work jack_detect_work;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
+
+	int codec_type;
+	int sysclk;
+	int sysclk_src;
+	int lrck[RT5645_AIFS];
+	int bclk[RT5645_AIFS];
+	int master[RT5645_AIFS];
+
+	int pll_src;
+	int pll_in;
+	int pll_out;
+
+	int jack_type;
+	bool en_button_func;
+};
+
 static int rt5645_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, RT5645_RESET, 0);
@@ -3218,7 +3251,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt5645_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5645_priv *rt5645;
-	int ret;
+	int ret, i;
 	unsigned int val;
 
 	rt5645 = devm_kzalloc(&i2c->dev, sizeof(struct rt5645_priv),
@@ -3252,6 +3285,24 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
+		rt5645->supplies[i].supply = rt5645_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev,
+				      ARRAY_SIZE(rt5645->supplies),
+				      rt5645->supplies);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(rt5645->supplies),
+				    rt5645->supplies);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	regmap_read(rt5645->regmap, RT5645_VENDOR_ID2, &val);
 
 	switch (val) {
@@ -3265,7 +3316,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5645 or rt5650\n",
 			val);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_enable;
 	}
 
 	if (rt5645->codec_type == CODEC_TYPE_RT5650) {
@@ -3403,7 +3455,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			| IRQF_ONESHOT, "rt5645", rt5645);
 		if (ret) {
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
-			return ret;
+			goto err_enable;
 		}
 	}
 
@@ -3417,6 +3469,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 err_irq:
 	if (rt5645->i2c->irq)
 		free_irq(rt5645->i2c->irq, rt5645);
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 	return ret;
 }
 
@@ -3430,6 +3484,7 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 
 	snd_soc_unregister_codec(&i2c->dev);
+	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 0353a6a..199b22f 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2177,32 +2177,6 @@ enum {
 int rt5645_sel_asrc_clk_src(struct snd_soc_codec *codec,
 		unsigned int filter_mask, unsigned int clk_src);
 
-struct rt5645_priv {
-	struct snd_soc_codec *codec;
-	struct rt5645_platform_data pdata;
-	struct regmap *regmap;
-	struct i2c_client *i2c;
-	struct gpio_desc *gpiod_hp_det;
-	struct snd_soc_jack *hp_jack;
-	struct snd_soc_jack *mic_jack;
-	struct snd_soc_jack *btn_jack;
-	struct delayed_work jack_detect_work;
-
-	int codec_type;
-	int sysclk;
-	int sysclk_src;
-	int lrck[RT5645_AIFS];
-	int bclk[RT5645_AIFS];
-	int master[RT5645_AIFS];
-
-	int pll_src;
-	int pll_in;
-	int pll_out;
-
-	int jack_type;
-	bool en_button_func;
-};
-
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
 	struct snd_soc_jack *btn_jack);
-- 
1.8.1.1.dirty
