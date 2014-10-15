From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: Add TDM channel select
	function
Date: Wed, 15 Oct 2014 18:02:13 +0800
Message-ID: <1413367334-12615-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F16E26050A
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 12:02:37 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add TDM channel select function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5677.h | 16 ++++++++--
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9f07146..52cbb56 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -795,6 +795,14 @@ static unsigned int bst_tlv[] = {
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
 };
 
+static const char * const rt5677_adc_tdm_mode[] = {
+	"1/2/3/4", "2/1/3/4", "2/3/1/4", "4/1/2/3", "1/3/2/4", "1/4/2/3",
+	"3/1/2/4", "3/4/1/2"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5677_adc_tdm_mode_enum,
+	SND_SOC_NOPM, 0, rt5677_adc_tdm_mode);
+
 static int rt5677_dsp_vad_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
@@ -820,6 +828,68 @@ static int rt5677_dsp_vad_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt5677_if1_adc_tdm_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+
+	regmap_read(rt5677->regmap, RT5677_TDM1_CTRL2, &value);
+
+	ucontrol->value.integer.value[0] = value & RT5677_IF1_ADC_CTRL_MASK;
+
+	return 0;
+}
+
+static int rt5677_if1_adc_tdm_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	unsigned int value = ucontrol->value.integer.value[0];
+
+	regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL2,
+		RT5677_IF1_ADC_CTRL_MASK, value);
+
+	regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL1,
+		RT5677_IF1_ADC_MODE_MASK, (!!value) << RT5677_IF1_ADC_MODE_SFT);
+
+	return 0;
+}
+
+static int rt5677_if2_adc_tdm_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+
+	regmap_read(rt5677->regmap, RT5677_TDM2_CTRL2, &value);
+
+	ucontrol->value.integer.value[0] = value & RT5677_IF2_ADC_CTRL_MASK;
+
+	return 0;
+}
+
+static int rt5677_if2_adc_tdm_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	unsigned int value = ucontrol->value.integer.value[0];
+
+	regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL2,
+		RT5677_IF2_ADC_CTRL_MASK, value);
+
+	regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL1,
+		RT5677_IF2_ADC_MODE_MASK, (!!value) << RT5677_IF2_ADC_MODE_SFT);
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 	/* OUTPUT Control */
 	SOC_SINGLE("OUT1 Playback Switch", RT5677_LOUT1,
@@ -894,6 +964,11 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 
 	SOC_SINGLE_EXT("DSP VAD Switch", SND_SOC_NOPM, 0, 1, 0,
 		rt5677_dsp_vad_get, rt5677_dsp_vad_put),
+
+	SOC_ENUM_EXT("ADC1 TDM Channel Switch", rt5677_adc_tdm_mode_enum,
+		rt5677_if1_adc_tdm_get, rt5677_if1_adc_tdm_put),
+	SOC_ENUM_EXT("ADC2 TDM Channel Switch", rt5677_adc_tdm_mode_enum,
+		rt5677_if2_adc_tdm_get, rt5677_if2_adc_tdm_put),
 };
 
 /**
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 20efa4a..20223eb 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -799,7 +799,11 @@
 #define RT5677_PDM2_I2C_EXE			(0x1 << 1)
 #define RT5677_PDM2_I2C_BUSY			(0x1 << 0)
 
-/* MX3C TDM1 control 1 (0x3c) */
+/* MX3B TDM1 control 1 (0x3b) */
+#define RT5677_IF1_ADC_MODE_MASK		(0x1 << 12)
+#define RT5677_IF1_ADC_MODE_SFT			12
+
+/* MX3C TDM1 control 2 (0x3c) */
 #define RT5677_IF1_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF1_ADC4_SFT			10
 #define RT5677_IF1_ADC3_MASK			(0x3 << 8)
@@ -808,8 +812,14 @@
 #define RT5677_IF1_ADC2_SFT			6
 #define RT5677_IF1_ADC1_MASK			(0x3 << 4)
 #define RT5677_IF1_ADC1_SFT			4
+#define RT5677_IF1_ADC_CTRL_MASK		(0x7 << 0)
+#define RT5677_IF1_ADC_CTRL_SFT			0
+
+/* MX40 TDM2 control 1 (0x40) */
+#define RT5677_IF2_ADC_MODE_MASK		(0x1 << 12)
+#define RT5677_IF2_ADC_MODE_SFT			12
 
-/* MX41 TDM2 control 1 (0x41) */
+/* MX41 TDM2 control 2 (0x41) */
 #define RT5677_IF2_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF2_ADC4_SFT			10
 #define RT5677_IF2_ADC3_MASK			(0x3 << 8)
@@ -818,6 +828,8 @@
 #define RT5677_IF2_ADC2_SFT			6
 #define RT5677_IF2_ADC1_MASK			(0x3 << 4)
 #define RT5677_IF2_ADC1_SFT			4
+#define RT5677_IF2_ADC_CTRL_MASK		(0x7 << 0)
+#define RT5677_IF2_ADC_CTRL_SFT			0
 
 /* Digital Microphone Control 1 (0x50) */
 #define RT5677_DMIC_1_EN_MASK			(0x1 << 15)
-- 
1.8.1.1.439.g50a6b54
