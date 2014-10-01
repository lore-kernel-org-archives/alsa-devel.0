From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: rt5640: Add function for enabling
	DMIC from ACPI probed machine
Date: Wed,  1 Oct 2014 15:08:14 +0300
Message-ID: <1412165295-24229-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7884E260485
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 14:08:32 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no code enabling DMIC clock in systems that don't provide platform
data for rt5640 after commit 71d97a794301 ("ASoC: rt5640: Use the platform
data for DMIC settings").

I think it's worth to keep this static DMIC clock and alternative data pin
setting during probe time. For making possible to use DMIC from ACPI probed
machine (prior ACPI 5.1 with _DSD) this patch moves DMIC configuration to
new exported rt5640_dmic_enable() that machine drivers can call.

Please note, this patch moves DMIC configuration from i2c probe to codec
probe in case platform data for rt5640 is set.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
for-next. I don't think there is regression caused by 71d97a794301 for the
byt-rt5640 machines. Theoretically yes for internal development platform
(which is don't care) but also byt-rt5640 got DMI quirks support for machine
specific routes only recently (i.e. machine without quirk was never working
completely).
---
 sound/soc/codecs/rt5640.c | 49 +++++++++++++++++++++++++++++------------------
 sound/soc/codecs/rt5640.h |  3 +++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index f1ec6e6bd08a..c3f2decd643c 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1906,6 +1906,32 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+int rt5640_dmic_enable(struct snd_soc_codec *codec,
+		       bool dmic1_data_pin, bool dmic2_data_pin)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+		RT5640_GP2_PIN_MASK, RT5640_GP2_PIN_DMIC1_SCL);
+
+	if (dmic1_data_pin) {
+		regmap_update_bits(rt5640->regmap, RT5640_DMIC,
+			RT5640_DMIC_1_DP_MASK, RT5640_DMIC_1_DP_GPIO3);
+		regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+			RT5640_GP3_PIN_MASK, RT5640_GP3_PIN_DMIC1_SDA);
+	}
+
+	if (dmic2_data_pin) {
+		regmap_update_bits(rt5640->regmap, RT5640_DMIC,
+			RT5640_DMIC_2_DP_MASK, RT5640_DMIC_2_DP_GPIO4);
+		regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+			RT5640_GP4_PIN_MASK, RT5640_GP4_PIN_DMIC2_SDA);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5640_dmic_enable);
+
 static int rt5640_probe(struct snd_soc_codec *codec)
 {
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
@@ -1945,6 +1971,10 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 		return -ENODEV;
 	}
 
+	if (rt5640->pdata.dmic_en)
+		rt5640_dmic_enable(codec, rt5640->pdata.dmic1_data_pin,
+					  rt5640->pdata.dmic2_data_pin);
+
 	return 0;
 }
 
@@ -2195,25 +2225,6 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5640->regmap, RT5640_IN3_IN4,
 					RT5640_IN_DF2, RT5640_IN_DF2);
 
-	if (rt5640->pdata.dmic_en) {
-		regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
-			RT5640_GP2_PIN_MASK, RT5640_GP2_PIN_DMIC1_SCL);
-
-		if (rt5640->pdata.dmic1_data_pin) {
-			regmap_update_bits(rt5640->regmap, RT5640_DMIC,
-				RT5640_DMIC_1_DP_MASK, RT5640_DMIC_1_DP_GPIO3);
-			regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
-				RT5640_GP3_PIN_MASK, RT5640_GP3_PIN_DMIC1_SDA);
-		}
-
-		if (rt5640->pdata.dmic2_data_pin) {
-			regmap_update_bits(rt5640->regmap, RT5640_DMIC,
-				RT5640_DMIC_2_DP_MASK, RT5640_DMIC_2_DP_GPIO4);
-			regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
-				RT5640_GP4_PIN_MASK, RT5640_GP4_PIN_DMIC2_SDA);
-		}
-	}
-
 	rt5640->hp_mute = 1;
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 58ebe96b86da..3deb8babeabb 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2097,4 +2097,7 @@ struct rt5640_priv {
 	bool hp_mute;
 };
 
+int rt5640_dmic_enable(struct snd_soc_codec *codec,
+		       bool dmic1_data_pin, bool dmic2_data_pin);
+
 #endif
-- 
2.1.0
