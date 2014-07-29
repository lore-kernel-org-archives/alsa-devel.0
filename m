From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Fix null pointer issue
Date: Tue, 29 Jul 2014 13:50:57 +0800
Message-ID: <1406613057-17359-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9551F265206
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 07:51:19 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

To make the interrupt safe if it happens to be called before the card is
ready, we use regmap read/write in the interrupt handler. Also, we try to
prevent the interrupt happen before the card is ready by enabling codec's
IRQ in the ASoC probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 74 +++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 218f86e..e4f6102 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -36,7 +36,6 @@
 
 struct rt286_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
 	struct rt286_platform_data pdata;
 	struct i2c_client *i2c;
 	struct snd_soc_jack *jack;
@@ -295,9 +294,8 @@ static int rt286_support_power_controls[] = {
 };
 #define RT286_POWER_REG_LEN ARRAY_SIZE(rt286_support_power_controls)
 
-static int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic)
+static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 {
-	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val, buf;
 	int i;
 
@@ -305,23 +303,23 @@ static int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic)
 	*mic = false;
 
 	if (rt286->pdata.cbj_en) {
-		buf = snd_soc_read(codec, RT286_GET_HP_SENSE);
+		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
 		*hp = buf & 0x80000000;
 		if (*hp) {
 			/* power on HV,VERF */
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 				RT286_POWER_CTRL1, 0x1001, 0x0);
 			/* power LDO1 */
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 				RT286_POWER_CTRL2, 0x4, 0x4);
-			snd_soc_write(codec, RT286_SET_MIC1, 0x24);
-			val = snd_soc_read(codec, RT286_CBJ_CTRL2);
+			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x24);
+			regmap_read(rt286->regmap, RT286_CBJ_CTRL2, &val);
 
 			msleep(200);
 			i = 40;
 			while (((val & 0x0800) == 0) && (i > 0)) {
-				val =  snd_soc_read(codec,
-					RT286_CBJ_CTRL2);
+				regmap_read(rt286->regmap,
+					RT286_CBJ_CTRL2, &val);
 				i--;
 				msleep(20);
 			}
@@ -329,53 +327,53 @@ static int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic)
 			if (0x0400 == (val & 0x0700)) {
 				*mic = false;
 
-				snd_soc_write(codec,
+				regmap_write(rt286->regmap,
 					RT286_SET_MIC1, 0x20);
 				/* power off HV,VERF */
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_POWER_CTRL1, 0x1001, 0x1001);
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_A_BIAS_CTRL3, 0xc000, 0x0000);
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_CBJ_CTRL1, 0x0030, 0x0000);
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_A_BIAS_CTRL2, 0xc000, 0x0000);
 			} else if ((0x0200 == (val & 0x0700)) ||
 				(0x0100 == (val & 0x0700))) {
 				*mic = true;
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_A_BIAS_CTRL3, 0xc000, 0x8000);
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_CBJ_CTRL1, 0x0030, 0x0020);
-				snd_soc_update_bits(codec,
+				regmap_update_bits(rt286->regmap,
 					RT286_A_BIAS_CTRL2, 0xc000, 0x8000);
 			} else {
 				*mic = false;
 			}
 
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 						RT286_MISC_CTRL1,
 						0x0060, 0x0000);
 		} else {
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 						RT286_MISC_CTRL1,
 						0x0060, 0x0020);
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 						RT286_A_BIAS_CTRL3,
 						0xc000, 0x8000);
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 						RT286_CBJ_CTRL1,
 						0x0030, 0x0020);
-			snd_soc_update_bits(codec,
+			regmap_update_bits(rt286->regmap,
 						RT286_A_BIAS_CTRL2,
 						0xc000, 0x8000);
 
 			*mic = false;
 		}
 	} else {
-		buf = snd_soc_read(codec, RT286_GET_HP_SENSE);
+		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
 		*hp = buf & 0x80000000;
-		buf = snd_soc_read(codec, RT286_GET_MIC1_SENSE);
+		regmap_read(rt286->regmap, RT286_GET_MIC1_SENSE, &buf);
 		*mic = buf & 0x80000000;
 	}
 
@@ -390,7 +388,7 @@ static void rt286_jack_detect_work(struct work_struct *work)
 	bool hp = false;
 	bool mic = false;
 
-	rt286_jack_detect(rt286->codec, &hp, &mic);
+	rt286_jack_detect(rt286, &hp, &mic);
 
 	if (hp == true)
 		status |= SND_JACK_HEADPHONE;
@@ -940,11 +938,10 @@ static irqreturn_t rt286_irq(int irq, void *data)
 	bool mic = false;
 	int status = 0;
 
-	rt286_jack_detect(rt286->codec, &hp, &mic);
+	rt286_jack_detect(rt286, &hp, &mic);
 
 	/* Clear IRQ */
-	snd_soc_update_bits(rt286->codec,
-					RT286_IRQ_CTRL, 0x1, 0x1);
+	regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x1, 0x1);
 
 	if (hp == true)
 		status |= SND_JACK_HEADPHONE;
@@ -965,7 +962,16 @@ static int rt286_probe(struct snd_soc_codec *codec)
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
-	rt286->codec = codec;
+
+	if (rt286->i2c->irq) {
+		regmap_update_bits(rt286->regmap,
+					RT286_IRQ_CTRL, 0x2, 0x2);
+
+		INIT_DELAYED_WORK(&rt286->jack_detect_work,
+					rt286_jack_detect_work);
+		schedule_delayed_work(&rt286->jack_detect_work,
+					msecs_to_jiffies(1250));
+	}
 
 	return 0;
 }
@@ -1171,14 +1177,6 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
 
 	if (rt286->i2c->irq) {
-		regmap_update_bits(rt286->regmap,
-					RT286_IRQ_CTRL, 0x2, 0x2);
-
-		INIT_DELAYED_WORK(&rt286->jack_detect_work,
-					rt286_jack_detect_work);
-		schedule_delayed_work(&rt286->jack_detect_work,
-					msecs_to_jiffies(1250));
-
 		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
 		if (ret != 0) {
-- 
1.8.1.1.439.g50a6b54
