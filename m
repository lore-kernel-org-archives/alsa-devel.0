From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add the HWEQ for the speaker
	output
Date: Fri, 23 Oct 2015 14:05:53 +0800
Message-ID: <1445580353-17125-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 40A0E2614A0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 08:06:02 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the HWEQ function for the speaker output. User can set the
HWEQ parameters using the ALSA binary control byte-by-byte. We use the
following struct array to store the HWEQ parameters for implementing as
simple as possible.
struct rt5645_eq_param_s {
	unsigned short reg;
	unsigned short val;
};
It supports the variant length of the HWEQ parameters that are required.
We add the validating function in the function "rt5645_hweq_put" of the
ALSA binary control to avoid the user that puts the invalid parameters.
In the HWEQ enable function of speaker event, we also add the validating
function to prevent that the invalid parameters are applied to codec.
The HWEQ parameters should be controlled by DAPM for a specific sequence,
so the parameters will be applied to the codec in the speaker power up
event of DAPM, and will be disabled in the speaker power down event of
DAPM.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9d9797c..2813237 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -42,6 +42,8 @@
 
 #define RT5645_PR_BASE (RT5645_PR_RANGE_BASE + (0 * RT5645_PR_SPACING))
 
+#define RT5645_HWEQ_NUM 57
+
 static const struct regmap_range_cfg rt5645_ranges[] = {
 	{
 		.name = "PR",
@@ -224,6 +226,11 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xff, 0x6308 },
 };
 
+struct rt5645_eq_param_s {
+	unsigned short reg;
+	unsigned short val;
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -240,6 +247,7 @@ struct rt5645_priv {
 	struct snd_soc_jack *btn_jack;
 	struct delayed_work jack_detect_work;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
+	struct rt5645_eq_param_s *eq_param;
 
 	int codec_type;
 	int sysclk;
@@ -477,6 +485,86 @@ static const DECLARE_TLV_DB_RANGE(spk_clsd_tlv,
 	7, 7, TLV_DB_SCALE_ITEM(228, 0, 0)
 );
 
+static int rt5645_hweq_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s);
+
+	return 0;
+}
+
+static int rt5645_hweq_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
+	struct rt5645_eq_param_s *eq_param =
+		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	int i;
+
+	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
+		eq_param[i].reg = cpu_to_be16(rt5645->eq_param[i].reg);
+		eq_param[i].val = cpu_to_be16(rt5645->eq_param[i].val);
+	}
+
+	return 0;
+}
+
+static bool rt5645_validate_hweq(unsigned short reg)
+{
+	if ((reg >= 0x1a4 && reg <= 0x1cd) | (reg >= 0x1e5 && reg <= 0x1f8) |
+		(reg == RT5645_EQ_CTRL2))
+		return true;
+
+	return false;
+}
+
+static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
+	struct rt5645_eq_param_s *eq_param =
+		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	int i;
+
+	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
+		eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
+		eq_param[i].val = be16_to_cpu(eq_param[i].val);
+	}
+
+	/* The final setting of the table should be RT5645_EQ_CTRL2 */
+	for (i = RT5645_HWEQ_NUM - 1; i >= 0; i--) {
+		if (eq_param[i].reg == 0)
+			continue;
+		else if (eq_param[i].reg != RT5645_EQ_CTRL2)
+			return 0;
+		else
+			break;
+	}
+
+	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
+		if (!rt5645_validate_hweq(eq_param[i].reg) &&
+			eq_param[i].reg != 0)
+			return 0;
+		else if (eq_param[i].reg == 0)
+			break;
+	}
+
+	memcpy(rt5645->eq_param, eq_param,
+		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
+
+	return 0;
+}
+
+#define RT5645_HWEQ(xname) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = rt5645_hweq_info, \
+	.get = rt5645_hweq_get, \
+	.put = rt5645_hweq_put \
+}
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -541,6 +629,7 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* I2S2 function select */
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
 		1, 1),
+	RT5645_HWEQ("Speaker HWEQ"),
 };
 
 /**
@@ -631,6 +720,22 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+static int rt5645_enable_hweq(struct snd_soc_codec *codec)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
+		if (rt5645_validate_hweq(rt5645->eq_param[i].reg))
+			regmap_write(rt5645->regmap, rt5645->eq_param[i].reg,
+					rt5645->eq_param[i].val);
+		else
+			break;
+	}
+
+	return 0;
+}
+
 /**
  * rt5645_sel_asrc_clk_src - select ASRC clock source for a set of filters
  * @codec: SoC audio codec device.
@@ -1535,6 +1640,7 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		rt5645_enable_hweq(codec);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L,
@@ -1543,6 +1649,7 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_write(codec, RT5645_EQ_CTRL2, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L, 0);
@@ -3060,6 +3167,9 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_sync(dapm);
 	}
 
+	rt5645->eq_param = devm_kzalloc(codec->dev,
+		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s), GFP_KERNEL);
+
 	return 0;
 }
 
-- 
1.8.1.1.439.g50a6b54
