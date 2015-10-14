From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v4] ASoC: rt5645: Add the HW EQ for the
	customized speaker output of Google Celes
Date: Wed, 14 Oct 2015 14:15:00 +0800
Message-ID: <1444803300-31699-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D2217265DED
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 08:15:14 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, gary_lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5645.h    |   2 +
 sound/soc/codecs/rt5645.c | 103 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index a5cf615..efa9f08 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,8 @@ struct rt5645_platform_data {
 	unsigned int jd_mode;
 	/* Invert JD when jack insert */
 	bool jd_invert;
+	/* Speaker HWEQ */
+	bool hweq;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4d54999..6809d1c 100644
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
@@ -477,6 +485,49 @@ static const DECLARE_TLV_DB_RANGE(spk_clsd_tlv,
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
+	char *p = ucontrol->value.bytes.data;
+
+	if (rt5645->pdata.hweq)
+		memcpy(p, rt5645->eq_param,
+			RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
+
+	return 0;
+}
+
+static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
+	char *p = ucontrol->value.bytes.data;
+
+	if (rt5645->pdata.hweq)
+		memcpy(rt5645->eq_param, p,
+			RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
+
+	return 0;
+}
+
+#define RT5645_HWEQ(xname) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = rt5645_hweq_info, \
+	.get = rt5645_hweq_get,\
+	.put = rt5645_hweq_put }
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -541,6 +592,7 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* I2S2 function select */
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
 		1, 1),
+	RT5645_HWEQ("Speaker HWEQ"),
 };
 
 /**
@@ -631,6 +683,31 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+static bool rt5645_validate_hweq(unsigned short reg)
+{
+	if ((reg >= 0x1a4 && reg <= 0x1cd) | (reg >= 0x1e5 && reg <= 0x1f8) |
+		(reg == RT5645_EQ_CTRL2))
+		return true;
+
+	return false;
+}
+
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
@@ -1532,9 +1609,12 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		if (rt5645->pdata.hweq)
+			rt5645_enable_hweq(codec);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L,
@@ -1543,6 +1623,8 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		if (rt5645->pdata.hweq)
+			snd_soc_write(codec, RT5645_EQ_CTRL2, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L, 0);
@@ -3060,6 +3142,11 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_sync(dapm);
 	}
 
+	if (rt5645->pdata.hweq)
+		rt5645->eq_param = devm_kzalloc(codec->dev,
+			RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s),
+			GFP_KERNEL);
+
 	return 0;
 }
 
@@ -3209,6 +3296,20 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+static struct rt5645_platform_data celes_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.jd_mode = 3,
+	.hweq = true,
+};
+
+static int celes_quirk_cb(const struct dmi_system_id *id)
+{
+	rt5645_pdata = &celes_platform_data;
+
+	return 1;
+}
+
 static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{
 		.ident = "Intel Strago",
@@ -3219,7 +3320,7 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	},
 	{
 		.ident = "Google Celes",
-		.callback = strago_quirk_cb,
+		.callback = celes_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
 		},
-- 
1.8.1.1.439.g50a6b54
