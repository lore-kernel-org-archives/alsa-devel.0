From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v3] ASoC: rt5645: Add the HW EQ for the
	customized speaker output of Google Celes
Date: Thu, 8 Oct 2015 11:21:33 +0800
Message-ID: <1444274494-15512-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AFA0A2665BF
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 05:21:47 +0200 (CEST)
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
 sound/soc/codecs/rt5645.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index a5cf615..42f0842 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,7 @@ struct rt5645_platform_data {
 	unsigned int jd_mode;
 	/* Invert JD when jack insert */
 	bool jd_invert;
+	bool hweq;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4c4fe6b..d9532bb 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/firmware.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -224,6 +225,16 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xff, 0x6308 },
 };
 
+struct rt5645_eq_param_s {
+	unsigned short reg;
+	unsigned short val;
+};
+
+struct rt5645_hweq_s {
+	unsigned short num;
+	struct rt5645_eq_param_s *param;
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -240,6 +251,7 @@ struct rt5645_priv {
 	struct snd_soc_jack *btn_jack;
 	struct delayed_work jack_detect_work;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
+	struct rt5645_hweq_s hweq;
 
 	int codec_type;
 	int sysclk;
@@ -631,6 +643,59 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+static int rt5645_read_hweq_param(struct snd_soc_codec *codec)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	const struct firmware *fw;
+	int i;
+
+	if (!request_firmware(&fw, "rt5645_hweq.bin", codec->dev)) {
+		rt5645->hweq.num = fw->size / sizeof(struct rt5645_eq_param_s);
+		rt5645->hweq.param = devm_kmemdup(codec->dev, fw->data,
+					fw->size, GFP_KERNEL);
+		if (rt5645->hweq.param) {
+			for (i = 0; i < rt5645->hweq.num; i++) {
+				rt5645->hweq.param[i].reg =
+					be16_to_cpu(rt5645->hweq.param[i].reg);
+				rt5645->hweq.param[i].val =
+					be16_to_cpu(rt5645->hweq.param[i].val);
+			}
+		}
+		release_firmware(fw);
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
+static int rt5645_enable_hweq(struct snd_soc_codec *codec)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	if (!rt5645->hweq.param)
+		rt5645_read_hweq_param(codec);
+
+	if (rt5645->hweq.param) {
+		for (i = 0; i < rt5645->hweq.num; i++) {
+			if (rt5645_validate_hweq(rt5645->hweq.param[i].reg))
+				regmap_write(rt5645->regmap,
+					rt5645->hweq.param[i].reg,
+					rt5645->hweq.param[i].val);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * rt5645_sel_asrc_clk_src - select ASRC clock source for a set of filters
  * @codec: SoC audio codec device.
@@ -1532,9 +1597,12 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
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
@@ -1543,6 +1611,8 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		if (rt5645->pdata.hweq)
+			snd_soc_write(codec, RT5645_EQ_CTRL2, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L, 0);
@@ -3205,6 +3275,20 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
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
@@ -3215,7 +3299,7 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
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
