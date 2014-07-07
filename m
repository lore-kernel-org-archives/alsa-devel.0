From: <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: RT286: move initial settings to
	_i2c_probe
Date: Mon, 7 Jul 2014 16:48:38 +0800
Message-ID: <1404722918-17466-3-git-send-email-bardliao@realtek.com>
References: <1404722918-17466-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1560126558D
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 10:49:25 +0200 (CEST)
In-Reply-To: <1404722918-17466-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Move codec initial settings from asoc probe to i2c probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 99 ++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 53eb7f3..e6f33ab 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -950,59 +950,10 @@ static irqreturn_t rt286_irq(int irq, void *data)
 static int rt286_probe(struct snd_soc_codec *codec)
 {
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-
-	snd_soc_write(codec, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
-
-	for (i = 0; i < RT286_POWER_REG_LEN; i++)
-		snd_soc_write(codec,
-			RT286_SET_POWER(rt286_support_power_controls[i]),
-			AC_PWRST_D1);
-
-	if (!rt286->pdata.cbj_en) {
-		snd_soc_write(codec, RT286_CBJ_CTRL2, 0x0000);
-		snd_soc_write(codec, RT286_MIC1_DET_CTRL, 0x0816);
-		snd_soc_write(codec, RT286_MISC_CTRL1, 0x0000);
-		snd_soc_update_bits(codec,
-					RT286_CBJ_CTRL1, 0xf000, 0xb000);
-	} else {
-		snd_soc_update_bits(codec,
-					RT286_CBJ_CTRL1, 0xf000, 0x5000);
-	}
-
-	mdelay(10);
-
-	if (!rt286->pdata.gpio2_en)
-		snd_soc_write(codec, RT286_SET_DMIC2_DEFAULT, 0x4000);
-	else
-		snd_soc_write(codec, RT286_SET_DMIC2_DEFAULT, 0);
-
-	mdelay(10);
-
-	/*Power down LDO2*/
-	snd_soc_update_bits(codec, RT286_POWER_CTRL2, 0x8, 0x0);
 
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	rt286->codec = codec;
 
-	if (rt286->i2c->irq) {
-		snd_soc_update_bits(codec,
-					RT286_IRQ_CTRL, 0x2, 0x2);
-
-		INIT_DELAYED_WORK(&rt286->jack_detect_work,
-					rt286_jack_detect_work);
-		schedule_delayed_work(&rt286->jack_detect_work,
-					msecs_to_jiffies(1250));
-
-		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
-		if (ret != 0) {
-			dev_err(codec->dev,
-				"Failed to reguest IRQ: %d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
@@ -1141,7 +1092,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
-	int ret;
+	int i, ret;
 
 	rt286 = devm_kzalloc(&i2c->dev,	sizeof(*rt286),
 				GFP_KERNEL);
@@ -1171,6 +1122,54 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
+	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
+
+	for (i = 0; i < RT286_POWER_REG_LEN; i++)
+		regmap_write(rt286->regmap,
+			RT286_SET_POWER(rt286_support_power_controls[i]),
+			AC_PWRST_D1);
+
+	if (!rt286->pdata.cbj_en) {
+		regmap_write(rt286->regmap, RT286_CBJ_CTRL2, 0x0000);
+		regmap_write(rt286->regmap, RT286_MIC1_DET_CTRL, 0x0816);
+		regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
+		regmap_update_bits(rt286->regmap,
+					RT286_CBJ_CTRL1, 0xf000, 0xb000);
+	} else {
+		regmap_update_bits(rt286->regmap,
+					RT286_CBJ_CTRL1, 0xf000, 0x5000);
+	}
+
+	mdelay(10);
+
+	if (!rt286->pdata.gpio2_en)
+		regmap_write(rt286->regmap, RT286_SET_DMIC2_DEFAULT, 0x4000);
+	else
+		regmap_write(rt286->regmap, RT286_SET_DMIC2_DEFAULT, 0);
+
+	mdelay(10);
+
+	/*Power down LDO2*/
+	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0x8, 0x0);
+
+	if (rt286->i2c->irq) {
+		regmap_update_bits(rt286->regmap,
+					RT286_IRQ_CTRL, 0x2, 0x2);
+
+		INIT_DELAYED_WORK(&rt286->jack_detect_work,
+					rt286_jack_detect_work);
+		schedule_delayed_work(&rt286->jack_detect_work,
+					msecs_to_jiffies(1250));
+
+		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
+			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
+		if (ret != 0) {
+			dev_err(&i2c->dev,
+				"Failed to reguest IRQ: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
 				     rt286_dai, ARRAY_SIZE(rt286_dai));
 
-- 
1.8.1.1.439.g50a6b54
