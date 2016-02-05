From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH v3] ASoC: nau8825: fix issue that pop noise
	when start playback
Date: Fri, 5 Feb 2016 16:32:45 +0800
Message-ID: <1454661165-15275-1-git-send-email-KCHSU0@nuvoton.com>
References: <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CAAF92605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 09:32:32 +0100 (CET)
In-Reply-To: <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Reduce pop noise in power up and down sequence when playback.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 200 +++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/nau8825.h |  14 ++++
 2 files changed, 180 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index b9bcb10..d270f63 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -84,6 +84,7 @@ static const struct nau8825_fll_attr fll_pre_scalar[] = {
 
 static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_ENA_CTRL, 0x00ff },
+	{ NAU8825_REG_IIC_ADDR_SET, 0x0 },
 	{ NAU8825_REG_CLK_DIVIDER, 0x0050 },
 	{ NAU8825_REG_FLL1, 0x0 },
 	{ NAU8825_REG_FLL2, 0x3126 },
@@ -158,8 +159,7 @@ static const struct reg_default nau8825_reg_defaults[] = {
 static bool nau8825_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case NAU8825_REG_ENA_CTRL:
-	case NAU8825_REG_CLK_DIVIDER ... NAU8825_REG_FLL_VCO_RSV:
+	case NAU8825_REG_ENA_CTRL ... NAU8825_REG_FLL_VCO_RSV:
 	case NAU8825_REG_HSD_CTRL ... NAU8825_REG_JACK_DET_CTRL:
 	case NAU8825_REG_INTERRUPT_MASK ... NAU8825_REG_KEYDET_CTRL:
 	case NAU8825_REG_VDET_THRESHOLD_1 ... NAU8825_REG_DACR_CTRL:
@@ -184,8 +184,7 @@ static bool nau8825_readable_reg(struct device *dev, unsigned int reg)
 static bool nau8825_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case NAU8825_REG_RESET ... NAU8825_REG_ENA_CTRL:
-	case NAU8825_REG_CLK_DIVIDER ... NAU8825_REG_FLL_VCO_RSV:
+	case NAU8825_REG_RESET ... NAU8825_REG_FLL_VCO_RSV:
 	case NAU8825_REG_HSD_CTRL ... NAU8825_REG_JACK_DET_CTRL:
 	case NAU8825_REG_INTERRUPT_MASK:
 	case NAU8825_REG_INT_CLR_KEY_STATUS ... NAU8825_REG_KEYDET_CTRL:
@@ -227,10 +226,23 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
 static int nau8825_pump_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* Prevent startup click by letting charge pump to ramp up */
 		msleep(10);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+			NAU8825_JAMNODCLOW, NAU8825_JAMNODCLOW);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
+			NAU8825_CLASSG_EN, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -239,6 +251,47 @@ static int nau8825_pump_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int nau8825_playback_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_TESTDAC_EN, NAU8825_BIAS_TESTDAC_EN);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_TESTDAC_EN, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, 0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int nau8825_dacr_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
@@ -262,6 +315,54 @@ static int nau8825_dacr_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int nau8825_output_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_TESTDAC_EN, 0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+			NAU8825_JAMNODCLOW, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8825_hp_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+			NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+			NAU8825_HP_BOOST_DIS, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
+			NAU8825_CLASSG_EN, NAU8825_CLASSG_EN);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const char * const nau8825_adc_decimation[] = {
 	"32", "64", "128", "256"
 };
@@ -339,10 +440,10 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("SAR", NAU8825_REG_SAR_CTRL,
 		NAU8825_SAR_ADC_EN_SFT, 0, NULL, 0),
 
-	SND_SOC_DAPM_DAC("ADACL", NULL, NAU8825_REG_RDAC, 12, 0),
-	SND_SOC_DAPM_DAC("ADACR", NULL, NAU8825_REG_RDAC, 13, 0),
-	SND_SOC_DAPM_SUPPLY("ADACL Clock", NAU8825_REG_RDAC, 8, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADACR Clock", NAU8825_REG_RDAC, 9, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACL", 2, NAU8825_REG_RDAC, 12, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACR", 2, NAU8825_REG_RDAC, 13, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACL Clock", 3, NAU8825_REG_RDAC, 8, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACR Clock", 3, NAU8825_REG_RDAC, 9, 0, NULL, 0),
 
 	SND_SOC_DAPM_DAC_E("DDACR", NULL, SND_SOC_NOPM, 0, 0,
 		nau8825_dacr_event, SND_SOC_DAPM_POST_PMU |
@@ -354,32 +455,40 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("DACL Mux", SND_SOC_NOPM, 0, 0, &nau8825_dacl_mux),
 	SND_SOC_DAPM_MUX("DACR Mux", SND_SOC_NOPM, 0, 0, &nau8825_dacr_mux),
 
-	SND_SOC_DAPM_PGA("HP amp L", NAU8825_REG_CLASSG_CTRL, 1, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HP amp R", NAU8825_REG_CLASSG_CTRL, 2, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("HP amp power", NAU8825_REG_CLASSG_CTRL, 0, 0, NULL,
-		0),
+	SND_SOC_DAPM_PGA_S("HP amp L", 0,
+		NAU8825_REG_CLASSG_CTRL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("HP amp R", 0,
+		NAU8825_REG_CLASSG_CTRL, 2, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("Charge Pump", NAU8825_REG_CHARGE_PUMP, 5, 0,
-		nau8825_pump_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("Charge Pump", 1, NAU8825_REG_CHARGE_PUMP, 5, 0,
+		nau8825_pump_event, SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_PGA("Output Driver R Stage 1",
+	SND_SOC_DAPM_PGA_S("Output Driver R Stage 1", 4,
 		NAU8825_REG_POWER_UP_CONTROL, 5, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Output Driver L Stage 1",
+	SND_SOC_DAPM_PGA_S("Output Driver L Stage 1", 4,
 		NAU8825_REG_POWER_UP_CONTROL, 4, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Output Driver R Stage 2",
+	SND_SOC_DAPM_PGA_S("Output Driver R Stage 2", 5,
 		NAU8825_REG_POWER_UP_CONTROL, 3, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Output Driver L Stage 2",
+	SND_SOC_DAPM_PGA_S("Output Driver L Stage 2", 5,
 		NAU8825_REG_POWER_UP_CONTROL, 2, 0, NULL, 0),
-	SND_SOC_DAPM_PGA_S("Output Driver R Stage 3", 1,
+	SND_SOC_DAPM_PGA_S("Output Driver R Stage 3", 6,
 		NAU8825_REG_POWER_UP_CONTROL, 1, 0, NULL, 0),
-	SND_SOC_DAPM_PGA_S("Output Driver L Stage 3", 1,
+	SND_SOC_DAPM_PGA_S("Output Driver L Stage 3", 6,
 		NAU8825_REG_POWER_UP_CONTROL, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_PGA_S("Output DACL", 2, NAU8825_REG_CHARGE_PUMP, 8, 1, NULL, 0),
-	SND_SOC_DAPM_PGA_S("Output DACR", 2, NAU8825_REG_CHARGE_PUMP, 9, 1, NULL, 0),
+	SND_SOC_DAPM_PGA_S("Output DACL", 7,
+		NAU8825_REG_CHARGE_PUMP, 8, 1, nau8825_output_dac_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_S("Output DACR", 7,
+		NAU8825_REG_CHARGE_PUMP, 9, 1, nau8825_output_dac_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_HP("HPOL", nau8825_hp_event),
+	SND_SOC_DAPM_HP("HPOR", nau8825_hp_event),
 
-	SND_SOC_DAPM_OUTPUT("HPOL"),
-	SND_SOC_DAPM_OUTPUT("HPOR"),
+	SND_SOC_DAPM_PRE("Pre Playback", nau8825_playback_event),
+	SND_SOC_DAPM_POST("Post Playback", nau8825_playback_event),
 };
 
 static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
@@ -399,14 +508,14 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
 	{"DACR Mux", "DACR", "DDACR"},
 	{"HP amp L", NULL, "DACL Mux"},
 	{"HP amp R", NULL, "DACR Mux"},
-	{"HP amp L", NULL, "HP amp power"},
-	{"HP amp R", NULL, "HP amp power"},
-	{"ADACL", NULL, "HP amp L"},
-	{"ADACR", NULL, "HP amp R"},
-	{"ADACL", NULL, "ADACL Clock"},
-	{"ADACR", NULL, "ADACR Clock"},
-	{"Output Driver L Stage 1", NULL, "ADACL"},
-	{"Output Driver R Stage 1", NULL, "ADACR"},
+	{"Charge Pump", NULL, "HP amp L"},
+	{"Charge Pump", NULL, "HP amp R"},
+	{"ADACL", NULL, "Charge Pump"},
+	{"ADACR", NULL, "Charge Pump"},
+	{"ADACL Clock", NULL, "ADACL"},
+	{"ADACR Clock", NULL, "ADACR"},
+	{"Output Driver L Stage 1", NULL, "ADACL Clock"},
+	{"Output Driver R Stage 1", NULL, "ADACR Clock"},
 	{"Output Driver L Stage 2", NULL, "Output Driver L Stage 1"},
 	{"Output Driver R Stage 2", NULL, "Output Driver R Stage 1"},
 	{"Output Driver L Stage 3", NULL, "Output Driver L Stage 2"},
@@ -415,8 +524,6 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
 	{"Output DACR", NULL, "Output Driver R Stage 3"},
 	{"HPOL", NULL, "Output DACL"},
 	{"HPOR", NULL, "Output DACR"},
-	{"HPOL", NULL, "Charge Pump"},
-	{"HPOR", NULL, "Charge Pump"},
 };
 
 static int nau8825_hw_params(struct snd_pcm_substream *substream,
@@ -792,6 +899,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 {
 	struct regmap *regmap = nau8825->regmap;
 
+	/* Latch IIC LSB value */
+	regmap_write(regmap, NAU8825_REG_IIC_ADDR_SET, 0x0001);
 	/* Enable Bias/Vmid */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
 		NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
@@ -846,6 +955,29 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_128);
 	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
 		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_128);
+	/* Disable DACR/L power */
+	regmap_update_bits(regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL);
+	/* CICCLP off */
+	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
+		NAU8825_DAC_CLIP_OFF, NAU8825_DAC_CLIP_OFF);
+
+	/* Class AB bias current to 2x, DAC Capacitor enable MSB/LSB */
+	regmap_update_bits(regmap, NAU8825_REG_ANALOG_CONTROL_2,
+		NAU8825_HP_NON_CLASSG_CURRENT_2xADJ |
+		NAU8825_DAC_CAPACITOR_MSB | NAU8825_DAC_CAPACITOR_LSB,
+		NAU8825_HP_NON_CLASSG_CURRENT_2xADJ |
+		NAU8825_DAC_CAPACITOR_MSB | NAU8825_DAC_CAPACITOR_LSB);
+	/* Class G timer 64ms */
+	regmap_update_bits(regmap, NAU8825_REG_CLASSG_CTRL,
+		NAU8825_CLASSG_TIMER_MASK,
+		0x20 << NAU8825_CLASSG_TIMER_SFT);
+	/* DAC clock delay 2ns, VREF */
+	regmap_update_bits(regmap, NAU8825_REG_RDAC,
+		NAU8825_RDAC_CLK_DELAY_MASK | NAU8825_RDAC_VREF_MASK,
+		(0x2 << NAU8825_RDAC_CLK_DELAY_SFT) |
+		(0x3 << NAU8825_RDAC_VREF_SFT));
 }
 
 static const struct regmap_config nau8825_regmap_config = {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 8237693..029134a 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -14,6 +14,7 @@
 
 #define NAU8825_REG_RESET		0x00
 #define NAU8825_REG_ENA_CTRL		0x01
+#define NAU8825_REG_IIC_ADDR_SET		0x02
 #define NAU8825_REG_CLK_DIVIDER		0x03
 #define NAU8825_REG_FLL1		0x04
 #define NAU8825_REG_FLL2		0x05
@@ -259,12 +260,18 @@
 /* DACR_CTRL (0x34) */
 #define NAU8825_DACR_CH_SEL_SFT	9
 
+/* CLASSG_CTRL (0x50) */
+#define NAU8825_CLASSG_TIMER_SFT	8
+#define NAU8825_CLASSG_TIMER_MASK	(0x3f << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_EN		(1 << 0)
+
 /* I2C_DEVICE_ID (0x58) */
 #define NAU8825_GPIO2JD1	(1 << 7)
 #define NAU8825_SOFTWARE_ID_MASK	0x3
 #define NAU8825_SOFTWARE_ID_NAU8825	0x0
 
 /* BIAS_ADJ (0x66) */
+#define NAU8825_BIAS_TESTDAC_EN	(0x3 << 8)
 #define NAU8825_BIAS_VMID	(1 << 6)
 #define NAU8825_BIAS_VMID_SEL_SFT	4
 #define NAU8825_BIAS_VMID_SEL_MASK	(3 << NAU8825_BIAS_VMID_SEL_SFT)
@@ -282,6 +289,12 @@
 #define NAU8825_ADC_VREFSEL_VMID_PLUS_1DB	(3 << 8)
 #define NAU8825_POWERUP_ADCL	(1 << 6)
 
+/* RDAC (0x73) */
+#define NAU8825_RDAC_CLK_DELAY_SFT	4
+#define NAU8825_RDAC_CLK_DELAY_MASK	(0x7 << NAU8825_RDAC_CLK_DELAY_SFT)
+#define NAU8825_RDAC_VREF_SFT	2
+#define NAU8825_RDAC_VREF_MASK	(0x3 << NAU8825_RDAC_VREF_SFT)
+
 /* MIC_BIAS (0x74) */
 #define NAU8825_MICBIAS_JKSLV	(1 << 14)
 #define NAU8825_MICBIAS_JKR2	(1 << 12)
@@ -292,6 +305,7 @@
 /* BOOST (0x76) */
 #define NAU8825_PRECHARGE_DIS	(1 << 13)
 #define NAU8825_GLOBAL_BIAS_EN	(1 << 12)
+#define NAU8825_HP_BOOST_DIS		(1 << 9)
 #define NAU8825_HP_BOOST_G_DIS	(1 << 8)
 #define NAU8825_SHORT_SHUTDOWN_EN	(1 << 6)
 
-- 
2.6.4
