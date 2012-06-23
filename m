From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add shared code for Wolfson Arizona
	class devices
Date: Sat, 23 Jun 2012 12:13:01 +0100
Message-ID: <1340449982-17066-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47F3124688
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2012 13:13:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Wolfson Arizona series of audio hub CODECs can share a large amount
of their driver code as the result of a common register map. This patch
adds some of this core support, providing a basis for the initial WM5102
audio driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig   |    5 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/arizona.c |  781 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |  149 +++++++++
 4 files changed, 937 insertions(+)
 create mode 100644 sound/soc/codecs/arizona.c
 create mode 100644 sound/soc/codecs/arizona.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 43f5240..2ae8082 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -129,6 +129,11 @@ config SND_SOC_ALL_CODECS
 config SND_SOC_88PM860X
 	tristate
 
+config SND_SOC_ARIZONA
+	tristate
+	default y if SND_SOC_WM5102=y
+	default m if SND_SOC_WM5102=m
+
 config SND_SOC_WM_HUBS
 	tristate
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3d30654..3005ea6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -14,6 +14,7 @@ snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-arizona-objs := arizona.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l52-objs := cs42l52.o
@@ -128,6 +129,7 @@ obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
+obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
new file mode 100644
index 0000000..3b5730b
--- /dev/null
+++ b/sound/soc/codecs/arizona.c
@@ -0,0 +1,781 @@
+/*
+ * arizona.c - Wolfson Arizona class device shared support
+ *
+ * Copyright 2012 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gcd.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+
+#include <linux/mfd/arizona/core.h>
+#include <linux/mfd/arizona/registers.h>
+
+#include "arizona.h"
+
+#define ARIZONA_AIF_BCLK_CTRL                   0x00
+#define ARIZONA_AIF_TX_PIN_CTRL                 0x01
+#define ARIZONA_AIF_RX_PIN_CTRL                 0x02
+#define ARIZONA_AIF_RATE_CTRL                   0x03
+#define ARIZONA_AIF_FORMAT                      0x04
+#define ARIZONA_AIF_TX_BCLK_RATE                0x05
+#define ARIZONA_AIF_RX_BCLK_RATE                0x06
+#define ARIZONA_AIF_FRAME_CTRL_1                0x07
+#define ARIZONA_AIF_FRAME_CTRL_2                0x08
+#define ARIZONA_AIF_FRAME_CTRL_3                0x09
+#define ARIZONA_AIF_FRAME_CTRL_4                0x0A
+#define ARIZONA_AIF_FRAME_CTRL_5                0x0B
+#define ARIZONA_AIF_FRAME_CTRL_6                0x0C
+#define ARIZONA_AIF_FRAME_CTRL_7                0x0D
+#define ARIZONA_AIF_FRAME_CTRL_8                0x0E
+#define ARIZONA_AIF_FRAME_CTRL_9                0x0F
+#define ARIZONA_AIF_FRAME_CTRL_10               0x10
+#define ARIZONA_AIF_FRAME_CTRL_11               0x11
+#define ARIZONA_AIF_FRAME_CTRL_12               0x12
+#define ARIZONA_AIF_FRAME_CTRL_13               0x13
+#define ARIZONA_AIF_FRAME_CTRL_14               0x14
+#define ARIZONA_AIF_FRAME_CTRL_15               0x15
+#define ARIZONA_AIF_FRAME_CTRL_16               0x16
+#define ARIZONA_AIF_FRAME_CTRL_17               0x17
+#define ARIZONA_AIF_FRAME_CTRL_18               0x18
+#define ARIZONA_AIF_TX_ENABLES                  0x19
+#define ARIZONA_AIF_RX_ENABLES                  0x1A
+#define ARIZONA_AIF_FORCE_WRITE                 0x1B
+
+#define arizona_fll_err(_fll, fmt, ...) \
+	dev_err(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+#define arizona_fll_warn(_fll, fmt, ...) \
+	dev_warn(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+#define arizona_fll_dbg(_fll, fmt, ...) \
+	dev_err(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+
+#define arizona_aif_err(_dai, fmt, ...) \
+	dev_err(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
+#define arizona_aif_warn(_dai, fmt, ...) \
+	dev_warn(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
+#define arizona_aif_dbg(_dai, fmt, ...) \
+	dev_err(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
+
+const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
+	"None",
+	"Tone Generator 1",
+	"Tone Generator 2",
+	"Haptics",
+	"AEC",
+	"Mic Mute Mixer",
+	"Noise Generator",
+	"IN1L",
+	"IN1R",
+	"IN2L",
+	"IN2R",
+	"IN3L",
+	"IN3R",
+	"AIF1RX1",
+	"AIF1RX2",
+	"AIF1RX3",
+	"AIF1RX4",
+	"AIF1RX5",
+	"AIF1RX6",
+	"AIF1RX7",
+	"AIF1RX8",
+	"AIF2RX1",
+	"AIF2RX2",
+	"AIF3RX1",
+	"AIF3RX2",
+	"SLIMRX1",
+	"SLIMRX2",
+	"SLIMRX3",
+	"SLIMRX4",
+	"SLIMRX5",
+	"SLIMRX6",
+	"SLIMRX7",
+	"SLIMRX8",
+	"EQ1",
+	"EQ2",
+	"EQ3",
+	"EQ4",
+	"DRC1L",
+	"DRC1R",
+	"DRC2L",
+	"DRC2R",
+	"LHPF1",
+	"LHPF2",
+	"LHPF3",
+	"LHPF4",
+	"DSP1.1",
+	"DSP1.2",
+	"DSP1.3",
+	"DSP1.4",
+	"DSP1.5",
+	"DSP1.6",
+	"ASRC1L",
+	"ASRC1R",
+	"ASRC2L",
+	"ASRC2R",
+};
+EXPORT_SYMBOL_GPL(arizona_mixer_texts);
+
+int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS] = {
+	0x00,  /* None */
+	0x04,  /* Tone */
+	0x05,
+	0x06,  /* Haptics */
+	0x08,  /* AEC */
+	0x0c,  /* Noise mixer */
+	0x0d,  /* Comfort noise */
+	0x10,  /* IN1L */
+	0x11,
+	0x12,
+	0x13,
+	0x14,
+	0x15,
+	0x20,  /* AIF1RX1 */
+	0x21,
+	0x22,
+	0x23,
+	0x24,
+	0x25,
+	0x26,
+	0x27,
+	0x28,  /* AIF2RX1 */
+	0x29,
+	0x30,  /* AIF3RX1 */
+	0x31,
+	0x38,  /* SLIMRX1 */
+	0x39,
+	0x3a,
+	0x3b,
+	0x3c,
+	0x3d,
+	0x3e,
+	0x3f,
+	0x50,  /* EQ1 */
+	0x51,
+	0x52,
+	0x53,
+	0x58,  /* DRC1L */
+	0x59,
+	0x5a,
+	0x5b,
+	0x60,  /* LHPF1 */
+	0x61,
+	0x62,
+	0x63,
+	0x68,  /* DSP1.1 */
+	0x69,
+	0x6a,
+	0x6b,
+	0x6c,
+	0x6d,
+	0x90,  /* ASRC1L */
+	0x91,
+	0x92,
+	0x93,
+};
+EXPORT_SYMBOL_GPL(arizona_mixer_values);
+
+const DECLARE_TLV_DB_SCALE(arizona_mixer_tlv, -3200, 100, 0);
+EXPORT_SYMBOL_GPL(arizona_mixer_tlv);
+
+static const char *arizona_lhpf_mode_text[] = {
+	"Low-pass", "High-pass"
+};
+
+const struct soc_enum arizona_lhpf1_mode =
+	SOC_ENUM_SINGLE(ARIZONA_HPLPF1_1, ARIZONA_LHPF1_MODE_SHIFT, 2,
+			arizona_lhpf_mode_text);
+EXPORT_SYMBOL_GPL(arizona_lhpf1_mode);
+
+const struct soc_enum arizona_lhpf2_mode =
+	SOC_ENUM_SINGLE(ARIZONA_HPLPF2_1, ARIZONA_LHPF2_MODE_SHIFT, 2,
+			arizona_lhpf_mode_text);
+EXPORT_SYMBOL_GPL(arizona_lhpf2_mode);
+
+const struct soc_enum arizona_lhpf3_mode =
+	SOC_ENUM_SINGLE(ARIZONA_HPLPF3_1, ARIZONA_LHPF3_MODE_SHIFT, 2,
+			arizona_lhpf_mode_text);
+EXPORT_SYMBOL_GPL(arizona_lhpf3_mode);
+
+const struct soc_enum arizona_lhpf4_mode =
+	SOC_ENUM_SINGLE(ARIZONA_HPLPF4_1, ARIZONA_LHPF4_MODE_SHIFT, 2,
+			arizona_lhpf_mode_text);
+EXPORT_SYMBOL_GPL(arizona_lhpf4_mode);
+
+int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		  int event)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_in_ev);
+
+int arizona_out_ev(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol,
+		   int event)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_out_ev);
+
+int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+		       int source, unsigned int freq, int dir)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	char *name;
+	unsigned int reg;
+	unsigned int mask = ARIZONA_SYSCLK_FREQ_MASK | ARIZONA_SYSCLK_SRC_MASK;
+	unsigned int val = source << ARIZONA_SYSCLK_SRC_SHIFT;
+	unsigned int *clk;
+
+	switch (clk_id) {
+	case ARIZONA_CLK_SYSCLK:
+		name = "SYSCLK";
+		reg = ARIZONA_SYSTEM_CLOCK_1;
+		clk = &priv->sysclk;
+		mask |= ARIZONA_SYSCLK_FRAC;
+		break;
+	case ARIZONA_CLK_ASYNCCLK:
+		name = "ASYNCCLK";
+		reg = ARIZONA_ASYNC_CLOCK_1;
+		clk = &priv->asyncclk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (freq) {
+	case  5644800:
+	case  6144000:
+		break;
+	case 11289600:
+	case 12288000:
+		val |= 1 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
+	case 22579200:
+	case 24576000:
+		val |= 2 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
+	case 45158400:
+	case 49152000:
+		val |= 3 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*clk = freq;
+
+	if (freq % 6144000)
+		val |= ARIZONA_SYSCLK_FRAC;
+
+	dev_dbg(arizona->dev, "%s set to %uHz", name, freq);
+
+	return regmap_update_bits(arizona->regmap, reg, mask, val);
+}
+EXPORT_SYMBOL_GPL(arizona_set_sysclk);
+
+static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int lrclk, bclk, mode, base;
+
+	base = dai->driver->base;
+
+	lrclk = 0;
+	bclk = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mode = 0;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		mode = 1;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		mode = 2;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode = 3;
+		break;
+	default:
+		arizona_aif_err(dai, "Unsupported DAI format %d\n",
+				fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		lrclk |= ARIZONA_AIF1TX_LRCLK_MSTR;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		bclk |= ARIZONA_AIF1_BCLK_MSTR;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		bclk |= ARIZONA_AIF1_BCLK_MSTR;
+		lrclk |= ARIZONA_AIF1TX_LRCLK_MSTR;
+		break;
+	default:
+		arizona_aif_err(dai, "Unsupported master mode %d\n",
+				fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		bclk |= ARIZONA_AIF1_BCLK_INV;
+		lrclk |= ARIZONA_AIF1TX_LRCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		bclk |= ARIZONA_AIF1_BCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		lrclk |= ARIZONA_AIF1TX_LRCLK_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_BCLK_CTRL,
+			    ARIZONA_AIF1_BCLK_INV | ARIZONA_AIF1_BCLK_MSTR,
+			    bclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_PIN_CTRL,
+			    ARIZONA_AIF1TX_LRCLK_INV |
+			    ARIZONA_AIF1TX_LRCLK_MSTR, lrclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_PIN_CTRL,
+			    ARIZONA_AIF1RX_LRCLK_INV |
+			    ARIZONA_AIF1RX_LRCLK_MSTR, lrclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_FORMAT,
+			    ARIZONA_AIF1_FMT_MASK, mode);
+
+	return 0;
+}
+
+static const int arizona_48k_rates[] = {
+	-1,
+	48000,
+	64000,
+	96000,
+	128000,
+	192000,
+	256000,
+	384000,
+	512000,
+	768000,
+	1024000,
+	1536000,
+	2048000,
+	3072000,
+	4096000,
+	6144000,
+	8192000,
+	12288000,
+	24576000,
+};
+
+static const int arizona_44k1_rates[] = {
+	-1,
+	44100,
+	58800,
+	88200,
+	117600,
+	177640,
+	235200,
+	352800,
+	470400,
+	705600,
+	940800,
+	1411200,
+	1881600,
+	2882400,
+	3763200,
+	5644800,
+	7526400,
+	11289600,
+	22579200,
+};
+
+static int arizona_sr_vals[] = {
+	0,
+	12000,
+	24000,
+	48000,
+	96000,
+	192000,
+	384000,
+	768000,
+	0,
+	11025,
+	22050,
+	44100,
+	88200,
+	176400,
+	352800,
+	705600,
+	4000,
+	8000,
+	16000,
+	32000,
+	64000,
+	128000,
+	256000,
+	512000,
+};
+
+static int arizona_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int base = dai->driver->base;
+	const int *rates;
+	int i;
+	int bclk, lrclk, wl, frame, sr_val;
+
+	if (params_rate(params) % 8000)
+		rates = &arizona_44k1_rates[0];
+	else
+		rates = &arizona_48k_rates[0];
+
+	for (i = 0; i < ARRAY_SIZE(arizona_44k1_rates); i++) {
+		if (rates[i] == snd_soc_params_to_bclk(params)) {
+			bclk = i;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(arizona_44k1_rates)) {
+		arizona_aif_err(dai, "Unsupported sample rate %dHz\n",
+				params_rate(params));
+		return -EINVAL;
+	}
+
+	/*
+	 * We will need to be more flexible than this in future,
+	 * currently we use a single sample rate for the chip.
+	 */
+	for (i = 0; i < ARRAY_SIZE(arizona_sr_vals); i++)
+		if (arizona_sr_vals[i] == params_rate(params))
+			break;
+	if (i == ARRAY_SIZE(arizona_sr_vals)) {
+		arizona_aif_err(dai, "Unsupported sample rate %dHz\n",
+				params_rate(params));
+		return -EINVAL;
+	}
+	sr_val = i;
+
+	lrclk = snd_soc_params_to_bclk(params) / params_rate(params);
+
+	arizona_aif_dbg(dai, "BCLK %dHz LRCLK %dHz\n",
+			rates[bclk], rates[bclk] / lrclk);
+
+	wl = snd_pcm_format_width(params_format(params));
+	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
+
+	snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
+			    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_BCLK_CTRL,
+			    ARIZONA_AIF1_BCLK_FREQ_MASK, bclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_BCLK_RATE,
+			    ARIZONA_AIF1TX_BCPF_MASK, lrclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_BCLK_RATE,
+			    ARIZONA_AIF1RX_BCPF_MASK, lrclk);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_FRAME_CTRL_1,
+			    ARIZONA_AIF1TX_WL_MASK |
+			    ARIZONA_AIF1TX_SLOT_LEN_MASK, frame);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_FRAME_CTRL_2,
+			    ARIZONA_AIF1RX_WL_MASK |
+			    ARIZONA_AIF1RX_SLOT_LEN_MASK, frame);
+
+	return 0;
+}
+
+const struct snd_soc_dai_ops arizona_dai_ops = {
+	.set_fmt = arizona_set_fmt,
+	.hw_params = arizona_hw_params,
+};
+
+static irqreturn_t arizona_fll_lock(int irq, void *data)
+{
+	struct arizona_fll *fll = data;
+
+	arizona_fll_dbg(fll, "Locked\n");
+
+	complete(&fll->lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t arizona_fll_clock_ok(int irq, void *data)
+{
+	struct arizona_fll *fll = data;
+
+	arizona_fll_dbg(fll, "clock OK\n");
+
+	complete(&fll->ok);
+
+	return IRQ_HANDLED;
+}
+
+static struct {
+	unsigned int min;
+	unsigned int max;
+	u16 fratio;
+	int ratio;
+} fll_fratios[] = {
+	{       0,    64000, 4, 16 },
+	{   64000,   128000, 3,  8 },
+	{  128000,   256000, 2,  4 },
+	{  256000,  1000000, 1,  2 },
+	{ 1000000, 13500000, 0,  1 },
+};
+
+struct arizona_fll_cfg {
+	int n;
+	int theta;
+	int lambda;
+	int refdiv;
+	int outdiv;
+	int fratio;
+};
+
+static int arizona_calc_fll(struct arizona_fll *fll,
+			    struct arizona_fll_cfg *cfg,
+			    unsigned int Fref,
+			    unsigned int Fout)
+{
+	unsigned int target, div, gcd_fll;
+	int i, ratio;
+
+	arizona_fll_dbg(fll, "Fref=%u Fout=%u\n", Fref, Fout);
+
+	/* Fref must be <=13.5MHz */
+	div = 1;
+	cfg->refdiv = 0;
+	while ((Fref / div) > 13500000) {
+		div *= 2;
+		cfg->refdiv++;
+
+		if (div > 8) {
+			arizona_fll_err(fll,
+					"Can't scale %dMHz in to <=13.5MHz\n",
+					Fref);
+			return -EINVAL;
+		}
+	}
+
+	/* Apply the division for our remaining calculations */
+	Fref /= div;
+
+	/* Fvco should be 90-100MHz; don't check the upper bound */
+	div = 1;
+	while (Fout * div < 90000000) {
+		div++;
+		if (div > 7) {
+			arizona_fll_err(fll, "No FLL_OUTDIV for Fout=%uHz\n",
+					Fout);
+			return -EINVAL;
+		}
+	}
+	target = Fout * div;
+	cfg->outdiv = div;
+
+	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
+
+	/* Find an appropraite FLL_FRATIO and factor it out of the target */
+	for (i = 0; i < ARRAY_SIZE(fll_fratios); i++) {
+		if (fll_fratios[i].min <= Fref && Fref <= fll_fratios[i].max) {
+			cfg->fratio = fll_fratios[i].fratio;
+			ratio = fll_fratios[i].ratio;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(fll_fratios)) {
+		arizona_fll_err(fll, "Unable to find FRATIO for Fref=%uHz\n",
+				Fref);
+		return -EINVAL;
+	}
+
+	cfg->n = target / (ratio * Fref);
+
+	if (target % Fref) {
+		gcd_fll = gcd(target, ratio * Fref);
+		arizona_fll_dbg(fll, "GCD=%u\n", gcd_fll);
+
+		cfg->theta = (target - (cfg->n * ratio * Fref))
+			/ gcd_fll;
+		cfg->lambda = (ratio * Fref) / gcd_fll;
+	} else {
+		cfg->theta = 0;
+		cfg->lambda = 0;
+	}
+
+	arizona_fll_dbg(fll, "N=%x THETA=%x LAMBDA=%x\n",
+			cfg->n, cfg->theta, cfg->lambda);
+	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
+			cfg->fratio, cfg->fratio, cfg->outdiv, cfg->refdiv);
+
+	return 0;
+
+}
+
+static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
+			      struct arizona_fll_cfg *cfg, int source)
+{
+	regmap_update_bits(arizona->regmap, base + 3,
+			   ARIZONA_FLL1_THETA_MASK, cfg->theta);
+	regmap_update_bits(arizona->regmap, base + 4,
+			   ARIZONA_FLL1_LAMBDA_MASK, cfg->lambda);
+	regmap_update_bits(arizona->regmap, base + 5,
+			   ARIZONA_FLL1_FRATIO_MASK,
+			   cfg->fratio << ARIZONA_FLL1_FRATIO_SHIFT);
+	regmap_update_bits(arizona->regmap, base + 6,
+			   ARIZONA_FLL1_CLK_REF_DIV_MASK |
+			   ARIZONA_FLL1_CLK_REF_SRC_MASK,
+			   cfg->refdiv << ARIZONA_FLL1_CLK_REF_DIV_SHIFT |
+			   source << ARIZONA_FLL1_CLK_REF_SRC_SHIFT);
+
+	regmap_update_bits(arizona->regmap, base + 2,
+			   ARIZONA_FLL1_CTRL_UPD | ARIZONA_FLL1_N_MASK,
+			   ARIZONA_FLL1_CTRL_UPD | cfg->n);
+}
+
+int arizona_set_fll(struct arizona_fll *fll, int source,
+		    unsigned int Fref, unsigned int Fout)
+{
+	struct arizona *arizona = fll->arizona;
+	struct arizona_fll_cfg cfg, sync;
+	unsigned int reg, val;
+	int syncsrc;
+	bool ena;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
+	if (ret != 0) {
+		arizona_fll_err(fll, "Failed to read current state: %d\n",
+				ret);
+		return ret;
+	}
+	ena = reg & ARIZONA_FLL1_ENA;
+
+	if (Fout) {
+		/* Do we have a 32kHz reference? */
+		regmap_read(arizona->regmap, ARIZONA_CLOCK_32K_1, &val);
+		switch (val & ARIZONA_CLK_32K_SRC_MASK) {
+		case ARIZONA_CLK_SRC_MCLK1:
+		case ARIZONA_CLK_SRC_MCLK2:
+			syncsrc = val & ARIZONA_CLK_32K_SRC_MASK;
+			break;
+		default:
+			syncsrc = -1;
+		}
+
+		if (source == syncsrc)
+			syncsrc = -1;
+
+		if (syncsrc >= 0) {
+			ret = arizona_calc_fll(fll, &sync, Fref, Fout);
+			if (ret != 0)
+				return ret;
+
+			ret = arizona_calc_fll(fll, &cfg, 32768, Fout);
+			if (ret != 0)
+				return ret;
+		} else {
+			ret = arizona_calc_fll(fll, &cfg, Fref, Fout);
+			if (ret != 0)
+				return ret;
+		}
+	} else {
+		regmap_update_bits(arizona->regmap, fll->base + 1,
+				   ARIZONA_FLL1_ENA, 0);
+		regmap_update_bits(arizona->regmap, fll->base + 0x11,
+				   ARIZONA_FLL1_SYNC_ENA, 0);
+
+		if (ena)
+			pm_runtime_put_autosuspend(arizona->dev);
+
+		return 0;
+	}
+
+	regmap_update_bits(arizona->regmap, fll->base + 5,
+			   ARIZONA_FLL1_OUTDIV_MASK,
+			   cfg.outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+
+	if (syncsrc >= 0) {
+		arizona_apply_fll(arizona, fll->base, &cfg, syncsrc);
+		arizona_apply_fll(arizona, fll->base + 0x10, &sync, source);
+	} else {
+		arizona_apply_fll(arizona, fll->base, &cfg, source);
+	}
+
+	if (!ena)
+		pm_runtime_get(arizona->dev);
+
+	/* Clear any pending completions */
+	try_wait_for_completion(&fll->ok);
+
+	regmap_update_bits(arizona->regmap, fll->base + 1,
+			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
+	if (syncsrc >= 0)
+		regmap_update_bits(arizona->regmap, fll->base + 0x11,
+				   ARIZONA_FLL1_SYNC_ENA,
+				   ARIZONA_FLL1_SYNC_ENA);
+
+	ret = wait_for_completion_timeout(&fll->ok,
+					  msecs_to_jiffies(25));
+	if (ret == 0)
+		arizona_fll_warn(fll, "Timed out waiting for lock\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_set_fll);
+
+int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
+		     int ok_irq, struct arizona_fll *fll)
+{
+	int ret;
+
+	init_completion(&fll->lock);
+	init_completion(&fll->ok);
+
+	fll->id = id;
+	fll->base = base;
+	fll->arizona = arizona;
+
+	snprintf(fll->lock_name, sizeof(fll->lock_name), "FLL%d lock", id);
+	snprintf(fll->clock_ok_name, sizeof(fll->clock_ok_name),
+		 "FLL%d clock OK", id);
+
+	ret = arizona_request_irq(arizona, lock_irq, fll->lock_name,
+				  arizona_fll_lock, fll);
+	if (ret != 0) {
+		dev_err(arizona->dev, "Failed to get FLL%d lock IRQ: %d\n",
+			id, ret);
+	}
+
+	ret = arizona_request_irq(arizona, ok_irq, fll->clock_ok_name,
+				  arizona_fll_clock_ok, fll);
+	if (ret != 0) {
+		dev_err(arizona->dev, "Failed to get FLL%d clock OK IRQ: %d\n",
+			id, ret);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_fll);
+
+MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
new file mode 100644
index 0000000..8c2ca1d
--- /dev/null
+++ b/sound/soc/codecs/arizona.h
@@ -0,0 +1,149 @@
+/*
+ * arizona.h - Wolfson Arizona class device shared support
+ *
+ * Copyright 2012 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASOC_ARIZONA_H
+#define _ASOC_ARIZONA_H
+
+#include <linux/completion.h>
+
+#include <sound/soc.h>
+
+#define ARIZONA_CLK_SYSCLK   1
+#define ARIZONA_CLK_ASYNCCLK 2
+
+#define ARIZONA_CLK_SRC_MCLK1    0x0
+#define ARIZONA_CLK_SRC_MCLK2    0x1
+#define ARIZONA_CLK_SRC_FLL1     0x4
+#define ARIZONA_CLK_SRC_FLL2     0x5
+#define ARIZONA_CLK_SRC_AIF1BCLK 0x8
+#define ARIZONA_CLK_SRC_AIF2BCLK 0x9
+#define ARIZONA_CLK_SRC_AIF3BCLK 0xa
+
+#define ARIZONA_FLL_SRC_MCLK1      0
+#define ARIZONA_FLL_SRC_MCLK2      1
+#define ARIZONA_FLL_SRC_SLIMCLK    2
+#define ARIZONA_FLL_SRC_FLL1       3
+#define ARIZONA_FLL_SRC_FLL2       4
+#define ARIZONA_FLL_SRC_AIF1BCLK   5
+#define ARIZONA_FLL_SRC_AIF2BCLK   6
+#define ARIZONA_FLL_SRC_AIF3BCLK   7
+#define ARIZONA_FLL_SRC_AIF1LRCLK  8
+#define ARIZONA_FLL_SRC_AIF2LRCLK  9
+#define ARIZONA_FLL_SRC_AIF3LRCLK 10
+
+#define ARIZONA_MIXER_VOL_MASK             0x00FE
+#define ARIZONA_MIXER_VOL_SHIFT                 1
+#define ARIZONA_MIXER_VOL_WIDTH                 7
+
+struct arizona;
+
+struct arizona_priv {
+	struct arizona *arizona;
+	int sysclk;
+	int asyncclk;
+};
+
+#define ARIZONA_NUM_MIXER_INPUTS 55
+
+extern const unsigned int arizona_mixer_tlv[];
+extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
+extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
+
+#define ARIZONA_MIXER_CONTROLS(name, base) \
+	SOC_SINGLE_RANGE_TLV(name " Input 1 Volume", base + 1,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv),			\
+	SOC_SINGLE_RANGE_TLV(name " Input 2 Volume", base + 3,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv),			\
+	SOC_SINGLE_RANGE_TLV(name " Input 3 Volume", base + 5,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv),			\
+	SOC_SINGLE_RANGE_TLV(name " Input 4 Volume", base + 7,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv)
+
+#define ARIZONA_MUX_ENUM_DECL(name, reg) \
+	SOC_VALUE_ENUM_SINGLE_DECL(name, reg, 0, 0xff,			\
+				   arizona_mixer_texts, arizona_mixer_values)
+
+#define ARIZONA_MUX_CTL_DECL(name) \
+	const struct snd_kcontrol_new name##_mux =	\
+		SOC_DAPM_VALUE_ENUM("Route", name##_enum)
+
+#define ARIZONA_MIXER_ENUMS(name, base_reg) \
+	static ARIZONA_MUX_ENUM_DECL(name##_in1_enum, base_reg);      \
+	static ARIZONA_MUX_ENUM_DECL(name##_in2_enum, base_reg + 2);  \
+	static ARIZONA_MUX_ENUM_DECL(name##_in3_enum, base_reg + 4);  \
+	static ARIZONA_MUX_ENUM_DECL(name##_in4_enum, base_reg + 6);  \
+	static ARIZONA_MUX_CTL_DECL(name##_in1); \
+	static ARIZONA_MUX_CTL_DECL(name##_in2); \
+	static ARIZONA_MUX_CTL_DECL(name##_in3); \
+	static ARIZONA_MUX_CTL_DECL(name##_in4)
+
+#define ARIZONA_MUX(name, ctrl) \
+	SND_SOC_DAPM_VALUE_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
+
+#define ARIZONA_MIXER_WIDGETS(name, name_str)	\
+	ARIZONA_MUX(name_str " Input 1", &name##_in1_mux), \
+	ARIZONA_MUX(name_str " Input 2", &name##_in2_mux), \
+	ARIZONA_MUX(name_str " Input 3", &name##_in3_mux), \
+	ARIZONA_MUX(name_str " Input 4", &name##_in4_mux), \
+	SND_SOC_DAPM_MIXER(name_str " Mixer", SND_SOC_NOPM, 0, 0, NULL, 0)
+
+#define ARIZONA_MIXER_ROUTES(widget, name) \
+	{ widget, NULL, name " Mixer" },         \
+	{ name " Mixer", NULL, name " Input 1" }, \
+	{ name " Mixer", NULL, name " Input 2" }, \
+	{ name " Mixer", NULL, name " Input 3" }, \
+	{ name " Mixer", NULL, name " Input 4" }, \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 1"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 2"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 3"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 4")
+
+extern const struct soc_enum arizona_lhpf1_mode;
+extern const struct soc_enum arizona_lhpf2_mode;
+extern const struct soc_enum arizona_lhpf3_mode;
+extern const struct soc_enum arizona_lhpf4_mode;
+
+extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol,
+			 int event);
+extern int arizona_out_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event);
+
+extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+			      int source, unsigned int freq, int dir);
+
+extern const struct snd_soc_dai_ops arizona_dai_ops;
+
+#define ARIZONA_FLL_NAME_LEN 20
+
+struct arizona_fll {
+	struct arizona *arizona;
+	int id;
+	unsigned int base;
+	struct completion lock;
+	struct completion ok;
+
+	char lock_name[ARIZONA_FLL_NAME_LEN];
+	char clock_ok_name[ARIZONA_FLL_NAME_LEN];
+};
+
+extern int arizona_init_fll(struct arizona *arizona, int id, int base,
+			    int lock_irq, int ok_irq, struct arizona_fll *fll);
+extern int arizona_set_fll(struct arizona_fll *fll, int source,
+			   unsigned int Fref, unsigned int Fout);
+
+#endif
-- 
1.7.10
