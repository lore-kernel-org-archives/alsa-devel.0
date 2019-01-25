From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt6358: add codec driver" to
	the asoc tree
Date: Fri, 25 Jan 2019 18:11:11 +0000 (GMT)
Message-ID: <20190125181111.CE7221126FC0@debutante.sirena.org.uk>
References: <1548139153-18783-4-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2416C26680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:11:12 +0100 (CET)
In-Reply-To: <1548139153-18783-4-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, shunli.wang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt6358: add codec driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6a8d4198ca80deb2f978260a096fa651229cf4a2 Mon Sep 17 00:00:00 2001
From: Shunli Wang <shunli.wang@mediatek.com>
Date: Tue, 22 Jan 2019 14:39:10 +0800
Subject: [PATCH] ASoC: mediatek: mt6358: add codec driver

add the mt6358 codec driver.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |    7 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/mt6358.c | 2336 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mt6358.h | 2314 ++++++++++++++++++++++++++++++++++++
 4 files changed, 4659 insertions(+)
 create mode 100644 sound/soc/codecs/mt6358.c
 create mode 100644 sound/soc/codecs/mt6358.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 71e6e123a115..55fd58015c2d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -110,6 +110,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_MT6351 if MTK_PMIC_WRAP
+	select SND_SOC_MT6358 if MTK_PMIC_WRAP
 	select SND_SOC_NAU8540 if I2C
 	select SND_SOC_NAU8810 if I2C
 	select SND_SOC_NAU8822 if I2C
@@ -1339,6 +1340,12 @@ config SND_SOC_ML26124
 config SND_SOC_MT6351
 	tristate "MediaTek MT6351 Codec"
 
+config SND_SOC_MT6358
+	tristate "MediaTek MT6358 Codec"
+	help
+	  Enable support for the platform which uses MT6358 as
+	external codec device.
+
 config SND_SOC_NAU8540
        tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
        depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9bb3346fab2f..457f9ff5a2d4 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -107,6 +107,7 @@ snd-soc-ml26124-objs := ml26124.o
 snd-soc-msm8916-analog-objs := msm8916-wcd-analog.o
 snd-soc-msm8916-digital-objs := msm8916-wcd-digital.o
 snd-soc-mt6351-objs := mt6351.o
+snd-soc-mt6358-objs := mt6358.o
 snd-soc-nau8540-objs := nau8540.o
 snd-soc-nau8810-objs := nau8810.o
 snd-soc-nau8822-objs := nau8822.o
@@ -375,6 +376,7 @@ obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_MSM8916_WCD_ANALOG) +=snd-soc-msm8916-analog.o
 obj-$(CONFIG_SND_SOC_MSM8916_WCD_DIGITAL) +=snd-soc-msm8916-digital.o
 obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-mt6351.o
+obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
 obj-$(CONFIG_SND_SOC_NAU8810)   += snd-soc-nau8810.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
new file mode 100644
index 000000000000..d4c4fee6d3d9
--- /dev/null
+++ b/sound/soc/codecs/mt6358.c
@@ -0,0 +1,2336 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt6358.c  --  mt6358 ALSA SoC audio codec driver
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/regulator/consumer.h>
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "mt6358.h"
+
+enum {
+	AUDIO_ANALOG_VOLUME_HSOUTL,
+	AUDIO_ANALOG_VOLUME_HSOUTR,
+	AUDIO_ANALOG_VOLUME_HPOUTL,
+	AUDIO_ANALOG_VOLUME_HPOUTR,
+	AUDIO_ANALOG_VOLUME_LINEOUTL,
+	AUDIO_ANALOG_VOLUME_LINEOUTR,
+	AUDIO_ANALOG_VOLUME_MICAMP1,
+	AUDIO_ANALOG_VOLUME_MICAMP2,
+	AUDIO_ANALOG_VOLUME_TYPE_MAX
+};
+
+enum {
+	MUX_ADC_L,
+	MUX_ADC_R,
+	MUX_PGA_L,
+	MUX_PGA_R,
+	MUX_MIC_TYPE,
+	MUX_HP_L,
+	MUX_HP_R,
+	MUX_NUM,
+};
+
+enum {
+	DEVICE_HP,
+	DEVICE_LO,
+	DEVICE_RCV,
+	DEVICE_MIC1,
+	DEVICE_MIC2,
+	DEVICE_NUM
+};
+
+/* Supply widget subseq */
+enum {
+	/* common */
+	SUPPLY_SEQ_CLK_BUF,
+	SUPPLY_SEQ_AUD_GLB,
+	SUPPLY_SEQ_CLKSQ,
+	SUPPLY_SEQ_VOW_AUD_LPW,
+	SUPPLY_SEQ_AUD_VOW,
+	SUPPLY_SEQ_VOW_CLK,
+	SUPPLY_SEQ_VOW_LDO,
+	SUPPLY_SEQ_TOP_CK,
+	SUPPLY_SEQ_TOP_CK_LAST,
+	SUPPLY_SEQ_AUD_TOP,
+	SUPPLY_SEQ_AUD_TOP_LAST,
+	SUPPLY_SEQ_AFE,
+	/* capture */
+	SUPPLY_SEQ_ADC_SUPPLY,
+};
+
+enum {
+	CH_L = 0,
+	CH_R,
+	NUM_CH,
+};
+
+#define REG_STRIDE 2
+
+struct mt6358_priv {
+	struct device *dev;
+	struct regmap *regmap;
+
+	unsigned int dl_rate;
+	unsigned int ul_rate;
+
+	int ana_gain[AUDIO_ANALOG_VOLUME_TYPE_MAX];
+	unsigned int mux_select[MUX_NUM];
+
+	int dev_counter[DEVICE_NUM];
+
+	int mtkaif_protocol;
+
+	struct regulator *avdd_reg;
+};
+
+int mt6358_set_mtkaif_protocol(struct snd_soc_component *cmpnt,
+			       int mtkaif_protocol)
+{
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	priv->mtkaif_protocol = mtkaif_protocol;
+	return 0;
+}
+
+static void playback_gpio_set(struct mt6358_priv *priv)
+{
+	/* set gpio mosi mode */
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE2_CLR,
+			   0x01f8, 0x01f8);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE2_SET,
+			   0xffff, 0x0249);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE2,
+			   0xffff, 0x0249);
+}
+
+static void playback_gpio_reset(struct mt6358_priv *priv)
+{
+	/* set pad_aud_*_mosi to GPIO mode and dir input
+	 * reason:
+	 * pad_aud_dat_mosi*, because the pin is used as boot strap
+	 * don't clean clk/sync, for mtkaif protocol 2
+	 */
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE2_CLR,
+			   0x01f8, 0x01f8);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE2,
+			   0x01f8, 0x0000);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_DIR0,
+			   0xf << 8, 0x0);
+}
+
+static void capture_gpio_set(struct mt6358_priv *priv)
+{
+	/* set gpio miso mode */
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE3_CLR,
+			   0xffff, 0xffff);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE3_SET,
+			   0xffff, 0x0249);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE3,
+			   0xffff, 0x0249);
+}
+
+static void capture_gpio_reset(struct mt6358_priv *priv)
+{
+	/* set pad_aud_*_miso to GPIO mode and dir input
+	 * reason:
+	 * pad_aud_clk_miso, because when playback only the miso_clk
+	 * will also have 26m, so will have power leak
+	 * pad_aud_dat_miso*, because the pin is used as boot strap
+	 */
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE3_CLR,
+			   0xffff, 0xffff);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_MODE3,
+			   0xffff, 0x0000);
+	regmap_update_bits(priv->regmap, MT6358_GPIO_DIR0,
+			   0xf << 12, 0x0);
+}
+
+/* use only when not govern by DAPM */
+static int mt6358_set_dcxo(struct mt6358_priv *priv, bool enable)
+{
+	regmap_update_bits(priv->regmap, MT6358_DCXO_CW14,
+			   0x1 << RG_XO_AUDIO_EN_M_SFT,
+			   (enable ? 1 : 0) << RG_XO_AUDIO_EN_M_SFT);
+	return 0;
+}
+
+/* use only when not govern by DAPM */
+static int mt6358_set_clksq(struct mt6358_priv *priv, bool enable)
+{
+	/* audio clk source from internal dcxo */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON6,
+			   RG_CLKSQ_IN_SEL_TEST_MASK_SFT,
+			   0x0);
+
+	/* Enable/disable CLKSQ 26MHz */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON6,
+			   RG_CLKSQ_EN_MASK_SFT,
+			   (enable ? 1 : 0) << RG_CLKSQ_EN_SFT);
+	return 0;
+}
+
+/* use only when not govern by DAPM */
+static int mt6358_set_aud_global_bias(struct mt6358_priv *priv, bool enable)
+{
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13,
+			   RG_AUDGLB_PWRDN_VA28_MASK_SFT,
+			   (enable ? 0 : 1) << RG_AUDGLB_PWRDN_VA28_SFT);
+	return 0;
+}
+
+/* use only when not govern by DAPM */
+static int mt6358_set_topck(struct mt6358_priv *priv, bool enable)
+{
+	regmap_update_bits(priv->regmap, MT6358_AUD_TOP_CKPDN_CON0,
+			   0x0066, enable ? 0x0 : 0x66);
+	return 0;
+}
+
+static int mt6358_mtkaif_tx_enable(struct mt6358_priv *priv)
+{
+	switch (priv->mtkaif_protocol) {
+	case MT6358_MTKAIF_PROTOCOL_2_CLK_P2:
+		/* MTKAIF TX format setting */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_ADDA_MTKAIF_CFG0,
+				   0xffff, 0x0010);
+		/* enable aud_pad TX fifos */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_AUD_PAD_TOP,
+				   0xff00, 0x3800);
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_AUD_PAD_TOP,
+				   0xff00, 0x3900);
+		break;
+	case MT6358_MTKAIF_PROTOCOL_2:
+		/* MTKAIF TX format setting */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_ADDA_MTKAIF_CFG0,
+				   0xffff, 0x0010);
+		/* enable aud_pad TX fifos */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_AUD_PAD_TOP,
+				   0xff00, 0x3100);
+		break;
+	case MT6358_MTKAIF_PROTOCOL_1:
+	default:
+		/* MTKAIF TX format setting */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_ADDA_MTKAIF_CFG0,
+				   0xffff, 0x0000);
+		/* enable aud_pad TX fifos */
+		regmap_update_bits(priv->regmap,
+				   MT6358_AFE_AUD_PAD_TOP,
+				   0xff00, 0x3100);
+		break;
+	}
+	return 0;
+}
+
+static int mt6358_mtkaif_tx_disable(struct mt6358_priv *priv)
+{
+	/* disable aud_pad TX fifos */
+	regmap_update_bits(priv->regmap, MT6358_AFE_AUD_PAD_TOP,
+			   0xff00, 0x3000);
+	return 0;
+}
+
+int mt6358_mtkaif_calibration_enable(struct snd_soc_component *cmpnt)
+{
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	playback_gpio_set(priv);
+	capture_gpio_set(priv);
+	mt6358_mtkaif_tx_enable(priv);
+
+	mt6358_set_dcxo(priv, true);
+	mt6358_set_aud_global_bias(priv, true);
+	mt6358_set_clksq(priv, true);
+	mt6358_set_topck(priv, true);
+
+	/* set dat_miso_loopback on */
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_MASK_SFT,
+			   1 << RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_SFT);
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_MASK_SFT,
+			   1 << RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT);
+	return 0;
+}
+
+int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt)
+{
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	/* set dat_miso_loopback off */
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_MASK_SFT,
+			   0 << RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_SFT);
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_MASK_SFT,
+			   0 << RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT);
+
+	mt6358_set_topck(priv, false);
+	mt6358_set_clksq(priv, false);
+	mt6358_set_aud_global_bias(priv, false);
+	mt6358_set_dcxo(priv, false);
+
+	mt6358_mtkaif_tx_disable(priv);
+	playback_gpio_reset(priv);
+	capture_gpio_reset(priv);
+	return 0;
+}
+
+int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
+					int phase_1, int phase_2)
+{
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_PHASE_MODE_MASK_SFT,
+			   phase_1 << RG_AUD_PAD_TOP_PHASE_MODE_SFT);
+	regmap_update_bits(priv->regmap, MT6358_AUDIO_DIG_CFG,
+			   RG_AUD_PAD_TOP_PHASE_MODE2_MASK_SFT,
+			   phase_2 << RG_AUD_PAD_TOP_PHASE_MODE2_SFT);
+	return 0;
+}
+
+/* dl pga gain */
+enum {
+	DL_GAIN_8DB = 0,
+	DL_GAIN_0DB = 8,
+	DL_GAIN_N_1DB = 9,
+	DL_GAIN_N_10DB = 18,
+	DL_GAIN_N_40DB = 0x1f,
+};
+
+#define DL_GAIN_N_10DB_REG (DL_GAIN_N_10DB << 7 | DL_GAIN_N_10DB)
+#define DL_GAIN_N_40DB_REG (DL_GAIN_N_40DB << 7 | DL_GAIN_N_40DB)
+#define DL_GAIN_REG_MASK 0x0f9f
+
+static void lo_store_gain(struct mt6358_priv *priv)
+{
+	unsigned int reg;
+	unsigned int gain_l, gain_r;
+
+	regmap_read(priv->regmap, MT6358_ZCD_CON1, &reg);
+	gain_l = (reg >> RG_AUDLOLGAIN_SFT) & RG_AUDLOLGAIN_MASK;
+	gain_r = (reg >> RG_AUDLORGAIN_SFT) & RG_AUDLORGAIN_MASK;
+
+	priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL] = gain_l;
+	priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR] = gain_r;
+}
+
+static void hp_store_gain(struct mt6358_priv *priv)
+{
+	unsigned int reg;
+	unsigned int gain_l, gain_r;
+
+	regmap_read(priv->regmap, MT6358_ZCD_CON2, &reg);
+	gain_l = (reg >> RG_AUDHPLGAIN_SFT) & RG_AUDHPLGAIN_MASK;
+	gain_r = (reg >> RG_AUDHPRGAIN_SFT) & RG_AUDHPRGAIN_MASK;
+
+	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] = gain_l;
+	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] = gain_r;
+}
+
+static void hp_zcd_disable(struct mt6358_priv *priv)
+{
+	regmap_write(priv->regmap, MT6358_ZCD_CON0, 0x0000);
+}
+
+static void hp_main_output_ramp(struct mt6358_priv *priv, bool up)
+{
+	int i = 0, stage = 0;
+	int target = 7;
+
+	/* Enable/Reduce HPL/R main output stage step by step */
+	for (i = 0; i <= target; i++) {
+		stage = up ? i : target - i;
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1,
+				   0x7 << 8, stage << 8);
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1,
+				   0x7 << 11, stage << 11);
+		usleep_range(100, 150);
+	}
+}
+
+static void hp_aux_feedback_loop_gain_ramp(struct mt6358_priv *priv, bool up)
+{
+	int i = 0, stage = 0;
+
+	/* Reduce HP aux feedback loop gain step by step */
+	for (i = 0; i <= 0xf; i++) {
+		stage = up ? i : 0xf - i;
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON9,
+				   0xf << 12, stage << 12);
+		usleep_range(100, 150);
+	}
+}
+
+static void hp_pull_down(struct mt6358_priv *priv, bool enable)
+{
+	int i;
+
+	if (enable) {
+		for (i = 0x0; i <= 0x6; i++) {
+			regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+					   0x7, i);
+			usleep_range(600, 700);
+		}
+	} else {
+		for (i = 0x6; i >= 0x1; i--) {
+			regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+					   0x7, i);
+			usleep_range(600, 700);
+		}
+	}
+}
+
+static bool is_valid_hp_pga_idx(int reg_idx)
+{
+	return (reg_idx >= DL_GAIN_8DB && reg_idx <= DL_GAIN_N_10DB) ||
+	       reg_idx == DL_GAIN_N_40DB;
+}
+
+static void headset_volume_ramp(struct mt6358_priv *priv,
+				int from, int to)
+{
+	int offset = 0, count = 1, reg_idx;
+
+	if (!is_valid_hp_pga_idx(from) || !is_valid_hp_pga_idx(to))
+		dev_warn(priv->dev, "%s(), volume index is not valid, from %d, to %d\n",
+			 __func__, from, to);
+
+	dev_info(priv->dev, "%s(), from %d, to %d\n",
+		 __func__, from, to);
+
+	if (to > from)
+		offset = to - from;
+	else
+		offset = from - to;
+
+	while (offset > 0) {
+		if (to > from)
+			reg_idx = from + count;
+		else
+			reg_idx = from - count;
+
+		if (is_valid_hp_pga_idx(reg_idx)) {
+			regmap_update_bits(priv->regmap,
+					   MT6358_ZCD_CON2,
+					   DL_GAIN_REG_MASK,
+					   (reg_idx << 7) | reg_idx);
+			usleep_range(200, 300);
+		}
+		offset--;
+		count++;
+	}
+}
+
+static const DECLARE_TLV_DB_SCALE(playback_tlv, -1000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 600, 0);
+
+static const struct snd_kcontrol_new mt6358_snd_controls[] = {
+	/* dl pga gain */
+	SOC_DOUBLE_TLV("Headphone Volume",
+		       MT6358_ZCD_CON2, 0, 7, 0x12, 1,
+		       playback_tlv),
+	SOC_DOUBLE_TLV("Lineout Volume",
+		       MT6358_ZCD_CON1, 0, 7, 0x12, 1,
+		       playback_tlv),
+	SOC_SINGLE_TLV("Handset Volume",
+		       MT6358_ZCD_CON3, 0, 0x12, 1,
+		       playback_tlv),
+	/* ul pga gain */
+	SOC_DOUBLE_R_TLV("PGA Volume",
+			 MT6358_AUDENC_ANA_CON0, MT6358_AUDENC_ANA_CON1,
+			 8, 4, 0,
+			 pga_tlv),
+};
+
+/* MUX */
+/* LOL MUX */
+static const char * const lo_in_mux_map[] = {
+	"Open", "Mute", "Playback", "Test Mode"
+};
+
+static int lo_in_mux_map_value[] = {
+	0x0, 0x1, 0x2, 0x3,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(lo_in_mux_map_enum,
+				  MT6358_AUDDEC_ANA_CON7,
+				  RG_AUDLOLMUXINPUTSEL_VAUDP15_SFT,
+				  RG_AUDLOLMUXINPUTSEL_VAUDP15_MASK,
+				  lo_in_mux_map,
+				  lo_in_mux_map_value);
+
+static const struct snd_kcontrol_new lo_in_mux_control =
+	SOC_DAPM_ENUM("In Select", lo_in_mux_map_enum);
+
+/*HP MUX */
+enum {
+	HP_MUX_OPEN = 0,
+	HP_MUX_HPSPK,
+	HP_MUX_HP,
+	HP_MUX_TEST_MODE,
+	HP_MUX_HP_IMPEDANCE,
+	HP_MUX_MASK = 0x7,
+};
+
+static const char * const hp_in_mux_map[] = {
+	"Open",
+	"LoudSPK Playback",
+	"Audio Playback",
+	"Test Mode",
+	"HP Impedance",
+	"undefined1",
+	"undefined2",
+	"undefined3",
+};
+
+static int hp_in_mux_map_value[] = {
+	HP_MUX_OPEN,
+	HP_MUX_HPSPK,
+	HP_MUX_HP,
+	HP_MUX_TEST_MODE,
+	HP_MUX_HP_IMPEDANCE,
+	HP_MUX_OPEN,
+	HP_MUX_OPEN,
+	HP_MUX_OPEN,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hpl_in_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  HP_MUX_MASK,
+				  hp_in_mux_map,
+				  hp_in_mux_map_value);
+
+static const struct snd_kcontrol_new hpl_in_mux_control =
+	SOC_DAPM_ENUM("HPL Select", hpl_in_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hpr_in_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  HP_MUX_MASK,
+				  hp_in_mux_map,
+				  hp_in_mux_map_value);
+
+static const struct snd_kcontrol_new hpr_in_mux_control =
+	SOC_DAPM_ENUM("HPR Select", hpr_in_mux_map_enum);
+
+/* RCV MUX */
+enum {
+	RCV_MUX_OPEN = 0,
+	RCV_MUX_MUTE,
+	RCV_MUX_VOICE_PLAYBACK,
+	RCV_MUX_TEST_MODE,
+	RCV_MUX_MASK = 0x3,
+};
+
+static const char * const rcv_in_mux_map[] = {
+	"Open", "Mute", "Voice Playback", "Test Mode"
+};
+
+static int rcv_in_mux_map_value[] = {
+	RCV_MUX_OPEN,
+	RCV_MUX_MUTE,
+	RCV_MUX_VOICE_PLAYBACK,
+	RCV_MUX_TEST_MODE,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(rcv_in_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  RCV_MUX_MASK,
+				  rcv_in_mux_map,
+				  rcv_in_mux_map_value);
+
+static const struct snd_kcontrol_new rcv_in_mux_control =
+	SOC_DAPM_ENUM("RCV Select", rcv_in_mux_map_enum);
+
+/* DAC In MUX */
+static const char * const dac_in_mux_map[] = {
+	"Normal Path", "Sgen"
+};
+
+static int dac_in_mux_map_value[] = {
+	0x0, 0x1,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(dac_in_mux_map_enum,
+				  MT6358_AFE_TOP_CON0,
+				  DL_SINE_ON_SFT,
+				  DL_SINE_ON_MASK,
+				  dac_in_mux_map,
+				  dac_in_mux_map_value);
+
+static const struct snd_kcontrol_new dac_in_mux_control =
+	SOC_DAPM_ENUM("DAC Select", dac_in_mux_map_enum);
+
+/* AIF Out MUX */
+static SOC_VALUE_ENUM_SINGLE_DECL(aif_out_mux_map_enum,
+				  MT6358_AFE_TOP_CON0,
+				  UL_SINE_ON_SFT,
+				  UL_SINE_ON_MASK,
+				  dac_in_mux_map,
+				  dac_in_mux_map_value);
+
+static const struct snd_kcontrol_new aif_out_mux_control =
+	SOC_DAPM_ENUM("AIF Out Select", aif_out_mux_map_enum);
+
+/* Mic Type MUX */
+enum {
+	MIC_TYPE_MUX_IDLE = 0,
+	MIC_TYPE_MUX_ACC,
+	MIC_TYPE_MUX_DMIC,
+	MIC_TYPE_MUX_DCC,
+	MIC_TYPE_MUX_DCC_ECM_DIFF,
+	MIC_TYPE_MUX_DCC_ECM_SINGLE,
+	MIC_TYPE_MUX_MASK = 0x7,
+};
+
+#define IS_DCC_BASE(type) ((type) == MIC_TYPE_MUX_DCC || \
+			(type) == MIC_TYPE_MUX_DCC_ECM_DIFF || \
+			(type) == MIC_TYPE_MUX_DCC_ECM_SINGLE)
+
+static const char * const mic_type_mux_map[] = {
+	"Idle",
+	"ACC",
+	"DMIC",
+	"DCC",
+	"DCC_ECM_DIFF",
+	"DCC_ECM_SINGLE",
+};
+
+static int mic_type_mux_map_value[] = {
+	MIC_TYPE_MUX_IDLE,
+	MIC_TYPE_MUX_ACC,
+	MIC_TYPE_MUX_DMIC,
+	MIC_TYPE_MUX_DCC,
+	MIC_TYPE_MUX_DCC_ECM_DIFF,
+	MIC_TYPE_MUX_DCC_ECM_SINGLE,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(mic_type_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  MIC_TYPE_MUX_MASK,
+				  mic_type_mux_map,
+				  mic_type_mux_map_value);
+
+static const struct snd_kcontrol_new mic_type_mux_control =
+	SOC_DAPM_ENUM("Mic Type Select", mic_type_mux_map_enum);
+
+/* ADC L MUX */
+enum {
+	ADC_MUX_IDLE = 0,
+	ADC_MUX_AIN0,
+	ADC_MUX_PREAMPLIFIER,
+	ADC_MUX_IDLE1,
+	ADC_MUX_MASK = 0x3,
+};
+
+static const char * const adc_left_mux_map[] = {
+	"Idle", "AIN0", "Left Preamplifier", "Idle_1"
+};
+
+static int adc_mux_map_value[] = {
+	ADC_MUX_IDLE,
+	ADC_MUX_AIN0,
+	ADC_MUX_PREAMPLIFIER,
+	ADC_MUX_IDLE1,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(adc_left_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  ADC_MUX_MASK,
+				  adc_left_mux_map,
+				  adc_mux_map_value);
+
+static const struct snd_kcontrol_new adc_left_mux_control =
+	SOC_DAPM_ENUM("ADC L Select", adc_left_mux_map_enum);
+
+/* ADC R MUX */
+static const char * const adc_right_mux_map[] = {
+	"Idle", "AIN0", "Right Preamplifier", "Idle_1"
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(adc_right_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  ADC_MUX_MASK,
+				  adc_right_mux_map,
+				  adc_mux_map_value);
+
+static const struct snd_kcontrol_new adc_right_mux_control =
+	SOC_DAPM_ENUM("ADC R Select", adc_right_mux_map_enum);
+
+/* PGA L MUX */
+enum {
+	PGA_MUX_NONE = 0,
+	PGA_MUX_AIN0,
+	PGA_MUX_AIN1,
+	PGA_MUX_AIN2,
+	PGA_MUX_MASK = 0x3,
+};
+
+static const char * const pga_mux_map[] = {
+	"None", "AIN0", "AIN1", "AIN2"
+};
+
+static int pga_mux_map_value[] = {
+	PGA_MUX_NONE,
+	PGA_MUX_AIN0,
+	PGA_MUX_AIN1,
+	PGA_MUX_AIN2,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(pga_left_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  PGA_MUX_MASK,
+				  pga_mux_map,
+				  pga_mux_map_value);
+
+static const struct snd_kcontrol_new pga_left_mux_control =
+	SOC_DAPM_ENUM("PGA L Select", pga_left_mux_map_enum);
+
+/* PGA R MUX */
+static SOC_VALUE_ENUM_SINGLE_DECL(pga_right_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  PGA_MUX_MASK,
+				  pga_mux_map,
+				  pga_mux_map_value);
+
+static const struct snd_kcontrol_new pga_right_mux_control =
+	SOC_DAPM_ENUM("PGA R Select", pga_right_mux_map_enum);
+
+static int mt_clksq_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x\n", __func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* audio clk source from internal dcxo */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON6,
+				   RG_CLKSQ_IN_SEL_TEST_MASK_SFT,
+				   0x0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_sgen_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol,
+			 int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x\n", __func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* sdm audio fifo clock power on */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0006);
+		/* scrambler clock on enable */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON0, 0xCBA1);
+		/* sdm power on */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0003);
+		/* sdm fifo enable */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x000B);
+
+		regmap_update_bits(priv->regmap, MT6358_AFE_SGEN_CFG0,
+				   0xff3f,
+				   0x0000);
+		regmap_update_bits(priv->regmap, MT6358_AFE_SGEN_CFG1,
+				   0xffff,
+				   0x0001);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* DL scrambler disabling sequence */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0000);
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON0, 0xcba0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_aif_in_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol,
+			   int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_info(priv->dev, "%s(), event 0x%x, rate %d\n",
+		 __func__, event, priv->dl_rate);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		playback_gpio_set(priv);
+
+		/* sdm audio fifo clock power on */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0006);
+		/* scrambler clock on enable */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON0, 0xCBA1);
+		/* sdm power on */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0003);
+		/* sdm fifo enable */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x000B);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* DL scrambler disabling sequence */
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON2, 0x0000);
+		regmap_write(priv->regmap, MT6358_AFUNC_AUD_CON0, 0xcba0);
+
+		playback_gpio_reset(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_hp_enable(struct mt6358_priv *priv)
+{
+	/* Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, true);
+	/* release HP CMFB gate rstb */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+			   0x1 << 6, 0x1 << 6);
+
+	/* Reduce ESD resistance of AU_REFN */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4000);
+
+	/* save target gain to restore after hardware open complete */
+	hp_store_gain(priv);
+	/* Set HPR/HPL gain as minimum (~ -40dB) */
+	regmap_write(priv->regmap, MT6358_ZCD_CON2, DL_GAIN_N_40DB_REG);
+
+	/* Turn on DA_600K_NCP_VA18 */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON1, 0x0001);
+	/* Set NCP clock as 604kHz // 26MHz/43 = 604KHz */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON2, 0x002c);
+	/* Toggle RG_DIVCKS_CHG */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON0, 0x0001);
+	/* Set NCP soft start mode as default mode: 100us */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON4, 0x0003);
+	/* Enable NCP */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3, 0x0000);
+	usleep_range(250, 270);
+
+	/* Enable cap-less LDOs (1.5V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+			   0x1055, 0x1055);
+	/* Enable NV regulator (-1.2V) */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON15, 0x0001);
+	usleep_range(100, 120);
+
+	/* Disable AUD_ZCD */
+	hp_zcd_disable(priv);
+
+	/* Disable headphone short-circuit protection */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x3000);
+
+	/* Enable IBIST */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+
+	/* Set HP DR bias current optimization, 010: 6uA */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON11, 0x4900);
+	/* Set HP & ZCD bias current optimization */
+	/* 01: ZCD: 4uA, HP/HS/LO: 5uA */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+	/* Set HPP/N STB enhance circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4033);
+
+	/* Enable HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x000c);
+	/* Enable HP aux feedback loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x003c);
+	/* Enable HP aux CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0c00);
+	/* Enable HP driver bias circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30c0);
+	/* Enable HP driver core circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30f0);
+	/* Short HP main output to HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x00fc);
+
+	/* Enable HP main CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0e00);
+	/* Disable HP aux CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0200);
+
+	/* Select CMFB resistor bulk to AC mode */
+	/* Selec HS/LO cap size (6.5pF default) */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON10, 0x0000);
+
+	/* Enable HP main output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x00ff);
+	/* Enable HPR/L main output stage step by step */
+	hp_main_output_ramp(priv, true);
+
+	/* Reduce HP aux feedback loop gain */
+	hp_aux_feedback_loop_gain_ramp(priv, true);
+	/* Disable HP aux feedback loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fcf);
+
+	/* apply volume setting */
+	headset_volume_ramp(priv,
+			    DL_GAIN_N_10DB,
+			    priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL]);
+
+	/* Disable HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fc3);
+	/* Unshort HP main output to HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3f03);
+	usleep_range(100, 120);
+
+	/* Enable AUD_CLK */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13, 0x1, 0x1);
+	/* Enable Audio DAC  */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30ff);
+	/* Enable low-noise mode of DAC */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0xf201);
+	usleep_range(100, 120);
+
+	/* Switch HPL MUX to audio DAC */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x32ff);
+	/* Switch HPR MUX to audio DAC */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x3aff);
+
+	/* Disable Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, false);
+
+	return 0;
+}
+
+static int mtk_hp_disable(struct mt6358_priv *priv)
+{
+	/* Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, true);
+
+	/* HPR/HPL mux to open */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x0f00, 0x0000);
+
+	/* Disable low-noise mode of DAC */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON9,
+			   0x0001, 0x0000);
+
+	/* Disable Audio DAC */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x000f, 0x0000);
+
+	/* Disable AUD_CLK */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13, 0x1, 0x0);
+
+	/* Short HP main output to HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fc3);
+	/* Enable HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fcf);
+
+	/* decrease HPL/R gain to normal gain step by step */
+	headset_volume_ramp(priv,
+			    priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL],
+			    DL_GAIN_N_40DB);
+
+	/* Enable HP aux feedback loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fff);
+
+	/* Reduce HP aux feedback loop gain */
+	hp_aux_feedback_loop_gain_ramp(priv, false);
+
+	/* decrease HPR/L main output stage step by step */
+	hp_main_output_ramp(priv, false);
+
+	/* Disable HP main output stage */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3, 0x0);
+
+	/* Enable HP aux CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0e00);
+
+	/* Disable HP main CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0c00);
+
+	/* Unshort HP main output to HP aux output stage */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1,
+			   0x3 << 6, 0x0);
+
+	/* Disable HP driver core circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x3 << 4, 0x0);
+
+	/* Disable HP driver bias circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x3 << 6, 0x0);
+
+	/* Disable HP aux CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0000);
+
+	/* Disable HP aux feedback loop */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1,
+			   0x3 << 4, 0x0);
+
+	/* Disable HP aux output stage */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1,
+			   0x3 << 2, 0x0);
+
+	/* Disable IBIST */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON12,
+			   0x1 << 8, 0x1 << 8);
+
+	/* Disable NV regulator (-1.2V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON15, 0x1, 0x0);
+	/* Disable cap-less LDOs (1.5V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+			   0x1055, 0x0);
+	/* Disable NCP */
+	regmap_update_bits(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3,
+			   0x1, 0x1);
+
+	/* Increase ESD resistance of AU_REFN */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON2,
+			   0x1 << 14, 0x0);
+
+	/* Set HP CMFB gate rstb */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+			   0x1 << 6, 0x0);
+	/* disable Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, false);
+
+	return 0;
+}
+
+static int mtk_hp_spk_enable(struct mt6358_priv *priv)
+{
+	/* Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, true);
+	/* release HP CMFB gate rstb */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+			   0x1 << 6, 0x1 << 6);
+
+	/* Reduce ESD resistance of AU_REFN */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4000);
+
+	/* save target gain to restore after hardware open complete */
+	hp_store_gain(priv);
+	/* Set HPR/HPL gain to -10dB */
+	regmap_write(priv->regmap, MT6358_ZCD_CON2, DL_GAIN_N_10DB_REG);
+
+	/* Turn on DA_600K_NCP_VA18 */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON1, 0x0001);
+	/* Set NCP clock as 604kHz // 26MHz/43 = 604KHz */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON2, 0x002c);
+	/* Toggle RG_DIVCKS_CHG */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON0, 0x0001);
+	/* Set NCP soft start mode as default mode: 100us */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON4, 0x0003);
+	/* Enable NCP */
+	regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3, 0x0000);
+	usleep_range(250, 270);
+
+	/* Enable cap-less LDOs (1.5V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+			   0x1055, 0x1055);
+	/* Enable NV regulator (-1.2V) */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON15, 0x0001);
+	usleep_range(100, 120);
+
+	/* Disable AUD_ZCD */
+	hp_zcd_disable(priv);
+
+	/* Disable headphone short-circuit protection */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x3000);
+
+	/* Enable IBIST */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+
+	/* Set HP DR bias current optimization, 010: 6uA */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON11, 0x4900);
+	/* Set HP & ZCD bias current optimization */
+	/* 01: ZCD: 4uA, HP/HS/LO: 5uA */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+	/* Set HPP/N STB enhance circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4033);
+
+	/* Disable Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, false);
+
+	/* Enable HP driver bias circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30c0);
+	/* Enable HP driver core circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30f0);
+	/* Enable HP main CMFB loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0200);
+
+	/* Select CMFB resistor bulk to AC mode */
+	/* Selec HS/LO cap size (6.5pF default) */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON10, 0x0000);
+
+	/* Enable HP main output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x0003);
+	/* Enable HPR/L main output stage step by step */
+	hp_main_output_ramp(priv, true);
+
+	/* Set LO gain as minimum (~ -40dB) */
+	lo_store_gain(priv);
+	regmap_write(priv->regmap, MT6358_ZCD_CON1, DL_GAIN_N_40DB_REG);
+	/* apply volume setting */
+	headset_volume_ramp(priv,
+			    DL_GAIN_N_10DB,
+			    priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL]);
+
+	/* Set LO STB enhance circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON7, 0x0110);
+	/* Enable LO driver bias circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON7, 0x0112);
+	/* Enable LO driver core circuits */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON7, 0x0113);
+
+	/* Set LOL gain to normal gain step by step */
+	regmap_update_bits(priv->regmap, MT6358_ZCD_CON1,
+			   RG_AUDLOLGAIN_MASK_SFT,
+			   priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL] <<
+			   RG_AUDLOLGAIN_SFT);
+	regmap_update_bits(priv->regmap, MT6358_ZCD_CON1,
+			   RG_AUDLORGAIN_MASK_SFT,
+			   priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR] <<
+			   RG_AUDLORGAIN_SFT);
+
+	/* Enable AUD_CLK */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13, 0x1, 0x1);
+	/* Enable Audio DAC  */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x30f9);
+	/* Enable low-noise mode of DAC */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0201);
+	/* Switch LOL MUX to audio DAC */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON7, 0x011b);
+	/* Switch HPL/R MUX to Line-out */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x35f9);
+
+	return 0;
+}
+
+static int mtk_hp_spk_disable(struct mt6358_priv *priv)
+{
+	/* HPR/HPL mux to open */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x0f00, 0x0000);
+	/* LOL mux to open */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON7,
+			   0x3 << 2, 0x0000);
+
+	/* Disable Audio DAC */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x000f, 0x0000);
+
+	/* Disable AUD_CLK */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13, 0x1, 0x0);
+
+	/* decrease HPL/R gain to normal gain step by step */
+	headset_volume_ramp(priv,
+			    priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL],
+			    DL_GAIN_N_40DB);
+
+	/* decrease LOL gain to minimum gain step by step */
+	regmap_update_bits(priv->regmap, MT6358_ZCD_CON1,
+			   DL_GAIN_REG_MASK, DL_GAIN_N_40DB_REG);
+
+	/* decrease HPR/L main output stage step by step */
+	hp_main_output_ramp(priv, false);
+
+	/* Disable HP main output stage */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3, 0x0);
+
+	/* Short HP main output to HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fc3);
+	/* Enable HP aux output stage */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fcf);
+
+	/* Enable HP aux feedback loop */
+	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON1, 0x3fff);
+
+	/* Reduce HP aux feedback loop gain */
+	hp_aux_feedback_loop_gain_ramp(priv, false);
+
+	/* Disable HP driver core circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x3 << 4, 0x0);
+	/* Disable LO driver core circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON7,
+			   0x1, 0x0);
+
+	/* Disable HP driver bias circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   0x3 << 6, 0x0);
+	/* Disable LO driver bias circuits */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON7,
+			   0x1 << 1, 0x0);
+
+	/* Disable HP aux CMFB loop */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON9,
+			   0xff << 8, 0x0000);
+
+	/* Disable IBIST */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON12,
+			   0x1 << 8, 0x1 << 8);
+	/* Disable NV regulator (-1.2V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON15, 0x1, 0x0);
+	/* Disable cap-less LDOs (1.5V) */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14, 0x1055, 0x0);
+	/* Disable NCP */
+	regmap_update_bits(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3, 0x1, 0x1);
+
+	/* Set HP CMFB gate rstb */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON4,
+			   0x1 << 6, 0x0);
+	/* disable Pull-down HPL/R to AVSS28_AUD */
+	hp_pull_down(priv, false);
+
+	return 0;
+}
+
+static int mt_hp_event(struct snd_soc_dapm_widget *w,
+		       struct snd_kcontrol *kcontrol,
+		       int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+	int device = DEVICE_HP;
+
+	dev_info(priv->dev, "%s(), event 0x%x, dev_counter[DEV_HP] %d, mux %u\n",
+		 __func__,
+		 event,
+		 priv->dev_counter[device],
+		 mux);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		priv->dev_counter[device]++;
+		if (priv->dev_counter[device] > 1)
+			break;	/* already enabled, do nothing */
+		else if (priv->dev_counter[device] <= 0)
+			dev_warn(priv->dev, "%s(), dev_counter[DEV_HP] %d <= 0\n",
+				 __func__,
+				 priv->dev_counter[device]);
+
+		priv->mux_select[MUX_HP_L] = mux;
+
+		if (mux == HP_MUX_HP)
+			mtk_hp_enable(priv);
+		else if (mux == HP_MUX_HPSPK)
+			mtk_hp_spk_enable(priv);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		priv->dev_counter[device]--;
+		if (priv->dev_counter[device] > 0) {
+			break;	/* still being used, don't close */
+		} else if (priv->dev_counter[device] < 0) {
+			dev_warn(priv->dev, "%s(), dev_counter[DEV_HP] %d < 0\n",
+				 __func__,
+				 priv->dev_counter[device]);
+			priv->dev_counter[device] = 0;
+			break;
+		}
+
+		if (priv->mux_select[MUX_HP_L] == HP_MUX_HP)
+			mtk_hp_disable(priv);
+		else if (priv->mux_select[MUX_HP_L] == HP_MUX_HPSPK)
+			mtk_hp_spk_disable(priv);
+
+		priv->mux_select[MUX_HP_L] = mux;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_rcv_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol,
+			int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_info(priv->dev, "%s(), event 0x%x, mux %u\n",
+		 __func__,
+		 event,
+		 dapm_kcontrol_get_value(w->kcontrols[0]));
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Reduce ESD resistance of AU_REFN */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4000);
+
+		/* Turn on DA_600K_NCP_VA18 */
+		regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON1, 0x0001);
+		/* Set NCP clock as 604kHz // 26MHz/43 = 604KHz */
+		regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON2, 0x002c);
+		/* Toggle RG_DIVCKS_CHG */
+		regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON0, 0x0001);
+		/* Set NCP soft start mode as default mode: 100us */
+		regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON4, 0x0003);
+		/* Enable NCP */
+		regmap_write(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3, 0x0000);
+		usleep_range(250, 270);
+
+		/* Enable cap-less LDOs (1.5V) */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x1055, 0x1055);
+		/* Enable NV regulator (-1.2V) */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON15, 0x0001);
+		usleep_range(100, 120);
+
+		/* Disable AUD_ZCD */
+		hp_zcd_disable(priv);
+
+		/* Disable handset short-circuit protection */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON6, 0x0010);
+
+		/* Enable IBIST */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+		/* Set HP DR bias current optimization, 010: 6uA */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON11, 0x4900);
+		/* Set HP & ZCD bias current optimization */
+		/* 01: ZCD: 4uA, HP/HS/LO: 5uA */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON12, 0x0055);
+		/* Set HS STB enhance circuits */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON6, 0x0090);
+
+		/* Disable HP main CMFB loop */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0000);
+		/* Select CMFB resistor bulk to AC mode */
+		/* Selec HS/LO cap size (6.5pF default) */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON10, 0x0000);
+
+		/* Enable HS driver bias circuits */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON6, 0x0092);
+		/* Enable HS driver core circuits */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON6, 0x0093);
+
+		/* Enable AUD_CLK */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13,
+				   0x1, 0x1);
+
+		/* Enable Audio DAC  */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON0, 0x0009);
+		/* Enable low-noise mode of DAC */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON9, 0x0001);
+		/* Switch HS MUX to audio DAC */
+		regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON6, 0x009b);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		/* HS mux to open */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON6,
+				   RG_AUDHSMUXINPUTSEL_VAUDP15_MASK_SFT,
+				   RCV_MUX_OPEN);
+
+		/* Disable Audio DAC */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+				   0x000f, 0x0000);
+
+		/* Disable AUD_CLK */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13,
+				   0x1, 0x0);
+
+		/* decrease HS gain to minimum gain step by step */
+		regmap_write(priv->regmap, MT6358_ZCD_CON3, DL_GAIN_N_40DB);
+
+		/* Disable HS driver core circuits */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON6,
+				   0x1, 0x0);
+
+		/* Disable HS driver bias circuits */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON6,
+				   0x1 << 1, 0x0000);
+
+		/* Disable HP aux CMFB loop */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON9,
+				   0xff << 8, 0x0);
+
+		/* Enable HP main CMFB Switch */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON9,
+				   0xff << 8, 0x2 << 8);
+
+		/* Disable IBIST */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON12,
+				   0x1 << 8, 0x1 << 8);
+
+		/* Disable NV regulator (-1.2V) */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON15,
+				   0x1, 0x0);
+		/* Disable cap-less LDOs (1.5V) */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x1055, 0x0);
+		/* Disable NCP */
+		regmap_update_bits(priv->regmap, MT6358_AUDNCP_CLKDIV_CON3,
+				   0x1, 0x1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_aif_out_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol,
+			    int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(priv->dev, "%s(), event 0x%x, rate %d\n",
+		__func__, event, priv->ul_rate);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		capture_gpio_set(priv);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		capture_gpio_reset(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_adc_supply_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol,
+			       int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(priv->dev, "%s(), event 0x%x\n",
+		__func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable audio ADC CLKGEN  */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13,
+				   0x1 << 5, 0x1 << 5);
+		/* ADC CLK from CLKGEN (13MHz) */
+		regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON3,
+			     0x0000);
+		/* Enable  LCLDO_ENC 1P8V */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x2500, 0x0100);
+		/* LCLDO_ENC remote sense */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x2500, 0x2500);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* LCLDO_ENC remote sense off */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x2500, 0x0100);
+		/* disable LCLDO_ENC 1P8V */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON14,
+				   0x2500, 0x0000);
+
+		/* ADC CLK from CLKGEN (13MHz) */
+		regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON3, 0x0000);
+		/* disable audio ADC CLKGEN  */
+		regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON13,
+				   0x1 << 5, 0x0 << 5);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt6358_amic_enable(struct mt6358_priv *priv)
+{
+	unsigned int mic_type = priv->mux_select[MUX_MIC_TYPE];
+	unsigned int mux_pga_l = priv->mux_select[MUX_PGA_L];
+	unsigned int mux_pga_r = priv->mux_select[MUX_PGA_R];
+
+	dev_info(priv->dev, "%s(), mux, mic %u, pga l %u, pga r %u\n",
+		 __func__, mic_type, mux_pga_l, mux_pga_r);
+
+	if (IS_DCC_BASE(mic_type)) {
+		/* DCC 50k CLK (from 26M) */
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2062);
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2062);
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2060);
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2061);
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG1, 0x0100);
+	}
+
+	/* mic bias 0 */
+	if (mux_pga_l == PGA_MUX_AIN0 || mux_pga_l == PGA_MUX_AIN2 ||
+	    mux_pga_r == PGA_MUX_AIN0 || mux_pga_r == PGA_MUX_AIN2) {
+		switch (mic_type) {
+		case MIC_TYPE_MUX_DCC_ECM_DIFF:
+			regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON9,
+					   0xff00, 0x7700);
+			break;
+		case MIC_TYPE_MUX_DCC_ECM_SINGLE:
+			regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON9,
+					   0xff00, 0x1100);
+			break;
+		default:
+			regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON9,
+					   0xff00, 0x0000);
+			break;
+		}
+		/* Enable MICBIAS0, MISBIAS0 = 1P9V */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON9,
+				   0xff, 0x21);
+	}
+
+	/* mic bias 1 */
+	if (mux_pga_l == PGA_MUX_AIN1 || mux_pga_r == PGA_MUX_AIN1) {
+		/* Enable MICBIAS1, MISBIAS1 = 2P6V */
+		if (mic_type == MIC_TYPE_MUX_DCC_ECM_SINGLE)
+			regmap_write(priv->regmap,
+				     MT6358_AUDENC_ANA_CON10, 0x0161);
+		else
+			regmap_write(priv->regmap,
+				     MT6358_AUDENC_ANA_CON10, 0x0061);
+	}
+
+	if (IS_DCC_BASE(mic_type)) {
+		/* Audio L/R preamplifier DCC precharge */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   0xf8ff, 0x0004);
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   0xf8ff, 0x0004);
+	} else {
+		/* reset reg */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   0xf8ff, 0x0000);
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   0xf8ff, 0x0000);
+	}
+
+	if (mux_pga_l != PGA_MUX_NONE) {
+		/* L preamplifier input sel */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   RG_AUDPREAMPLINPUTSEL_MASK_SFT,
+				   mux_pga_l << RG_AUDPREAMPLINPUTSEL_SFT);
+
+		/* L preamplifier enable */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   RG_AUDPREAMPLON_MASK_SFT,
+				   0x1 << RG_AUDPREAMPLON_SFT);
+
+		if (IS_DCC_BASE(mic_type)) {
+			/* L preamplifier DCCEN */
+			regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+					   RG_AUDPREAMPLDCCEN_MASK_SFT,
+					   0x1 << RG_AUDPREAMPLDCCEN_SFT);
+		}
+
+		/* L ADC input sel : L PGA. Enable audio L ADC */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   RG_AUDADCLINPUTSEL_MASK_SFT,
+				   ADC_MUX_PREAMPLIFIER <<
+				   RG_AUDADCLINPUTSEL_SFT);
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   RG_AUDADCLPWRUP_MASK_SFT,
+				   0x1 << RG_AUDADCLPWRUP_SFT);
+	}
+
+	if (mux_pga_r != PGA_MUX_NONE) {
+		/* R preamplifier input sel */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   RG_AUDPREAMPRINPUTSEL_MASK_SFT,
+				   mux_pga_r << RG_AUDPREAMPRINPUTSEL_SFT);
+
+		/* R preamplifier enable */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   RG_AUDPREAMPRON_MASK_SFT,
+				   0x1 << RG_AUDPREAMPRON_SFT);
+
+		if (IS_DCC_BASE(mic_type)) {
+			/* R preamplifier DCCEN */
+			regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+					   RG_AUDPREAMPRDCCEN_MASK_SFT,
+					   0x1 << RG_AUDPREAMPRDCCEN_SFT);
+		}
+
+		/* R ADC input sel : R PGA. Enable audio R ADC */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   RG_AUDADCRINPUTSEL_MASK_SFT,
+				   ADC_MUX_PREAMPLIFIER <<
+				   RG_AUDADCRINPUTSEL_SFT);
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   RG_AUDADCRPWRUP_MASK_SFT,
+				   0x1 << RG_AUDADCRPWRUP_SFT);
+	}
+
+	if (IS_DCC_BASE(mic_type)) {
+		usleep_range(100, 150);
+		/* Audio L preamplifier DCC precharge off */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+				   RG_AUDPREAMPLDCPRECHARGE_MASK_SFT, 0x0);
+		/* Audio R preamplifier DCC precharge off */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+				   RG_AUDPREAMPRDCPRECHARGE_MASK_SFT, 0x0);
+
+		/* Short body to ground in PGA */
+		regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON3,
+				   0x1 << 12, 0x0);
+	}
+
+	/* here to set digital part */
+	mt6358_mtkaif_tx_enable(priv);
+
+	/* UL dmic setting off */
+	regmap_write(priv->regmap, MT6358_AFE_UL_SRC_CON0_H, 0x0000);
+
+	/* UL turn on */
+	regmap_write(priv->regmap, MT6358_AFE_UL_SRC_CON0_L, 0x0001);
+
+	return 0;
+}
+
+static void mt6358_amic_disable(struct mt6358_priv *priv)
+{
+	unsigned int mic_type = priv->mux_select[MUX_MIC_TYPE];
+	unsigned int mux_pga_l = priv->mux_select[MUX_PGA_L];
+	unsigned int mux_pga_r = priv->mux_select[MUX_PGA_R];
+
+	dev_info(priv->dev, "%s(), mux, mic %u, pga l %u, pga r %u\n",
+		 __func__, mic_type, mux_pga_l, mux_pga_r);
+
+	/* UL turn off */
+	regmap_update_bits(priv->regmap, MT6358_AFE_UL_SRC_CON0_L,
+			   0x0001, 0x0000);
+
+	/* disable aud_pad TX fifos */
+	mt6358_mtkaif_tx_disable(priv);
+
+	/* L ADC input sel : off, disable L ADC */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+			   0xf000, 0x0000);
+	/* L preamplifier DCCEN */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+			   0x1 << 1, 0x0);
+	/* L preamplifier input sel : off, L PGA 0 dB gain */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+			   0xfffb, 0x0000);
+
+	/* disable L preamplifier DCC precharge */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON0,
+			   0x1 << 2, 0x0);
+
+	/* R ADC input sel : off, disable R ADC */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+			   0xf000, 0x0000);
+	/* R preamplifier DCCEN */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+			   0x1 << 1, 0x0);
+	/* R preamplifier input sel : off, R PGA 0 dB gain */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+			   0x0ffb, 0x0000);
+
+	/* disable R preamplifier DCC precharge */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON1,
+			   0x1 << 2, 0x0);
+
+	/* mic bias */
+	/* Disable MICBIAS0, MISBIAS0 = 1P7V */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON9, 0x0000);
+
+	/* Disable MICBIAS1 */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON10,
+			   0x0001, 0x0000);
+
+	if (IS_DCC_BASE(mic_type)) {
+		/* dcclk_gen_on=1'b0 */
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2060);
+		/* dcclk_pdn=1'b1 */
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2062);
+		/* dcclk_ref_ck_sel=2'b00 */
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2062);
+		/* dcclk_div=11'b00100000011 */
+		regmap_write(priv->regmap, MT6358_AFE_DCCLK_CFG0, 0x2062);
+	}
+}
+
+static int mt6358_dmic_enable(struct mt6358_priv *priv)
+{
+	dev_info(priv->dev, "%s()\n", __func__);
+
+	/* mic bias */
+	/* Enable MICBIAS0, MISBIAS0 = 1P9V */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON9, 0x0021);
+
+	/* RG_BANDGAPGEN=1'b0 */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON10,
+			   0x1 << 12, 0x0);
+
+	/* DMIC enable */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON8, 0x0005);
+
+	/* here to set digital part */
+	mt6358_mtkaif_tx_enable(priv);
+
+	/* UL dmic setting */
+	regmap_write(priv->regmap, MT6358_AFE_UL_SRC_CON0_H, 0x0080);
+
+	/* UL turn on */
+	regmap_write(priv->regmap, MT6358_AFE_UL_SRC_CON0_L, 0x0003);
+	return 0;
+}
+
+static void mt6358_dmic_disable(struct mt6358_priv *priv)
+{
+	dev_info(priv->dev, "%s()\n", __func__);
+
+	/* UL turn off */
+	regmap_update_bits(priv->regmap, MT6358_AFE_UL_SRC_CON0_L,
+			   0x0003, 0x0000);
+
+	/* disable aud_pad TX fifos */
+	mt6358_mtkaif_tx_disable(priv);
+
+	/* DMIC disable */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON8, 0x0000);
+
+	/* mic bias */
+	/* MISBIAS0 = 1P7V */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON9, 0x0001);
+
+	/* RG_BANDGAPGEN=1'b0 */
+	regmap_update_bits(priv->regmap, MT6358_AUDENC_ANA_CON10,
+			   0x1 << 12, 0x0);
+
+	/* MICBIA0 disable */
+	regmap_write(priv->regmap, MT6358_AUDENC_ANA_CON9, 0x0000);
+}
+
+static int mt_mic_type_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+
+	dev_dbg(priv->dev, "%s(), event 0x%x, mux %u\n",
+		__func__, event, mux);
+
+	switch (event) {
+	case SND_SOC_DAPM_WILL_PMU:
+		priv->mux_select[MUX_MIC_TYPE] = mux;
+		break;
+	case SND_SOC_DAPM_PRE_PMU:
+		switch (mux) {
+		case MIC_TYPE_MUX_DMIC:
+			mt6358_dmic_enable(priv);
+			break;
+		default:
+			mt6358_amic_enable(priv);
+			break;
+		}
+
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		switch (priv->mux_select[MUX_MIC_TYPE]) {
+		case MIC_TYPE_MUX_DMIC:
+			mt6358_dmic_disable(priv);
+			break;
+		default:
+			mt6358_amic_disable(priv);
+			break;
+		}
+
+		priv->mux_select[MUX_MIC_TYPE] = mux;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_adc_l_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x, mux %u\n",
+		__func__, event, mux);
+
+	priv->mux_select[MUX_ADC_L] = mux;
+
+	return 0;
+}
+
+static int mt_adc_r_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x, mux %u\n",
+		__func__, event, mux);
+
+	priv->mux_select[MUX_ADC_R] = mux;
+
+	return 0;
+}
+
+static int mt_pga_left_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x, mux %u\n",
+		__func__, event, mux);
+
+	priv->mux_select[MUX_PGA_L] = mux;
+
+	return 0;
+}
+
+static int mt_pga_right_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol,
+			      int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int mux = dapm_kcontrol_get_value(w->kcontrols[0]);
+
+	dev_dbg(priv->dev, "%s(), event = 0x%x, mux %u\n",
+		__func__, event, mux);
+
+	priv->mux_select[MUX_PGA_R] = mux;
+
+	return 0;
+}
+
+static int mt_delay_250_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol,
+			      int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(250, 270);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		usleep_range(250, 270);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* DAPM Widgets */
+static const struct snd_soc_dapm_widget mt6358_dapm_widgets[] = {
+	/* Global Supply*/
+	SND_SOC_DAPM_SUPPLY_S("CLK_BUF", SUPPLY_SEQ_CLK_BUF,
+			      MT6358_DCXO_CW14,
+			      RG_XO_AUDIO_EN_M_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDGLB", SUPPLY_SEQ_AUD_GLB,
+			      MT6358_AUDDEC_ANA_CON13,
+			      RG_AUDGLB_PWRDN_VA28_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("CLKSQ Audio", SUPPLY_SEQ_CLKSQ,
+			      MT6358_AUDENC_ANA_CON6,
+			      RG_CLKSQ_EN_SFT, 0,
+			      mt_clksq_event,
+			      SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY_S("AUDNCP_CK", SUPPLY_SEQ_TOP_CK,
+			      MT6358_AUD_TOP_CKPDN_CON0,
+			      RG_AUDNCP_CK_PDN_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ZCD13M_CK", SUPPLY_SEQ_TOP_CK,
+			      MT6358_AUD_TOP_CKPDN_CON0,
+			      RG_ZCD13M_CK_PDN_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUD_CK", SUPPLY_SEQ_TOP_CK_LAST,
+			      MT6358_AUD_TOP_CKPDN_CON0,
+			      RG_AUD_CK_PDN_SFT, 1,
+			      mt_delay_250_event,
+			      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY_S("AUDIF_CK", SUPPLY_SEQ_TOP_CK,
+			      MT6358_AUD_TOP_CKPDN_CON0,
+			      RG_AUDIF_CK_PDN_SFT, 1, NULL, 0),
+
+	/* Digital Clock */
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_AFE_CTL", SUPPLY_SEQ_AUD_TOP_LAST,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_AFE_CTL_SFT, 1,
+			      mt_delay_250_event,
+			      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_DAC_CTL", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_DAC_CTL_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_ADC_CTL", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_ADC_CTL_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_I2S_DL", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_I2S_DL_CTL_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_PWR_CLK", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PWR_CLK_DIS_CTL_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_PDN_AFE_TESTMODEL", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_AFE_TESTMODEL_CTL_SFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AUDIO_TOP_PDN_RESERVED", SUPPLY_SEQ_AUD_TOP,
+			      MT6358_AUDIO_TOP_CON0,
+			      PDN_RESERVED_SFT, 1, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DL Digital Clock", SND_SOC_NOPM,
+			    0, 0, NULL, 0),
+
+	/* AFE ON */
+	SND_SOC_DAPM_SUPPLY_S("AFE_ON", SUPPLY_SEQ_AFE,
+			      MT6358_AFE_UL_DL_CON0, AFE_ON_SFT, 0,
+			      NULL, 0),
+
+	/* AIF Rx*/
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "AIF1 Playback", 0,
+			      MT6358_AFE_DL_SRC2_CON0_L,
+			      DL_2_SRC_ON_TMP_CTL_PRE_SFT, 0,
+			      mt_aif_in_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* DL Supply */
+	SND_SOC_DAPM_SUPPLY("DL Power Supply", SND_SOC_NOPM,
+			    0, 0, NULL, 0),
+
+	/* DAC */
+	SND_SOC_DAPM_MUX("DAC In Mux", SND_SOC_NOPM, 0, 0, &dac_in_mux_control),
+
+	SND_SOC_DAPM_DAC("DACL", NULL, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_DAC("DACR", NULL, SND_SOC_NOPM, 0, 0),
+
+	/* LOL */
+	SND_SOC_DAPM_MUX("LOL Mux", SND_SOC_NOPM, 0, 0, &lo_in_mux_control),
+
+	SND_SOC_DAPM_SUPPLY("LO Stability Enh", MT6358_AUDDEC_ANA_CON7,
+			    RG_LOOUTPUTSTBENH_VAUDP15_SFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUT_DRV("LOL Buffer", MT6358_AUDDEC_ANA_CON7,
+			     RG_AUDLOLPWRUP_VAUDP15_SFT, 0, NULL, 0),
+
+	/* Headphone */
+	SND_SOC_DAPM_MUX_E("HPL Mux", SND_SOC_NOPM, 0, 0,
+			   &hpl_in_mux_control,
+			   mt_hp_event,
+			   SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_MUX_E("HPR Mux", SND_SOC_NOPM, 0, 0,
+			   &hpr_in_mux_control,
+			   mt_hp_event,
+			   SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_PRE_PMD),
+
+	/* Receiver */
+	SND_SOC_DAPM_MUX_E("RCV Mux", SND_SOC_NOPM, 0, 0,
+			   &rcv_in_mux_control,
+			   mt_rcv_event,
+			   SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_PRE_PMD),
+
+	/* Outputs */
+	SND_SOC_DAPM_OUTPUT("Receiver"),
+	SND_SOC_DAPM_OUTPUT("Headphone L"),
+	SND_SOC_DAPM_OUTPUT("Headphone R"),
+	SND_SOC_DAPM_OUTPUT("Headphone L Ext Spk Amp"),
+	SND_SOC_DAPM_OUTPUT("Headphone R Ext Spk Amp"),
+	SND_SOC_DAPM_OUTPUT("LINEOUT L"),
+	SND_SOC_DAPM_OUTPUT("LINEOUT L HSSPK"),
+
+	/* SGEN */
+	SND_SOC_DAPM_SUPPLY("SGEN DL Enable", MT6358_AFE_SGEN_CFG0,
+			    SGEN_DAC_EN_CTL_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("SGEN MUTE", MT6358_AFE_SGEN_CFG0,
+			    SGEN_MUTE_SW_CTL_SFT, 1,
+			    mt_sgen_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("SGEN DL SRC", MT6358_AFE_DL_SRC2_CON0_L,
+			    DL_2_SRC_ON_TMP_CTL_PRE_SFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("SGEN DL"),
+
+	/* Uplinks */
+	SND_SOC_DAPM_AIF_OUT_E("AIF1TX", "AIF1 Capture", 0,
+			       SND_SOC_NOPM, 0, 0,
+			       mt_aif_out_event,
+			       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("ADC Supply", SUPPLY_SEQ_ADC_SUPPLY,
+			      SND_SOC_NOPM, 0, 0,
+			      mt_adc_supply_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* Uplinks MUX */
+	SND_SOC_DAPM_MUX("AIF Out Mux", SND_SOC_NOPM, 0, 0,
+			 &aif_out_mux_control),
+
+	SND_SOC_DAPM_MUX_E("Mic Type Mux", SND_SOC_NOPM, 0, 0,
+			   &mic_type_mux_control,
+			   mt_mic_type_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD |
+			   SND_SOC_DAPM_WILL_PMU),
+
+	SND_SOC_DAPM_MUX_E("ADC L Mux", SND_SOC_NOPM, 0, 0,
+			   &adc_left_mux_control,
+			   mt_adc_l_event,
+			   SND_SOC_DAPM_WILL_PMU),
+	SND_SOC_DAPM_MUX_E("ADC R Mux", SND_SOC_NOPM, 0, 0,
+			   &adc_right_mux_control,
+			   mt_adc_r_event,
+			   SND_SOC_DAPM_WILL_PMU),
+
+	SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_MUX_E("PGA L Mux", SND_SOC_NOPM, 0, 0,
+			   &pga_left_mux_control,
+			   mt_pga_left_event,
+			   SND_SOC_DAPM_WILL_PMU),
+	SND_SOC_DAPM_MUX_E("PGA R Mux", SND_SOC_NOPM, 0, 0,
+			   &pga_right_mux_control,
+			   mt_pga_right_event,
+			   SND_SOC_DAPM_WILL_PMU),
+
+	SND_SOC_DAPM_PGA("PGA L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA R", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* UL input */
+	SND_SOC_DAPM_INPUT("AIN0"),
+	SND_SOC_DAPM_INPUT("AIN1"),
+	SND_SOC_DAPM_INPUT("AIN2"),
+};
+
+static const struct snd_soc_dapm_route mt6358_dapm_routes[] = {
+	/* Capture */
+	{"AIF1TX", NULL, "AIF Out Mux"},
+	{"AIF1TX", NULL, "CLK_BUF"},
+	{"AIF1TX", NULL, "AUDGLB"},
+	{"AIF1TX", NULL, "CLKSQ Audio"},
+
+	{"AIF1TX", NULL, "AUD_CK"},
+	{"AIF1TX", NULL, "AUDIF_CK"},
+
+	{"AIF1TX", NULL, "AUDIO_TOP_AFE_CTL"},
+	{"AIF1TX", NULL, "AUDIO_TOP_ADC_CTL"},
+	{"AIF1TX", NULL, "AUDIO_TOP_PWR_CLK"},
+	{"AIF1TX", NULL, "AUDIO_TOP_PDN_RESERVED"},
+	{"AIF1TX", NULL, "AUDIO_TOP_I2S_DL"},
+
+	{"AIF1TX", NULL, "AFE_ON"},
+
+	{"AIF Out Mux", NULL, "Mic Type Mux"},
+
+	{"Mic Type Mux", "ACC", "ADC L"},
+	{"Mic Type Mux", "ACC", "ADC R"},
+	{"Mic Type Mux", "DCC", "ADC L"},
+	{"Mic Type Mux", "DCC", "ADC R"},
+	{"Mic Type Mux", "DCC_ECM_DIFF", "ADC L"},
+	{"Mic Type Mux", "DCC_ECM_DIFF", "ADC R"},
+	{"Mic Type Mux", "DCC_ECM_SINGLE", "ADC L"},
+	{"Mic Type Mux", "DCC_ECM_SINGLE", "ADC R"},
+	{"Mic Type Mux", "DMIC", "AIN0"},
+	{"Mic Type Mux", "DMIC", "AIN2"},
+
+	{"ADC L", NULL, "ADC L Mux"},
+	{"ADC L", NULL, "ADC Supply"},
+	{"ADC R", NULL, "ADC R Mux"},
+	{"ADC R", NULL, "ADC Supply"},
+
+	{"ADC L Mux", "Left Preamplifier", "PGA L"},
+
+	{"ADC R Mux", "Right Preamplifier", "PGA R"},
+
+	{"PGA L", NULL, "PGA L Mux"},
+	{"PGA R", NULL, "PGA R Mux"},
+
+	{"PGA L Mux", "AIN0", "AIN0"},
+	{"PGA L Mux", "AIN1", "AIN1"},
+	{"PGA L Mux", "AIN2", "AIN2"},
+
+	{"PGA R Mux", "AIN0", "AIN0"},
+	{"PGA R Mux", "AIN1", "AIN1"},
+	{"PGA R Mux", "AIN2", "AIN2"},
+
+	/* DL Supply */
+	{"DL Power Supply", NULL, "CLK_BUF"},
+	{"DL Power Supply", NULL, "AUDGLB"},
+	{"DL Power Supply", NULL, "CLKSQ Audio"},
+
+	{"DL Power Supply", NULL, "AUDNCP_CK"},
+	{"DL Power Supply", NULL, "ZCD13M_CK"},
+	{"DL Power Supply", NULL, "AUD_CK"},
+	{"DL Power Supply", NULL, "AUDIF_CK"},
+
+	/* DL Digital Supply */
+	{"DL Digital Clock", NULL, "AUDIO_TOP_AFE_CTL"},
+	{"DL Digital Clock", NULL, "AUDIO_TOP_DAC_CTL"},
+	{"DL Digital Clock", NULL, "AUDIO_TOP_PWR_CLK"},
+
+	{"DL Digital Clock", NULL, "AFE_ON"},
+
+	{"AIF_RX", NULL, "DL Digital Clock"},
+
+	/* DL Path */
+	{"DAC In Mux", "Normal Path", "AIF_RX"},
+
+	{"DAC In Mux", "Sgen", "SGEN DL"},
+	{"SGEN DL", NULL, "SGEN DL SRC"},
+	{"SGEN DL", NULL, "SGEN MUTE"},
+	{"SGEN DL", NULL, "SGEN DL Enable"},
+	{"SGEN DL", NULL, "DL Digital Clock"},
+	{"SGEN DL", NULL, "AUDIO_TOP_PDN_AFE_TESTMODEL"},
+
+	{"DACL", NULL, "DAC In Mux"},
+	{"DACL", NULL, "DL Power Supply"},
+
+	{"DACR", NULL, "DAC In Mux"},
+	{"DACR", NULL, "DL Power Supply"},
+
+	/* Lineout Path */
+	{"LOL Mux", "Playback", "DACL"},
+
+	{"LOL Buffer", NULL, "LOL Mux"},
+	{"LOL Buffer", NULL, "LO Stability Enh"},
+
+	{"LINEOUT L", NULL, "LOL Buffer"},
+
+	/* Headphone Path */
+	{"HPL Mux", "Audio Playback", "DACL"},
+	{"HPR Mux", "Audio Playback", "DACR"},
+	{"HPL Mux", "HP Impedance", "DACL"},
+	{"HPR Mux", "HP Impedance", "DACR"},
+	{"HPL Mux", "LoudSPK Playback", "DACL"},
+	{"HPR Mux", "LoudSPK Playback", "DACR"},
+
+	{"Headphone L", NULL, "HPL Mux"},
+	{"Headphone R", NULL, "HPR Mux"},
+	{"Headphone L Ext Spk Amp", NULL, "HPL Mux"},
+	{"Headphone R Ext Spk Amp", NULL, "HPR Mux"},
+	{"LINEOUT L HSSPK", NULL, "HPL Mux"},
+
+	/* Receiver Path */
+	{"RCV Mux", "Voice Playback", "DACL"},
+	{"Receiver", NULL, "RCV Mux"},
+};
+
+static int mt6358_codec_dai_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *cmpnt = dai->component;
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int rate = params_rate(params);
+
+	dev_info(priv->dev, "%s(), substream->stream %d, rate %d, number %d\n",
+		 __func__,
+		 substream->stream,
+		 rate,
+		 substream->number);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		priv->dl_rate = rate;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		priv->ul_rate = rate;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mt6358_codec_dai_ops = {
+	.hw_params = mt6358_codec_dai_hw_params,
+};
+
+#define MT6358_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |\
+			SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |\
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |\
+			SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE |\
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |\
+			SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE)
+
+static struct snd_soc_dai_driver mt6358_dai_driver[] = {
+	{
+		.name = "mt6358-snd-codec-aif1",
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000 |
+				 SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = MT6358_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_32000 |
+				 SNDRV_PCM_RATE_48000,
+			.formats = MT6358_FORMATS,
+		},
+		.ops = &mt6358_codec_dai_ops,
+	},
+};
+
+static int mt6358_codec_init_reg(struct mt6358_priv *priv)
+{
+	int ret = 0;
+
+	/* Disable HeadphoneL/HeadphoneR short circuit protection */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   RG_AUDHPLSCDISABLE_VAUDP15_MASK_SFT,
+			   0x1 << RG_AUDHPLSCDISABLE_VAUDP15_SFT);
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
+			   RG_AUDHPRSCDISABLE_VAUDP15_MASK_SFT,
+			   0x1 << RG_AUDHPRSCDISABLE_VAUDP15_SFT);
+	/* Disable voice short circuit protection */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON6,
+			   RG_AUDHSSCDISABLE_VAUDP15_MASK_SFT,
+			   0x1 << RG_AUDHSSCDISABLE_VAUDP15_SFT);
+	/* disable LO buffer left short circuit protection */
+	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON7,
+			   RG_AUDLOLSCDISABLE_VAUDP15_MASK_SFT,
+			   0x1 << RG_AUDLOLSCDISABLE_VAUDP15_SFT);
+
+	/* accdet s/w enable */
+	regmap_update_bits(priv->regmap, MT6358_ACCDET_CON13,
+			   0xFFFF, 0x700E);
+
+	/* gpio miso driving set to 4mA */
+	regmap_write(priv->regmap, MT6358_DRV_CON3, 0x8888);
+
+	/* set gpio */
+	playback_gpio_reset(priv);
+	capture_gpio_reset(priv);
+
+	return ret;
+}
+
+static int mt6358_codec_probe(struct snd_soc_component *cmpnt)
+{
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	int ret;
+
+	snd_soc_component_init_regmap(cmpnt, priv->regmap);
+
+	mt6358_codec_init_reg(priv);
+
+	priv->avdd_reg = devm_regulator_get(priv->dev, "Avdd");
+	if (IS_ERR(priv->avdd_reg)) {
+		dev_err(priv->dev, "%s() have no Avdd supply", __func__);
+		return PTR_ERR(priv->avdd_reg);
+	}
+
+	ret = regulator_enable(priv->avdd_reg);
+	if (ret)
+		return  ret;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver mt6358_soc_component_driver = {
+	.probe = mt6358_codec_probe,
+	.controls = mt6358_snd_controls,
+	.num_controls = ARRAY_SIZE(mt6358_snd_controls),
+	.dapm_widgets = mt6358_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt6358_dapm_widgets),
+	.dapm_routes = mt6358_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt6358_dapm_routes),
+};
+
+static int mt6358_platform_driver_probe(struct platform_device *pdev)
+{
+	struct mt6358_priv *priv;
+	struct mt6397_chip *mt6397 = dev_get_drvdata(pdev->dev.parent);
+
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(struct mt6358_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = mt6397->regmap;
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	dev_info(priv->dev, "%s(), dev name %s\n",
+		 __func__, dev_name(&pdev->dev));
+
+	return devm_snd_soc_register_component(&pdev->dev,
+				      &mt6358_soc_component_driver,
+				      mt6358_dai_driver,
+				      ARRAY_SIZE(mt6358_dai_driver));
+}
+
+static const struct of_device_id mt6358_of_match[] = {
+	{.compatible = "mediatek,mt6358-sound",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6358_of_match);
+
+static struct platform_driver mt6358_platform_driver = {
+	.driver = {
+		.name = "mt6358-sound",
+		.of_match_table = mt6358_of_match,
+	},
+	.probe = mt6358_platform_driver_probe,
+};
+
+module_platform_driver(mt6358_platform_driver)
+
+/* Module information */
+MODULE_DESCRIPTION("MT6358 ALSA SoC codec driver");
+MODULE_AUTHOR("KaiChieh Chuang <kaichieh.chuang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/mt6358.h b/sound/soc/codecs/mt6358.h
new file mode 100644
index 000000000000..a5953315eaa2
--- /dev/null
+++ b/sound/soc/codecs/mt6358.h
@@ -0,0 +1,2314 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt6358.h  --  mt6358 ALSA SoC audio codec driver
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
+ */
+
+#ifndef __MT6358_H__
+#define __MT6358_H__
+
+/* Reg bit define */
+/* MT6358_DCXO_CW14 */
+#define RG_XO_AUDIO_EN_M_SFT 13
+
+/* MT6358_DCXO_CW13 */
+#define RG_XO_VOW_EN_SFT 8
+
+/* MT6358_AUD_TOP_CKPDN_CON0 */
+#define RG_VOW13M_CK_PDN_SFT                              13
+#define RG_VOW13M_CK_PDN_MASK                             0x1
+#define RG_VOW13M_CK_PDN_MASK_SFT                         (0x1 << 13)
+#define RG_VOW32K_CK_PDN_SFT                              12
+#define RG_VOW32K_CK_PDN_MASK                             0x1
+#define RG_VOW32K_CK_PDN_MASK_SFT                         (0x1 << 12)
+#define RG_AUD_INTRP_CK_PDN_SFT                           8
+#define RG_AUD_INTRP_CK_PDN_MASK                          0x1
+#define RG_AUD_INTRP_CK_PDN_MASK_SFT                      (0x1 << 8)
+#define RG_PAD_AUD_CLK_MISO_CK_PDN_SFT                    7
+#define RG_PAD_AUD_CLK_MISO_CK_PDN_MASK                   0x1
+#define RG_PAD_AUD_CLK_MISO_CK_PDN_MASK_SFT               (0x1 << 7)
+#define RG_AUDNCP_CK_PDN_SFT                              6
+#define RG_AUDNCP_CK_PDN_MASK                             0x1
+#define RG_AUDNCP_CK_PDN_MASK_SFT                         (0x1 << 6)
+#define RG_ZCD13M_CK_PDN_SFT                              5
+#define RG_ZCD13M_CK_PDN_MASK                             0x1
+#define RG_ZCD13M_CK_PDN_MASK_SFT                         (0x1 << 5)
+#define RG_AUDIF_CK_PDN_SFT                               2
+#define RG_AUDIF_CK_PDN_MASK                              0x1
+#define RG_AUDIF_CK_PDN_MASK_SFT                          (0x1 << 2)
+#define RG_AUD_CK_PDN_SFT                                 1
+#define RG_AUD_CK_PDN_MASK                                0x1
+#define RG_AUD_CK_PDN_MASK_SFT                            (0x1 << 1)
+#define RG_ACCDET_CK_PDN_SFT                              0
+#define RG_ACCDET_CK_PDN_MASK                             0x1
+#define RG_ACCDET_CK_PDN_MASK_SFT                         (0x1 << 0)
+
+/* MT6358_AUD_TOP_CKPDN_CON0_SET */
+#define RG_AUD_TOP_CKPDN_CON0_SET_SFT                     0
+#define RG_AUD_TOP_CKPDN_CON0_SET_MASK                    0x3fff
+#define RG_AUD_TOP_CKPDN_CON0_SET_MASK_SFT                (0x3fff << 0)
+
+/* MT6358_AUD_TOP_CKPDN_CON0_CLR */
+#define RG_AUD_TOP_CKPDN_CON0_CLR_SFT                     0
+#define RG_AUD_TOP_CKPDN_CON0_CLR_MASK                    0x3fff
+#define RG_AUD_TOP_CKPDN_CON0_CLR_MASK_SFT                (0x3fff << 0)
+
+/* MT6358_AUD_TOP_CKSEL_CON0 */
+#define RG_AUDIF_CK_CKSEL_SFT                             3
+#define RG_AUDIF_CK_CKSEL_MASK                            0x1
+#define RG_AUDIF_CK_CKSEL_MASK_SFT                        (0x1 << 3)
+#define RG_AUD_CK_CKSEL_SFT                               2
+#define RG_AUD_CK_CKSEL_MASK                              0x1
+#define RG_AUD_CK_CKSEL_MASK_SFT                          (0x1 << 2)
+
+/* MT6358_AUD_TOP_CKSEL_CON0_SET */
+#define RG_AUD_TOP_CKSEL_CON0_SET_SFT                     0
+#define RG_AUD_TOP_CKSEL_CON0_SET_MASK                    0xf
+#define RG_AUD_TOP_CKSEL_CON0_SET_MASK_SFT                (0xf << 0)
+
+/* MT6358_AUD_TOP_CKSEL_CON0_CLR */
+#define RG_AUD_TOP_CKSEL_CON0_CLR_SFT                     0
+#define RG_AUD_TOP_CKSEL_CON0_CLR_MASK                    0xf
+#define RG_AUD_TOP_CKSEL_CON0_CLR_MASK_SFT                (0xf << 0)
+
+/* MT6358_AUD_TOP_CKTST_CON0 */
+#define RG_VOW13M_CK_TSTSEL_SFT                           9
+#define RG_VOW13M_CK_TSTSEL_MASK                          0x1
+#define RG_VOW13M_CK_TSTSEL_MASK_SFT                      (0x1 << 9)
+#define RG_VOW13M_CK_TST_DIS_SFT                          8
+#define RG_VOW13M_CK_TST_DIS_MASK                         0x1
+#define RG_VOW13M_CK_TST_DIS_MASK_SFT                     (0x1 << 8)
+#define RG_AUD26M_CK_TSTSEL_SFT                           4
+#define RG_AUD26M_CK_TSTSEL_MASK                          0x1
+#define RG_AUD26M_CK_TSTSEL_MASK_SFT                      (0x1 << 4)
+#define RG_AUDIF_CK_TSTSEL_SFT                            3
+#define RG_AUDIF_CK_TSTSEL_MASK                           0x1
+#define RG_AUDIF_CK_TSTSEL_MASK_SFT                       (0x1 << 3)
+#define RG_AUD_CK_TSTSEL_SFT                              2
+#define RG_AUD_CK_TSTSEL_MASK                             0x1
+#define RG_AUD_CK_TSTSEL_MASK_SFT                         (0x1 << 2)
+#define RG_AUD26M_CK_TST_DIS_SFT                          0
+#define RG_AUD26M_CK_TST_DIS_MASK                         0x1
+#define RG_AUD26M_CK_TST_DIS_MASK_SFT                     (0x1 << 0)
+
+/* MT6358_AUD_TOP_CLK_HWEN_CON0 */
+#define RG_AUD_INTRP_CK_PDN_HWEN_SFT                      0
+#define RG_AUD_INTRP_CK_PDN_HWEN_MASK                     0x1
+#define RG_AUD_INTRP_CK_PDN_HWEN_MASK_SFT                 (0x1 << 0)
+
+/* MT6358_AUD_TOP_CLK_HWEN_CON0_SET */
+#define RG_AUD_INTRP_CK_PND_HWEN_CON0_SET_SFT             0
+#define RG_AUD_INTRP_CK_PND_HWEN_CON0_SET_MASK            0xffff
+#define RG_AUD_INTRP_CK_PND_HWEN_CON0_SET_MASK_SFT        (0xffff << 0)
+
+/* MT6358_AUD_TOP_CLK_HWEN_CON0_CLR */
+#define RG_AUD_INTRP_CLK_PDN_HWEN_CON0_CLR_SFT            0
+#define RG_AUD_INTRP_CLK_PDN_HWEN_CON0_CLR_MASK           0xffff
+#define RG_AUD_INTRP_CLK_PDN_HWEN_CON0_CLR_MASK_SFT       (0xffff << 0)
+
+/* MT6358_AUD_TOP_RST_CON0 */
+#define RG_AUDNCP_RST_SFT                                 3
+#define RG_AUDNCP_RST_MASK                                0x1
+#define RG_AUDNCP_RST_MASK_SFT                            (0x1 << 3)
+#define RG_ZCD_RST_SFT                                    2
+#define RG_ZCD_RST_MASK                                   0x1
+#define RG_ZCD_RST_MASK_SFT                               (0x1 << 2)
+#define RG_ACCDET_RST_SFT                                 1
+#define RG_ACCDET_RST_MASK                                0x1
+#define RG_ACCDET_RST_MASK_SFT                            (0x1 << 1)
+#define RG_AUDIO_RST_SFT                                  0
+#define RG_AUDIO_RST_MASK                                 0x1
+#define RG_AUDIO_RST_MASK_SFT                             (0x1 << 0)
+
+/* MT6358_AUD_TOP_RST_CON0_SET */
+#define RG_AUD_TOP_RST_CON0_SET_SFT                       0
+#define RG_AUD_TOP_RST_CON0_SET_MASK                      0xf
+#define RG_AUD_TOP_RST_CON0_SET_MASK_SFT                  (0xf << 0)
+
+/* MT6358_AUD_TOP_RST_CON0_CLR */
+#define RG_AUD_TOP_RST_CON0_CLR_SFT                       0
+#define RG_AUD_TOP_RST_CON0_CLR_MASK                      0xf
+#define RG_AUD_TOP_RST_CON0_CLR_MASK_SFT                  (0xf << 0)
+
+/* MT6358_AUD_TOP_RST_BANK_CON0 */
+#define BANK_AUDZCD_SWRST_SFT                             2
+#define BANK_AUDZCD_SWRST_MASK                            0x1
+#define BANK_AUDZCD_SWRST_MASK_SFT                        (0x1 << 2)
+#define BANK_AUDIO_SWRST_SFT                              1
+#define BANK_AUDIO_SWRST_MASK                             0x1
+#define BANK_AUDIO_SWRST_MASK_SFT                         (0x1 << 1)
+#define BANK_ACCDET_SWRST_SFT                             0
+#define BANK_ACCDET_SWRST_MASK                            0x1
+#define BANK_ACCDET_SWRST_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AUD_TOP_INT_CON0 */
+#define RG_INT_EN_AUDIO_SFT                               0
+#define RG_INT_EN_AUDIO_MASK                              0x1
+#define RG_INT_EN_AUDIO_MASK_SFT                          (0x1 << 0)
+#define RG_INT_EN_ACCDET_SFT                              5
+#define RG_INT_EN_ACCDET_MASK                             0x1
+#define RG_INT_EN_ACCDET_MASK_SFT                         (0x1 << 5)
+#define RG_INT_EN_ACCDET_EINT0_SFT                        6
+#define RG_INT_EN_ACCDET_EINT0_MASK                       0x1
+#define RG_INT_EN_ACCDET_EINT0_MASK_SFT                   (0x1 << 6)
+#define RG_INT_EN_ACCDET_EINT1_SFT                        7
+#define RG_INT_EN_ACCDET_EINT1_MASK                       0x1
+#define RG_INT_EN_ACCDET_EINT1_MASK_SFT                   (0x1 << 7)
+
+/* MT6358_AUD_TOP_INT_CON0_SET */
+#define RG_AUD_INT_CON0_SET_SFT                           0
+#define RG_AUD_INT_CON0_SET_MASK                          0xffff
+#define RG_AUD_INT_CON0_SET_MASK_SFT                      (0xffff << 0)
+
+/* MT6358_AUD_TOP_INT_CON0_CLR */
+#define RG_AUD_INT_CON0_CLR_SFT                           0
+#define RG_AUD_INT_CON0_CLR_MASK                          0xffff
+#define RG_AUD_INT_CON0_CLR_MASK_SFT                      (0xffff << 0)
+
+/* MT6358_AUD_TOP_INT_MASK_CON0 */
+#define RG_INT_MASK_AUDIO_SFT                             0
+#define RG_INT_MASK_AUDIO_MASK                            0x1
+#define RG_INT_MASK_AUDIO_MASK_SFT                        (0x1 << 0)
+#define RG_INT_MASK_ACCDET_SFT                            5
+#define RG_INT_MASK_ACCDET_MASK                           0x1
+#define RG_INT_MASK_ACCDET_MASK_SFT                       (0x1 << 5)
+#define RG_INT_MASK_ACCDET_EINT0_SFT                      6
+#define RG_INT_MASK_ACCDET_EINT0_MASK                     0x1
+#define RG_INT_MASK_ACCDET_EINT0_MASK_SFT                 (0x1 << 6)
+#define RG_INT_MASK_ACCDET_EINT1_SFT                      7
+#define RG_INT_MASK_ACCDET_EINT1_MASK                     0x1
+#define RG_INT_MASK_ACCDET_EINT1_MASK_SFT                 (0x1 << 7)
+
+/* MT6358_AUD_TOP_INT_MASK_CON0_SET */
+#define RG_AUD_INT_MASK_CON0_SET_SFT                      0
+#define RG_AUD_INT_MASK_CON0_SET_MASK                     0xff
+#define RG_AUD_INT_MASK_CON0_SET_MASK_SFT                 (0xff << 0)
+
+/* MT6358_AUD_TOP_INT_MASK_CON0_CLR */
+#define RG_AUD_INT_MASK_CON0_CLR_SFT                      0
+#define RG_AUD_INT_MASK_CON0_CLR_MASK                     0xff
+#define RG_AUD_INT_MASK_CON0_CLR_MASK_SFT                 (0xff << 0)
+
+/* MT6358_AUD_TOP_INT_STATUS0 */
+#define RG_INT_STATUS_AUDIO_SFT                           0
+#define RG_INT_STATUS_AUDIO_MASK                          0x1
+#define RG_INT_STATUS_AUDIO_MASK_SFT                      (0x1 << 0)
+#define RG_INT_STATUS_ACCDET_SFT                          5
+#define RG_INT_STATUS_ACCDET_MASK                         0x1
+#define RG_INT_STATUS_ACCDET_MASK_SFT                     (0x1 << 5)
+#define RG_INT_STATUS_ACCDET_EINT0_SFT                    6
+#define RG_INT_STATUS_ACCDET_EINT0_MASK                   0x1
+#define RG_INT_STATUS_ACCDET_EINT0_MASK_SFT               (0x1 << 6)
+#define RG_INT_STATUS_ACCDET_EINT1_SFT                    7
+#define RG_INT_STATUS_ACCDET_EINT1_MASK                   0x1
+#define RG_INT_STATUS_ACCDET_EINT1_MASK_SFT               (0x1 << 7)
+
+/* MT6358_AUD_TOP_INT_RAW_STATUS0 */
+#define RG_INT_RAW_STATUS_AUDIO_SFT                       0
+#define RG_INT_RAW_STATUS_AUDIO_MASK                      0x1
+#define RG_INT_RAW_STATUS_AUDIO_MASK_SFT                  (0x1 << 0)
+#define RG_INT_RAW_STATUS_ACCDET_SFT                      5
+#define RG_INT_RAW_STATUS_ACCDET_MASK                     0x1
+#define RG_INT_RAW_STATUS_ACCDET_MASK_SFT                 (0x1 << 5)
+#define RG_INT_RAW_STATUS_ACCDET_EINT0_SFT                6
+#define RG_INT_RAW_STATUS_ACCDET_EINT0_MASK               0x1
+#define RG_INT_RAW_STATUS_ACCDET_EINT0_MASK_SFT           (0x1 << 6)
+#define RG_INT_RAW_STATUS_ACCDET_EINT1_SFT                7
+#define RG_INT_RAW_STATUS_ACCDET_EINT1_MASK               0x1
+#define RG_INT_RAW_STATUS_ACCDET_EINT1_MASK_SFT           (0x1 << 7)
+
+/* MT6358_AUD_TOP_INT_MISC_CON0 */
+#define RG_AUD_TOP_INT_POLARITY_SFT                       0
+#define RG_AUD_TOP_INT_POLARITY_MASK                      0x1
+#define RG_AUD_TOP_INT_POLARITY_MASK_SFT                  (0x1 << 0)
+
+/* MT6358_AUDNCP_CLKDIV_CON0 */
+#define RG_DIVCKS_CHG_SFT                                 0
+#define RG_DIVCKS_CHG_MASK                                0x1
+#define RG_DIVCKS_CHG_MASK_SFT                            (0x1 << 0)
+
+/* MT6358_AUDNCP_CLKDIV_CON1 */
+#define RG_DIVCKS_ON_SFT                                  0
+#define RG_DIVCKS_ON_MASK                                 0x1
+#define RG_DIVCKS_ON_MASK_SFT                             (0x1 << 0)
+
+/* MT6358_AUDNCP_CLKDIV_CON2 */
+#define RG_DIVCKS_PRG_SFT                                 0
+#define RG_DIVCKS_PRG_MASK                                0x1ff
+#define RG_DIVCKS_PRG_MASK_SFT                            (0x1ff << 0)
+
+/* MT6358_AUDNCP_CLKDIV_CON3 */
+#define RG_DIVCKS_PWD_NCP_SFT                             0
+#define RG_DIVCKS_PWD_NCP_MASK                            0x1
+#define RG_DIVCKS_PWD_NCP_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AUDNCP_CLKDIV_CON4 */
+#define RG_DIVCKS_PWD_NCP_ST_SEL_SFT                      0
+#define RG_DIVCKS_PWD_NCP_ST_SEL_MASK                     0x3
+#define RG_DIVCKS_PWD_NCP_ST_SEL_MASK_SFT                 (0x3 << 0)
+
+/* MT6358_AUD_TOP_MON_CON0 */
+#define RG_AUD_TOP_MON_SEL_SFT                            0
+#define RG_AUD_TOP_MON_SEL_MASK                           0x7
+#define RG_AUD_TOP_MON_SEL_MASK_SFT                       (0x7 << 0)
+#define RG_AUD_CLK_INT_MON_FLAG_SEL_SFT                   3
+#define RG_AUD_CLK_INT_MON_FLAG_SEL_MASK                  0xff
+#define RG_AUD_CLK_INT_MON_FLAG_SEL_MASK_SFT              (0xff << 3)
+#define RG_AUD_CLK_INT_MON_FLAG_EN_SFT                    11
+#define RG_AUD_CLK_INT_MON_FLAG_EN_MASK                   0x1
+#define RG_AUD_CLK_INT_MON_FLAG_EN_MASK_SFT               (0x1 << 11)
+
+/* MT6358_AUDIO_DIG_DSN_ID */
+#define AUDIO_DIG_ANA_ID_SFT                              0
+#define AUDIO_DIG_ANA_ID_MASK                             0xff
+#define AUDIO_DIG_ANA_ID_MASK_SFT                         (0xff << 0)
+#define AUDIO_DIG_DIG_ID_SFT                              8
+#define AUDIO_DIG_DIG_ID_MASK                             0xff
+#define AUDIO_DIG_DIG_ID_MASK_SFT                         (0xff << 8)
+
+/* MT6358_AUDIO_DIG_DSN_REV0 */
+#define AUDIO_DIG_ANA_MINOR_REV_SFT                       0
+#define AUDIO_DIG_ANA_MINOR_REV_MASK                      0xf
+#define AUDIO_DIG_ANA_MINOR_REV_MASK_SFT                  (0xf << 0)
+#define AUDIO_DIG_ANA_MAJOR_REV_SFT                       4
+#define AUDIO_DIG_ANA_MAJOR_REV_MASK                      0xf
+#define AUDIO_DIG_ANA_MAJOR_REV_MASK_SFT                  (0xf << 4)
+#define AUDIO_DIG_DIG_MINOR_REV_SFT                       8
+#define AUDIO_DIG_DIG_MINOR_REV_MASK                      0xf
+#define AUDIO_DIG_DIG_MINOR_REV_MASK_SFT                  (0xf << 8)
+#define AUDIO_DIG_DIG_MAJOR_REV_SFT                       12
+#define AUDIO_DIG_DIG_MAJOR_REV_MASK                      0xf
+#define AUDIO_DIG_DIG_MAJOR_REV_MASK_SFT                  (0xf << 12)
+
+/* MT6358_AUDIO_DIG_DSN_DBI */
+#define AUDIO_DIG_DSN_CBS_SFT                             0
+#define AUDIO_DIG_DSN_CBS_MASK                            0x3
+#define AUDIO_DIG_DSN_CBS_MASK_SFT                        (0x3 << 0)
+#define AUDIO_DIG_DSN_BIX_SFT                             2
+#define AUDIO_DIG_DSN_BIX_MASK                            0x3
+#define AUDIO_DIG_DSN_BIX_MASK_SFT                        (0x3 << 2)
+#define AUDIO_DIG_ESP_SFT                                 8
+#define AUDIO_DIG_ESP_MASK                                0xff
+#define AUDIO_DIG_ESP_MASK_SFT                            (0xff << 8)
+
+/* MT6358_AUDIO_DIG_DSN_DXI */
+#define AUDIO_DIG_DSN_FPI_SFT                             0
+#define AUDIO_DIG_DSN_FPI_MASK                            0xff
+#define AUDIO_DIG_DSN_FPI_MASK_SFT                        (0xff << 0)
+
+/* MT6358_AFE_UL_DL_CON0 */
+#define AFE_UL_LR_SWAP_SFT                                15
+#define AFE_UL_LR_SWAP_MASK                               0x1
+#define AFE_UL_LR_SWAP_MASK_SFT                           (0x1 << 15)
+#define AFE_DL_LR_SWAP_SFT                                14
+#define AFE_DL_LR_SWAP_MASK                               0x1
+#define AFE_DL_LR_SWAP_MASK_SFT                           (0x1 << 14)
+#define AFE_ON_SFT                                        0
+#define AFE_ON_MASK                                       0x1
+#define AFE_ON_MASK_SFT                                   (0x1 << 0)
+
+/* MT6358_AFE_DL_SRC2_CON0_L */
+#define DL_2_SRC_ON_TMP_CTL_PRE_SFT                       0
+#define DL_2_SRC_ON_TMP_CTL_PRE_MASK                      0x1
+#define DL_2_SRC_ON_TMP_CTL_PRE_MASK_SFT                  (0x1 << 0)
+
+/* MT6358_AFE_UL_SRC_CON0_H */
+#define C_DIGMIC_PHASE_SEL_CH1_CTL_SFT                    11
+#define C_DIGMIC_PHASE_SEL_CH1_CTL_MASK                   0x7
+#define C_DIGMIC_PHASE_SEL_CH1_CTL_MASK_SFT               (0x7 << 11)
+#define C_DIGMIC_PHASE_SEL_CH2_CTL_SFT                    8
+#define C_DIGMIC_PHASE_SEL_CH2_CTL_MASK                   0x7
+#define C_DIGMIC_PHASE_SEL_CH2_CTL_MASK_SFT               (0x7 << 8)
+#define C_TWO_DIGITAL_MIC_CTL_SFT                         7
+#define C_TWO_DIGITAL_MIC_CTL_MASK                        0x1
+#define C_TWO_DIGITAL_MIC_CTL_MASK_SFT                    (0x1 << 7)
+
+/* MT6358_AFE_UL_SRC_CON0_L */
+#define DMIC_LOW_POWER_MODE_CTL_SFT                       14
+#define DMIC_LOW_POWER_MODE_CTL_MASK                      0x3
+#define DMIC_LOW_POWER_MODE_CTL_MASK_SFT                  (0x3 << 14)
+#define DIGMIC_3P25M_1P625M_SEL_CTL_SFT                   5
+#define DIGMIC_3P25M_1P625M_SEL_CTL_MASK                  0x1
+#define DIGMIC_3P25M_1P625M_SEL_CTL_MASK_SFT              (0x1 << 5)
+#define UL_LOOP_BACK_MODE_CTL_SFT                         2
+#define UL_LOOP_BACK_MODE_CTL_MASK                        0x1
+#define UL_LOOP_BACK_MODE_CTL_MASK_SFT                    (0x1 << 2)
+#define UL_SDM_3_LEVEL_CTL_SFT                            1
+#define UL_SDM_3_LEVEL_CTL_MASK                           0x1
+#define UL_SDM_3_LEVEL_CTL_MASK_SFT                       (0x1 << 1)
+#define UL_SRC_ON_TMP_CTL_SFT                             0
+#define UL_SRC_ON_TMP_CTL_MASK                            0x1
+#define UL_SRC_ON_TMP_CTL_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AFE_TOP_CON0 */
+#define MTKAIF_SINE_ON_SFT                                2
+#define MTKAIF_SINE_ON_MASK                               0x1
+#define MTKAIF_SINE_ON_MASK_SFT                           (0x1 << 2)
+#define UL_SINE_ON_SFT                                    1
+#define UL_SINE_ON_MASK                                   0x1
+#define UL_SINE_ON_MASK_SFT                               (0x1 << 1)
+#define DL_SINE_ON_SFT                                    0
+#define DL_SINE_ON_MASK                                   0x1
+#define DL_SINE_ON_MASK_SFT                               (0x1 << 0)
+
+/* MT6358_AUDIO_TOP_CON0 */
+#define PDN_AFE_CTL_SFT                                   7
+#define PDN_AFE_CTL_MASK                                  0x1
+#define PDN_AFE_CTL_MASK_SFT                              (0x1 << 7)
+#define PDN_DAC_CTL_SFT                                   6
+#define PDN_DAC_CTL_MASK                                  0x1
+#define PDN_DAC_CTL_MASK_SFT                              (0x1 << 6)
+#define PDN_ADC_CTL_SFT                                   5
+#define PDN_ADC_CTL_MASK                                  0x1
+#define PDN_ADC_CTL_MASK_SFT                              (0x1 << 5)
+#define PDN_I2S_DL_CTL_SFT                                3
+#define PDN_I2S_DL_CTL_MASK                               0x1
+#define PDN_I2S_DL_CTL_MASK_SFT                           (0x1 << 3)
+#define PWR_CLK_DIS_CTL_SFT                               2
+#define PWR_CLK_DIS_CTL_MASK                              0x1
+#define PWR_CLK_DIS_CTL_MASK_SFT                          (0x1 << 2)
+#define PDN_AFE_TESTMODEL_CTL_SFT                         1
+#define PDN_AFE_TESTMODEL_CTL_MASK                        0x1
+#define PDN_AFE_TESTMODEL_CTL_MASK_SFT                    (0x1 << 1)
+#define PDN_RESERVED_SFT                                  0
+#define PDN_RESERVED_MASK                                 0x1
+#define PDN_RESERVED_MASK_SFT                             (0x1 << 0)
+
+/* MT6358_AFE_MON_DEBUG0 */
+#define AUDIO_SYS_TOP_MON_SWAP_SFT                        14
+#define AUDIO_SYS_TOP_MON_SWAP_MASK                       0x3
+#define AUDIO_SYS_TOP_MON_SWAP_MASK_SFT                   (0x3 << 14)
+#define AUDIO_SYS_TOP_MON_SEL_SFT                         8
+#define AUDIO_SYS_TOP_MON_SEL_MASK                        0x1f
+#define AUDIO_SYS_TOP_MON_SEL_MASK_SFT                    (0x1f << 8)
+#define AFE_MON_SEL_SFT                                   0
+#define AFE_MON_SEL_MASK                                  0xff
+#define AFE_MON_SEL_MASK_SFT                              (0xff << 0)
+
+/* MT6358_AFUNC_AUD_CON0 */
+#define CCI_AUD_ANACK_SEL_SFT                             15
+#define CCI_AUD_ANACK_SEL_MASK                            0x1
+#define CCI_AUD_ANACK_SEL_MASK_SFT                        (0x1 << 15)
+#define CCI_AUDIO_FIFO_WPTR_SFT                           12
+#define CCI_AUDIO_FIFO_WPTR_MASK                          0x7
+#define CCI_AUDIO_FIFO_WPTR_MASK_SFT                      (0x7 << 12)
+#define CCI_SCRAMBLER_CG_EN_SFT                           11
+#define CCI_SCRAMBLER_CG_EN_MASK                          0x1
+#define CCI_SCRAMBLER_CG_EN_MASK_SFT                      (0x1 << 11)
+#define CCI_LCH_INV_SFT                                   10
+#define CCI_LCH_INV_MASK                                  0x1
+#define CCI_LCH_INV_MASK_SFT                              (0x1 << 10)
+#define CCI_RAND_EN_SFT                                   9
+#define CCI_RAND_EN_MASK                                  0x1
+#define CCI_RAND_EN_MASK_SFT                              (0x1 << 9)
+#define CCI_SPLT_SCRMB_CLK_ON_SFT                         8
+#define CCI_SPLT_SCRMB_CLK_ON_MASK                        0x1
+#define CCI_SPLT_SCRMB_CLK_ON_MASK_SFT                    (0x1 << 8)
+#define CCI_SPLT_SCRMB_ON_SFT                             7
+#define CCI_SPLT_SCRMB_ON_MASK                            0x1
+#define CCI_SPLT_SCRMB_ON_MASK_SFT                        (0x1 << 7)
+#define CCI_AUD_IDAC_TEST_EN_SFT                          6
+#define CCI_AUD_IDAC_TEST_EN_MASK                         0x1
+#define CCI_AUD_IDAC_TEST_EN_MASK_SFT                     (0x1 << 6)
+#define CCI_ZERO_PAD_DISABLE_SFT                          5
+#define CCI_ZERO_PAD_DISABLE_MASK                         0x1
+#define CCI_ZERO_PAD_DISABLE_MASK_SFT                     (0x1 << 5)
+#define CCI_AUD_SPLIT_TEST_EN_SFT                         4
+#define CCI_AUD_SPLIT_TEST_EN_MASK                        0x1
+#define CCI_AUD_SPLIT_TEST_EN_MASK_SFT                    (0x1 << 4)
+#define CCI_AUD_SDM_MUTEL_SFT                             3
+#define CCI_AUD_SDM_MUTEL_MASK                            0x1
+#define CCI_AUD_SDM_MUTEL_MASK_SFT                        (0x1 << 3)
+#define CCI_AUD_SDM_MUTER_SFT                             2
+#define CCI_AUD_SDM_MUTER_MASK                            0x1
+#define CCI_AUD_SDM_MUTER_MASK_SFT                        (0x1 << 2)
+#define CCI_AUD_SDM_7BIT_SEL_SFT                          1
+#define CCI_AUD_SDM_7BIT_SEL_MASK                         0x1
+#define CCI_AUD_SDM_7BIT_SEL_MASK_SFT                     (0x1 << 1)
+#define CCI_SCRAMBLER_EN_SFT                              0
+#define CCI_SCRAMBLER_EN_MASK                             0x1
+#define CCI_SCRAMBLER_EN_MASK_SFT                         (0x1 << 0)
+
+/* MT6358_AFUNC_AUD_CON1 */
+#define AUD_SDM_TEST_L_SFT                                8
+#define AUD_SDM_TEST_L_MASK                               0xff
+#define AUD_SDM_TEST_L_MASK_SFT                           (0xff << 8)
+#define AUD_SDM_TEST_R_SFT                                0
+#define AUD_SDM_TEST_R_MASK                               0xff
+#define AUD_SDM_TEST_R_MASK_SFT                           (0xff << 0)
+
+/* MT6358_AFUNC_AUD_CON2 */
+#define CCI_AUD_DAC_ANA_MUTE_SFT                          7
+#define CCI_AUD_DAC_ANA_MUTE_MASK                         0x1
+#define CCI_AUD_DAC_ANA_MUTE_MASK_SFT                     (0x1 << 7)
+#define CCI_AUD_DAC_ANA_RSTB_SEL_SFT                      6
+#define CCI_AUD_DAC_ANA_RSTB_SEL_MASK                     0x1
+#define CCI_AUD_DAC_ANA_RSTB_SEL_MASK_SFT                 (0x1 << 6)
+#define CCI_AUDIO_FIFO_CLKIN_INV_SFT                      4
+#define CCI_AUDIO_FIFO_CLKIN_INV_MASK                     0x1
+#define CCI_AUDIO_FIFO_CLKIN_INV_MASK_SFT                 (0x1 << 4)
+#define CCI_AUDIO_FIFO_ENABLE_SFT                         3
+#define CCI_AUDIO_FIFO_ENABLE_MASK                        0x1
+#define CCI_AUDIO_FIFO_ENABLE_MASK_SFT                    (0x1 << 3)
+#define CCI_ACD_MODE_SFT                                  2
+#define CCI_ACD_MODE_MASK                                 0x1
+#define CCI_ACD_MODE_MASK_SFT                             (0x1 << 2)
+#define CCI_AFIFO_CLK_PWDB_SFT                            1
+#define CCI_AFIFO_CLK_PWDB_MASK                           0x1
+#define CCI_AFIFO_CLK_PWDB_MASK_SFT                       (0x1 << 1)
+#define CCI_ACD_FUNC_RSTB_SFT                             0
+#define CCI_ACD_FUNC_RSTB_MASK                            0x1
+#define CCI_ACD_FUNC_RSTB_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AFUNC_AUD_CON3 */
+#define SDM_ANA13M_TESTCK_SEL_SFT                         15
+#define SDM_ANA13M_TESTCK_SEL_MASK                        0x1
+#define SDM_ANA13M_TESTCK_SEL_MASK_SFT                    (0x1 << 15)
+#define SDM_ANA13M_TESTCK_SRC_SEL_SFT                     12
+#define SDM_ANA13M_TESTCK_SRC_SEL_MASK                    0x7
+#define SDM_ANA13M_TESTCK_SRC_SEL_MASK_SFT                (0x7 << 12)
+#define SDM_TESTCK_SRC_SEL_SFT                            8
+#define SDM_TESTCK_SRC_SEL_MASK                           0x7
+#define SDM_TESTCK_SRC_SEL_MASK_SFT                       (0x7 << 8)
+#define DIGMIC_TESTCK_SRC_SEL_SFT                         4
+#define DIGMIC_TESTCK_SRC_SEL_MASK                        0x7
+#define DIGMIC_TESTCK_SRC_SEL_MASK_SFT                    (0x7 << 4)
+#define DIGMIC_TESTCK_SEL_SFT                             0
+#define DIGMIC_TESTCK_SEL_MASK                            0x1
+#define DIGMIC_TESTCK_SEL_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AFUNC_AUD_CON4 */
+#define UL_FIFO_WCLK_INV_SFT                              8
+#define UL_FIFO_WCLK_INV_MASK                             0x1
+#define UL_FIFO_WCLK_INV_MASK_SFT                         (0x1 << 8)
+#define UL_FIFO_DIGMIC_WDATA_TESTSRC_SEL_SFT              6
+#define UL_FIFO_DIGMIC_WDATA_TESTSRC_SEL_MASK             0x1
+#define UL_FIFO_DIGMIC_WDATA_TESTSRC_SEL_MASK_SFT         (0x1 << 6)
+#define UL_FIFO_WDATA_TESTEN_SFT                          5
+#define UL_FIFO_WDATA_TESTEN_MASK                         0x1
+#define UL_FIFO_WDATA_TESTEN_MASK_SFT                     (0x1 << 5)
+#define UL_FIFO_WDATA_TESTSRC_SEL_SFT                     4
+#define UL_FIFO_WDATA_TESTSRC_SEL_MASK                    0x1
+#define UL_FIFO_WDATA_TESTSRC_SEL_MASK_SFT                (0x1 << 4)
+#define UL_FIFO_WCLK_6P5M_TESTCK_SEL_SFT                  3
+#define UL_FIFO_WCLK_6P5M_TESTCK_SEL_MASK                 0x1
+#define UL_FIFO_WCLK_6P5M_TESTCK_SEL_MASK_SFT             (0x1 << 3)
+#define UL_FIFO_WCLK_6P5M_TESTCK_SRC_SEL_SFT              0
+#define UL_FIFO_WCLK_6P5M_TESTCK_SRC_SEL_MASK             0x7
+#define UL_FIFO_WCLK_6P5M_TESTCK_SRC_SEL_MASK_SFT         (0x7 << 0)
+
+/* MT6358_AFUNC_AUD_CON5 */
+#define R_AUD_DAC_POS_LARGE_MONO_SFT                      8
+#define R_AUD_DAC_POS_LARGE_MONO_MASK                     0xff
+#define R_AUD_DAC_POS_LARGE_MONO_MASK_SFT                 (0xff << 8)
+#define R_AUD_DAC_NEG_LARGE_MONO_SFT                      0
+#define R_AUD_DAC_NEG_LARGE_MONO_MASK                     0xff
+#define R_AUD_DAC_NEG_LARGE_MONO_MASK_SFT                 (0xff << 0)
+
+/* MT6358_AFUNC_AUD_CON6 */
+#define R_AUD_DAC_POS_SMALL_MONO_SFT                      12
+#define R_AUD_DAC_POS_SMALL_MONO_MASK                     0xf
+#define R_AUD_DAC_POS_SMALL_MONO_MASK_SFT                 (0xf << 12)
+#define R_AUD_DAC_NEG_SMALL_MONO_SFT                      8
+#define R_AUD_DAC_NEG_SMALL_MONO_MASK                     0xf
+#define R_AUD_DAC_NEG_SMALL_MONO_MASK_SFT                 (0xf << 8)
+#define R_AUD_DAC_POS_TINY_MONO_SFT                       6
+#define R_AUD_DAC_POS_TINY_MONO_MASK                      0x3
+#define R_AUD_DAC_POS_TINY_MONO_MASK_SFT                  (0x3 << 6)
+#define R_AUD_DAC_NEG_TINY_MONO_SFT                       4
+#define R_AUD_DAC_NEG_TINY_MONO_MASK                      0x3
+#define R_AUD_DAC_NEG_TINY_MONO_MASK_SFT                  (0x3 << 4)
+#define R_AUD_DAC_MONO_SEL_SFT                            3
+#define R_AUD_DAC_MONO_SEL_MASK                           0x1
+#define R_AUD_DAC_MONO_SEL_MASK_SFT                       (0x1 << 3)
+#define R_AUD_DAC_SW_RSTB_SFT                             0
+#define R_AUD_DAC_SW_RSTB_MASK                            0x1
+#define R_AUD_DAC_SW_RSTB_MASK_SFT                        (0x1 << 0)
+
+/* MT6358_AFUNC_AUD_MON0 */
+#define AUD_SCR_OUT_L_SFT                                 8
+#define AUD_SCR_OUT_L_MASK                                0xff
+#define AUD_SCR_OUT_L_MASK_SFT                            (0xff << 8)
+#define AUD_SCR_OUT_R_SFT                                 0
+#define AUD_SCR_OUT_R_MASK                                0xff
+#define AUD_SCR_OUT_R_MASK_SFT                            (0xff << 0)
+
+/* MT6358_AUDRC_TUNE_MON0 */
+#define ASYNC_TEST_OUT_BCK_SFT                            15
+#define ASYNC_TEST_OUT_BCK_MASK                           0x1
+#define ASYNC_TEST_OUT_BCK_MASK_SFT                       (0x1 << 15)
+#define RGS_AUDRCTUNE1READ_SFT                            8
+#define RGS_AUDRCTUNE1READ_MASK                           0x1f
+#define RGS_AUDRCTUNE1READ_MASK_SFT                       (0x1f << 8)
+#define RGS_AUDRCTUNE0READ_SFT                            0
+#define RGS_AUDRCTUNE0READ_MASK                           0x1f
+#define RGS_AUDRCTUNE0READ_MASK_SFT                       (0x1f << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_FIFO_CFG0 */
+#define AFE_RESERVED_SFT                                  1
+#define AFE_RESERVED_MASK                                 0x7fff
+#define AFE_RESERVED_MASK_SFT                             (0x7fff << 1)
+#define RG_MTKAIF_RXIF_FIFO_INTEN_SFT                     0
+#define RG_MTKAIF_RXIF_FIFO_INTEN_MASK                    0x1
+#define RG_MTKAIF_RXIF_FIFO_INTEN_MASK_SFT                (0x1 << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_FIFO_LOG_MON1 */
+#define MTKAIF_RXIF_WR_FULL_STATUS_SFT                    1
+#define MTKAIF_RXIF_WR_FULL_STATUS_MASK                   0x1
+#define MTKAIF_RXIF_WR_FULL_STATUS_MASK_SFT               (0x1 << 1)
+#define MTKAIF_RXIF_RD_EMPTY_STATUS_SFT                   0
+#define MTKAIF_RXIF_RD_EMPTY_STATUS_MASK                  0x1
+#define MTKAIF_RXIF_RD_EMPTY_STATUS_MASK_SFT              (0x1 << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_MON0 */
+#define MTKAIFTX_V3_SYNC_OUT_SFT                          14
+#define MTKAIFTX_V3_SYNC_OUT_MASK                         0x1
+#define MTKAIFTX_V3_SYNC_OUT_MASK_SFT                     (0x1 << 14)
+#define MTKAIFTX_V3_SDATA_OUT2_SFT                        13
+#define MTKAIFTX_V3_SDATA_OUT2_MASK                       0x1
+#define MTKAIFTX_V3_SDATA_OUT2_MASK_SFT                   (0x1 << 13)
+#define MTKAIFTX_V3_SDATA_OUT1_SFT                        12
+#define MTKAIFTX_V3_SDATA_OUT1_MASK                       0x1
+#define MTKAIFTX_V3_SDATA_OUT1_MASK_SFT                   (0x1 << 12)
+#define MTKAIF_RXIF_FIFO_STATUS_SFT                       0
+#define MTKAIF_RXIF_FIFO_STATUS_MASK                      0xfff
+#define MTKAIF_RXIF_FIFO_STATUS_MASK_SFT                  (0xfff << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_MON1 */
+#define MTKAIFRX_V3_SYNC_IN_SFT                           14
+#define MTKAIFRX_V3_SYNC_IN_MASK                          0x1
+#define MTKAIFRX_V3_SYNC_IN_MASK_SFT                      (0x1 << 14)
+#define MTKAIFRX_V3_SDATA_IN2_SFT                         13
+#define MTKAIFRX_V3_SDATA_IN2_MASK                        0x1
+#define MTKAIFRX_V3_SDATA_IN2_MASK_SFT                    (0x1 << 13)
+#define MTKAIFRX_V3_SDATA_IN1_SFT                         12
+#define MTKAIFRX_V3_SDATA_IN1_MASK                        0x1
+#define MTKAIFRX_V3_SDATA_IN1_MASK_SFT                    (0x1 << 12)
+#define MTKAIF_RXIF_SEARCH_FAIL_FLAG_SFT                  11
+#define MTKAIF_RXIF_SEARCH_FAIL_FLAG_MASK                 0x1
+#define MTKAIF_RXIF_SEARCH_FAIL_FLAG_MASK_SFT             (0x1 << 11)
+#define MTKAIF_RXIF_INVALID_FLAG_SFT                      8
+#define MTKAIF_RXIF_INVALID_FLAG_MASK                     0x1
+#define MTKAIF_RXIF_INVALID_FLAG_MASK_SFT                 (0x1 << 8)
+#define MTKAIF_RXIF_INVALID_CYCLE_SFT                     0
+#define MTKAIF_RXIF_INVALID_CYCLE_MASK                    0xff
+#define MTKAIF_RXIF_INVALID_CYCLE_MASK_SFT                (0xff << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_MON2 */
+#define MTKAIF_TXIF_IN_CH2_SFT                            8
+#define MTKAIF_TXIF_IN_CH2_MASK                           0xff
+#define MTKAIF_TXIF_IN_CH2_MASK_SFT                       (0xff << 8)
+#define MTKAIF_TXIF_IN_CH1_SFT                            0
+#define MTKAIF_TXIF_IN_CH1_MASK                           0xff
+#define MTKAIF_TXIF_IN_CH1_MASK_SFT                       (0xff << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_MON3 */
+#define MTKAIF_RXIF_OUT_CH2_SFT                           8
+#define MTKAIF_RXIF_OUT_CH2_MASK                          0xff
+#define MTKAIF_RXIF_OUT_CH2_MASK_SFT                      (0xff << 8)
+#define MTKAIF_RXIF_OUT_CH1_SFT                           0
+#define MTKAIF_RXIF_OUT_CH1_MASK                          0xff
+#define MTKAIF_RXIF_OUT_CH1_MASK_SFT                      (0xff << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_CFG0 */
+#define RG_MTKAIF_RXIF_CLKINV_SFT                         15
+#define RG_MTKAIF_RXIF_CLKINV_MASK                        0x1
+#define RG_MTKAIF_RXIF_CLKINV_MASK_SFT                    (0x1 << 15)
+#define RG_MTKAIF_RXIF_PROTOCOL2_SFT                      8
+#define RG_MTKAIF_RXIF_PROTOCOL2_MASK                     0x1
+#define RG_MTKAIF_RXIF_PROTOCOL2_MASK_SFT                 (0x1 << 8)
+#define RG_MTKAIF_BYPASS_SRC_MODE_SFT                     6
+#define RG_MTKAIF_BYPASS_SRC_MODE_MASK                    0x3
+#define RG_MTKAIF_BYPASS_SRC_MODE_MASK_SFT                (0x3 << 6)
+#define RG_MTKAIF_BYPASS_SRC_TEST_SFT                     5
+#define RG_MTKAIF_BYPASS_SRC_TEST_MASK                    0x1
+#define RG_MTKAIF_BYPASS_SRC_TEST_MASK_SFT                (0x1 << 5)
+#define RG_MTKAIF_TXIF_PROTOCOL2_SFT                      4
+#define RG_MTKAIF_TXIF_PROTOCOL2_MASK                     0x1
+#define RG_MTKAIF_TXIF_PROTOCOL2_MASK_SFT                 (0x1 << 4)
+#define RG_MTKAIF_PMIC_TXIF_8TO5_SFT                      2
+#define RG_MTKAIF_PMIC_TXIF_8TO5_MASK                     0x1
+#define RG_MTKAIF_PMIC_TXIF_8TO5_MASK_SFT                 (0x1 << 2)
+#define RG_MTKAIF_LOOPBACK_TEST2_SFT                      1
+#define RG_MTKAIF_LOOPBACK_TEST2_MASK                     0x1
+#define RG_MTKAIF_LOOPBACK_TEST2_MASK_SFT                 (0x1 << 1)
+#define RG_MTKAIF_LOOPBACK_TEST1_SFT                      0
+#define RG_MTKAIF_LOOPBACK_TEST1_MASK                     0x1
+#define RG_MTKAIF_LOOPBACK_TEST1_MASK_SFT                 (0x1 << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_RX_CFG0 */
+#define RG_MTKAIF_RXIF_VOICE_MODE_SFT                     12
+#define RG_MTKAIF_RXIF_VOICE_MODE_MASK                    0xf
+#define RG_MTKAIF_RXIF_VOICE_MODE_MASK_SFT                (0xf << 12)
+#define RG_MTKAIF_RXIF_DATA_BIT_SFT                       8
+#define RG_MTKAIF_RXIF_DATA_BIT_MASK                      0x7
+#define RG_MTKAIF_RXIF_DATA_BIT_MASK_SFT                  (0x7 << 8)
+#define RG_MTKAIF_RXIF_FIFO_RSP_SFT                       4
+#define RG_MTKAIF_RXIF_FIFO_RSP_MASK                      0x7
+#define RG_MTKAIF_RXIF_FIFO_RSP_MASK_SFT                  (0x7 << 4)
+#define RG_MTKAIF_RXIF_DETECT_ON_SFT                      3
+#define RG_MTKAIF_RXIF_DETECT_ON_MASK                     0x1
+#define RG_MTKAIF_RXIF_DETECT_ON_MASK_SFT                 (0x1 << 3)
+#define RG_MTKAIF_RXIF_DATA_MODE_SFT                      0
+#define RG_MTKAIF_RXIF_DATA_MODE_MASK                     0x1
+#define RG_MTKAIF_RXIF_DATA_MODE_MASK_SFT                 (0x1 << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_RX_CFG1 */
+#define RG_MTKAIF_RXIF_SYNC_SEARCH_TABLE_SFT              12
+#define RG_MTKAIF_RXIF_SYNC_SEARCH_TABLE_MASK             0xf
+#define RG_MTKAIF_RXIF_SYNC_SEARCH_TABLE_MASK_SFT         (0xf << 12)
+#define RG_MTKAIF_RXIF_INVALID_SYNC_CHECK_ROUND_SFT       8
+#define RG_MTKAIF_RXIF_INVALID_SYNC_CHECK_ROUND_MASK      0xf
+#define RG_MTKAIF_RXIF_INVALID_SYNC_CHECK_ROUND_MASK_SFT  (0xf << 8)
+#define RG_MTKAIF_RXIF_SYNC_CHECK_ROUND_SFT               4
+#define RG_MTKAIF_RXIF_SYNC_CHECK_ROUND_MASK              0xf
+#define RG_MTKAIF_RXIF_SYNC_CHECK_ROUND_MASK_SFT          (0xf << 4)
+#define RG_MTKAIF_RXIF_VOICE_MODE_PROTOCOL2_SFT           0
+#define RG_MTKAIF_RXIF_VOICE_MODE_PROTOCOL2_MASK          0xf
+#define RG_MTKAIF_RXIF_VOICE_MODE_PROTOCOL2_MASK_SFT      (0xf << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_RX_CFG2 */
+#define RG_MTKAIF_RXIF_CLEAR_SYNC_FAIL_SFT                12
+#define RG_MTKAIF_RXIF_CLEAR_SYNC_FAIL_MASK               0x1
+#define RG_MTKAIF_RXIF_CLEAR_SYNC_FAIL_MASK_SFT           (0x1 << 12)
+#define RG_MTKAIF_RXIF_SYNC_CNT_TABLE_SFT                 0
+#define RG_MTKAIF_RXIF_SYNC_CNT_TABLE_MASK                0xfff
+#define RG_MTKAIF_RXIF_SYNC_CNT_TABLE_MASK_SFT            (0xfff << 0)
+
+/* MT6358_AFE_ADDA_MTKAIF_RX_CFG3 */
+#define RG_MTKAIF_RXIF_LOOPBACK_USE_NLE_SFT               7
+#define RG_MTKAIF_RXIF_LOOPBACK_USE_NLE_MASK              0x1
+#define RG_MTKAIF_RXIF_LOOPBACK_USE_NLE_MASK_SFT          (0x1 << 7)
+#define RG_MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_SFT             4
+#define RG_MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_MASK            0x7
+#define RG_MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_MASK_SFT        (0x7 << 4)
+#define RG_MTKAIF_RXIF_DETECT_ON_PROTOCOL2_SFT            3
+#define RG_MTKAIF_RXIF_DETECT_ON_PROTOCOL2_MASK           0x1
+#define RG_MTKAIF_RXIF_DETECT_ON_PROTOCOL2_MASK_SFT       (0x1 << 3)
+
+/* MT6358_AFE_ADDA_MTKAIF_TX_CFG1 */
+#define RG_MTKAIF_SYNC_WORD2_SFT                          4
+#define RG_MTKAIF_SYNC_WORD2_MASK                         0x7
+#define RG_MTKAIF_SYNC_WORD2_MASK_SFT                     (0x7 << 4)
+#define RG_MTKAIF_SYNC_WORD1_SFT                          0
+#define RG_MTKAIF_SYNC_WORD1_MASK                         0x7
+#define RG_MTKAIF_SYNC_WORD1_MASK_SFT                     (0x7 << 0)
+
+/* MT6358_AFE_SGEN_CFG0 */
+#define SGEN_AMP_DIV_CH1_CTL_SFT                          12
+#define SGEN_AMP_DIV_CH1_CTL_MASK                         0xf
+#define SGEN_AMP_DIV_CH1_CTL_MASK_SFT                     (0xf << 12)
+#define SGEN_DAC_EN_CTL_SFT                               7
+#define SGEN_DAC_EN_CTL_MASK                              0x1
+#define SGEN_DAC_EN_CTL_MASK_SFT                          (0x1 << 7)
+#define SGEN_MUTE_SW_CTL_SFT                              6
+#define SGEN_MUTE_SW_CTL_MASK                             0x1
+#define SGEN_MUTE_SW_CTL_MASK_SFT                         (0x1 << 6)
+#define R_AUD_SDM_MUTE_L_SFT                              5
+#define R_AUD_SDM_MUTE_L_MASK                             0x1
+#define R_AUD_SDM_MUTE_L_MASK_SFT                         (0x1 << 5)
+#define R_AUD_SDM_MUTE_R_SFT                              4
+#define R_AUD_SDM_MUTE_R_MASK                             0x1
+#define R_AUD_SDM_MUTE_R_MASK_SFT                         (0x1 << 4)
+
+/* MT6358_AFE_SGEN_CFG1 */
+#define C_SGEN_RCH_INV_5BIT_SFT                           15
+#define C_SGEN_RCH_INV_5BIT_MASK                          0x1
+#define C_SGEN_RCH_INV_5BIT_MASK_SFT                      (0x1 << 15)
+#define C_SGEN_RCH_INV_8BIT_SFT                           14
+#define C_SGEN_RCH_INV_8BIT_MASK                          0x1
+#define C_SGEN_RCH_INV_8BIT_MASK_SFT                      (0x1 << 14)
+#define SGEN_FREQ_DIV_CH1_CTL_SFT                         0
+#define SGEN_FREQ_DIV_CH1_CTL_MASK                        0x1f
+#define SGEN_FREQ_DIV_CH1_CTL_MASK_SFT                    (0x1f << 0)
+
+/* MT6358_AFE_ADC_ASYNC_FIFO_CFG */
+#define RG_UL_ASYNC_FIFO_SOFT_RST_EN_SFT                  5
+#define RG_UL_ASYNC_FIFO_SOFT_RST_EN_MASK                 0x1
+#define RG_UL_ASYNC_FIFO_SOFT_RST_EN_MASK_SFT             (0x1 << 5)
+#define RG_UL_ASYNC_FIFO_SOFT_RST_SFT                     4
+#define RG_UL_ASYNC_FIFO_SOFT_RST_MASK                    0x1
+#define RG_UL_ASYNC_FIFO_SOFT_RST_MASK_SFT                (0x1 << 4)
+#define RG_AMIC_UL_ADC_CLK_SEL_SFT                        1
+#define RG_AMIC_UL_ADC_CLK_SEL_MASK                       0x1
+#define RG_AMIC_UL_ADC_CLK_SEL_MASK_SFT                   (0x1 << 1)
+
+/* MT6358_AFE_DCCLK_CFG0 */
+#define DCCLK_DIV_SFT                                     5
+#define DCCLK_DIV_MASK                                    0x7ff
+#define DCCLK_DIV_MASK_SFT                                (0x7ff << 5)
+#define DCCLK_INV_SFT                                     4
+#define DCCLK_INV_MASK                                    0x1
+#define DCCLK_INV_MASK_SFT                                (0x1 << 4)
+#define DCCLK_PDN_SFT                                     1
+#define DCCLK_PDN_MASK                                    0x1
+#define DCCLK_PDN_MASK_SFT                                (0x1 << 1)
+#define DCCLK_GEN_ON_SFT                                  0
+#define DCCLK_GEN_ON_MASK                                 0x1
+#define DCCLK_GEN_ON_MASK_SFT                             (0x1 << 0)
+
+/* MT6358_AFE_DCCLK_CFG1 */
+#define RESYNC_SRC_SEL_SFT                                10
+#define RESYNC_SRC_SEL_MASK                               0x3
+#define RESYNC_SRC_SEL_MASK_SFT                           (0x3 << 10)
+#define RESYNC_SRC_CK_INV_SFT                             9
+#define RESYNC_SRC_CK_INV_MASK                            0x1
+#define RESYNC_SRC_CK_INV_MASK_SFT                        (0x1 << 9)
+#define DCCLK_RESYNC_BYPASS_SFT                           8
+#define DCCLK_RESYNC_BYPASS_MASK                          0x1
+#define DCCLK_RESYNC_BYPASS_MASK_SFT                      (0x1 << 8)
+#define DCCLK_PHASE_SEL_SFT                               4
+#define DCCLK_PHASE_SEL_MASK                              0xf
+#define DCCLK_PHASE_SEL_MASK_SFT                          (0xf << 4)
+
+/* MT6358_AUDIO_DIG_CFG */
+#define RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_SFT             15
+#define RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_MASK            0x1
+#define RG_AUD_PAD_TOP_DAT_MISO2_LOOPBACK_MASK_SFT        (0x1 << 15)
+#define RG_AUD_PAD_TOP_PHASE_MODE2_SFT                    8
+#define RG_AUD_PAD_TOP_PHASE_MODE2_MASK                   0x7f
+#define RG_AUD_PAD_TOP_PHASE_MODE2_MASK_SFT               (0x7f << 8)
+#define RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT              7
+#define RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_MASK             0x1
+#define RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_MASK_SFT         (0x1 << 7)
+#define RG_AUD_PAD_TOP_PHASE_MODE_SFT                     0
+#define RG_AUD_PAD_TOP_PHASE_MODE_MASK                    0x7f
+#define RG_AUD_PAD_TOP_PHASE_MODE_MASK_SFT                (0x7f << 0)
+
+/* MT6358_AFE_AUD_PAD_TOP */
+#define RG_AUD_PAD_TOP_TX_FIFO_RSP_SFT                    12
+#define RG_AUD_PAD_TOP_TX_FIFO_RSP_MASK                   0x7
+#define RG_AUD_PAD_TOP_TX_FIFO_RSP_MASK_SFT               (0x7 << 12)
+#define RG_AUD_PAD_TOP_MTKAIF_CLK_PROTOCOL2_SFT           11
+#define RG_AUD_PAD_TOP_MTKAIF_CLK_PROTOCOL2_MASK          0x1
+#define RG_AUD_PAD_TOP_MTKAIF_CLK_PROTOCOL2_MASK_SFT      (0x1 << 11)
+#define RG_AUD_PAD_TOP_TX_FIFO_ON_SFT                     8
+#define RG_AUD_PAD_TOP_TX_FIFO_ON_MASK                    0x1
+#define RG_AUD_PAD_TOP_TX_FIFO_ON_MASK_SFT                (0x1 << 8)
+
+/* MT6358_AFE_AUD_PAD_TOP_MON */
+#define ADDA_AUD_PAD_TOP_MON_SFT                          0
+#define ADDA_AUD_PAD_TOP_MON_MASK                         0xffff
+#define ADDA_AUD_PAD_TOP_MON_MASK_SFT                     (0xffff << 0)
+
+/* MT6358_AFE_AUD_PAD_TOP_MON1 */
+#define ADDA_AUD_PAD_TOP_MON1_SFT                         0
+#define ADDA_AUD_PAD_TOP_MON1_MASK                        0xffff
+#define ADDA_AUD_PAD_TOP_MON1_MASK_SFT                    (0xffff << 0)
+
+/* MT6358_AFE_DL_NLE_CFG */
+#define NLE_RCH_HPGAIN_SEL_SFT                            10
+#define NLE_RCH_HPGAIN_SEL_MASK                           0x1
+#define NLE_RCH_HPGAIN_SEL_MASK_SFT                       (0x1 << 10)
+#define NLE_RCH_CH_SEL_SFT                                9
+#define NLE_RCH_CH_SEL_MASK                               0x1
+#define NLE_RCH_CH_SEL_MASK_SFT                           (0x1 << 9)
+#define NLE_RCH_ON_SFT                                    8
+#define NLE_RCH_ON_MASK                                   0x1
+#define NLE_RCH_ON_MASK_SFT                               (0x1 << 8)
+#define NLE_LCH_HPGAIN_SEL_SFT                            2
+#define NLE_LCH_HPGAIN_SEL_MASK                           0x1
+#define NLE_LCH_HPGAIN_SEL_MASK_SFT                       (0x1 << 2)
+#define NLE_LCH_CH_SEL_SFT                                1
+#define NLE_LCH_CH_SEL_MASK                               0x1
+#define NLE_LCH_CH_SEL_MASK_SFT                           (0x1 << 1)
+#define NLE_LCH_ON_SFT                                    0
+#define NLE_LCH_ON_MASK                                   0x1
+#define NLE_LCH_ON_MASK_SFT                               (0x1 << 0)
+
+/* MT6358_AFE_DL_NLE_MON */
+#define NLE_MONITOR_SFT                                   0
+#define NLE_MONITOR_MASK                                  0x3fff
+#define NLE_MONITOR_MASK_SFT                              (0x3fff << 0)
+
+/* MT6358_AFE_CG_EN_MON */
+#define CK_CG_EN_MON_SFT                                  0
+#define CK_CG_EN_MON_MASK                                 0x3f
+#define CK_CG_EN_MON_MASK_SFT                             (0x3f << 0)
+
+/* MT6358_AFE_VOW_TOP */
+#define PDN_VOW_SFT                                       15
+#define PDN_VOW_MASK                                      0x1
+#define PDN_VOW_MASK_SFT                                  (0x1 << 15)
+#define VOW_1P6M_800K_SEL_SFT                             14
+#define VOW_1P6M_800K_SEL_MASK                            0x1
+#define VOW_1P6M_800K_SEL_MASK_SFT                        (0x1 << 14)
+#define VOW_DIGMIC_ON_SFT                                 13
+#define VOW_DIGMIC_ON_MASK                                0x1
+#define VOW_DIGMIC_ON_MASK_SFT                            (0x1 << 13)
+#define VOW_CK_DIV_RST_SFT                                12
+#define VOW_CK_DIV_RST_MASK                               0x1
+#define VOW_CK_DIV_RST_MASK_SFT                           (0x1 << 12)
+#define VOW_ON_SFT                                        11
+#define VOW_ON_MASK                                       0x1
+#define VOW_ON_MASK_SFT                                   (0x1 << 11)
+#define VOW_DIGMIC_CK_PHASE_SEL_SFT                       8
+#define VOW_DIGMIC_CK_PHASE_SEL_MASK                      0x7
+#define VOW_DIGMIC_CK_PHASE_SEL_MASK_SFT                  (0x7 << 8)
+#define MAIN_DMIC_CK_VOW_SEL_SFT                          7
+#define MAIN_DMIC_CK_VOW_SEL_MASK                         0x1
+#define MAIN_DMIC_CK_VOW_SEL_MASK_SFT                     (0x1 << 7)
+#define VOW_SDM_3_LEVEL_SFT                               6
+#define VOW_SDM_3_LEVEL_MASK                              0x1
+#define VOW_SDM_3_LEVEL_MASK_SFT                          (0x1 << 6)
+#define VOW_LOOP_BACK_MODE_SFT                            5
+#define VOW_LOOP_BACK_MODE_MASK                           0x1
+#define VOW_LOOP_BACK_MODE_MASK_SFT                       (0x1 << 5)
+#define VOW_INTR_SOURCE_SEL_SFT                           4
+#define VOW_INTR_SOURCE_SEL_MASK                          0x1
+#define VOW_INTR_SOURCE_SEL_MASK_SFT                      (0x1 << 4)
+#define VOW_INTR_CLR_SFT                                  3
+#define VOW_INTR_CLR_MASK                                 0x1
+#define VOW_INTR_CLR_MASK_SFT                             (0x1 << 3)
+#define S_N_VALUE_RST_SFT                                 2
+#define S_N_VALUE_RST_MASK                                0x1
+#define S_N_VALUE_RST_MASK_SFT                            (0x1 << 2)
+#define SAMPLE_BASE_MODE_SFT                              1
+#define SAMPLE_BASE_MODE_MASK                             0x1
+#define SAMPLE_BASE_MODE_MASK_SFT                         (0x1 << 1)
+#define VOW_INTR_FLAG_SFT                                 0
+#define VOW_INTR_FLAG_MASK                                0x1
+#define VOW_INTR_FLAG_MASK_SFT                            (0x1 << 0)
+
+/* MT6358_AFE_VOW_CFG0 */
+#define AMPREF_SFT                                        0
+#define AMPREF_MASK                                       0xffff
+#define AMPREF_MASK_SFT                                   (0xffff << 0)
+
+/* MT6358_AFE_VOW_CFG1 */
+#define TIMERINI_SFT                                      0
+#define TIMERINI_MASK                                     0xffff
+#define TIMERINI_MASK_SFT                                 (0xffff << 0)
+
+/* MT6358_AFE_VOW_CFG2 */
+#define B_DEFAULT_SFT                                     12
+#define B_DEFAULT_MASK                                    0x7
+#define B_DEFAULT_MASK_SFT                                (0x7 << 12)
+#define A_DEFAULT_SFT                                     8
+#define A_DEFAULT_MASK                                    0x7
+#define A_DEFAULT_MASK_SFT                                (0x7 << 8)
+#define B_INI_SFT                                         4
+#define B_INI_MASK                                        0x7
+#define B_INI_MASK_SFT                                    (0x7 << 4)
+#define A_INI_SFT                                         0
+#define A_INI_MASK                                        0x7
+#define A_INI_MASK_SFT                                    (0x7 << 0)
+
+/* MT6358_AFE_VOW_CFG3 */
+#define K_BETA_RISE_SFT                                   12
+#define K_BETA_RISE_MASK                                  0xf
+#define K_BETA_RISE_MASK_SFT                              (0xf << 12)
+#define K_BETA_FALL_SFT                                   8
+#define K_BETA_FALL_MASK                                  0xf
+#define K_BETA_FALL_MASK_SFT                              (0xf << 8)
+#define K_ALPHA_RISE_SFT                                  4
+#define K_ALPHA_RISE_MASK                                 0xf
+#define K_ALPHA_RISE_MASK_SFT                             (0xf << 4)
+#define K_ALPHA_FALL_SFT                                  0
+#define K_ALPHA_FALL_MASK                                 0xf
+#define K_ALPHA_FALL_MASK_SFT                             (0xf << 0)
+
+/* MT6358_AFE_VOW_CFG4 */
+#define VOW_TXIF_SCK_INV_SFT                              15
+#define VOW_TXIF_SCK_INV_MASK                             0x1
+#define VOW_TXIF_SCK_INV_MASK_SFT                         (0x1 << 15)
+#define VOW_ADC_TESTCK_SRC_SEL_SFT                        12
+#define VOW_ADC_TESTCK_SRC_SEL_MASK                       0x7
+#define VOW_ADC_TESTCK_SRC_SEL_MASK_SFT                   (0x7 << 12)
+#define VOW_ADC_TESTCK_SEL_SFT                            11
+#define VOW_ADC_TESTCK_SEL_MASK                           0x1
+#define VOW_ADC_TESTCK_SEL_MASK_SFT                       (0x1 << 11)
+#define VOW_ADC_CLK_INV_SFT                               10
+#define VOW_ADC_CLK_INV_MASK                              0x1
+#define VOW_ADC_CLK_INV_MASK_SFT                          (0x1 << 10)
+#define VOW_TXIF_MONO_SFT                                 9
+#define VOW_TXIF_MONO_MASK                                0x1
+#define VOW_TXIF_MONO_MASK_SFT                            (0x1 << 9)
+#define VOW_TXIF_SCK_DIV_SFT                              4
+#define VOW_TXIF_SCK_DIV_MASK                             0x1f
+#define VOW_TXIF_SCK_DIV_MASK_SFT                         (0x1f << 4)
+#define K_GAMMA_SFT                                       0
+#define K_GAMMA_MASK                                      0xf
+#define K_GAMMA_MASK_SFT                                  (0xf << 0)
+
+/* MT6358_AFE_VOW_CFG5 */
+#define N_MIN_SFT                                         0
+#define N_MIN_MASK                                        0xffff
+#define N_MIN_MASK_SFT                                    (0xffff << 0)
+
+/* MT6358_AFE_VOW_CFG6 */
+#define RG_WINDOW_SIZE_SEL_SFT                            12
+#define RG_WINDOW_SIZE_SEL_MASK                           0x1
+#define RG_WINDOW_SIZE_SEL_MASK_SFT                       (0x1 << 12)
+#define RG_FLR_BYPASS_SFT                                 11
+#define RG_FLR_BYPASS_MASK                                0x1
+#define RG_FLR_BYPASS_MASK_SFT                            (0x1 << 11)
+#define RG_FLR_RATIO_SFT                                  8
+#define RG_FLR_RATIO_MASK                                 0x7
+#define RG_FLR_RATIO_MASK_SFT                             (0x7 << 8)
+#define RG_BUCK_DVFS_DONE_SW_CTL_SFT                      7
+#define RG_BUCK_DVFS_DONE_SW_CTL_MASK                     0x1
+#define RG_BUCK_DVFS_DONE_SW_CTL_MASK_SFT                 (0x1 << 7)
+#define RG_BUCK_DVFS_DONE_HW_MODE_SFT                     6
+#define RG_BUCK_DVFS_DONE_HW_MODE_MASK                    0x1
+#define RG_BUCK_DVFS_DONE_HW_MODE_MASK_SFT                (0x1 << 6)
+#define RG_BUCK_DVFS_HW_CNT_THR_SFT                       0
+#define RG_BUCK_DVFS_HW_CNT_THR_MASK                      0x3f
+#define RG_BUCK_DVFS_HW_CNT_THR_MASK_SFT                  (0x3f << 0)
+
+/* MT6358_AFE_VOW_MON0 */
+#define VOW_DOWNCNT_SFT                                   0
+#define VOW_DOWNCNT_MASK                                  0xffff
+#define VOW_DOWNCNT_MASK_SFT                              (0xffff << 0)
+
+/* MT6358_AFE_VOW_MON1 */
+#define K_TMP_MON_SFT                                     10
+#define K_TMP_MON_MASK                                    0xf
+#define K_TMP_MON_MASK_SFT                                (0xf << 10)
+#define SLT_COUNTER_MON_SFT                               7
+#define SLT_COUNTER_MON_MASK                              0x7
+#define SLT_COUNTER_MON_MASK_SFT                          (0x7 << 7)
+#define VOW_B_SFT                                         4
+#define VOW_B_MASK                                        0x7
+#define VOW_B_MASK_SFT                                    (0x7 << 4)
+#define VOW_A_SFT                                         1
+#define VOW_A_MASK                                        0x7
+#define VOW_A_MASK_SFT                                    (0x7 << 1)
+#define SECOND_CNT_START_SFT                              0
+#define SECOND_CNT_START_MASK                             0x1
+#define SECOND_CNT_START_MASK_SFT                         (0x1 << 0)
+
+/* MT6358_AFE_VOW_MON2 */
+#define VOW_S_L_SFT                                       0
+#define VOW_S_L_MASK                                      0xffff
+#define VOW_S_L_MASK_SFT                                  (0xffff << 0)
+
+/* MT6358_AFE_VOW_MON3 */
+#define VOW_S_H_SFT                                       0
+#define VOW_S_H_MASK                                      0xffff
+#define VOW_S_H_MASK_SFT                                  (0xffff << 0)
+
+/* MT6358_AFE_VOW_MON4 */
+#define VOW_N_L_SFT                                       0
+#define VOW_N_L_MASK                                      0xffff
+#define VOW_N_L_MASK_SFT                                  (0xffff << 0)
+
+/* MT6358_AFE_VOW_MON5 */
+#define VOW_N_H_SFT                                       0
+#define VOW_N_H_MASK                                      0xffff
+#define VOW_N_H_MASK_SFT                                  (0xffff << 0)
+
+/* MT6358_AFE_VOW_SN_INI_CFG */
+#define VOW_SN_INI_CFG_EN_SFT                             15
+#define VOW_SN_INI_CFG_EN_MASK                            0x1
+#define VOW_SN_INI_CFG_EN_MASK_SFT                        (0x1 << 15)
+#define VOW_SN_INI_CFG_VAL_SFT                            0
+#define VOW_SN_INI_CFG_VAL_MASK                           0x7fff
+#define VOW_SN_INI_CFG_VAL_MASK_SFT                       (0x7fff << 0)
+
+/* MT6358_AFE_VOW_TGEN_CFG0 */
+#define VOW_TGEN_EN_SFT                                   15
+#define VOW_TGEN_EN_MASK                                  0x1
+#define VOW_TGEN_EN_MASK_SFT                              (0x1 << 15)
+#define VOW_TGEN_MUTE_SW_SFT                              14
+#define VOW_TGEN_MUTE_SW_MASK                             0x1
+#define VOW_TGEN_MUTE_SW_MASK_SFT                         (0x1 << 14)
+#define VOW_TGEN_FREQ_DIV_SFT                             0
+#define VOW_TGEN_FREQ_DIV_MASK                            0x3fff
+#define VOW_TGEN_FREQ_DIV_MASK_SFT                        (0x3fff << 0)
+
+/* MT6358_AFE_VOW_POSDIV_CFG0 */
+#define BUCK_DVFS_DONE_SFT                                15
+#define BUCK_DVFS_DONE_MASK                               0x1
+#define BUCK_DVFS_DONE_MASK_SFT                           (0x1 << 15)
+#define VOW_32K_MODE_SFT                                  13
+#define VOW_32K_MODE_MASK                                 0x1
+#define VOW_32K_MODE_MASK_SFT                             (0x1 << 13)
+#define RG_BUCK_CLK_DIV_SFT                               8
+#define RG_BUCK_CLK_DIV_MASK                              0x1f
+#define RG_BUCK_CLK_DIV_MASK_SFT                          (0x1f << 8)
+#define RG_A1P6M_EN_SEL_SFT                               7
+#define RG_A1P6M_EN_SEL_MASK                              0x1
+#define RG_A1P6M_EN_SEL_MASK_SFT                          (0x1 << 7)
+#define VOW_CLK_SEL_SFT                                   6
+#define VOW_CLK_SEL_MASK                                  0x1
+#define VOW_CLK_SEL_MASK_SFT                              (0x1 << 6)
+#define VOW_INTR_SW_MODE_SFT                              5
+#define VOW_INTR_SW_MODE_MASK                             0x1
+#define VOW_INTR_SW_MODE_MASK_SFT                         (0x1 << 5)
+#define VOW_INTR_SW_VAL_SFT                               4
+#define VOW_INTR_SW_VAL_MASK                              0x1
+#define VOW_INTR_SW_VAL_MASK_SFT                          (0x1 << 4)
+#define VOW_CIC_MODE_SEL_SFT                              2
+#define VOW_CIC_MODE_SEL_MASK                             0x3
+#define VOW_CIC_MODE_SEL_MASK_SFT                         (0x3 << 2)
+#define RG_VOW_POSDIV_SFT                                 0
+#define RG_VOW_POSDIV_MASK                                0x3
+#define RG_VOW_POSDIV_MASK_SFT                            (0x3 << 0)
+
+/* MT6358_AFE_VOW_HPF_CFG0 */
+#define VOW_HPF_DC_TEST_SFT                               12
+#define VOW_HPF_DC_TEST_MASK                              0xf
+#define VOW_HPF_DC_TEST_MASK_SFT                          (0xf << 12)
+#define VOW_IRQ_LATCH_SNR_EN_SFT                          10
+#define VOW_IRQ_LATCH_SNR_EN_MASK                         0x1
+#define VOW_IRQ_LATCH_SNR_EN_MASK_SFT                     (0x1 << 10)
+#define VOW_DMICCLK_PDN_SFT                               9
+#define VOW_DMICCLK_PDN_MASK                              0x1
+#define VOW_DMICCLK_PDN_MASK_SFT                          (0x1 << 9)
+#define VOW_POSDIVCLK_PDN_SFT                             8
+#define VOW_POSDIVCLK_PDN_MASK                            0x1
+#define VOW_POSDIVCLK_PDN_MASK_SFT                        (0x1 << 8)
+#define RG_BASELINE_ALPHA_ORDER_SFT                       4
+#define RG_BASELINE_ALPHA_ORDER_MASK                      0xf
+#define RG_BASELINE_ALPHA_ORDER_MASK_SFT                  (0xf << 4)
+#define RG_MTKAIF_HPF_BYPASS_SFT                          2
+#define RG_MTKAIF_HPF_BYPASS_MASK                         0x1
+#define RG_MTKAIF_HPF_BYPASS_MASK_SFT                     (0x1 << 2)
+#define RG_SNRDET_HPF_BYPASS_SFT                          1
+#define RG_SNRDET_HPF_BYPASS_MASK                         0x1
+#define RG_SNRDET_HPF_BYPASS_MASK_SFT                     (0x1 << 1)
+#define RG_HPF_ON_SFT                                     0
+#define RG_HPF_ON_MASK                                    0x1
+#define RG_HPF_ON_MASK_SFT                                (0x1 << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG0 */
+#define RG_PERIODIC_EN_SFT                                15
+#define RG_PERIODIC_EN_MASK                               0x1
+#define RG_PERIODIC_EN_MASK_SFT                           (0x1 << 15)
+#define RG_PERIODIC_CNT_CLR_SFT                           14
+#define RG_PERIODIC_CNT_CLR_MASK                          0x1
+#define RG_PERIODIC_CNT_CLR_MASK_SFT                      (0x1 << 14)
+#define RG_PERIODIC_CNT_PERIOD_SFT                        0
+#define RG_PERIODIC_CNT_PERIOD_MASK                       0x3fff
+#define RG_PERIODIC_CNT_PERIOD_MASK_SFT                   (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG1 */
+#define RG_PERIODIC_CNT_SET_SFT                           15
+#define RG_PERIODIC_CNT_SET_MASK                          0x1
+#define RG_PERIODIC_CNT_SET_MASK_SFT                      (0x1 << 15)
+#define RG_PERIODIC_CNT_PAUSE_SFT                         14
+#define RG_PERIODIC_CNT_PAUSE_MASK                        0x1
+#define RG_PERIODIC_CNT_PAUSE_MASK_SFT                    (0x1 << 14)
+#define RG_PERIODIC_CNT_SET_VALUE_SFT                     0
+#define RG_PERIODIC_CNT_SET_VALUE_MASK                    0x3fff
+#define RG_PERIODIC_CNT_SET_VALUE_MASK_SFT                (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG2 */
+#define AUDPREAMPLON_PERIODIC_MODE_SFT                    15
+#define AUDPREAMPLON_PERIODIC_MODE_MASK                   0x1
+#define AUDPREAMPLON_PERIODIC_MODE_MASK_SFT               (0x1 << 15)
+#define AUDPREAMPLON_PERIODIC_INVERSE_SFT                 14
+#define AUDPREAMPLON_PERIODIC_INVERSE_MASK                0x1
+#define AUDPREAMPLON_PERIODIC_INVERSE_MASK_SFT            (0x1 << 14)
+#define AUDPREAMPLON_PERIODIC_ON_CYCLE_SFT                0
+#define AUDPREAMPLON_PERIODIC_ON_CYCLE_MASK               0x3fff
+#define AUDPREAMPLON_PERIODIC_ON_CYCLE_MASK_SFT           (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG3 */
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_MODE_SFT           15
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_MODE_MASK          0x1
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_MODE_MASK_SFT      (0x1 << 15)
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_INVERSE_SFT        14
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_INVERSE_MASK       0x1
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_INVERSE_MASK_SFT   (0x1 << 14)
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_ON_CYCLE_SFT       0
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_ON_CYCLE_MASK      0x3fff
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_ON_CYCLE_MASK_SFT  (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG4 */
+#define AUDADCLPWRUP_PERIODIC_MODE_SFT                    15
+#define AUDADCLPWRUP_PERIODIC_MODE_MASK                   0x1
+#define AUDADCLPWRUP_PERIODIC_MODE_MASK_SFT               (0x1 << 15)
+#define AUDADCLPWRUP_PERIODIC_INVERSE_SFT                 14
+#define AUDADCLPWRUP_PERIODIC_INVERSE_MASK                0x1
+#define AUDADCLPWRUP_PERIODIC_INVERSE_MASK_SFT            (0x1 << 14)
+#define AUDADCLPWRUP_PERIODIC_ON_CYCLE_SFT                0
+#define AUDADCLPWRUP_PERIODIC_ON_CYCLE_MASK               0x3fff
+#define AUDADCLPWRUP_PERIODIC_ON_CYCLE_MASK_SFT           (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG5 */
+#define AUDGLBVOWLPWEN_PERIODIC_MODE_SFT                  15
+#define AUDGLBVOWLPWEN_PERIODIC_MODE_MASK                 0x1
+#define AUDGLBVOWLPWEN_PERIODIC_MODE_MASK_SFT             (0x1 << 15)
+#define AUDGLBVOWLPWEN_PERIODIC_INVERSE_SFT               14
+#define AUDGLBVOWLPWEN_PERIODIC_INVERSE_MASK              0x1
+#define AUDGLBVOWLPWEN_PERIODIC_INVERSE_MASK_SFT          (0x1 << 14)
+#define AUDGLBVOWLPWEN_PERIODIC_ON_CYCLE_SFT              0
+#define AUDGLBVOWLPWEN_PERIODIC_ON_CYCLE_MASK             0x3fff
+#define AUDGLBVOWLPWEN_PERIODIC_ON_CYCLE_MASK_SFT         (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG6 */
+#define AUDDIGMICEN_PERIODIC_MODE_SFT                     15
+#define AUDDIGMICEN_PERIODIC_MODE_MASK                    0x1
+#define AUDDIGMICEN_PERIODIC_MODE_MASK_SFT                (0x1 << 15)
+#define AUDDIGMICEN_PERIODIC_INVERSE_SFT                  14
+#define AUDDIGMICEN_PERIODIC_INVERSE_MASK                 0x1
+#define AUDDIGMICEN_PERIODIC_INVERSE_MASK_SFT             (0x1 << 14)
+#define AUDDIGMICEN_PERIODIC_ON_CYCLE_SFT                 0
+#define AUDDIGMICEN_PERIODIC_ON_CYCLE_MASK                0x3fff
+#define AUDDIGMICEN_PERIODIC_ON_CYCLE_MASK_SFT            (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG7 */
+#define AUDPWDBMICBIAS0_PERIODIC_MODE_SFT                 15
+#define AUDPWDBMICBIAS0_PERIODIC_MODE_MASK                0x1
+#define AUDPWDBMICBIAS0_PERIODIC_MODE_MASK_SFT            (0x1 << 15)
+#define AUDPWDBMICBIAS0_PERIODIC_INVERSE_SFT              14
+#define AUDPWDBMICBIAS0_PERIODIC_INVERSE_MASK             0x1
+#define AUDPWDBMICBIAS0_PERIODIC_INVERSE_MASK_SFT         (0x1 << 14)
+#define AUDPWDBMICBIAS0_PERIODIC_ON_CYCLE_SFT             0
+#define AUDPWDBMICBIAS0_PERIODIC_ON_CYCLE_MASK            0x3fff
+#define AUDPWDBMICBIAS0_PERIODIC_ON_CYCLE_MASK_SFT        (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG8 */
+#define AUDPWDBMICBIAS1_PERIODIC_MODE_SFT                 15
+#define AUDPWDBMICBIAS1_PERIODIC_MODE_MASK                0x1
+#define AUDPWDBMICBIAS1_PERIODIC_MODE_MASK_SFT            (0x1 << 15)
+#define AUDPWDBMICBIAS1_PERIODIC_INVERSE_SFT              14
+#define AUDPWDBMICBIAS1_PERIODIC_INVERSE_MASK             0x1
+#define AUDPWDBMICBIAS1_PERIODIC_INVERSE_MASK_SFT         (0x1 << 14)
+#define AUDPWDBMICBIAS1_PERIODIC_ON_CYCLE_SFT             0
+#define AUDPWDBMICBIAS1_PERIODIC_ON_CYCLE_MASK            0x3fff
+#define AUDPWDBMICBIAS1_PERIODIC_ON_CYCLE_MASK_SFT        (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG9 */
+#define XO_VOW_CK_EN_PERIODIC_MODE_SFT                    15
+#define XO_VOW_CK_EN_PERIODIC_MODE_MASK                   0x1
+#define XO_VOW_CK_EN_PERIODIC_MODE_MASK_SFT               (0x1 << 15)
+#define XO_VOW_CK_EN_PERIODIC_INVERSE_SFT                 14
+#define XO_VOW_CK_EN_PERIODIC_INVERSE_MASK                0x1
+#define XO_VOW_CK_EN_PERIODIC_INVERSE_MASK_SFT            (0x1 << 14)
+#define XO_VOW_CK_EN_PERIODIC_ON_CYCLE_SFT                0
+#define XO_VOW_CK_EN_PERIODIC_ON_CYCLE_MASK               0x3fff
+#define XO_VOW_CK_EN_PERIODIC_ON_CYCLE_MASK_SFT           (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG10 */
+#define AUDGLB_PWRDN_PERIODIC_MODE_SFT                    15
+#define AUDGLB_PWRDN_PERIODIC_MODE_MASK                   0x1
+#define AUDGLB_PWRDN_PERIODIC_MODE_MASK_SFT               (0x1 << 15)
+#define AUDGLB_PWRDN_PERIODIC_INVERSE_SFT                 14
+#define AUDGLB_PWRDN_PERIODIC_INVERSE_MASK                0x1
+#define AUDGLB_PWRDN_PERIODIC_INVERSE_MASK_SFT            (0x1 << 14)
+#define AUDGLB_PWRDN_PERIODIC_ON_CYCLE_SFT                0
+#define AUDGLB_PWRDN_PERIODIC_ON_CYCLE_MASK               0x3fff
+#define AUDGLB_PWRDN_PERIODIC_ON_CYCLE_MASK_SFT           (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG11 */
+#define VOW_ON_PERIODIC_MODE_SFT                          15
+#define VOW_ON_PERIODIC_MODE_MASK                         0x1
+#define VOW_ON_PERIODIC_MODE_MASK_SFT                     (0x1 << 15)
+#define VOW_ON_PERIODIC_INVERSE_SFT                       14
+#define VOW_ON_PERIODIC_INVERSE_MASK                      0x1
+#define VOW_ON_PERIODIC_INVERSE_MASK_SFT                  (0x1 << 14)
+#define VOW_ON_PERIODIC_ON_CYCLE_SFT                      0
+#define VOW_ON_PERIODIC_ON_CYCLE_MASK                     0x3fff
+#define VOW_ON_PERIODIC_ON_CYCLE_MASK_SFT                 (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG12 */
+#define DMIC_ON_PERIODIC_MODE_SFT                         15
+#define DMIC_ON_PERIODIC_MODE_MASK                        0x1
+#define DMIC_ON_PERIODIC_MODE_MASK_SFT                    (0x1 << 15)
+#define DMIC_ON_PERIODIC_INVERSE_SFT                      14
+#define DMIC_ON_PERIODIC_INVERSE_MASK                     0x1
+#define DMIC_ON_PERIODIC_INVERSE_MASK_SFT                 (0x1 << 14)
+#define DMIC_ON_PERIODIC_ON_CYCLE_SFT                     0
+#define DMIC_ON_PERIODIC_ON_CYCLE_MASK                    0x3fff
+#define DMIC_ON_PERIODIC_ON_CYCLE_MASK_SFT                (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG13 */
+#define PDN_VOW_F32K_CK_SFT                               15
+#define PDN_VOW_F32K_CK_MASK                              0x1
+#define PDN_VOW_F32K_CK_MASK_SFT                          (0x1 << 15)
+#define AUDPREAMPLON_PERIODIC_OFF_CYCLE_SFT               0
+#define AUDPREAMPLON_PERIODIC_OFF_CYCLE_MASK              0x3fff
+#define AUDPREAMPLON_PERIODIC_OFF_CYCLE_MASK_SFT          (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG14 */
+#define VOW_SNRDET_PERIODIC_CFG_SFT                       15
+#define VOW_SNRDET_PERIODIC_CFG_MASK                      0x1
+#define VOW_SNRDET_PERIODIC_CFG_MASK_SFT                  (0x1 << 15)
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_OFF_CYCLE_SFT      0
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_OFF_CYCLE_MASK     0x3fff
+#define AUDPREAMPLDCPRECHARGE_PERIODIC_OFF_CYCLE_MASK_SFT (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG15 */
+#define AUDADCLPWRUP_PERIODIC_OFF_CYCLE_SFT               0
+#define AUDADCLPWRUP_PERIODIC_OFF_CYCLE_MASK              0x3fff
+#define AUDADCLPWRUP_PERIODIC_OFF_CYCLE_MASK_SFT          (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG16 */
+#define AUDGLBVOWLPWEN_PERIODIC_OFF_CYCLE_SFT             0
+#define AUDGLBVOWLPWEN_PERIODIC_OFF_CYCLE_MASK            0x3fff
+#define AUDGLBVOWLPWEN_PERIODIC_OFF_CYCLE_MASK_SFT        (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG17 */
+#define AUDDIGMICEN_PERIODIC_OFF_CYCLE_SFT                0
+#define AUDDIGMICEN_PERIODIC_OFF_CYCLE_MASK               0x3fff
+#define AUDDIGMICEN_PERIODIC_OFF_CYCLE_MASK_SFT           (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG18 */
+#define AUDPWDBMICBIAS0_PERIODIC_OFF_CYCLE_SFT            0
+#define AUDPWDBMICBIAS0_PERIODIC_OFF_CYCLE_MASK           0x3fff
+#define AUDPWDBMICBIAS0_PERIODIC_OFF_CYCLE_MASK_SFT       (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG19 */
+#define AUDPWDBMICBIAS1_PERIODIC_OFF_CYCLE_SFT            0
+#define AUDPWDBMICBIAS1_PERIODIC_OFF_CYCLE_MASK           0x3fff
+#define AUDPWDBMICBIAS1_PERIODIC_OFF_CYCLE_MASK_SFT       (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG20 */
+#define CLKSQ_EN_VOW_PERIODIC_MODE_SFT                    15
+#define CLKSQ_EN_VOW_PERIODIC_MODE_MASK                   0x1
+#define CLKSQ_EN_VOW_PERIODIC_MODE_MASK_SFT               (0x1 << 15)
+#define XO_VOW_CK_EN_PERIODIC_OFF_CYCLE_SFT               0
+#define XO_VOW_CK_EN_PERIODIC_OFF_CYCLE_MASK              0x3fff
+#define XO_VOW_CK_EN_PERIODIC_OFF_CYCLE_MASK_SFT          (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG21 */
+#define AUDGLB_PWRDN_PERIODIC_OFF_CYCLE_SFT               0
+#define AUDGLB_PWRDN_PERIODIC_OFF_CYCLE_MASK              0x3fff
+#define AUDGLB_PWRDN_PERIODIC_OFF_CYCLE_MASK_SFT          (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG22 */
+#define VOW_ON_PERIODIC_OFF_CYCLE_SFT                     0
+#define VOW_ON_PERIODIC_OFF_CYCLE_MASK                    0x3fff
+#define VOW_ON_PERIODIC_OFF_CYCLE_MASK_SFT                (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_CFG23 */
+#define DMIC_ON_PERIODIC_OFF_CYCLE_SFT                    0
+#define DMIC_ON_PERIODIC_OFF_CYCLE_MASK                   0x3fff
+#define DMIC_ON_PERIODIC_OFF_CYCLE_MASK_SFT               (0x3fff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_MON0 */
+#define VOW_PERIODIC_MON_SFT                              0
+#define VOW_PERIODIC_MON_MASK                             0xffff
+#define VOW_PERIODIC_MON_MASK_SFT                         (0xffff << 0)
+
+/* MT6358_AFE_VOW_PERIODIC_MON1 */
+#define VOW_PERIODIC_COUNT_MON_SFT                        0
+#define VOW_PERIODIC_COUNT_MON_MASK                       0xffff
+#define VOW_PERIODIC_COUNT_MON_MASK_SFT                   (0xffff << 0)
+
+/* MT6358_AUDENC_DSN_ID */
+#define AUDENC_ANA_ID_SFT                                 0
+#define AUDENC_ANA_ID_MASK                                0xff
+#define AUDENC_ANA_ID_MASK_SFT                            (0xff << 0)
+#define AUDENC_DIG_ID_SFT                                 8
+#define AUDENC_DIG_ID_MASK                                0xff
+#define AUDENC_DIG_ID_MASK_SFT                            (0xff << 8)
+
+/* MT6358_AUDENC_DSN_REV0 */
+#define AUDENC_ANA_MINOR_REV_SFT                          0
+#define AUDENC_ANA_MINOR_REV_MASK                         0xf
+#define AUDENC_ANA_MINOR_REV_MASK_SFT                     (0xf << 0)
+#define AUDENC_ANA_MAJOR_REV_SFT                          4
+#define AUDENC_ANA_MAJOR_REV_MASK                         0xf
+#define AUDENC_ANA_MAJOR_REV_MASK_SFT                     (0xf << 4)
+#define AUDENC_DIG_MINOR_REV_SFT                          8
+#define AUDENC_DIG_MINOR_REV_MASK                         0xf
+#define AUDENC_DIG_MINOR_REV_MASK_SFT                     (0xf << 8)
+#define AUDENC_DIG_MAJOR_REV_SFT                          12
+#define AUDENC_DIG_MAJOR_REV_MASK                         0xf
+#define AUDENC_DIG_MAJOR_REV_MASK_SFT                     (0xf << 12)
+
+/* MT6358_AUDENC_DSN_DBI */
+#define AUDENC_DSN_CBS_SFT                                0
+#define AUDENC_DSN_CBS_MASK                               0x3
+#define AUDENC_DSN_CBS_MASK_SFT                           (0x3 << 0)
+#define AUDENC_DSN_BIX_SFT                                2
+#define AUDENC_DSN_BIX_MASK                               0x3
+#define AUDENC_DSN_BIX_MASK_SFT                           (0x3 << 2)
+#define AUDENC_DSN_ESP_SFT                                8
+#define AUDENC_DSN_ESP_MASK                               0xff
+#define AUDENC_DSN_ESP_MASK_SFT                           (0xff << 8)
+
+/* MT6358_AUDENC_DSN_FPI */
+#define AUDENC_DSN_FPI_SFT                                0
+#define AUDENC_DSN_FPI_MASK                               0xff
+#define AUDENC_DSN_FPI_MASK_SFT                           (0xff << 0)
+
+/* MT6358_AUDENC_ANA_CON0 */
+#define RG_AUDPREAMPLON_SFT                               0
+#define RG_AUDPREAMPLON_MASK                              0x1
+#define RG_AUDPREAMPLON_MASK_SFT                          (0x1 << 0)
+#define RG_AUDPREAMPLDCCEN_SFT                            1
+#define RG_AUDPREAMPLDCCEN_MASK                           0x1
+#define RG_AUDPREAMPLDCCEN_MASK_SFT                       (0x1 << 1)
+#define RG_AUDPREAMPLDCPRECHARGE_SFT                      2
+#define RG_AUDPREAMPLDCPRECHARGE_MASK                     0x1
+#define RG_AUDPREAMPLDCPRECHARGE_MASK_SFT                 (0x1 << 2)
+#define RG_AUDPREAMPLPGATEST_SFT                          3
+#define RG_AUDPREAMPLPGATEST_MASK                         0x1
+#define RG_AUDPREAMPLPGATEST_MASK_SFT                     (0x1 << 3)
+#define RG_AUDPREAMPLVSCALE_SFT                           4
+#define RG_AUDPREAMPLVSCALE_MASK                          0x3
+#define RG_AUDPREAMPLVSCALE_MASK_SFT                      (0x3 << 4)
+#define RG_AUDPREAMPLINPUTSEL_SFT                         6
+#define RG_AUDPREAMPLINPUTSEL_MASK                        0x3
+#define RG_AUDPREAMPLINPUTSEL_MASK_SFT                    (0x3 << 6)
+#define RG_AUDPREAMPLGAIN_SFT                             8
+#define RG_AUDPREAMPLGAIN_MASK                            0x7
+#define RG_AUDPREAMPLGAIN_MASK_SFT                        (0x7 << 8)
+#define RG_AUDADCLPWRUP_SFT                               12
+#define RG_AUDADCLPWRUP_MASK                              0x1
+#define RG_AUDADCLPWRUP_MASK_SFT                          (0x1 << 12)
+#define RG_AUDADCLINPUTSEL_SFT                            13
+#define RG_AUDADCLINPUTSEL_MASK                           0x3
+#define RG_AUDADCLINPUTSEL_MASK_SFT                       (0x3 << 13)
+
+/* MT6358_AUDENC_ANA_CON1 */
+#define RG_AUDPREAMPRON_SFT                               0
+#define RG_AUDPREAMPRON_MASK                              0x1
+#define RG_AUDPREAMPRON_MASK_SFT                          (0x1 << 0)
+#define RG_AUDPREAMPRDCCEN_SFT                            1
+#define RG_AUDPREAMPRDCCEN_MASK                           0x1
+#define RG_AUDPREAMPRDCCEN_MASK_SFT                       (0x1 << 1)
+#define RG_AUDPREAMPRDCPRECHARGE_SFT                      2
+#define RG_AUDPREAMPRDCPRECHARGE_MASK                     0x1
+#define RG_AUDPREAMPRDCPRECHARGE_MASK_SFT                 (0x1 << 2)
+#define RG_AUDPREAMPRPGATEST_SFT                          3
+#define RG_AUDPREAMPRPGATEST_MASK                         0x1
+#define RG_AUDPREAMPRPGATEST_MASK_SFT                     (0x1 << 3)
+#define RG_AUDPREAMPRVSCALE_SFT                           4
+#define RG_AUDPREAMPRVSCALE_MASK                          0x3
+#define RG_AUDPREAMPRVSCALE_MASK_SFT                      (0x3 << 4)
+#define RG_AUDPREAMPRINPUTSEL_SFT                         6
+#define RG_AUDPREAMPRINPUTSEL_MASK                        0x3
+#define RG_AUDPREAMPRINPUTSEL_MASK_SFT                    (0x3 << 6)
+#define RG_AUDPREAMPRGAIN_SFT                             8
+#define RG_AUDPREAMPRGAIN_MASK                            0x7
+#define RG_AUDPREAMPRGAIN_MASK_SFT                        (0x7 << 8)
+#define RG_AUDIO_VOW_EN_SFT                               11
+#define RG_AUDIO_VOW_EN_MASK                              0x1
+#define RG_AUDIO_VOW_EN_MASK_SFT                          (0x1 << 11)
+#define RG_AUDADCRPWRUP_SFT                               12
+#define RG_AUDADCRPWRUP_MASK                              0x1
+#define RG_AUDADCRPWRUP_MASK_SFT                          (0x1 << 12)
+#define RG_AUDADCRINPUTSEL_SFT                            13
+#define RG_AUDADCRINPUTSEL_MASK                           0x3
+#define RG_AUDADCRINPUTSEL_MASK_SFT                       (0x3 << 13)
+#define RG_CLKSQ_EN_VOW_SFT                               15
+#define RG_CLKSQ_EN_VOW_MASK                              0x1
+#define RG_CLKSQ_EN_VOW_MASK_SFT                          (0x1 << 15)
+
+/* MT6358_AUDENC_ANA_CON2 */
+#define RG_AUDULHALFBIAS_SFT                              0
+#define RG_AUDULHALFBIAS_MASK                             0x1
+#define RG_AUDULHALFBIAS_MASK_SFT                         (0x1 << 0)
+#define RG_AUDGLBVOWLPWEN_SFT                             1
+#define RG_AUDGLBVOWLPWEN_MASK                            0x1
+#define RG_AUDGLBVOWLPWEN_MASK_SFT                        (0x1 << 1)
+#define RG_AUDPREAMPLPEN_SFT                              2
+#define RG_AUDPREAMPLPEN_MASK                             0x1
+#define RG_AUDPREAMPLPEN_MASK_SFT                         (0x1 << 2)
+#define RG_AUDADC1STSTAGELPEN_SFT                         3
+#define RG_AUDADC1STSTAGELPEN_MASK                        0x1
+#define RG_AUDADC1STSTAGELPEN_MASK_SFT                    (0x1 << 3)
+#define RG_AUDADC2NDSTAGELPEN_SFT                         4
+#define RG_AUDADC2NDSTAGELPEN_MASK                        0x1
+#define RG_AUDADC2NDSTAGELPEN_MASK_SFT                    (0x1 << 4)
+#define RG_AUDADCFLASHLPEN_SFT                            5
+#define RG_AUDADCFLASHLPEN_MASK                           0x1
+#define RG_AUDADCFLASHLPEN_MASK_SFT                       (0x1 << 5)
+#define RG_AUDPREAMPIDDTEST_SFT                           6
+#define RG_AUDPREAMPIDDTEST_MASK                          0x3
+#define RG_AUDPREAMPIDDTEST_MASK_SFT                      (0x3 << 6)
+#define RG_AUDADC1STSTAGEIDDTEST_SFT                      8
+#define RG_AUDADC1STSTAGEIDDTEST_MASK                     0x3
+#define RG_AUDADC1STSTAGEIDDTEST_MASK_SFT                 (0x3 << 8)
+#define RG_AUDADC2NDSTAGEIDDTEST_SFT                      10
+#define RG_AUDADC2NDSTAGEIDDTEST_MASK                     0x3
+#define RG_AUDADC2NDSTAGEIDDTEST_MASK_SFT                 (0x3 << 10)
+#define RG_AUDADCREFBUFIDDTEST_SFT                        12
+#define RG_AUDADCREFBUFIDDTEST_MASK                       0x3
+#define RG_AUDADCREFBUFIDDTEST_MASK_SFT                   (0x3 << 12)
+#define RG_AUDADCFLASHIDDTEST_SFT                         14
+#define RG_AUDADCFLASHIDDTEST_MASK                        0x3
+#define RG_AUDADCFLASHIDDTEST_MASK_SFT                    (0x3 << 14)
+
+/* MT6358_AUDENC_ANA_CON3 */
+#define RG_AUDADCDAC0P25FS_SFT                            0
+#define RG_AUDADCDAC0P25FS_MASK                           0x1
+#define RG_AUDADCDAC0P25FS_MASK_SFT                       (0x1 << 0)
+#define RG_AUDADCCLKSEL_SFT                               1
+#define RG_AUDADCCLKSEL_MASK                              0x1
+#define RG_AUDADCCLKSEL_MASK_SFT                          (0x1 << 1)
+#define RG_AUDADCCLKSOURCE_SFT                            2
+#define RG_AUDADCCLKSOURCE_MASK                           0x3
+#define RG_AUDADCCLKSOURCE_MASK_SFT                       (0x3 << 2)
+#define RG_AUDPREAMPAAFEN_SFT                             8
+#define RG_AUDPREAMPAAFEN_MASK                            0x1
+#define RG_AUDPREAMPAAFEN_MASK_SFT                        (0x1 << 8)
+#define RG_DCCVCMBUFLPMODSEL_SFT                          9
+#define RG_DCCVCMBUFLPMODSEL_MASK                         0x1
+#define RG_DCCVCMBUFLPMODSEL_MASK_SFT                     (0x1 << 9)
+#define RG_DCCVCMBUFLPSWEN_SFT                            10
+#define RG_DCCVCMBUFLPSWEN_MASK                           0x1
+#define RG_DCCVCMBUFLPSWEN_MASK_SFT                       (0x1 << 10)
+#define RG_CMSTBENH_SFT                                   11
+#define RG_CMSTBENH_MASK                                  0x1
+#define RG_CMSTBENH_MASK_SFT                              (0x1 << 11)
+#define RG_PGABODYSW_SFT                                  12
+#define RG_PGABODYSW_MASK                                 0x1
+#define RG_PGABODYSW_MASK_SFT                             (0x1 << 12)
+
+/* MT6358_AUDENC_ANA_CON4 */
+#define RG_AUDADC1STSTAGESDENB_SFT                        0
+#define RG_AUDADC1STSTAGESDENB_MASK                       0x1
+#define RG_AUDADC1STSTAGESDENB_MASK_SFT                   (0x1 << 0)
+#define RG_AUDADC2NDSTAGERESET_SFT                        1
+#define RG_AUDADC2NDSTAGERESET_MASK                       0x1
+#define RG_AUDADC2NDSTAGERESET_MASK_SFT                   (0x1 << 1)
+#define RG_AUDADC3RDSTAGERESET_SFT                        2
+#define RG_AUDADC3RDSTAGERESET_MASK                       0x1
+#define RG_AUDADC3RDSTAGERESET_MASK_SFT                   (0x1 << 2)
+#define RG_AUDADCFSRESET_SFT                              3
+#define RG_AUDADCFSRESET_MASK                             0x1
+#define RG_AUDADCFSRESET_MASK_SFT                         (0x1 << 3)
+#define RG_AUDADCWIDECM_SFT                               4
+#define RG_AUDADCWIDECM_MASK                              0x1
+#define RG_AUDADCWIDECM_MASK_SFT                          (0x1 << 4)
+#define RG_AUDADCNOPATEST_SFT                             5
+#define RG_AUDADCNOPATEST_MASK                            0x1
+#define RG_AUDADCNOPATEST_MASK_SFT                        (0x1 << 5)
+#define RG_AUDADCBYPASS_SFT                               6
+#define RG_AUDADCBYPASS_MASK                              0x1
+#define RG_AUDADCBYPASS_MASK_SFT                          (0x1 << 6)
+#define RG_AUDADCFFBYPASS_SFT                             7
+#define RG_AUDADCFFBYPASS_MASK                            0x1
+#define RG_AUDADCFFBYPASS_MASK_SFT                        (0x1 << 7)
+#define RG_AUDADCDACFBCURRENT_SFT                         8
+#define RG_AUDADCDACFBCURRENT_MASK                        0x1
+#define RG_AUDADCDACFBCURRENT_MASK_SFT                    (0x1 << 8)
+#define RG_AUDADCDACIDDTEST_SFT                           9
+#define RG_AUDADCDACIDDTEST_MASK                          0x3
+#define RG_AUDADCDACIDDTEST_MASK_SFT                      (0x3 << 9)
+#define RG_AUDADCDACNRZ_SFT                               11
+#define RG_AUDADCDACNRZ_MASK                              0x1
+#define RG_AUDADCDACNRZ_MASK_SFT                          (0x1 << 11)
+#define RG_AUDADCNODEM_SFT                                12
+#define RG_AUDADCNODEM_MASK                               0x1
+#define RG_AUDADCNODEM_MASK_SFT                           (0x1 << 12)
+#define RG_AUDADCDACTEST_SFT                              13
+#define RG_AUDADCDACTEST_MASK                             0x1
+#define RG_AUDADCDACTEST_MASK_SFT                         (0x1 << 13)
+
+/* MT6358_AUDENC_ANA_CON5 */
+#define RG_AUDRCTUNEL_SFT                                 0
+#define RG_AUDRCTUNEL_MASK                                0x1f
+#define RG_AUDRCTUNEL_MASK_SFT                            (0x1f << 0)
+#define RG_AUDRCTUNELSEL_SFT                              5
+#define RG_AUDRCTUNELSEL_MASK                             0x1
+#define RG_AUDRCTUNELSEL_MASK_SFT                         (0x1 << 5)
+#define RG_AUDRCTUNER_SFT                                 8
+#define RG_AUDRCTUNER_MASK                                0x1f
+#define RG_AUDRCTUNER_MASK_SFT                            (0x1f << 8)
+#define RG_AUDRCTUNERSEL_SFT                              13
+#define RG_AUDRCTUNERSEL_MASK                             0x1
+#define RG_AUDRCTUNERSEL_MASK_SFT                         (0x1 << 13)
+
+/* MT6358_AUDENC_ANA_CON6 */
+#define RG_CLKSQ_EN_SFT                                   0
+#define RG_CLKSQ_EN_MASK                                  0x1
+#define RG_CLKSQ_EN_MASK_SFT                              (0x1 << 0)
+#define RG_CLKSQ_IN_SEL_TEST_SFT                          1
+#define RG_CLKSQ_IN_SEL_TEST_MASK                         0x1
+#define RG_CLKSQ_IN_SEL_TEST_MASK_SFT                     (0x1 << 1)
+#define RG_CM_REFGENSEL_SFT                               2
+#define RG_CM_REFGENSEL_MASK                              0x1
+#define RG_CM_REFGENSEL_MASK_SFT                          (0x1 << 2)
+#define RG_AUDSPARE_SFT                                   4
+#define RG_AUDSPARE_MASK                                  0xf
+#define RG_AUDSPARE_MASK_SFT                              (0xf << 4)
+#define RG_AUDENCSPARE_SFT                                8
+#define RG_AUDENCSPARE_MASK                               0x3f
+#define RG_AUDENCSPARE_MASK_SFT                           (0x3f << 8)
+
+/* MT6358_AUDENC_ANA_CON7 */
+#define RG_AUDENCSPARE2_SFT                               0
+#define RG_AUDENCSPARE2_MASK                              0xff
+#define RG_AUDENCSPARE2_MASK_SFT                          (0xff << 0)
+
+/* MT6358_AUDENC_ANA_CON8 */
+#define RG_AUDDIGMICEN_SFT                                0
+#define RG_AUDDIGMICEN_MASK                               0x1
+#define RG_AUDDIGMICEN_MASK_SFT                           (0x1 << 0)
+#define RG_AUDDIGMICBIAS_SFT                              1
+#define RG_AUDDIGMICBIAS_MASK                             0x3
+#define RG_AUDDIGMICBIAS_MASK_SFT                         (0x3 << 1)
+#define RG_DMICHPCLKEN_SFT                                3
+#define RG_DMICHPCLKEN_MASK                               0x1
+#define RG_DMICHPCLKEN_MASK_SFT                           (0x1 << 3)
+#define RG_AUDDIGMICPDUTY_SFT                             4
+#define RG_AUDDIGMICPDUTY_MASK                            0x3
+#define RG_AUDDIGMICPDUTY_MASK_SFT                        (0x3 << 4)
+#define RG_AUDDIGMICNDUTY_SFT                             6
+#define RG_AUDDIGMICNDUTY_MASK                            0x3
+#define RG_AUDDIGMICNDUTY_MASK_SFT                        (0x3 << 6)
+#define RG_DMICMONEN_SFT                                  8
+#define RG_DMICMONEN_MASK                                 0x1
+#define RG_DMICMONEN_MASK_SFT                             (0x1 << 8)
+#define RG_DMICMONSEL_SFT                                 9
+#define RG_DMICMONSEL_MASK                                0x7
+#define RG_DMICMONSEL_MASK_SFT                            (0x7 << 9)
+#define RG_AUDSPAREVMIC_SFT                               12
+#define RG_AUDSPAREVMIC_MASK                              0xf
+#define RG_AUDSPAREVMIC_MASK_SFT                          (0xf << 12)
+
+/* MT6358_AUDENC_ANA_CON9 */
+#define RG_AUDPWDBMICBIAS0_SFT                            0
+#define RG_AUDPWDBMICBIAS0_MASK                           0x1
+#define RG_AUDPWDBMICBIAS0_MASK_SFT                       (0x1 << 0)
+#define RG_AUDMICBIAS0BYPASSEN_SFT                        1
+#define RG_AUDMICBIAS0BYPASSEN_MASK                       0x1
+#define RG_AUDMICBIAS0BYPASSEN_MASK_SFT                   (0x1 << 1)
+#define RG_AUDMICBIAS0LOWPEN_SFT                          2
+#define RG_AUDMICBIAS0LOWPEN_MASK                         0x1
+#define RG_AUDMICBIAS0LOWPEN_MASK_SFT                     (0x1 << 2)
+#define RG_AUDMICBIAS0VREF_SFT                            4
+#define RG_AUDMICBIAS0VREF_MASK                           0x7
+#define RG_AUDMICBIAS0VREF_MASK_SFT                       (0x7 << 4)
+#define RG_AUDMICBIAS0DCSW0P1EN_SFT                       8
+#define RG_AUDMICBIAS0DCSW0P1EN_MASK                      0x1
+#define RG_AUDMICBIAS0DCSW0P1EN_MASK_SFT                  (0x1 << 8)
+#define RG_AUDMICBIAS0DCSW0P2EN_SFT                       9
+#define RG_AUDMICBIAS0DCSW0P2EN_MASK                      0x1
+#define RG_AUDMICBIAS0DCSW0P2EN_MASK_SFT                  (0x1 << 9)
+#define RG_AUDMICBIAS0DCSW0NEN_SFT                        10
+#define RG_AUDMICBIAS0DCSW0NEN_MASK                       0x1
+#define RG_AUDMICBIAS0DCSW0NEN_MASK_SFT                   (0x1 << 10)
+#define RG_AUDMICBIAS0DCSW2P1EN_SFT                       12
+#define RG_AUDMICBIAS0DCSW2P1EN_MASK                      0x1
+#define RG_AUDMICBIAS0DCSW2P1EN_MASK_SFT                  (0x1 << 12)
+#define RG_AUDMICBIAS0DCSW2P2EN_SFT                       13
+#define RG_AUDMICBIAS0DCSW2P2EN_MASK                      0x1
+#define RG_AUDMICBIAS0DCSW2P2EN_MASK_SFT                  (0x1 << 13)
+#define RG_AUDMICBIAS0DCSW2NEN_SFT                        14
+#define RG_AUDMICBIAS0DCSW2NEN_MASK                       0x1
+#define RG_AUDMICBIAS0DCSW2NEN_MASK_SFT                   (0x1 << 14)
+
+/* MT6358_AUDENC_ANA_CON10 */
+#define RG_AUDPWDBMICBIAS1_SFT                            0
+#define RG_AUDPWDBMICBIAS1_MASK                           0x1
+#define RG_AUDPWDBMICBIAS1_MASK_SFT                       (0x1 << 0)
+#define RG_AUDMICBIAS1BYPASSEN_SFT                        1
+#define RG_AUDMICBIAS1BYPASSEN_MASK                       0x1
+#define RG_AUDMICBIAS1BYPASSEN_MASK_SFT                   (0x1 << 1)
+#define RG_AUDMICBIAS1LOWPEN_SFT                          2
+#define RG_AUDMICBIAS1LOWPEN_MASK                         0x1
+#define RG_AUDMICBIAS1LOWPEN_MASK_SFT                     (0x1 << 2)
+#define RG_AUDMICBIAS1VREF_SFT                            4
+#define RG_AUDMICBIAS1VREF_MASK                           0x7
+#define RG_AUDMICBIAS1VREF_MASK_SFT                       (0x7 << 4)
+#define RG_AUDMICBIAS1DCSW1PEN_SFT                        8
+#define RG_AUDMICBIAS1DCSW1PEN_MASK                       0x1
+#define RG_AUDMICBIAS1DCSW1PEN_MASK_SFT                   (0x1 << 8)
+#define RG_AUDMICBIAS1DCSW1NEN_SFT                        9
+#define RG_AUDMICBIAS1DCSW1NEN_MASK                       0x1
+#define RG_AUDMICBIAS1DCSW1NEN_MASK_SFT                   (0x1 << 9)
+#define RG_BANDGAPGEN_SFT                                 12
+#define RG_BANDGAPGEN_MASK                                0x1
+#define RG_BANDGAPGEN_MASK_SFT                            (0x1 << 12)
+#define RG_MTEST_EN_SFT                                   13
+#define RG_MTEST_EN_MASK                                  0x1
+#define RG_MTEST_EN_MASK_SFT                              (0x1 << 13)
+#define RG_MTEST_SEL_SFT                                  14
+#define RG_MTEST_SEL_MASK                                 0x1
+#define RG_MTEST_SEL_MASK_SFT                             (0x1 << 14)
+#define RG_MTEST_CURRENT_SFT                              15
+#define RG_MTEST_CURRENT_MASK                             0x1
+#define RG_MTEST_CURRENT_MASK_SFT                         (0x1 << 15)
+
+/* MT6358_AUDENC_ANA_CON11 */
+#define RG_AUDACCDETMICBIAS0PULLLOW_SFT                   0
+#define RG_AUDACCDETMICBIAS0PULLLOW_MASK                  0x1
+#define RG_AUDACCDETMICBIAS0PULLLOW_MASK_SFT              (0x1 << 0)
+#define RG_AUDACCDETMICBIAS1PULLLOW_SFT                   1
+#define RG_AUDACCDETMICBIAS1PULLLOW_MASK                  0x1
+#define RG_AUDACCDETMICBIAS1PULLLOW_MASK_SFT              (0x1 << 1)
+#define RG_AUDACCDETVIN1PULLLOW_SFT                       2
+#define RG_AUDACCDETVIN1PULLLOW_MASK                      0x1
+#define RG_AUDACCDETVIN1PULLLOW_MASK_SFT                  (0x1 << 2)
+#define RG_AUDACCDETVTHACAL_SFT                           4
+#define RG_AUDACCDETVTHACAL_MASK                          0x1
+#define RG_AUDACCDETVTHACAL_MASK_SFT                      (0x1 << 4)
+#define RG_AUDACCDETVTHBCAL_SFT                           5
+#define RG_AUDACCDETVTHBCAL_MASK                          0x1
+#define RG_AUDACCDETVTHBCAL_MASK_SFT                      (0x1 << 5)
+#define RG_AUDACCDETTVDET_SFT                             6
+#define RG_AUDACCDETTVDET_MASK                            0x1
+#define RG_AUDACCDETTVDET_MASK_SFT                        (0x1 << 6)
+#define RG_ACCDETSEL_SFT                                  7
+#define RG_ACCDETSEL_MASK                                 0x1
+#define RG_ACCDETSEL_MASK_SFT                             (0x1 << 7)
+#define RG_SWBUFMODSEL_SFT                                8
+#define RG_SWBUFMODSEL_MASK                               0x1
+#define RG_SWBUFMODSEL_MASK_SFT                           (0x1 << 8)
+#define RG_SWBUFSWEN_SFT                                  9
+#define RG_SWBUFSWEN_MASK                                 0x1
+#define RG_SWBUFSWEN_MASK_SFT                             (0x1 << 9)
+#define RG_EINTCOMPVTH_SFT                                10
+#define RG_EINTCOMPVTH_MASK                               0x1
+#define RG_EINTCOMPVTH_MASK_SFT                           (0x1 << 10)
+#define RG_EINTCONFIGACCDET_SFT                           11
+#define RG_EINTCONFIGACCDET_MASK                          0x1
+#define RG_EINTCONFIGACCDET_MASK_SFT                      (0x1 << 11)
+#define RG_EINTHIRENB_SFT                                 12
+#define RG_EINTHIRENB_MASK                                0x1
+#define RG_EINTHIRENB_MASK_SFT                            (0x1 << 12)
+#define RG_ACCDET2AUXRESBYPASS_SFT                        13
+#define RG_ACCDET2AUXRESBYPASS_MASK                       0x1
+#define RG_ACCDET2AUXRESBYPASS_MASK_SFT                   (0x1 << 13)
+#define RG_ACCDET2AUXBUFFERBYPASS_SFT                     14
+#define RG_ACCDET2AUXBUFFERBYPASS_MASK                    0x1
+#define RG_ACCDET2AUXBUFFERBYPASS_MASK_SFT                (0x1 << 14)
+#define RG_ACCDET2AUXSWEN_SFT                             15
+#define RG_ACCDET2AUXSWEN_MASK                            0x1
+#define RG_ACCDET2AUXSWEN_MASK_SFT                        (0x1 << 15)
+
+/* MT6358_AUDENC_ANA_CON12 */
+#define RGS_AUDRCTUNELREAD_SFT                            0
+#define RGS_AUDRCTUNELREAD_MASK                           0x1f
+#define RGS_AUDRCTUNELREAD_MASK_SFT                       (0x1f << 0)
+#define RGS_AUDRCTUNERREAD_SFT                            8
+#define RGS_AUDRCTUNERREAD_MASK                           0x1f
+#define RGS_AUDRCTUNERREAD_MASK_SFT                       (0x1f << 8)
+
+/* MT6358_AUDDEC_DSN_ID */
+#define AUDDEC_ANA_ID_SFT                                 0
+#define AUDDEC_ANA_ID_MASK                                0xff
+#define AUDDEC_ANA_ID_MASK_SFT                            (0xff << 0)
+#define AUDDEC_DIG_ID_SFT                                 8
+#define AUDDEC_DIG_ID_MASK                                0xff
+#define AUDDEC_DIG_ID_MASK_SFT                            (0xff << 8)
+
+/* MT6358_AUDDEC_DSN_REV0 */
+#define AUDDEC_ANA_MINOR_REV_SFT                          0
+#define AUDDEC_ANA_MINOR_REV_MASK                         0xf
+#define AUDDEC_ANA_MINOR_REV_MASK_SFT                     (0xf << 0)
+#define AUDDEC_ANA_MAJOR_REV_SFT                          4
+#define AUDDEC_ANA_MAJOR_REV_MASK                         0xf
+#define AUDDEC_ANA_MAJOR_REV_MASK_SFT                     (0xf << 4)
+#define AUDDEC_DIG_MINOR_REV_SFT                          8
+#define AUDDEC_DIG_MINOR_REV_MASK                         0xf
+#define AUDDEC_DIG_MINOR_REV_MASK_SFT                     (0xf << 8)
+#define AUDDEC_DIG_MAJOR_REV_SFT                          12
+#define AUDDEC_DIG_MAJOR_REV_MASK                         0xf
+#define AUDDEC_DIG_MAJOR_REV_MASK_SFT                     (0xf << 12)
+
+/* MT6358_AUDDEC_DSN_DBI */
+#define AUDDEC_DSN_CBS_SFT                                0
+#define AUDDEC_DSN_CBS_MASK                               0x3
+#define AUDDEC_DSN_CBS_MASK_SFT                           (0x3 << 0)
+#define AUDDEC_DSN_BIX_SFT                                2
+#define AUDDEC_DSN_BIX_MASK                               0x3
+#define AUDDEC_DSN_BIX_MASK_SFT                           (0x3 << 2)
+#define AUDDEC_DSN_ESP_SFT                                8
+#define AUDDEC_DSN_ESP_MASK                               0xff
+#define AUDDEC_DSN_ESP_MASK_SFT                           (0xff << 8)
+
+/* MT6358_AUDDEC_DSN_FPI */
+#define AUDDEC_DSN_FPI_SFT                                0
+#define AUDDEC_DSN_FPI_MASK                               0xff
+#define AUDDEC_DSN_FPI_MASK_SFT                           (0xff << 0)
+
+/* MT6358_AUDDEC_ANA_CON0 */
+#define RG_AUDDACLPWRUP_VAUDP15_SFT                       0
+#define RG_AUDDACLPWRUP_VAUDP15_MASK                      0x1
+#define RG_AUDDACLPWRUP_VAUDP15_MASK_SFT                  (0x1 << 0)
+#define RG_AUDDACRPWRUP_VAUDP15_SFT                       1
+#define RG_AUDDACRPWRUP_VAUDP15_MASK                      0x1
+#define RG_AUDDACRPWRUP_VAUDP15_MASK_SFT                  (0x1 << 1)
+#define RG_AUD_DAC_PWR_UP_VA28_SFT                        2
+#define RG_AUD_DAC_PWR_UP_VA28_MASK                       0x1
+#define RG_AUD_DAC_PWR_UP_VA28_MASK_SFT                   (0x1 << 2)
+#define RG_AUD_DAC_PWL_UP_VA28_SFT                        3
+#define RG_AUD_DAC_PWL_UP_VA28_MASK                       0x1
+#define RG_AUD_DAC_PWL_UP_VA28_MASK_SFT                   (0x1 << 3)
+#define RG_AUDHPLPWRUP_VAUDP15_SFT                        4
+#define RG_AUDHPLPWRUP_VAUDP15_MASK                       0x1
+#define RG_AUDHPLPWRUP_VAUDP15_MASK_SFT                   (0x1 << 4)
+#define RG_AUDHPRPWRUP_VAUDP15_SFT                        5
+#define RG_AUDHPRPWRUP_VAUDP15_MASK                       0x1
+#define RG_AUDHPRPWRUP_VAUDP15_MASK_SFT                   (0x1 << 5)
+#define RG_AUDHPLPWRUP_IBIAS_VAUDP15_SFT                  6
+#define RG_AUDHPLPWRUP_IBIAS_VAUDP15_MASK                 0x1
+#define RG_AUDHPLPWRUP_IBIAS_VAUDP15_MASK_SFT             (0x1 << 6)
+#define RG_AUDHPRPWRUP_IBIAS_VAUDP15_SFT                  7
+#define RG_AUDHPRPWRUP_IBIAS_VAUDP15_MASK                 0x1
+#define RG_AUDHPRPWRUP_IBIAS_VAUDP15_MASK_SFT             (0x1 << 7)
+#define RG_AUDHPLMUXINPUTSEL_VAUDP15_SFT                  8
+#define RG_AUDHPLMUXINPUTSEL_VAUDP15_MASK                 0x3
+#define RG_AUDHPLMUXINPUTSEL_VAUDP15_MASK_SFT             (0x3 << 8)
+#define RG_AUDHPRMUXINPUTSEL_VAUDP15_SFT                  10
+#define RG_AUDHPRMUXINPUTSEL_VAUDP15_MASK                 0x3
+#define RG_AUDHPRMUXINPUTSEL_VAUDP15_MASK_SFT             (0x3 << 10)
+#define RG_AUDHPLSCDISABLE_VAUDP15_SFT                    12
+#define RG_AUDHPLSCDISABLE_VAUDP15_MASK                   0x1
+#define RG_AUDHPLSCDISABLE_VAUDP15_MASK_SFT               (0x1 << 12)
+#define RG_AUDHPRSCDISABLE_VAUDP15_SFT                    13
+#define RG_AUDHPRSCDISABLE_VAUDP15_MASK                   0x1
+#define RG_AUDHPRSCDISABLE_VAUDP15_MASK_SFT               (0x1 << 13)
+#define RG_AUDHPLBSCCURRENT_VAUDP15_SFT                   14
+#define RG_AUDHPLBSCCURRENT_VAUDP15_MASK                  0x1
+#define RG_AUDHPLBSCCURRENT_VAUDP15_MASK_SFT              (0x1 << 14)
+#define RG_AUDHPRBSCCURRENT_VAUDP15_SFT                   15
+#define RG_AUDHPRBSCCURRENT_VAUDP15_MASK                  0x1
+#define RG_AUDHPRBSCCURRENT_VAUDP15_MASK_SFT              (0x1 << 15)
+
+/* MT6358_AUDDEC_ANA_CON1 */
+#define RG_AUDHPLOUTPWRUP_VAUDP15_SFT                     0
+#define RG_AUDHPLOUTPWRUP_VAUDP15_MASK                    0x1
+#define RG_AUDHPLOUTPWRUP_VAUDP15_MASK_SFT                (0x1 << 0)
+#define RG_AUDHPROUTPWRUP_VAUDP15_SFT                     1
+#define RG_AUDHPROUTPWRUP_VAUDP15_MASK                    0x1
+#define RG_AUDHPROUTPWRUP_VAUDP15_MASK_SFT                (0x1 << 1)
+#define RG_AUDHPLOUTAUXPWRUP_VAUDP15_SFT                  2
+#define RG_AUDHPLOUTAUXPWRUP_VAUDP15_MASK                 0x1
+#define RG_AUDHPLOUTAUXPWRUP_VAUDP15_MASK_SFT             (0x1 << 2)
+#define RG_AUDHPROUTAUXPWRUP_VAUDP15_SFT                  3
+#define RG_AUDHPROUTAUXPWRUP_VAUDP15_MASK                 0x1
+#define RG_AUDHPROUTAUXPWRUP_VAUDP15_MASK_SFT             (0x1 << 3)
+#define RG_HPLAUXFBRSW_EN_VAUDP15_SFT                     4
+#define RG_HPLAUXFBRSW_EN_VAUDP15_MASK                    0x1
+#define RG_HPLAUXFBRSW_EN_VAUDP15_MASK_SFT                (0x1 << 4)
+#define RG_HPRAUXFBRSW_EN_VAUDP15_SFT                     5
+#define RG_HPRAUXFBRSW_EN_VAUDP15_MASK                    0x1
+#define RG_HPRAUXFBRSW_EN_VAUDP15_MASK_SFT                (0x1 << 5)
+#define RG_HPLSHORT2HPLAUX_EN_VAUDP15_SFT                 6
+#define RG_HPLSHORT2HPLAUX_EN_VAUDP15_MASK                0x1
+#define RG_HPLSHORT2HPLAUX_EN_VAUDP15_MASK_SFT            (0x1 << 6)
+#define RG_HPRSHORT2HPRAUX_EN_VAUDP15_SFT                 7
+#define RG_HPRSHORT2HPRAUX_EN_VAUDP15_MASK                0x1
+#define RG_HPRSHORT2HPRAUX_EN_VAUDP15_MASK_SFT            (0x1 << 7)
+#define RG_HPLOUTSTGCTRL_VAUDP15_SFT                      8
+#define RG_HPLOUTSTGCTRL_VAUDP15_MASK                     0x7
+#define RG_HPLOUTSTGCTRL_VAUDP15_MASK_SFT                 (0x7 << 8)
+#define RG_HPROUTSTGCTRL_VAUDP15_SFT                      11
+#define RG_HPROUTSTGCTRL_VAUDP15_MASK                     0x7
+#define RG_HPROUTSTGCTRL_VAUDP15_MASK_SFT                 (0x7 << 11)
+
+/* MT6358_AUDDEC_ANA_CON2 */
+#define RG_HPLOUTPUTSTBENH_VAUDP15_SFT                    0
+#define RG_HPLOUTPUTSTBENH_VAUDP15_MASK                   0x7
+#define RG_HPLOUTPUTSTBENH_VAUDP15_MASK_SFT               (0x7 << 0)
+#define RG_HPROUTPUTSTBENH_VAUDP15_SFT                    4
+#define RG_HPROUTPUTSTBENH_VAUDP15_MASK                   0x7
+#define RG_HPROUTPUTSTBENH_VAUDP15_MASK_SFT               (0x7 << 4)
+#define RG_AUDHPSTARTUP_VAUDP15_SFT                       13
+#define RG_AUDHPSTARTUP_VAUDP15_MASK                      0x1
+#define RG_AUDHPSTARTUP_VAUDP15_MASK_SFT                  (0x1 << 13)
+#define RG_AUDREFN_DERES_EN_VAUDP15_SFT                   14
+#define RG_AUDREFN_DERES_EN_VAUDP15_MASK                  0x1
+#define RG_AUDREFN_DERES_EN_VAUDP15_MASK_SFT              (0x1 << 14)
+#define RG_HPPSHORT2VCM_VAUDP15_SFT                       15
+#define RG_HPPSHORT2VCM_VAUDP15_MASK                      0x1
+#define RG_HPPSHORT2VCM_VAUDP15_MASK_SFT                  (0x1 << 15)
+
+/* MT6358_AUDDEC_ANA_CON3 */
+#define RG_HPINPUTSTBENH_VAUDP15_SFT                      13
+#define RG_HPINPUTSTBENH_VAUDP15_MASK                     0x1
+#define RG_HPINPUTSTBENH_VAUDP15_MASK_SFT                 (0x1 << 13)
+#define RG_HPINPUTRESET0_VAUDP15_SFT                      14
+#define RG_HPINPUTRESET0_VAUDP15_MASK                     0x1
+#define RG_HPINPUTRESET0_VAUDP15_MASK_SFT                 (0x1 << 14)
+#define RG_HPOUTPUTRESET0_VAUDP15_SFT                     15
+#define RG_HPOUTPUTRESET0_VAUDP15_MASK                    0x1
+#define RG_HPOUTPUTRESET0_VAUDP15_MASK_SFT                (0x1 << 15)
+
+/* MT6358_AUDDEC_ANA_CON4 */
+#define RG_ABIDEC_RSVD0_VAUDP28_SFT                       0
+#define RG_ABIDEC_RSVD0_VAUDP28_MASK                      0xff
+#define RG_ABIDEC_RSVD0_VAUDP28_MASK_SFT                  (0xff << 0)
+
+/* MT6358_AUDDEC_ANA_CON5 */
+#define RG_AUDHPDECMGAINADJ_VAUDP15_SFT                   0
+#define RG_AUDHPDECMGAINADJ_VAUDP15_MASK                  0x7
+#define RG_AUDHPDECMGAINADJ_VAUDP15_MASK_SFT              (0x7 << 0)
+#define RG_AUDHPDEDMGAINADJ_VAUDP15_SFT                   4
+#define RG_AUDHPDEDMGAINADJ_VAUDP15_MASK                  0x7
+#define RG_AUDHPDEDMGAINADJ_VAUDP15_MASK_SFT              (0x7 << 4)
+
+/* MT6358_AUDDEC_ANA_CON6 */
+#define RG_AUDHSPWRUP_VAUDP15_SFT                         0
+#define RG_AUDHSPWRUP_VAUDP15_MASK                        0x1
+#define RG_AUDHSPWRUP_VAUDP15_MASK_SFT                    (0x1 << 0)
+#define RG_AUDHSPWRUP_IBIAS_VAUDP15_SFT                   1
+#define RG_AUDHSPWRUP_IBIAS_VAUDP15_MASK                  0x1
+#define RG_AUDHSPWRUP_IBIAS_VAUDP15_MASK_SFT              (0x1 << 1)
+#define RG_AUDHSMUXINPUTSEL_VAUDP15_SFT                   2
+#define RG_AUDHSMUXINPUTSEL_VAUDP15_MASK                  0x3
+#define RG_AUDHSMUXINPUTSEL_VAUDP15_MASK_SFT              (0x3 << 2)
+#define RG_AUDHSSCDISABLE_VAUDP15_SFT                     4
+#define RG_AUDHSSCDISABLE_VAUDP15_MASK                    0x1
+#define RG_AUDHSSCDISABLE_VAUDP15_MASK_SFT                (0x1 << 4)
+#define RG_AUDHSBSCCURRENT_VAUDP15_SFT                    5
+#define RG_AUDHSBSCCURRENT_VAUDP15_MASK                   0x1
+#define RG_AUDHSBSCCURRENT_VAUDP15_MASK_SFT               (0x1 << 5)
+#define RG_AUDHSSTARTUP_VAUDP15_SFT                       6
+#define RG_AUDHSSTARTUP_VAUDP15_MASK                      0x1
+#define RG_AUDHSSTARTUP_VAUDP15_MASK_SFT                  (0x1 << 6)
+#define RG_HSOUTPUTSTBENH_VAUDP15_SFT                     7
+#define RG_HSOUTPUTSTBENH_VAUDP15_MASK                    0x1
+#define RG_HSOUTPUTSTBENH_VAUDP15_MASK_SFT                (0x1 << 7)
+#define RG_HSINPUTSTBENH_VAUDP15_SFT                      8
+#define RG_HSINPUTSTBENH_VAUDP15_MASK                     0x1
+#define RG_HSINPUTSTBENH_VAUDP15_MASK_SFT                 (0x1 << 8)
+#define RG_HSINPUTRESET0_VAUDP15_SFT                      9
+#define RG_HSINPUTRESET0_VAUDP15_MASK                     0x1
+#define RG_HSINPUTRESET0_VAUDP15_MASK_SFT                 (0x1 << 9)
+#define RG_HSOUTPUTRESET0_VAUDP15_SFT                     10
+#define RG_HSOUTPUTRESET0_VAUDP15_MASK                    0x1
+#define RG_HSOUTPUTRESET0_VAUDP15_MASK_SFT                (0x1 << 10)
+#define RG_HSOUT_SHORTVCM_VAUDP15_SFT                     11
+#define RG_HSOUT_SHORTVCM_VAUDP15_MASK                    0x1
+#define RG_HSOUT_SHORTVCM_VAUDP15_MASK_SFT                (0x1 << 11)
+
+/* MT6358_AUDDEC_ANA_CON7 */
+#define RG_AUDLOLPWRUP_VAUDP15_SFT                        0
+#define RG_AUDLOLPWRUP_VAUDP15_MASK                       0x1
+#define RG_AUDLOLPWRUP_VAUDP15_MASK_SFT                   (0x1 << 0)
+#define RG_AUDLOLPWRUP_IBIAS_VAUDP15_SFT                  1
+#define RG_AUDLOLPWRUP_IBIAS_VAUDP15_MASK                 0x1
+#define RG_AUDLOLPWRUP_IBIAS_VAUDP15_MASK_SFT             (0x1 << 1)
+#define RG_AUDLOLMUXINPUTSEL_VAUDP15_SFT                  2
+#define RG_AUDLOLMUXINPUTSEL_VAUDP15_MASK                 0x3
+#define RG_AUDLOLMUXINPUTSEL_VAUDP15_MASK_SFT             (0x3 << 2)
+#define RG_AUDLOLSCDISABLE_VAUDP15_SFT                    4
+#define RG_AUDLOLSCDISABLE_VAUDP15_MASK                   0x1
+#define RG_AUDLOLSCDISABLE_VAUDP15_MASK_SFT               (0x1 << 4)
+#define RG_AUDLOLBSCCURRENT_VAUDP15_SFT                   5
+#define RG_AUDLOLBSCCURRENT_VAUDP15_MASK                  0x1
+#define RG_AUDLOLBSCCURRENT_VAUDP15_MASK_SFT              (0x1 << 5)
+#define RG_AUDLOSTARTUP_VAUDP15_SFT                       6
+#define RG_AUDLOSTARTUP_VAUDP15_MASK                      0x1
+#define RG_AUDLOSTARTUP_VAUDP15_MASK_SFT                  (0x1 << 6)
+#define RG_LOINPUTSTBENH_VAUDP15_SFT                      7
+#define RG_LOINPUTSTBENH_VAUDP15_MASK                     0x1
+#define RG_LOINPUTSTBENH_VAUDP15_MASK_SFT                 (0x1 << 7)
+#define RG_LOOUTPUTSTBENH_VAUDP15_SFT                     8
+#define RG_LOOUTPUTSTBENH_VAUDP15_MASK                    0x1
+#define RG_LOOUTPUTSTBENH_VAUDP15_MASK_SFT                (0x1 << 8)
+#define RG_LOINPUTRESET0_VAUDP15_SFT                      9
+#define RG_LOINPUTRESET0_VAUDP15_MASK                     0x1
+#define RG_LOINPUTRESET0_VAUDP15_MASK_SFT                 (0x1 << 9)
+#define RG_LOOUTPUTRESET0_VAUDP15_SFT                     10
+#define RG_LOOUTPUTRESET0_VAUDP15_MASK                    0x1
+#define RG_LOOUTPUTRESET0_VAUDP15_MASK_SFT                (0x1 << 10)
+#define RG_LOOUT_SHORTVCM_VAUDP15_SFT                     11
+#define RG_LOOUT_SHORTVCM_VAUDP15_MASK                    0x1
+#define RG_LOOUT_SHORTVCM_VAUDP15_MASK_SFT                (0x1 << 11)
+
+/* MT6358_AUDDEC_ANA_CON8 */
+#define RG_AUDTRIMBUF_INPUTMUXSEL_VAUDP15_SFT             0
+#define RG_AUDTRIMBUF_INPUTMUXSEL_VAUDP15_MASK            0xf
+#define RG_AUDTRIMBUF_INPUTMUXSEL_VAUDP15_MASK_SFT        (0xf << 0)
+#define RG_AUDTRIMBUF_GAINSEL_VAUDP15_SFT                 4
+#define RG_AUDTRIMBUF_GAINSEL_VAUDP15_MASK                0x3
+#define RG_AUDTRIMBUF_GAINSEL_VAUDP15_MASK_SFT            (0x3 << 4)
+#define RG_AUDTRIMBUF_EN_VAUDP15_SFT                      6
+#define RG_AUDTRIMBUF_EN_VAUDP15_MASK                     0x1
+#define RG_AUDTRIMBUF_EN_VAUDP15_MASK_SFT                 (0x1 << 6)
+#define RG_AUDHPSPKDET_INPUTMUXSEL_VAUDP15_SFT            8
+#define RG_AUDHPSPKDET_INPUTMUXSEL_VAUDP15_MASK           0x3
+#define RG_AUDHPSPKDET_INPUTMUXSEL_VAUDP15_MASK_SFT       (0x3 << 8)
+#define RG_AUDHPSPKDET_OUTPUTMUXSEL_VAUDP15_SFT           10
+#define RG_AUDHPSPKDET_OUTPUTMUXSEL_VAUDP15_MASK          0x3
+#define RG_AUDHPSPKDET_OUTPUTMUXSEL_VAUDP15_MASK_SFT      (0x3 << 10)
+#define RG_AUDHPSPKDET_EN_VAUDP15_SFT                     12
+#define RG_AUDHPSPKDET_EN_VAUDP15_MASK                    0x1
+#define RG_AUDHPSPKDET_EN_VAUDP15_MASK_SFT                (0x1 << 12)
+
+/* MT6358_AUDDEC_ANA_CON9 */
+#define RG_ABIDEC_RSVD0_VA28_SFT                          0
+#define RG_ABIDEC_RSVD0_VA28_MASK                         0xff
+#define RG_ABIDEC_RSVD0_VA28_MASK_SFT                     (0xff << 0)
+#define RG_ABIDEC_RSVD0_VAUDP15_SFT                       8
+#define RG_ABIDEC_RSVD0_VAUDP15_MASK                      0xff
+#define RG_ABIDEC_RSVD0_VAUDP15_MASK_SFT                  (0xff << 8)
+
+/* MT6358_AUDDEC_ANA_CON10 */
+#define RG_ABIDEC_RSVD1_VAUDP15_SFT                       0
+#define RG_ABIDEC_RSVD1_VAUDP15_MASK                      0xff
+#define RG_ABIDEC_RSVD1_VAUDP15_MASK_SFT                  (0xff << 0)
+#define RG_ABIDEC_RSVD2_VAUDP15_SFT                       8
+#define RG_ABIDEC_RSVD2_VAUDP15_MASK                      0xff
+#define RG_ABIDEC_RSVD2_VAUDP15_MASK_SFT                  (0xff << 8)
+
+/* MT6358_AUDDEC_ANA_CON11 */
+#define RG_AUDZCDMUXSEL_VAUDP15_SFT                       0
+#define RG_AUDZCDMUXSEL_VAUDP15_MASK                      0x7
+#define RG_AUDZCDMUXSEL_VAUDP15_MASK_SFT                  (0x7 << 0)
+#define RG_AUDZCDCLKSEL_VAUDP15_SFT                       3
+#define RG_AUDZCDCLKSEL_VAUDP15_MASK                      0x1
+#define RG_AUDZCDCLKSEL_VAUDP15_MASK_SFT                  (0x1 << 3)
+#define RG_AUDBIASADJ_0_VAUDP15_SFT                       7
+#define RG_AUDBIASADJ_0_VAUDP15_MASK                      0x1ff
+#define RG_AUDBIASADJ_0_VAUDP15_MASK_SFT                  (0x1ff << 7)
+
+/* MT6358_AUDDEC_ANA_CON12 */
+#define RG_AUDBIASADJ_1_VAUDP15_SFT                       0
+#define RG_AUDBIASADJ_1_VAUDP15_MASK                      0xff
+#define RG_AUDBIASADJ_1_VAUDP15_MASK_SFT                  (0xff << 0)
+#define RG_AUDIBIASPWRDN_VAUDP15_SFT                      8
+#define RG_AUDIBIASPWRDN_VAUDP15_MASK                     0x1
+#define RG_AUDIBIASPWRDN_VAUDP15_MASK_SFT                 (0x1 << 8)
+
+/* MT6358_AUDDEC_ANA_CON13 */
+#define RG_RSTB_DECODER_VA28_SFT                          0
+#define RG_RSTB_DECODER_VA28_MASK                         0x1
+#define RG_RSTB_DECODER_VA28_MASK_SFT                     (0x1 << 0)
+#define RG_SEL_DECODER_96K_VA28_SFT                       1
+#define RG_SEL_DECODER_96K_VA28_MASK                      0x1
+#define RG_SEL_DECODER_96K_VA28_MASK_SFT                  (0x1 << 1)
+#define RG_SEL_DELAY_VCORE_SFT                            2
+#define RG_SEL_DELAY_VCORE_MASK                           0x1
+#define RG_SEL_DELAY_VCORE_MASK_SFT                       (0x1 << 2)
+#define RG_AUDGLB_PWRDN_VA28_SFT                          4
+#define RG_AUDGLB_PWRDN_VA28_MASK                         0x1
+#define RG_AUDGLB_PWRDN_VA28_MASK_SFT                     (0x1 << 4)
+#define RG_RSTB_ENCODER_VA28_SFT                          5
+#define RG_RSTB_ENCODER_VA28_MASK                         0x1
+#define RG_RSTB_ENCODER_VA28_MASK_SFT                     (0x1 << 5)
+#define RG_SEL_ENCODER_96K_VA28_SFT                       6
+#define RG_SEL_ENCODER_96K_VA28_MASK                      0x1
+#define RG_SEL_ENCODER_96K_VA28_MASK_SFT                  (0x1 << 6)
+
+/* MT6358_AUDDEC_ANA_CON14 */
+#define RG_HCLDO_EN_VA18_SFT                              0
+#define RG_HCLDO_EN_VA18_MASK                             0x1
+#define RG_HCLDO_EN_VA18_MASK_SFT                         (0x1 << 0)
+#define RG_HCLDO_PDDIS_EN_VA18_SFT                        1
+#define RG_HCLDO_PDDIS_EN_VA18_MASK                       0x1
+#define RG_HCLDO_PDDIS_EN_VA18_MASK_SFT                   (0x1 << 1)
+#define RG_HCLDO_REMOTE_SENSE_VA18_SFT                    2
+#define RG_HCLDO_REMOTE_SENSE_VA18_MASK                   0x1
+#define RG_HCLDO_REMOTE_SENSE_VA18_MASK_SFT               (0x1 << 2)
+#define RG_LCLDO_EN_VA18_SFT                              4
+#define RG_LCLDO_EN_VA18_MASK                             0x1
+#define RG_LCLDO_EN_VA18_MASK_SFT                         (0x1 << 4)
+#define RG_LCLDO_PDDIS_EN_VA18_SFT                        5
+#define RG_LCLDO_PDDIS_EN_VA18_MASK                       0x1
+#define RG_LCLDO_PDDIS_EN_VA18_MASK_SFT                   (0x1 << 5)
+#define RG_LCLDO_REMOTE_SENSE_VA18_SFT                    6
+#define RG_LCLDO_REMOTE_SENSE_VA18_MASK                   0x1
+#define RG_LCLDO_REMOTE_SENSE_VA18_MASK_SFT               (0x1 << 6)
+#define RG_LCLDO_ENC_EN_VA28_SFT                          8
+#define RG_LCLDO_ENC_EN_VA28_MASK                         0x1
+#define RG_LCLDO_ENC_EN_VA28_MASK_SFT                     (0x1 << 8)
+#define RG_LCLDO_ENC_PDDIS_EN_VA28_SFT                    9
+#define RG_LCLDO_ENC_PDDIS_EN_VA28_MASK                   0x1
+#define RG_LCLDO_ENC_PDDIS_EN_VA28_MASK_SFT               (0x1 << 9)
+#define RG_LCLDO_ENC_REMOTE_SENSE_VA28_SFT                10
+#define RG_LCLDO_ENC_REMOTE_SENSE_VA28_MASK               0x1
+#define RG_LCLDO_ENC_REMOTE_SENSE_VA28_MASK_SFT           (0x1 << 10)
+#define RG_VA33REFGEN_EN_VA18_SFT                         12
+#define RG_VA33REFGEN_EN_VA18_MASK                        0x1
+#define RG_VA33REFGEN_EN_VA18_MASK_SFT                    (0x1 << 12)
+#define RG_VA28REFGEN_EN_VA28_SFT                         13
+#define RG_VA28REFGEN_EN_VA28_MASK                        0x1
+#define RG_VA28REFGEN_EN_VA28_MASK_SFT                    (0x1 << 13)
+#define RG_HCLDO_VOSEL_VA18_SFT                           14
+#define RG_HCLDO_VOSEL_VA18_MASK                          0x1
+#define RG_HCLDO_VOSEL_VA18_MASK_SFT                      (0x1 << 14)
+#define RG_LCLDO_VOSEL_VA18_SFT                           15
+#define RG_LCLDO_VOSEL_VA18_MASK                          0x1
+#define RG_LCLDO_VOSEL_VA18_MASK_SFT                      (0x1 << 15)
+
+/* MT6358_AUDDEC_ANA_CON15 */
+#define RG_NVREG_EN_VAUDP15_SFT                           0
+#define RG_NVREG_EN_VAUDP15_MASK                          0x1
+#define RG_NVREG_EN_VAUDP15_MASK_SFT                      (0x1 << 0)
+#define RG_NVREG_PULL0V_VAUDP15_SFT                       1
+#define RG_NVREG_PULL0V_VAUDP15_MASK                      0x1
+#define RG_NVREG_PULL0V_VAUDP15_MASK_SFT                  (0x1 << 1)
+#define RG_AUDPMU_RSD0_VAUDP15_SFT                        4
+#define RG_AUDPMU_RSD0_VAUDP15_MASK                       0xf
+#define RG_AUDPMU_RSD0_VAUDP15_MASK_SFT                   (0xf << 4)
+#define RG_AUDPMU_RSD0_VA18_SFT                           8
+#define RG_AUDPMU_RSD0_VA18_MASK                          0xf
+#define RG_AUDPMU_RSD0_VA18_MASK_SFT                      (0xf << 8)
+#define RG_AUDPMU_RSD0_VA28_SFT                           12
+#define RG_AUDPMU_RSD0_VA28_MASK                          0xf
+#define RG_AUDPMU_RSD0_VA28_MASK_SFT                      (0xf << 12)
+
+/* MT6358_ZCD_CON0 */
+#define RG_AUDZCDENABLE_SFT                               0
+#define RG_AUDZCDENABLE_MASK                              0x1
+#define RG_AUDZCDENABLE_MASK_SFT                          (0x1 << 0)
+#define RG_AUDZCDGAINSTEPTIME_SFT                         1
+#define RG_AUDZCDGAINSTEPTIME_MASK                        0x7
+#define RG_AUDZCDGAINSTEPTIME_MASK_SFT                    (0x7 << 1)
+#define RG_AUDZCDGAINSTEPSIZE_SFT                         4
+#define RG_AUDZCDGAINSTEPSIZE_MASK                        0x3
+#define RG_AUDZCDGAINSTEPSIZE_MASK_SFT                    (0x3 << 4)
+#define RG_AUDZCDTIMEOUTMODESEL_SFT                       6
+#define RG_AUDZCDTIMEOUTMODESEL_MASK                      0x1
+#define RG_AUDZCDTIMEOUTMODESEL_MASK_SFT                  (0x1 << 6)
+
+/* MT6358_ZCD_CON1 */
+#define RG_AUDLOLGAIN_SFT                                 0
+#define RG_AUDLOLGAIN_MASK                                0x1f
+#define RG_AUDLOLGAIN_MASK_SFT                            (0x1f << 0)
+#define RG_AUDLORGAIN_SFT                                 7
+#define RG_AUDLORGAIN_MASK                                0x1f
+#define RG_AUDLORGAIN_MASK_SFT                            (0x1f << 7)
+
+/* MT6358_ZCD_CON2 */
+#define RG_AUDHPLGAIN_SFT                                 0
+#define RG_AUDHPLGAIN_MASK                                0x1f
+#define RG_AUDHPLGAIN_MASK_SFT                            (0x1f << 0)
+#define RG_AUDHPRGAIN_SFT                                 7
+#define RG_AUDHPRGAIN_MASK                                0x1f
+#define RG_AUDHPRGAIN_MASK_SFT                            (0x1f << 7)
+
+/* MT6358_ZCD_CON3 */
+#define RG_AUDHSGAIN_SFT                                  0
+#define RG_AUDHSGAIN_MASK                                 0x1f
+#define RG_AUDHSGAIN_MASK_SFT                             (0x1f << 0)
+
+/* MT6358_ZCD_CON4 */
+#define RG_AUDIVLGAIN_SFT                                 0
+#define RG_AUDIVLGAIN_MASK                                0x7
+#define RG_AUDIVLGAIN_MASK_SFT                            (0x7 << 0)
+#define RG_AUDIVRGAIN_SFT                                 8
+#define RG_AUDIVRGAIN_MASK                                0x7
+#define RG_AUDIVRGAIN_MASK_SFT                            (0x7 << 8)
+
+/* MT6358_ZCD_CON5 */
+#define RG_AUDINTGAIN1_SFT                                0
+#define RG_AUDINTGAIN1_MASK                               0x3f
+#define RG_AUDINTGAIN1_MASK_SFT                           (0x3f << 0)
+#define RG_AUDINTGAIN2_SFT                                8
+#define RG_AUDINTGAIN2_MASK                               0x3f
+#define RG_AUDINTGAIN2_MASK_SFT                           (0x3f << 8)
+
+/* audio register */
+#define MT6358_DRV_CON3            0x3c
+#define MT6358_GPIO_DIR0           0x88
+
+#define MT6358_GPIO_MODE2          0xd8	/* mosi */
+#define MT6358_GPIO_MODE2_SET      0xda
+#define MT6358_GPIO_MODE2_CLR      0xdc
+
+#define MT6358_GPIO_MODE3          0xde	/* miso */
+#define MT6358_GPIO_MODE3_SET      0xe0
+#define MT6358_GPIO_MODE3_CLR      0xe2
+
+#define MT6358_TOP_CKPDN_CON0      0x10c
+#define MT6358_TOP_CKPDN_CON0_SET  0x10e
+#define MT6358_TOP_CKPDN_CON0_CLR  0x110
+
+#define MT6358_TOP_CKHWEN_CON0     0x12a
+#define MT6358_TOP_CKHWEN_CON0_SET 0x12c
+#define MT6358_TOP_CKHWEN_CON0_CLR 0x12e
+
+#define MT6358_OTP_CON0            0x38a
+#define MT6358_OTP_CON8            0x39a
+#define MT6358_OTP_CON11           0x3a0
+#define MT6358_OTP_CON12           0x3a2
+#define MT6358_OTP_CON13           0x3a4
+
+#define MT6358_DCXO_CW13           0x7aa
+#define MT6358_DCXO_CW14           0x7ac
+
+#define MT6358_AUXADC_CON10        0x11a0
+
+/* audio register */
+#define MT6358_AUD_TOP_ID                    0x2200
+#define MT6358_AUD_TOP_REV0                  0x2202
+#define MT6358_AUD_TOP_DBI                   0x2204
+#define MT6358_AUD_TOP_DXI                   0x2206
+#define MT6358_AUD_TOP_CKPDN_TPM0            0x2208
+#define MT6358_AUD_TOP_CKPDN_TPM1            0x220a
+#define MT6358_AUD_TOP_CKPDN_CON0            0x220c
+#define MT6358_AUD_TOP_CKPDN_CON0_SET        0x220e
+#define MT6358_AUD_TOP_CKPDN_CON0_CLR        0x2210
+#define MT6358_AUD_TOP_CKSEL_CON0            0x2212
+#define MT6358_AUD_TOP_CKSEL_CON0_SET        0x2214
+#define MT6358_AUD_TOP_CKSEL_CON0_CLR        0x2216
+#define MT6358_AUD_TOP_CKTST_CON0            0x2218
+#define MT6358_AUD_TOP_CLK_HWEN_CON0         0x221a
+#define MT6358_AUD_TOP_CLK_HWEN_CON0_SET     0x221c
+#define MT6358_AUD_TOP_CLK_HWEN_CON0_CLR     0x221e
+#define MT6358_AUD_TOP_RST_CON0              0x2220
+#define MT6358_AUD_TOP_RST_CON0_SET          0x2222
+#define MT6358_AUD_TOP_RST_CON0_CLR          0x2224
+#define MT6358_AUD_TOP_RST_BANK_CON0         0x2226
+#define MT6358_AUD_TOP_INT_CON0              0x2228
+#define MT6358_AUD_TOP_INT_CON0_SET          0x222a
+#define MT6358_AUD_TOP_INT_CON0_CLR          0x222c
+#define MT6358_AUD_TOP_INT_MASK_CON0         0x222e
+#define MT6358_AUD_TOP_INT_MASK_CON0_SET     0x2230
+#define MT6358_AUD_TOP_INT_MASK_CON0_CLR     0x2232
+#define MT6358_AUD_TOP_INT_STATUS0           0x2234
+#define MT6358_AUD_TOP_INT_RAW_STATUS0       0x2236
+#define MT6358_AUD_TOP_INT_MISC_CON0         0x2238
+#define MT6358_AUDNCP_CLKDIV_CON0            0x223a
+#define MT6358_AUDNCP_CLKDIV_CON1            0x223c
+#define MT6358_AUDNCP_CLKDIV_CON2            0x223e
+#define MT6358_AUDNCP_CLKDIV_CON3            0x2240
+#define MT6358_AUDNCP_CLKDIV_CON4            0x2242
+#define MT6358_AUD_TOP_MON_CON0              0x2244
+#define MT6358_AUDIO_DIG_DSN_ID              0x2280
+#define MT6358_AUDIO_DIG_DSN_REV0            0x2282
+#define MT6358_AUDIO_DIG_DSN_DBI             0x2284
+#define MT6358_AUDIO_DIG_DSN_DXI             0x2286
+#define MT6358_AFE_UL_DL_CON0                0x2288
+#define MT6358_AFE_DL_SRC2_CON0_L            0x228a
+#define MT6358_AFE_UL_SRC_CON0_H             0x228c
+#define MT6358_AFE_UL_SRC_CON0_L             0x228e
+#define MT6358_AFE_TOP_CON0                  0x2290
+#define MT6358_AUDIO_TOP_CON0                0x2292
+#define MT6358_AFE_MON_DEBUG0                0x2294
+#define MT6358_AFUNC_AUD_CON0                0x2296
+#define MT6358_AFUNC_AUD_CON1                0x2298
+#define MT6358_AFUNC_AUD_CON2                0x229a
+#define MT6358_AFUNC_AUD_CON3                0x229c
+#define MT6358_AFUNC_AUD_CON4                0x229e
+#define MT6358_AFUNC_AUD_CON5                0x22a0
+#define MT6358_AFUNC_AUD_CON6                0x22a2
+#define MT6358_AFUNC_AUD_MON0                0x22a4
+#define MT6358_AUDRC_TUNE_MON0               0x22a6
+#define MT6358_AFE_ADDA_MTKAIF_FIFO_CFG0     0x22a8
+#define MT6358_AFE_ADDA_MTKAIF_FIFO_LOG_MON1 0x22aa
+#define MT6358_AFE_ADDA_MTKAIF_MON0          0x22ac
+#define MT6358_AFE_ADDA_MTKAIF_MON1          0x22ae
+#define MT6358_AFE_ADDA_MTKAIF_MON2          0x22b0
+#define MT6358_AFE_ADDA_MTKAIF_MON3          0x22b2
+#define MT6358_AFE_ADDA_MTKAIF_CFG0          0x22b4
+#define MT6358_AFE_ADDA_MTKAIF_RX_CFG0       0x22b6
+#define MT6358_AFE_ADDA_MTKAIF_RX_CFG1       0x22b8
+#define MT6358_AFE_ADDA_MTKAIF_RX_CFG2       0x22ba
+#define MT6358_AFE_ADDA_MTKAIF_RX_CFG3       0x22bc
+#define MT6358_AFE_ADDA_MTKAIF_TX_CFG1       0x22be
+#define MT6358_AFE_SGEN_CFG0                 0x22c0
+#define MT6358_AFE_SGEN_CFG1                 0x22c2
+#define MT6358_AFE_ADC_ASYNC_FIFO_CFG        0x22c4
+#define MT6358_AFE_DCCLK_CFG0                0x22c6
+#define MT6358_AFE_DCCLK_CFG1                0x22c8
+#define MT6358_AUDIO_DIG_CFG                 0x22ca
+#define MT6358_AFE_AUD_PAD_TOP               0x22cc
+#define MT6358_AFE_AUD_PAD_TOP_MON           0x22ce
+#define MT6358_AFE_AUD_PAD_TOP_MON1          0x22d0
+#define MT6358_AFE_DL_NLE_CFG                0x22d2
+#define MT6358_AFE_DL_NLE_MON                0x22d4
+#define MT6358_AFE_CG_EN_MON                 0x22d6
+#define MT6358_AUDIO_DIG_2ND_DSN_ID          0x2300
+#define MT6358_AUDIO_DIG_2ND_DSN_REV0        0x2302
+#define MT6358_AUDIO_DIG_2ND_DSN_DBI         0x2304
+#define MT6358_AUDIO_DIG_2ND_DSN_DXI         0x2306
+#define MT6358_AFE_PMIC_NEWIF_CFG3           0x2308
+#define MT6358_AFE_VOW_TOP                   0x230a
+#define MT6358_AFE_VOW_CFG0                  0x230c
+#define MT6358_AFE_VOW_CFG1                  0x230e
+#define MT6358_AFE_VOW_CFG2                  0x2310
+#define MT6358_AFE_VOW_CFG3                  0x2312
+#define MT6358_AFE_VOW_CFG4                  0x2314
+#define MT6358_AFE_VOW_CFG5                  0x2316
+#define MT6358_AFE_VOW_CFG6                  0x2318
+#define MT6358_AFE_VOW_MON0                  0x231a
+#define MT6358_AFE_VOW_MON1                  0x231c
+#define MT6358_AFE_VOW_MON2                  0x231e
+#define MT6358_AFE_VOW_MON3                  0x2320
+#define MT6358_AFE_VOW_MON4                  0x2322
+#define MT6358_AFE_VOW_MON5                  0x2324
+#define MT6358_AFE_VOW_SN_INI_CFG            0x2326
+#define MT6358_AFE_VOW_TGEN_CFG0             0x2328
+#define MT6358_AFE_VOW_POSDIV_CFG0           0x232a
+#define MT6358_AFE_VOW_HPF_CFG0              0x232c
+#define MT6358_AFE_VOW_PERIODIC_CFG0         0x232e
+#define MT6358_AFE_VOW_PERIODIC_CFG1         0x2330
+#define MT6358_AFE_VOW_PERIODIC_CFG2         0x2332
+#define MT6358_AFE_VOW_PERIODIC_CFG3         0x2334
+#define MT6358_AFE_VOW_PERIODIC_CFG4         0x2336
+#define MT6358_AFE_VOW_PERIODIC_CFG5         0x2338
+#define MT6358_AFE_VOW_PERIODIC_CFG6         0x233a
+#define MT6358_AFE_VOW_PERIODIC_CFG7         0x233c
+#define MT6358_AFE_VOW_PERIODIC_CFG8         0x233e
+#define MT6358_AFE_VOW_PERIODIC_CFG9         0x2340
+#define MT6358_AFE_VOW_PERIODIC_CFG10        0x2342
+#define MT6358_AFE_VOW_PERIODIC_CFG11        0x2344
+#define MT6358_AFE_VOW_PERIODIC_CFG12        0x2346
+#define MT6358_AFE_VOW_PERIODIC_CFG13        0x2348
+#define MT6358_AFE_VOW_PERIODIC_CFG14        0x234a
+#define MT6358_AFE_VOW_PERIODIC_CFG15        0x234c
+#define MT6358_AFE_VOW_PERIODIC_CFG16        0x234e
+#define MT6358_AFE_VOW_PERIODIC_CFG17        0x2350
+#define MT6358_AFE_VOW_PERIODIC_CFG18        0x2352
+#define MT6358_AFE_VOW_PERIODIC_CFG19        0x2354
+#define MT6358_AFE_VOW_PERIODIC_CFG20        0x2356
+#define MT6358_AFE_VOW_PERIODIC_CFG21        0x2358
+#define MT6358_AFE_VOW_PERIODIC_CFG22        0x235a
+#define MT6358_AFE_VOW_PERIODIC_CFG23        0x235c
+#define MT6358_AFE_VOW_PERIODIC_MON0         0x235e
+#define MT6358_AFE_VOW_PERIODIC_MON1         0x2360
+#define MT6358_AUDENC_DSN_ID                 0x2380
+#define MT6358_AUDENC_DSN_REV0               0x2382
+#define MT6358_AUDENC_DSN_DBI                0x2384
+#define MT6358_AUDENC_DSN_FPI                0x2386
+#define MT6358_AUDENC_ANA_CON0               0x2388
+#define MT6358_AUDENC_ANA_CON1               0x238a
+#define MT6358_AUDENC_ANA_CON2               0x238c
+#define MT6358_AUDENC_ANA_CON3               0x238e
+#define MT6358_AUDENC_ANA_CON4               0x2390
+#define MT6358_AUDENC_ANA_CON5               0x2392
+#define MT6358_AUDENC_ANA_CON6               0x2394
+#define MT6358_AUDENC_ANA_CON7               0x2396
+#define MT6358_AUDENC_ANA_CON8               0x2398
+#define MT6358_AUDENC_ANA_CON9               0x239a
+#define MT6358_AUDENC_ANA_CON10              0x239c
+#define MT6358_AUDENC_ANA_CON11              0x239e
+#define MT6358_AUDENC_ANA_CON12              0x23a0
+#define MT6358_AUDDEC_DSN_ID                 0x2400
+#define MT6358_AUDDEC_DSN_REV0               0x2402
+#define MT6358_AUDDEC_DSN_DBI                0x2404
+#define MT6358_AUDDEC_DSN_FPI                0x2406
+#define MT6358_AUDDEC_ANA_CON0               0x2408
+#define MT6358_AUDDEC_ANA_CON1               0x240a
+#define MT6358_AUDDEC_ANA_CON2               0x240c
+#define MT6358_AUDDEC_ANA_CON3               0x240e
+#define MT6358_AUDDEC_ANA_CON4               0x2410
+#define MT6358_AUDDEC_ANA_CON5               0x2412
+#define MT6358_AUDDEC_ANA_CON6               0x2414
+#define MT6358_AUDDEC_ANA_CON7               0x2416
+#define MT6358_AUDDEC_ANA_CON8               0x2418
+#define MT6358_AUDDEC_ANA_CON9               0x241a
+#define MT6358_AUDDEC_ANA_CON10              0x241c
+#define MT6358_AUDDEC_ANA_CON11              0x241e
+#define MT6358_AUDDEC_ANA_CON12              0x2420
+#define MT6358_AUDDEC_ANA_CON13              0x2422
+#define MT6358_AUDDEC_ANA_CON14              0x2424
+#define MT6358_AUDDEC_ANA_CON15              0x2426
+#define MT6358_AUDDEC_ELR_NUM                0x2428
+#define MT6358_AUDDEC_ELR_0                  0x242a
+#define MT6358_AUDZCD_DSN_ID                 0x2480
+#define MT6358_AUDZCD_DSN_REV0               0x2482
+#define MT6358_AUDZCD_DSN_DBI                0x2484
+#define MT6358_AUDZCD_DSN_FPI                0x2486
+#define MT6358_ZCD_CON0                      0x2488
+#define MT6358_ZCD_CON1                      0x248a
+#define MT6358_ZCD_CON2                      0x248c
+#define MT6358_ZCD_CON3                      0x248e
+#define MT6358_ZCD_CON4                      0x2490
+#define MT6358_ZCD_CON5                      0x2492
+#define MT6358_ACCDET_CON13                  0x2522
+
+#define MT6358_MAX_REGISTER MT6358_ZCD_CON5
+
+enum {
+	MT6358_MTKAIF_PROTOCOL_1 = 0,
+	MT6358_MTKAIF_PROTOCOL_2,
+	MT6358_MTKAIF_PROTOCOL_2_CLK_P2,
+};
+
+/* set only during init */
+int mt6358_set_mtkaif_protocol(struct snd_soc_component *cmpnt,
+			       int mtkaif_protocol);
+int mt6358_mtkaif_calibration_enable(struct snd_soc_component *cmpnt);
+int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt);
+int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
+					int phase_1, int phase_2);
+#endif /* __MT6358_H__ */
-- 
2.20.1
