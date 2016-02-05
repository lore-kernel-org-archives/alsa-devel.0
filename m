From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: add crosstalk suppression
	feature
Date: Fri, 5 Feb 2016 13:52:46 +0800
Message-ID: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A72B2605C6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 06:52:37 +0100 (CET)
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

Add crosstalk signal suppression function.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 403 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  77 ++++++++-
 2 files changed, 479 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index d270f63..81554be 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -82,6 +82,380 @@ static const struct nau8825_fll_attr fll_pre_scalar[] = {
 	{ 8, 0x3 },
 };
 
+/* Crosstalk detection */
+#define LOG10_MAGIC 646456993
+#define GAIN_AUGMENT 22500
+#define SIDETONE_BASE 207000
+
+static struct reg_default nau8825_xtalk_baktab[] = {
+	{ NAU8825_REG_FLL6, 0 },
+	{ NAU8825_REG_CLK_DIVIDER, 0 },
+	{ NAU8825_REG_ADC_DGAIN_CTRL, 0 },
+	{ NAU8825_REG_HSVOL_CTRL, 0 },
+	{ NAU8825_REG_DACL_CTRL, 0 },
+	{ NAU8825_REG_DACR_CTRL, 0 },
+	{ NAU8825_REG_CLASSG_CTRL, 0 },
+};
+
+static const struct reg_default nau8825_biq_reg[] = {
+	{ NAU8825_REG_BIQ_CTRL, 0x0000 },
+	{ NAU8825_REG_BIQ_COF1, 0x009B },
+	{ NAU8825_REG_BIQ_COF2, 0x0006 },
+	{ NAU8825_REG_BIQ_COF3, 0xff66 },
+	{ NAU8825_REG_BIQ_COF4, 0x0000 },
+	{ NAU8825_REG_BIQ_COF5, 0xffb3 },
+	{ NAU8825_REG_BIQ_COF6, 0x0000 },
+	{ NAU8825_REG_BIQ_COF7, 0x009A },
+	{ NAU8825_REG_BIQ_COF8, 0x0006 },
+	{ NAU8825_REG_BIQ_COF9, 0xffb3 },
+	{ NAU8825_REG_BIQ_COF10, 0x8000 },
+	{ NAU8825_REG_BIQ_CTRL, 0x0010 },
+};
+
+static const unsigned short logtable[256] = {
+	0x0000, 0x0171, 0x02e0, 0x044e, 0x05ba, 0x0725, 0x088e, 0x09f7,
+	0x0b5d, 0x0cc3, 0x0e27, 0x0f8a, 0x10eb, 0x124b, 0x13aa, 0x1508,
+	0x1664, 0x17bf, 0x1919, 0x1a71, 0x1bc8, 0x1d1e, 0x1e73, 0x1fc6,
+	0x2119, 0x226a, 0x23ba, 0x2508, 0x2656, 0x27a2, 0x28ed, 0x2a37,
+	0x2b80, 0x2cc8, 0x2e0f, 0x2f54, 0x3098, 0x31dc, 0x331e, 0x345f,
+	0x359f, 0x36de, 0x381b, 0x3958, 0x3a94, 0x3bce, 0x3d08, 0x3e41,
+	0x3f78, 0x40af, 0x41e4, 0x4319, 0x444c, 0x457f, 0x46b0, 0x47e1,
+	0x4910, 0x4a3f, 0x4b6c, 0x4c99, 0x4dc5, 0x4eef, 0x5019, 0x5142,
+	0x526a, 0x5391, 0x54b7, 0x55dc, 0x5700, 0x5824, 0x5946, 0x5a68,
+	0x5b89, 0x5ca8, 0x5dc7, 0x5ee5, 0x6003, 0x611f, 0x623a, 0x6355,
+	0x646f, 0x6588, 0x66a0, 0x67b7, 0x68ce, 0x69e4, 0x6af8, 0x6c0c,
+	0x6d20, 0x6e32, 0x6f44, 0x7055, 0x7165, 0x7274, 0x7383, 0x7490,
+	0x759d, 0x76aa, 0x77b5, 0x78c0, 0x79ca, 0x7ad3, 0x7bdb, 0x7ce3,
+	0x7dea, 0x7ef0, 0x7ff6, 0x80fb, 0x81ff, 0x8302, 0x8405, 0x8507,
+	0x8608, 0x8709, 0x8809, 0x8908, 0x8a06, 0x8b04, 0x8c01, 0x8cfe,
+	0x8dfa, 0x8ef5, 0x8fef, 0x90e9, 0x91e2, 0x92db, 0x93d2, 0x94ca,
+	0x95c0, 0x96b6, 0x97ab, 0x98a0, 0x9994, 0x9a87, 0x9b7a, 0x9c6c,
+	0x9d5e, 0x9e4f, 0x9f3f, 0xa02e, 0xa11e, 0xa20c, 0xa2fa, 0xa3e7,
+	0xa4d4, 0xa5c0, 0xa6ab, 0xa796, 0xa881, 0xa96a, 0xaa53, 0xab3c,
+	0xac24, 0xad0c, 0xadf2, 0xaed9, 0xafbe, 0xb0a4, 0xb188, 0xb26c,
+	0xb350, 0xb433, 0xb515, 0xb5f7, 0xb6d9, 0xb7ba, 0xb89a, 0xb97a,
+	0xba59, 0xbb38, 0xbc16, 0xbcf4, 0xbdd1, 0xbead, 0xbf8a, 0xc065,
+	0xc140, 0xc21b, 0xc2f5, 0xc3cf, 0xc4a8, 0xc580, 0xc658, 0xc730,
+	0xc807, 0xc8de, 0xc9b4, 0xca8a, 0xcb5f, 0xcc34, 0xcd08, 0xcddc,
+	0xceaf, 0xcf82, 0xd054, 0xd126, 0xd1f7, 0xd2c8, 0xd399, 0xd469,
+	0xd538, 0xd607, 0xd6d6, 0xd7a4, 0xd872, 0xd93f, 0xda0c, 0xdad9,
+	0xdba5, 0xdc70, 0xdd3b, 0xde06, 0xded0, 0xdf9a, 0xe063, 0xe12c,
+	0xe1f5, 0xe2bd, 0xe385, 0xe44c, 0xe513, 0xe5d9, 0xe69f, 0xe765,
+	0xe82a, 0xe8ef, 0xe9b3, 0xea77, 0xeb3b, 0xebfe, 0xecc1, 0xed83,
+	0xee45, 0xef06, 0xefc8, 0xf088, 0xf149, 0xf209, 0xf2c8, 0xf387,
+	0xf446, 0xf505, 0xf5c3, 0xf680, 0xf73e, 0xf7fb, 0xf8b7, 0xf973,
+	0xfa2f, 0xfaea, 0xfba5, 0xfc60, 0xfd1a, 0xfdd4, 0xfe8e, 0xff47
+};
+
+/**
+ * computes log10 of a value; the result is round off to 3 decimal.
+ * this function takes reference to dvb-math.
+ *
+ * @return log10(value) * 1000
+ */
+static u32 nau8825_intlog10_dec3(u32 value)
+{
+	u32 msb, logentry, significand, interpolation, log10val;
+	u64 log2val;
+
+	msb = fls(value) - 1;
+	significand = value << (31 - msb);
+	logentry = (significand >> 23) & 0xff;
+	interpolation = ((significand & 0x7fffff) *
+		((logtable[(logentry + 1) & 0xff] -
+		logtable[logentry]) & 0xffff)) >> 15;
+
+	log2val = ((msb << 24) + (logtable[logentry] << 8) + interpolation);
+	log10val = (log2val * LOG10_MAGIC) >> 31;
+	return log10val / ((1 << 24) / 1000);
+}
+
+/**
+ * computes cross-talk sidetone with orignal and cross-talk signal
+ *
+ * @sig_org: orignal signal
+ * @sig_cros: cross-talk signal
+ *
+ * return cross-talk sidetone
+ */
+static u32 nau8825_xtalk_sidetone(u32 sig_org, u32 sig_cros)
+{
+	u32 gain, sidetone;
+
+	if (unlikely(sig_org == 0) || unlikely(sig_cros == 0)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	sig_org = nau8825_intlog10_dec3(sig_org);
+	sig_cros = nau8825_intlog10_dec3(sig_cros);
+	gain = (sig_org - sig_cros) * 20 + GAIN_AUGMENT;
+	sidetone = SIDETONE_BASE - gain * 2;
+	sidetone /= 1000;
+
+	return sidetone;
+}
+
+static void nau8825_xtalk_backup(struct nau8825 *nau8825)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++)
+		regmap_read(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
+				&nau8825_xtalk_baktab[i].def);
+}
+
+static void nau8825_xtalk_restore(struct nau8825 *nau8825)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++)
+		regmap_write(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
+				nau8825_xtalk_baktab[i].def);
+}
+
+static void nau8825_xtalk_biq_apply(struct nau8825 *nau8825)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nau8825_biq_reg); i++)
+		regmap_write(nau8825->regmap, nau8825_biq_reg[i].reg,
+				nau8825_biq_reg[i].def);
+}
+
+static void nau8825_xtalk_biq_cancel(struct nau8825 *nau8825)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nau8825_biq_reg); i++)
+		regmap_write(nau8825->regmap, nau8825_biq_reg[i].reg, 0);
+}
+
+static void nau8825_xtalk_prepare_dac(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_TESTDAC_EN, NAU8825_BIAS_TESTDACL_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACR | NAU8825_ENABLE_DACL |
+		NAU8825_ENABLE_ADC | NAU8825_ENABLE_ADC_CLK |
+		NAU8825_ENABLE_DAC_CLK, NAU8825_ENABLE_DACR |
+		NAU8825_ENABLE_DACL | NAU8825_ENABLE_ADC |
+		NAU8825_ENABLE_ADC_CLK | NAU8825_ENABLE_DAC_CLK);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
+		NAU8825_CLASSG_LDAC_EN | NAU8825_CLASSG_RDAC_EN,
+		NAU8825_CLASSG_LDAC_EN | NAU8825_CLASSG_RDAC_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_JAMNODCLOW | NAU8825_CHANRGE_PUMP_EN,
+		NAU8825_JAMNODCLOW | NAU8825_CHANRGE_PUMP_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_RDAC,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L |
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L |
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L, 0);
+}
+
+static void nau8825_xtalk_prepare_adc(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ANALOG_ADC_2,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_VMID_PLUS_0_5DB);
+}
+
+static void nau8825_xtalk_clock(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
+		NAU8825_DCO_EN, NAU8825_DCO_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+		NAU8825_CLK_SRC_MASK | NAU8825_CLK_MCLK_SRC_MASK,
+		NAU8825_CLK_SRC_VCO | 0x3);
+}
+
+static void nau8825_xtalk_prepare(struct nau8825 *nau8825)
+{
+	/* backup value of specific register used by cross-talk */
+	nau8825_xtalk_backup(nau8825);
+	nau8825_xtalk_clock(nau8825);
+	nau8825_xtalk_prepare_dac(nau8825);
+	nau8825_xtalk_prepare_adc(nau8825);
+	/* Config channel */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACL_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
+		NAU8825_DACR_CH_SEL_MASK, NAU8825_DACR_CH_SEL_R);
+	/* Config headphone volume */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSVOL_CTRL,
+		NAU8825_HPL_VOL_MASK | NAU8825_HPR_VOL_MASK, 0x0492);
+	/* Config IIS parameter */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_DRV_MASK | NAU8825_I2S_BLK_DIV_MASK,
+		(0x2 << NAU8825_I2S_DRV_SFT) | 0x1);
+	/* Config crosstalk */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL,
+		NAU8825_IMM_THD_MASK | NAU8825_IMM_CYC_MASK |
+		NAU8825_IMM_DAC_SRC_MASK, (0x2 << NAU8825_IMM_THD_SFT) |
+		NAU8825_IMM_CYC_8192 | NAU8825_IMM_DAC_SRC_SIN);
+	regmap_update_bits(nau8825->regmap,
+		NAU8825_REG_INTERRUPT_MASK, NAU8825_IRQ_RMS_EN, 0);
+	nau8825_xtalk_biq_apply(nau8825);
+}
+
+static void nau8825_xtalk_clean_dac(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL |
+		NAU8825_JAMNODCLOW);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
+		NAU8825_CLASSG_LDAC_EN | NAU8825_CLASSG_RDAC_EN, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_CHANRGE_PUMP_EN, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP |
+		NAU8825_BIAS_TESTDAC_EN, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_HP_BOOST_DIS, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACL | NAU8825_ENABLE_ADC |
+		NAU8825_ENABLE_ADC_CLK | NAU8825_ENABLE_DAC_CLK, 0);
+	if (!nau8825->irq)
+		regmap_update_bits(nau8825->regmap,
+			NAU8825_REG_ENA_CTRL, NAU8825_ENABLE_DACR, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_RDAC,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN, 0);
+}
+
+static void nau8825_xtalk_clean_adc(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ANALOG_ADC_2,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK, 0);
+}
+
+static void nau8825_xtalk_clean(struct nau8825 *nau8825)
+{
+	/* restore value of specific register for cross-talk */
+	nau8825_xtalk_restore(nau8825);
+	nau8825_xtalk_clean_dac(nau8825);
+	nau8825_xtalk_clean_adc(nau8825);
+	regmap_write(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_RMS_EN, NAU8825_IRQ_RMS_EN);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+	nau8825_xtalk_biq_cancel(nau8825);
+}
+
+static void nau8825_xtalk_imm_start(struct nau8825 *nau8825, int vol)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ADC_DGAIN_CTRL,
+				NAU8825_ADC_DIG_VOL_MASK, vol);
+	switch (nau8825->xtalk_state) {
+	case NAU8825_XTALK_HPR_R2L:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP,
+			NAU8825_BIAS_HPR_IMP);
+		break;
+	case NAU8825_XTALK_HPL_R2L:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP,
+			NAU8825_BIAS_HPL_IMP);
+		break;
+	default:
+		break;
+	}
+	msleep(100);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL,
+				NAU8825_IMM_EN, NAU8825_IMM_EN);
+}
+
+static void nau8825_xtalk_imm_stop(struct nau8825 *nau8825)
+{
+	regmap_update_bits(nau8825->regmap,
+		NAU8825_REG_IMM_MODE_CTRL, NAU8825_IMM_EN, 0);
+}
+
+static void nau8825_xtalk_measure(struct nau8825 *nau8825)
+{
+	u32 sidetone;
+
+	switch (nau8825->xtalk_state) {
+	case NAU8825_XTALK_DONE:
+		nau8825_xtalk_prepare(nau8825);
+		nau8825->xtalk_state = NAU8825_XTALK_HPR_R2L;
+		msleep(280);
+		nau8825_xtalk_imm_start(nau8825, 0x00d2);
+		break;
+	case NAU8825_XTALK_HPR_R2L:
+		regmap_read(nau8825->regmap, NAU8825_REG_IMM_RMS_L,
+			&nau8825->imp_rms[NAU8825_XTALK_HPR_R2L]);
+		dev_dbg(nau8825->dev, "HPR_R2L imm: %x\n",
+			nau8825->imp_rms[NAU8825_XTALK_HPR_R2L]);
+		nau8825_xtalk_imm_stop(nau8825);
+		nau8825->xtalk_state = NAU8825_XTALK_HPL_R2L;
+		nau8825_xtalk_imm_start(nau8825, 0x00ff);
+		break;
+	case NAU8825_XTALK_HPL_R2L:
+		regmap_read(nau8825->regmap, NAU8825_REG_IMM_RMS_L,
+			&nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		dev_dbg(nau8825->dev, "HPL_R2L imm: %x\n",
+			nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		nau8825_xtalk_imm_stop(nau8825);
+		nau8825->xtalk_state = NAU8825_XTALK_IMM;
+		break;
+	case NAU8825_XTALK_IMM:
+		sidetone = nau8825_xtalk_sidetone(
+			nau8825->imp_rms[NAU8825_XTALK_HPR_R2L],
+			nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		dev_dbg(nau8825->dev, "cross-talk sidetone: %x\n", sidetone);
+		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
+					(sidetone << 8) | sidetone);
+		nau8825_xtalk_clean(nau8825);
+		nau8825->xtalk_state = NAU8825_XTALK_DONE;
+		break;
+	default:
+		break;
+	}
+}
+
+static void nau8825_xtalk_work(struct work_struct *work)
+{
+	struct nau8825 *nau8825 = container_of(
+		work, struct nau8825, xtalk_work);
+
+	nau8825_xtalk_measure(nau8825);
+	if (nau8825->xtalk_state == NAU8825_XTALK_IMM)
+		nau8825_xtalk_measure(nau8825);
+}
+
+
 static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_ENA_CTRL, 0x00ff },
 	{ NAU8825_REG_IIC_ADDR_SET, 0x0 },
@@ -211,6 +585,7 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
 	case NAU8825_REG_RESET:
 	case NAU8825_REG_IRQ_STATUS:
 	case NAU8825_REG_INT_CLR_KEY_STATUS:
+	case NAU8825_REG_BIQ_CTRL ... NAU8825_REG_BIQ_COF10:
 	case NAU8825_REG_IMM_RMS_L:
 	case NAU8825_REG_IMM_RMS_R:
 	case NAU8825_REG_I2C_DEVICE_ID:
@@ -741,6 +1116,10 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 
 	regmap_read(regmap, NAU8825_REG_GENERAL_STATUS, &jack_status_reg);
 	mic_detected = (jack_status_reg >> 10) & 3;
+	if (mic_detected == 0x3)
+		nau8825->high_imped = 1;
+	else
+		nau8825->high_imped = 0;
 
 	switch (mic_detected) {
 	case 0:
@@ -836,6 +1215,10 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
+			if (!nau8825->high_imped) {
+				nau8825->xtalk_state = NAU8825_XTALK_DONE;
+				schedule_work(&nau8825->xtalk_work);
+			}
 		} else {
 			dev_warn(nau8825->dev, "Headset completion IRQ fired but no headset connected\n");
 			nau8825_eject_jack(nau8825);
@@ -843,6 +1226,9 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 
 		event_mask |= SND_JACK_HEADSET;
 		clear_irq = NAU8825_HEADSET_COMPLETION_IRQ;
+	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
+		schedule_work(&nau8825->xtalk_work);
+		clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
 	}
 
 	if (!clear_irq)
@@ -901,6 +1287,11 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 
 	/* Latch IIC LSB value */
 	regmap_write(regmap, NAU8825_REG_IIC_ADDR_SET, 0x0001);
+	/* Config channel */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACL_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
+		NAU8825_DACR_CH_SEL_MASK, NAU8825_DACR_CH_SEL_R);
 	/* Enable Bias/Vmid */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
 		NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
@@ -1007,6 +1398,17 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 	regmap_write(nau8825->regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0);
 	nau8825_restart_jack_detection(nau8825->regmap);
 
+	INIT_WORK(&nau8825->xtalk_work, nau8825_xtalk_work);
+
+	return 0;
+}
+
+static int nau8825_codec_remove(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	cancel_work_sync(&nau8825->xtalk_work);
+
 	return 0;
 }
 
@@ -1326,6 +1728,7 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
+	.remove = nau8825_codec_remove,
 	.set_sysclk = nau8825_set_sysclk,
 	.set_pll = nau8825_set_pll,
 	.set_bias_level = nau8825_set_bias_level,
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 029134a..808474d 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -98,7 +98,13 @@
 #define NAU8825_ENABLE_DACR_SFT	10
 #define NAU8825_ENABLE_DACR	(1 << NAU8825_ENABLE_DACR_SFT)
 #define NAU8825_ENABLE_DACL_SFT	9
+#define NAU8825_ENABLE_DACL		(1 << NAU8825_ENABLE_DACL_SFT)
 #define NAU8825_ENABLE_ADC_SFT	8
+#define NAU8825_ENABLE_ADC		(1 << NAU8825_ENABLE_ADC_SFT)
+#define NAU8825_ENABLE_ADC_CLK_SFT	7
+#define NAU8825_ENABLE_ADC_CLK	(1 << NAU8825_ENABLE_ADC_CLK_SFT)
+#define NAU8825_ENABLE_DAC_CLK_SFT	6
+#define NAU8825_ENABLE_DAC_CLK	(1 << NAU8825_ENABLE_DAC_CLK_SFT)
 #define NAU8825_ENABLE_SAR_SFT	1
 
 /* CLK_DIVIDER (0x3) */
@@ -153,6 +159,7 @@
 /* INTERRUPT_MASK (0xf) */
 #define NAU8825_IRQ_OUTPUT_EN (1 << 11)
 #define NAU8825_IRQ_HEADSET_COMPLETE_EN (1 << 10)
+#define NAU8825_IRQ_RMS_EN (1 << 8)
 #define NAU8825_IRQ_KEY_RELEASE_EN (1 << 7)
 #define NAU8825_IRQ_KEY_SHORT_PRESS_EN (1 << 5)
 #define NAU8825_IRQ_EJECT_EN (1 << 2)
@@ -225,10 +232,13 @@
 
 /* I2S_PCM_CTRL2 (0x1d) */
 #define NAU8825_I2S_TRISTATE	(1 << 15) /* 0 - normal mode, 1 - Hi-Z output */
+#define NAU8825_I2S_DRV_SFT	12
+#define NAU8825_I2S_DRV_MASK	(0x3 << NAU8825_I2S_DRV_SFT)
 #define NAU8825_I2S_MS_SFT	3
 #define NAU8825_I2S_MS_MASK	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
+#define NAU8825_I2S_BLK_DIV_MASK	0x7
 
 /* ADC_RATE (0x2b) */
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
@@ -247,22 +257,66 @@
 #define NAU8825_DAC_OVERSAMPLE_128	2
 #define NAU8825_DAC_OVERSAMPLE_32	4
 
+/* ADC_DGAIN_CTRL (0x30) */
+#define NAU8825_ADC_DAC_ST1_SFT	12
+#define NAU8825_ADC_DAC_ST1_MASK	0xf
+#define NAU8825_ADC_DAC_ST2_SFT	8
+#define NAU8825_ADC_DAC_ST2_MASK	0xf
+#define NAU8825_ADC_DIG_VOL_MASK	0xff
+
 /* MUTE_CTRL (0x31) */
 #define NAU8825_DAC_ZERO_CROSSING_EN	(1 << 9)
 #define NAU8825_DAC_SOFT_MUTE	(1 << 9)
 
 /* HSVOL_CTRL (0x32) */
 #define NAU8825_HP_MUTE	(1 << 15)
+#define NAU8825_HP_MUTE_AUTO	(1 << 14)
+#define NAU8825_HPL_MUTE	(1 << 13)
+#define NAU8825_HPR_MUTE	(1 << 12)
+#define NAU8825_HPL_VOL_SFT	6
+#define NAU8825_HPL_VOL_MASK	(0x3f << NAU8825_HPL_VOL_SFT)
+#define NAU8825_HPR_VOL_SFT	0
+#define NAU8825_HPR_VOL_MASK	(0x3f << NAU8825_HPR_VOL_SFT)
 
 /* DACL_CTRL (0x33) */
 #define NAU8825_DACL_CH_SEL_SFT	9
+#define NAU8825_DACL_CH_SEL_MASK	(0x1 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_L		(0x0 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_R		(0x1 << NAU8825_DACL_CH_SEL_SFT)
 
 /* DACR_CTRL (0x34) */
 #define NAU8825_DACR_CH_SEL_SFT	9
+#define NAU8825_DACR_CH_SEL_MASK	(0x1 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_L		(0x0 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_R		(0x1 << NAU8825_DACR_CH_SEL_SFT)
+
+/* IMM_MODE_CTRL (0x4C) */
+#define NAU8825_IMM_THD_SFT		8
+#define NAU8825_IMM_THD_MASK		(0x3f << NAU8825_IMM_THD_SFT)
+#define NAU8825_IMM_CYC_SFT		4
+#define NAU8825_IMM_CYC_MASK		(0x3 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_1024		(0x0 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_2048		(0x1 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_4096		(0x2 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_8192		(0x3 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_EN			(1 << 3)
+#define NAU8825_IMM_DAC_SRC_MASK	0x7
+#define NAU8825_IMM_DAC_SRC_BIQ	0x0
+#define NAU8825_IMM_DAC_SRC_DRC	0x1
+#define NAU8825_IMM_DAC_SRC_MIX	0x2
+#define NAU8825_IMM_DAC_SRC_SIN	0x3
 
 /* CLASSG_CTRL (0x50) */
 #define NAU8825_CLASSG_TIMER_SFT	8
 #define NAU8825_CLASSG_TIMER_MASK	(0x3f << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_1ms	(0x1 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_2ms	(0x2 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_8ms	(0x4 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_16ms	(0x8 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_32ms	(0x10 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_64ms	(0x20 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_LDAC_EN		(0x1 << 2)
+#define NAU8825_CLASSG_RDAC_EN		(0x1 << 1)
 #define NAU8825_CLASSG_EN		(1 << 0)
 
 /* I2C_DEVICE_ID (0x58) */
@@ -271,7 +325,12 @@
 #define NAU8825_SOFTWARE_ID_NAU8825	0x0
 
 /* BIAS_ADJ (0x66) */
-#define NAU8825_BIAS_TESTDAC_EN	(0x3 << 8)
+#define NAU8825_BIAS_HPR_IMP		(1 << 15)
+#define NAU8825_BIAS_HPL_IMP		(1 << 14)
+#define NAU8825_BIAS_TESTDAC_SFT	8
+#define NAU8825_BIAS_TESTDAC_EN	(0x3 << NAU8825_BIAS_TESTDAC_SFT)
+#define NAU8825_BIAS_TESTDACR_EN	(0x2 << NAU8825_BIAS_TESTDAC_SFT)
+#define NAU8825_BIAS_TESTDACL_EN	(0x1 << NAU8825_BIAS_TESTDAC_SFT)
 #define NAU8825_BIAS_VMID	(1 << 6)
 #define NAU8825_BIAS_VMID_SEL_SFT	4
 #define NAU8825_BIAS_VMID_SEL_MASK	(3 << NAU8825_BIAS_VMID_SEL_SFT)
@@ -290,6 +349,10 @@
 #define NAU8825_POWERUP_ADCL	(1 << 6)
 
 /* RDAC (0x73) */
+#define NAU8825_RDAC_EN_SFT		12
+#define NAU8825_RDAC_EN		(0x3 << NAU8825_RDAC_EN_SFT)
+#define NAU8825_RDAC_CLK_EN_SFT	8
+#define NAU8825_RDAC_CLK_EN		(0x3 << NAU8825_RDAC_CLK_EN_SFT)
 #define NAU8825_RDAC_CLK_DELAY_SFT	4
 #define NAU8825_RDAC_CLK_DELAY_MASK	(0x7 << NAU8825_RDAC_CLK_DELAY_SFT)
 #define NAU8825_RDAC_VREF_SFT	2
@@ -333,12 +396,21 @@ enum {
 	NAU8825_CLK_FLL_FS,
 };
 
+/* Crosstalk detection state */
+enum {
+	NAU8825_XTALK_HPR_R2L = 0,
+	NAU8825_XTALK_HPL_R2L,
+	NAU8825_XTALK_IMM,
+	NAU8825_XTALK_DONE,
+};
+
 struct nau8825 {
 	struct device *dev;
 	struct regmap *regmap;
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack *jack;
 	struct clk *mclk;
+	struct work_struct xtalk_work;
 	int irq;
 	int mclk_freq; /* 0 - mclk is disabled */
 	int button_pressed;
@@ -357,6 +429,9 @@ struct nau8825 {
 	int key_debounce;
 	int jack_insert_debounce;
 	int jack_eject_debounce;
+	int xtalk_state;
+	int imp_rms[NAU8825_XTALK_IMM];
+	int high_imped;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.6.4
