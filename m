From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH v4] ASoC: nau8825: fix issue that pop noise
	when start playback
Date: Fri, 11 Mar 2016 17:33:58 -0800
Message-ID: <1457746438-6466-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D802605F0
 for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2016 02:34:07 +0100 (CET)
Received: by mail-pf0-f171.google.com with SMTP id x3so1752954pfb.1
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 17:34:07 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ben Zhang <benzh@chromium.org>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

From: John Hsu <KCHSU0@nuvoton.com>

Reduce pop noise in power up and down sequence when playback.
The DAPM widgets graph is reconstructed to ensure the
register write sequence at playback matches exactly to the
v5 clickless sequence provided by Nuvoton.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 169 +++++++++++++++++++++++++++++++++------------
 sound/soc/codecs/nau8825.h |  16 ++++-
 2 files changed, 141 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c1b87c5..1c87299 100644
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
@@ -227,10 +226,42 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
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
+static int nau8825_output_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Disables the TESTDAC to let DAC signal pass through. */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_TESTDAC_EN, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_TESTDAC_EN, NAU8825_BIAS_TESTDAC_EN);
 		break;
 	default:
 		return -EINVAL;
@@ -316,10 +347,10 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("SAR", NULL, NAU8825_REG_SAR_CTRL,
 		NAU8825_SAR_ADC_EN_SFT, 0),
 
-	SND_SOC_DAPM_DAC("ADACL", NULL, NAU8825_REG_RDAC, 12, 0),
-	SND_SOC_DAPM_DAC("ADACR", NULL, NAU8825_REG_RDAC, 13, 0),
-	SND_SOC_DAPM_SUPPLY("ADACL Clock", NAU8825_REG_RDAC, 8, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADACR Clock", NAU8825_REG_RDAC, 9, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACL", 2, NAU8825_REG_RDAC, 12, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACR", 2, NAU8825_REG_RDAC, 13, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACL Clock", 3, NAU8825_REG_RDAC, 8, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("ADACR Clock", 3, NAU8825_REG_RDAC, 9, 0, NULL, 0),
 
 	SND_SOC_DAPM_DAC("DDACR", NULL, NAU8825_REG_ENA_CTRL,
 		NAU8825_ENABLE_DACR_SFT, 0),
@@ -330,29 +361,48 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
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
+		SND_SOC_DAPM_PRE_PMD),
 
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
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_S("Output DACR", 7,
+		NAU8825_REG_CHARGE_PUMP, 9, 1, nau8825_output_dac_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* HPOL/R are ungrounded by disabling 16 Ohm pull-downs on playback */
+	SND_SOC_DAPM_PGA_S("HPOL Pulldown", 8,
+		NAU8825_REG_HSD_CTRL, 0, 1, NULL, 0),
+	SND_SOC_DAPM_PGA_S("HPOR Pulldown", 8,
+		NAU8825_REG_HSD_CTRL, 1, 1, NULL, 0),
+
+	/* High current HPOL/R boost driver */
+	SND_SOC_DAPM_PGA_S("HP Boost Driver", 9,
+		NAU8825_REG_BOOST, 9, 1, NULL, 0),
+
+	/* Class G operation control*/
+	SND_SOC_DAPM_PGA_S("Class G", 10,
+		NAU8825_REG_CLASSG_CTRL, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("HPOL"),
 	SND_SOC_DAPM_OUTPUT("HPOR"),
@@ -375,24 +425,27 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
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
 	{"Output Driver R Stage 3", NULL, "Output Driver R Stage 2"},
 	{"Output DACL", NULL, "Output Driver L Stage 3"},
 	{"Output DACR", NULL, "Output Driver R Stage 3"},
-	{"HPOL", NULL, "Output DACL"},
-	{"HPOR", NULL, "Output DACR"},
-	{"HPOL", NULL, "Charge Pump"},
-	{"HPOR", NULL, "Charge Pump"},
+	{"HPOL Pulldown", NULL, "Output DACL"},
+	{"HPOR Pulldown", NULL, "Output DACR"},
+	{"HP Boost Driver", NULL, "HPOL Pulldown"},
+	{"HP Boost Driver", NULL, "HPOR Pulldown"},
+	{"Class G", NULL, "HP Boost Driver"},
+	{"HPOL", NULL, "Class G"},
+	{"HPOR", NULL, "Class G"},
 };
 
 static int nau8825_hw_params(struct snd_pcm_substream *substream,
@@ -659,11 +712,10 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 		break;
 	}
 
-	if (type & SND_JACK_HEADPHONE) {
-		/* Unground HPL/R */
-		regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 0x3, 0);
-	}
-
+	/* Leaving HPOL/R grounded after jack insert by default. They will be
+	 * ungrounded as part of the widget power up sequence at the beginning
+	 * of playback to reduce pop.
+	 */
 	return type;
 }
 
@@ -768,6 +820,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 {
 	struct regmap *regmap = nau8825->regmap;
 
+	/* Latch IIC LSB value */
+	regmap_write(regmap, NAU8825_REG_IIC_ADDR_SET, 0x0001);
 	/* Enable Bias/Vmid */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
 		NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
@@ -780,10 +834,10 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		nau8825->vref_impedance << NAU8825_BIAS_VMID_SEL_SFT);
 	/* Disable Boost Driver, Automatic Short circuit protection enable */
 	regmap_update_bits(regmap, NAU8825_REG_BOOST,
-		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_G_DIS |
-		NAU8825_SHORT_SHUTDOWN_EN,
-		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_G_DIS |
-		NAU8825_SHORT_SHUTDOWN_EN);
+		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_DIS |
+		NAU8825_HP_BOOST_G_DIS | NAU8825_SHORT_SHUTDOWN_EN,
+		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_DIS |
+		NAU8825_HP_BOOST_G_DIS | NAU8825_SHORT_SHUTDOWN_EN);
 
 	regmap_update_bits(regmap, NAU8825_REG_GPIO12_CTRL,
 		NAU8825_JKDET_OUTPUT_EN,
@@ -822,6 +876,35 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_128);
 	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
 		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_128);
+	/* Disable DACR/L power */
+	regmap_update_bits(regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL);
+	/* Enable TESTDAC. This sets the analog DAC inputs to a '0' input
+	 * signal to avoid any glitches due to power up transients in both
+	 * the analog and digital DAC circuit.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_TESTDAC_EN, NAU8825_BIAS_TESTDAC_EN);
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
index dff8edb..8ceb5f3 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -14,6 +14,7 @@
 
 #define NAU8825_REG_RESET		0x00
 #define NAU8825_REG_ENA_CTRL		0x01
+#define NAU8825_REG_IIC_ADDR_SET		0x02
 #define NAU8825_REG_CLK_DIVIDER		0x03
 #define NAU8825_REG_FLL1		0x04
 #define NAU8825_REG_FLL2		0x05
@@ -129,7 +130,7 @@
 
 /* HSD_CTRL (0xc) */
 #define NAU8825_HSD_AUTO_MODE	(1 << 6)
-/* 0 - short to GND, 1 - open */
+/* 0 - open, 1 - short to GND */
 #define NAU8825_SPKR_DWN1R	(1 << 1)
 #define NAU8825_SPKR_DWN1L	(1 << 0)
 
@@ -251,12 +252,18 @@
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
@@ -274,6 +281,12 @@
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
@@ -284,6 +297,7 @@
 /* BOOST (0x76) */
 #define NAU8825_PRECHARGE_DIS	(1 << 13)
 #define NAU8825_GLOBAL_BIAS_EN	(1 << 12)
+#define NAU8825_HP_BOOST_DIS		(1 << 9)
 #define NAU8825_HP_BOOST_G_DIS	(1 << 8)
 #define NAU8825_SHORT_SHUTDOWN_EN	(1 << 6)
 
-- 
2.7.0.rc3.207.g0ac5344
