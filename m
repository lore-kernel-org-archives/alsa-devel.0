From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Implement stability check
	for EQ coefficients
Date: Thu, 25 Jun 2015 09:35:11 +0100
Message-ID: <1435221312-22977-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B72F4260464
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 10:49:44 +0200 (CEST)
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

Specifying unstable coefficients for the EQ can have a severe impact on
the audio. This patchs adds a stability check on the coefficients
written to the EQ, for this it is necessary to merge the mode control
and the coefficients as some coefficients may only be unstable with a
certain mode setting so it is ideal if these are always updated in sync.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |   10 +++++++
 sound/soc/codecs/wm5102.c  |   12 +++------
 sound/soc/codecs/wm5110.c  |   12 +++------
 sound/soc/codecs/wm8997.c  |   12 +++------
 5 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 802e05e..3996786 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2313,6 +2313,65 @@ const struct snd_kcontrol_new arizona_adsp2_rate_controls[] = {
 };
 EXPORT_SYMBOL_GPL(arizona_adsp2_rate_controls);
 
+static bool arizona_eq_filter_unstable(bool mode, __be16 _a, __be16 _b)
+{
+	s16 a = be16_to_cpu(_a);
+	s16 b = be16_to_cpu(_b);
+
+	if (!mode) {
+		return abs(a) >= 4096;
+	} else {
+		if (abs(b) >= 4096)
+			return true;
+
+		return (abs((a << 16) / (4096 - b)) >= 4096 << 4);
+	}
+}
+
+int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	struct soc_bytes *params = (void *)kcontrol->private_value;
+	unsigned int val;
+	__be16 *data;
+	int len;
+	int ret;
+
+	len = params->num_regs * regmap_get_val_bytes(arizona->regmap);
+
+	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+
+	data[0] &= cpu_to_be16(ARIZONA_EQ1_B1_MODE);
+
+	if (arizona_eq_filter_unstable(!!data[0], data[1], data[2]) ||
+	    arizona_eq_filter_unstable(true, data[4], data[5]) ||
+	    arizona_eq_filter_unstable(true, data[8], data[9]) ||
+	    arizona_eq_filter_unstable(true, data[12], data[13]) ||
+	    arizona_eq_filter_unstable(false, data[16], data[17])) {
+		dev_err(arizona->dev, "Rejecting unstable EQ coefficients\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = regmap_read(arizona->regmap, params->base, &val);
+	if (ret != 0)
+		goto out;
+
+	val &= ~ARIZONA_EQ1_B1_MODE;
+	data[0] |= cpu_to_be16(val);
+
+	ret = regmap_raw_write(arizona->regmap, params->base, data, len);
+
+out:
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arizona_eq_coeff_put);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 43deb04..ebe50cf 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -194,6 +194,13 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_ROUTES(name " Preloader", name "L"), \
 	ARIZONA_MIXER_ROUTES(name " Preloader", name "R")
 
+#define ARIZONA_EQ_CONTROL(xname, xbase)                      \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
+	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
+	.put = arizona_eq_coeff_put, .private_value =         \
+	((unsigned long)&(struct soc_bytes) { .base = xbase,  \
+	 .num_regs = 20, .mask = ~ARIZONA_EQ1_B1_MODE }) }
+
 #define ARIZONA_RATE_ENUM_SIZE 4
 extern const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
 extern const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
@@ -229,6 +236,9 @@ extern int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
 
+extern int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol);
+
 extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			      int source, unsigned int freq, int dir);
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index d097f09e5..556bd98 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -788,8 +788,7 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 19),
-SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ1 Coefficients", ARIZONA_EQ1_2),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ1 B2 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B2_GAIN_SHIFT,
@@ -801,8 +800,7 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 19),
-SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ2 Coefficients", ARIZONA_EQ2_2),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ2 B2 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B2_GAIN_SHIFT,
@@ -814,8 +812,7 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 19),
-SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ3 Coefficients", ARIZONA_EQ3_2),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ3 B2 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B2_GAIN_SHIFT,
@@ -827,8 +824,7 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 19),
-SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ4 Coefficients", ARIZONA_EQ4_2),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ4 B2 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B2_GAIN_SHIFT,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 709fcc6..dfa4d4b 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -247,8 +247,7 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 19),
-SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ1 Coefficients", ARIZONA_EQ1_2),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ1 B2 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B2_GAIN_SHIFT,
@@ -260,8 +259,7 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 19),
-SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ2 Coefficients", ARIZONA_EQ2_2),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ2 B2 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B2_GAIN_SHIFT,
@@ -273,8 +271,7 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 19),
-SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ3 Coefficients", ARIZONA_EQ3_2),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ3 B2 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B2_GAIN_SHIFT,
@@ -286,8 +283,7 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 19),
-SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ4 Coefficients", ARIZONA_EQ4_2),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ4 B2 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B2_GAIN_SHIFT,
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 4134dc7..53e0a46 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -174,8 +174,7 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 19),
-SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ1 Coefficients", ARIZONA_EQ1_2),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ1 B2 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B2_GAIN_SHIFT,
@@ -187,8 +186,7 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 19),
-SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ2 Coefficients", ARIZONA_EQ2_2),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ2 B2 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B2_GAIN_SHIFT,
@@ -200,8 +198,7 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 19),
-SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ3 Coefficients", ARIZONA_EQ3_2),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ3 B2 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B2_GAIN_SHIFT,
@@ -213,8 +210,7 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 19),
-SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
+ARIZONA_EQ_CONTROL("EQ4 Coefficients", ARIZONA_EQ4_2),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ4 B2 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B2_GAIN_SHIFT,
-- 
1.7.2.5
