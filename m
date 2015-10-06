From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: Add the HW EQ for the
	customized speaker output of Google Celes
Date: Tue, 6 Oct 2015 10:20:05 +0800
Message-ID: <1444098005-25968-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9D12619D7
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 04:20:27 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5645.h    |  1 +
 sound/soc/codecs/rt5645.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5645.h |  5 ++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index a5cf615..cf944e4 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,7 @@ struct rt5645_platform_data {
 	unsigned int jd_mode;
 	/* Invert JD when jack insert */
 	bool jd_invert;
+	unsigned int eq_mode;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4c4fe6b..def9caa 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -224,6 +224,36 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xff, 0x6308 },
 };
 
+struct rt5647_eq_parameter {
+	unsigned int reg;
+	unsigned int val;
+};
+
+#define EQ_REG_NUM 56
+struct hweq_s {
+	struct rt5647_eq_parameter par[EQ_REG_NUM];
+	unsigned int ctrl;
+};
+
+static const struct hweq_s hweq_param[] = {
+	{ /* EQ_NONE */
+		{
+			{0, 0},
+		},
+		0x0000,
+	},
+	{ /* EQ_GOOGLE_CELES */
+		{
+			{0x1c0, 0x04b8},
+			{0x1c1, 0xfd02},
+			{0x1c2, 0x04b8},
+			{0x1c3, 0xfd02},
+			{0, 0},
+		},
+		0x0020,
+	},
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -631,6 +661,27 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+static int rt5645_update_eqmode(struct snd_soc_codec *codec,
+	unsigned int mode)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	unsigned int i;
+
+	for (i = 0; i < EQ_REG_NUM; i++) {
+		if (hweq_param[mode].par[i].reg)
+			regmap_write(rt5645->regmap,
+				hweq_param[mode].par[i].reg,
+				hweq_param[mode].par[i].val);
+		else
+			break;
+	}
+
+	snd_soc_update_bits(codec, RT5645_EQ_CTRL2, 0x33fe,
+		hweq_param[mode].ctrl);
+
+	return 0;
+}
+
 /**
  * rt5645_sel_asrc_clk_src - select ASRC clock source for a set of filters
  * @codec: SoC audio codec device.
@@ -1532,9 +1583,11 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		rt5645_update_eqmode(codec, rt5645->pdata.eq_mode);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L,
@@ -1543,6 +1596,7 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		rt5645_update_eqmode(codec, EQ_NONE);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L, 0);
@@ -3205,6 +3259,20 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+static struct rt5645_platform_data celes_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.jd_mode = 3,
+	.eq_mode = EQ_GOOGLE_CELES,
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
@@ -3215,7 +3283,7 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	},
 	{
 		.ident = "Google Celes",
-		.callback = strago_quirk_cb,
+		.callback = celes_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
 		},
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 13ac732..89f25b8 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2187,6 +2187,11 @@ enum {
 	RT5645_AD_MONO_R_FILTER = (0x1 << 5),
 };
 
+enum {
+	EQ_NONE,
+	EQ_GOOGLE_CELES,
+};
+
 int rt5645_sel_asrc_clk_src(struct snd_soc_codec *codec,
 		unsigned int filter_mask, unsigned int clk_src);
 
-- 
1.8.1.1.439.g50a6b54
