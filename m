From: Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 2/2] ASoC: Add MICFIL SoC Digital Audio
	Interface driver.
Date: Fri, 4 Jan 2019 09:17:38 +0000
Message-ID: <1546593445-10509-3-git-send-email-cosmin.samoila@nxp.com>
References: <1546593445-10509-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
 by alsa0.perex.cz (Postfix) with ESMTP id CD1A0267B3F
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 10:17:40 +0100 (CET)
In-Reply-To: <1546593445-10509-1-git-send-email-cosmin.samoila@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

Add Digital Audio Interface driver that convers PDM bitstream to PCM
format.

Features:
- Fixed filtering characteristics for audio application.
- Full or partial set of channels operation with individual enable control.
- Programmable PDM clock generator.
- Programmable decimation rate.
- 16-bit signed output result.
- Overall stopband attenuation more than 80dB.
- Overall passband ripple less than 0.2dB.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/Kconfig      |   9 +
 sound/soc/fsl/Makefile     |   2 +
 sound/soc/fsl/fsl_micfil.c | 826 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_micfil.h | 283 ++++++++++++++++
 4 files changed, 1120 insertions(+)
 create mode 100644 sound/soc/fsl/fsl_micfil.c
 create mode 100644 sound/soc/fsl/fsl_micfil.h

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 2e75b5b..7b1d997 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -57,6 +57,15 @@ config SND_SOC_FSL_ESAI
 	  This option is only useful for out-of-tree drivers since
 	  in-tree drivers select it automatically.
 
+config SND_SOC_FSL_MICFIL
+	tristate "Pulse Density Modulation Microphone Interface (MICFIL) module support"
+	select REGMAP_MMIO
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y if you want to add Pulse Density Modulation microphone
+	  interface (MICFIL) support for NXP.
+
 config SND_SOC_FSL_UTILS
 	tristate
 
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index de94fa0..3c0ff31 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -19,6 +19,7 @@ snd-soc-fsl-ssi-y := fsl_ssi.o
 snd-soc-fsl-ssi-$(CONFIG_DEBUG_FS) += fsl_ssi_dbg.o
 snd-soc-fsl-spdif-objs := fsl_spdif.o
 snd-soc-fsl-esai-objs := fsl_esai.o
+snd-soc-fsl-micfil-objs := fsl_micfil.o
 snd-soc-fsl-utils-objs := fsl_utils.o
 snd-soc-fsl-dma-objs := fsl_dma.o
 obj-$(CONFIG_SND_SOC_FSL_ASOC_CARD) += snd-soc-fsl-asoc-card.o
@@ -27,6 +28,7 @@ obj-$(CONFIG_SND_SOC_FSL_SAI) += snd-soc-fsl-sai.o
 obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
 obj-$(CONFIG_SND_SOC_FSL_SPDIF) += snd-soc-fsl-spdif.o
 obj-$(CONFIG_SND_SOC_FSL_ESAI) += snd-soc-fsl-esai.o
+obj-$(CONFIG_SND_SOC_FSL_MICFIL) += snd-soc-fsl-micfil.o
 obj-$(CONFIG_SND_SOC_FSL_UTILS) += snd-soc-fsl-utils.o
 obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
 
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
new file mode 100644
index 0000000..40c07e7
--- /dev/null
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2018 NXP
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kobject.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/core.h>
+
+#include "fsl_micfil.h"
+#include "imx-pcm.h"
+
+#define FSL_MICFIL_RATES		SNDRV_PCM_RATE_8000_48000
+#define FSL_MICFIL_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE)
+
+struct fsl_micfil {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	const struct fsl_micfil_soc_data *soc;
+	struct clk *mclk;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	unsigned int dataline;
+	char name[32];
+	int irq[MICFIL_IRQ_LINES];
+	unsigned int mclk_streams;
+	int quality;	/*QUALITY 2-0 bits */
+	bool slave_mode;
+	int channel_gain[8];
+};
+
+struct fsl_micfil_soc_data {
+	unsigned int fifos;
+	unsigned int fifo_depth;
+	unsigned int dataline;
+	bool imx;
+};
+
+static struct fsl_micfil_soc_data fsl_micfil_imx8mm = {
+	.imx = true,
+	.fifos = 8,
+	.fifo_depth = 8,
+	.dataline =  0xf,
+};
+
+static const struct of_device_id fsl_micfil_dt_ids[] = {
+	{ .compatible = "fsl,imx8mm-micfil", .data = &fsl_micfil_imx8mm },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_micfil_dt_ids);
+
+/* Table 5. Quality Modes
+ * Medium	0 0 0
+ * High		0 0 1
+ * Very Low 2	1 0 0
+ * Very Low 1	1 0 1
+ * Very Low 0	1 1 0
+ * Low		1 1 1
+ */
+static const char * const micfil_quality_select_texts[] = {
+	"Medium", "High",
+	"N/A", "N/A",
+	"VLow2", "VLow1",
+	"VLow0", "Low",
+};
+
+static const struct soc_enum fsl_micfil_quality_enum =
+	SOC_ENUM_SINGLE(REG_MICFIL_CTRL2,
+			MICFIL_CTRL2_QSEL_SHIFT,
+			ARRAY_SIZE(micfil_quality_select_texts),
+			micfil_quality_select_texts);
+
+static DECLARE_TLV_DB_SCALE(gain_tlv, 0, 100, 0);
+
+static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
+	SOC_SINGLE_SX_TLV("CH0 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(0), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH1 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(1), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH2 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(2), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH3 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(3), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH4 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(4), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH5 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(5), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH6 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(6), 0xF, 0x7, gain_tlv),
+	SOC_SINGLE_SX_TLV("CH7 Volume", REG_MICFIL_OUT_CTRL,
+			  MICFIL_OUTGAIN_CHX_SHIFT(7), 0xF, 0x7, gain_tlv),
+	SOC_ENUM_EXT("MICFIL Quality Select",
+		     fsl_micfil_quality_enum,
+		     snd_soc_get_enum_double, snd_soc_put_enum_double),
+};
+
+static inline int get_pdm_clk(struct fsl_micfil *micfil,
+			      unsigned int rate)
+{
+	u32 ctrl2_reg;
+	int qsel, osr;
+	int bclk;
+
+	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
+	osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
+		    >> MICFIL_CTRL2_CICOSR_SHIFT);
+
+	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
+	qsel = ctrl2_reg & MICFIL_CTRL2_QSEL_MASK;
+
+	switch (qsel) {
+	case MICFIL_HIGH_QUALITY:
+		bclk = rate * 8 * osr / 2; /* kfactor = 0.5 */
+		break;
+	case MICFIL_MEDIUM_QUALITY:
+	case MICFIL_VLOW0_QUALITY:
+		bclk = rate * 4 * osr * 1; /* kfactor = 1 */
+		break;
+	case MICFIL_LOW_QUALITY:
+	case MICFIL_VLOW1_QUALITY:
+		bclk = rate * 2 * osr * 2; /* kfactor = 2 */
+		break;
+	case MICFIL_VLOW2_QUALITY:
+		bclk = rate * osr * 4; /* kfactor = 4 */
+		break;
+	default:
+		dev_err(&micfil->pdev->dev,
+			"Please make sure you select a valid quality.\n");
+		bclk = -1;
+		break;
+	}
+
+	return bclk;
+}
+
+static inline int get_clk_div(struct fsl_micfil *micfil,
+			      unsigned int rate)
+{
+	u32 ctrl2_reg;
+	long mclk_rate;
+	int osr;
+	int clk_div;
+
+	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
+	osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
+		    >> MICFIL_CTRL2_CICOSR_SHIFT);
+
+	mclk_rate = clk_get_rate(micfil->mclk);
+
+	clk_div = mclk_rate / (get_pdm_clk(micfil, rate) * 2);
+
+	return clk_div;
+}
+
+/* The SRES is a self-negated bit which provides the CPU with the
+ * capability to initialize the PDM Interface module through the
+ * slave-bus interface. This bit always reads as zero, and this
+ * bit is only effective when MDIS is cleared
+ */
+static int fsl_micfil_reset(struct device *dev)
+{
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(micfil->regmap,
+				 REG_MICFIL_CTRL1,
+				 MICFIL_CTRL1_MDIS_MASK,
+				 0);
+	if (ret) {
+		dev_err(dev, "failed to clear MDIS bit %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(micfil->regmap,
+				 REG_MICFIL_CTRL1,
+				 MICFIL_CTRL1_SRES_MASK,
+				 MICFIL_CTRL1_SRES);
+	if (ret) {
+		dev_err(dev, "failed to reset MICFIL: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fsl_micfil_set_mclk_rate(struct fsl_micfil *micfil,
+				    unsigned int freq)
+{
+	struct device *dev = &micfil->pdev->dev;
+	int ret;
+
+	clk_disable_unprepare(micfil->mclk);
+
+	ret = clk_set_rate(micfil->mclk, freq * 1024);
+	if (ret)
+		dev_warn(dev, "failed to set rate (%u): %d\n",
+			 freq * 1024, ret);
+
+	clk_prepare_enable(micfil->mclk);
+
+	return ret;
+}
+
+static int fsl_micfil_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
+
+	if (!micfil) {
+		dev_err(dai->dev,
+			"micfil dai priv_data not set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
+			      struct snd_soc_dai *dai)
+{
+	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &micfil->pdev->dev;
+	int ret;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = fsl_micfil_reset(dev);
+		if (ret) {
+			dev_err(dev, "failed to soft reset\n");
+			return ret;
+		}
+
+		/* DMA Interrupt Selection - DISEL bits
+		 * 00 - DMA and IRQ disabled
+		 * 01 - DMA req enabled
+		 * 10 - IRQ enabled
+		 * 11 - reserved
+		 */
+		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+					 MICFIL_CTRL1_DISEL_MASK,
+					 (1 << MICFIL_CTRL1_DISEL_SHIFT));
+		if (ret) {
+			dev_err(dev, "failed to update DISEL bits\n");
+			return ret;
+		}
+
+		/* Enable the module */
+		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+					 MICFIL_CTRL1_PDMIEN_MASK,
+					 MICFIL_CTRL1_PDMIEN);
+		if (ret) {
+			dev_err(dev, "failed to enable the module\n");
+			return ret;
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		/* Disable the module */
+		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+					 MICFIL_CTRL1_PDMIEN_MASK,
+					 0);
+		if (ret) {
+			dev_err(dev, "failed to enable the module\n");
+			return ret;
+		}
+
+		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+					 MICFIL_CTRL1_DISEL_MASK,
+					 (0 << MICFIL_CTRL1_DISEL_SHIFT));
+		if (ret) {
+			dev_err(dev, "failed to update DISEL bits\n");
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int fsl_set_clock_params(struct device *dev, unsigned int rate)
+{
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+	int clk_div;
+	int ret = 0;
+
+	ret = fsl_micfil_set_mclk_rate(micfil, rate);
+	if (ret < 0)
+		dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
+			clk_get_rate(micfil->mclk), rate);
+
+	/* set CICOSR */
+	ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+				 MICFIL_CTRL2_CICOSR_MASK,
+				 MICFIL_CTRL2_OSR_DEFAULT);
+	if (ret)
+		dev_err(dev, "failed to set CICOSR in reg 0x%X\n",
+			REG_MICFIL_CTRL2);
+
+	/* set CLK_DIV */
+	clk_div = get_clk_div(micfil, rate);
+	if (clk_div < 0)
+		ret = -EINVAL;
+
+	ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+				 MICFIL_CTRL2_CLKDIV_MASK, clk_div);
+	if (ret)
+		dev_err(dev, "failed to set CLKDIV in reg 0x%X\n",
+			REG_MICFIL_CTRL2);
+
+	return ret;
+}
+
+static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
+	unsigned int channels = params_channels(params);
+	unsigned int rate = params_rate(params);
+	struct device *dev = &micfil->pdev->dev;
+	int ret;
+
+	/* 1. Disable the module */
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				 MICFIL_CTRL1_PDMIEN_MASK, 0);
+	if (ret) {
+		dev_err(dev, "failed to disable the module\n");
+		return ret;
+	}
+
+	/* enable channels */
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				 0xFF, ((1 << channels) - 1));
+	if (ret) {
+		dev_err(dev, "failed to enable channels %d, reg 0x%X\n", ret,
+			REG_MICFIL_CTRL1);
+		return ret;
+	}
+
+	ret = fsl_set_clock_params(dev, rate);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set clock parameters [%d]\n", ret);
+		return ret;
+	}
+
+	micfil->dma_params_rx.maxburst = channels * MICFIL_DMA_MAXBURST_RX;
+
+	return 0;
+}
+
+static int fsl_micfil_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				     unsigned int freq, int dir)
+{
+	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &micfil->pdev->dev;
+
+	int ret;
+
+	if (!freq)
+		return 0;
+
+	ret = fsl_micfil_set_mclk_rate(micfil, freq);
+	if (ret < 0)
+		dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
+			clk_get_rate(micfil->mclk), freq);
+
+	return ret;
+}
+
+static struct snd_soc_dai_ops fsl_micfil_dai_ops = {
+	.startup = fsl_micfil_startup,
+	.trigger = fsl_micfil_trigger,
+	.hw_params = fsl_micfil_hw_params,
+	.set_sysclk = fsl_micfil_set_dai_sysclk,
+};
+
+static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
+{
+	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
+	struct device *dev = cpu_dai->dev;
+	unsigned int val;
+	int ret;
+	int i;
+
+	/* set qsel to medium */
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+				 MICFIL_CTRL2_QSEL_MASK, MICFIL_MEDIUM_QUALITY);
+	if (ret) {
+		dev_err(dev, "failed to set quality mode bits, reg 0x%X\n",
+			REG_MICFIL_CTRL2);
+		return ret;
+	}
+
+	/* set default gain to max_gain */
+	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x77777777);
+	for (i = 0; i < 8; i++)
+		micfil->channel_gain[i] = 0xF;
+
+	snd_soc_dai_init_dma_data(cpu_dai, NULL,
+				  &micfil->dma_params_rx);
+
+	/* FIFO Watermark Control - FIFOWMK*/
+	val = MICFIL_FIFO_CTRL_FIFOWMK(micfil->soc->fifo_depth) - 1;
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_FIFO_CTRL,
+				 MICFIL_FIFO_CTRL_FIFOWMK_MASK,
+				 val);
+	if (ret) {
+		dev_err(dev, "failed to set FIFOWMK\n");
+		return ret;
+	}
+
+	snd_soc_dai_set_drvdata(cpu_dai, micfil);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver fsl_micfil_dai = {
+	.probe = fsl_micfil_dai_probe,
+	.capture = {
+		.stream_name = "CPU-Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = FSL_MICFIL_RATES,
+		.formats = FSL_MICFIL_FORMATS,
+	},
+	.ops = &fsl_micfil_dai_ops,
+};
+
+static const struct snd_soc_component_driver fsl_micfil_component = {
+	.name		= "fsl-micfil-dai",
+	.controls       = fsl_micfil_snd_controls,
+	.num_controls   = ARRAY_SIZE(fsl_micfil_snd_controls),
+
+};
+
+/* REGMAP */
+static const struct reg_default fsl_micfil_reg_defaults[] = {
+	{REG_MICFIL_CTRL1,		0x00000000},
+	{REG_MICFIL_CTRL2,		0x00000000},
+	{REG_MICFIL_STAT,		0x00000000},
+	{REG_MICFIL_FIFO_CTRL,		0x00000007},
+	{REG_MICFIL_FIFO_STAT,		0x00000000},
+	{REG_MICFIL_DATACH0,		0x00000000},
+	{REG_MICFIL_DATACH1,		0x00000000},
+	{REG_MICFIL_DATACH2,		0x00000000},
+	{REG_MICFIL_DATACH3,		0x00000000},
+	{REG_MICFIL_DATACH4,		0x00000000},
+	{REG_MICFIL_DATACH5,		0x00000000},
+	{REG_MICFIL_DATACH6,		0x00000000},
+	{REG_MICFIL_DATACH7,		0x00000000},
+	{REG_MICFIL_DC_CTRL,		0x00000000},
+	{REG_MICFIL_OUT_CTRL,		0x00000000},
+	{REG_MICFIL_OUT_STAT,		0x00000000},
+	{REG_MICFIL_VAD0_CTRL1,		0x00000000},
+	{REG_MICFIL_VAD0_CTRL2,		0x000A0000},
+	{REG_MICFIL_VAD0_STAT,		0x00000000},
+	{REG_MICFIL_VAD0_SCONFIG,	0x00000000},
+	{REG_MICFIL_VAD0_NCONFIG,	0x80000000},
+	{REG_MICFIL_VAD0_NDATA,		0x00000000},
+	{REG_MICFIL_VAD0_ZCD,		0x00000004},
+};
+
+static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_MICFIL_CTRL1:
+	case REG_MICFIL_CTRL2:
+	case REG_MICFIL_STAT:
+	case REG_MICFIL_FIFO_CTRL:
+	case REG_MICFIL_FIFO_STAT:
+	case REG_MICFIL_DATACH0:
+	case REG_MICFIL_DATACH1:
+	case REG_MICFIL_DATACH2:
+	case REG_MICFIL_DATACH3:
+	case REG_MICFIL_DATACH4:
+	case REG_MICFIL_DATACH5:
+	case REG_MICFIL_DATACH6:
+	case REG_MICFIL_DATACH7:
+	case REG_MICFIL_DC_CTRL:
+	case REG_MICFIL_OUT_CTRL:
+	case REG_MICFIL_OUT_STAT:
+	case REG_MICFIL_VAD0_CTRL1:
+	case REG_MICFIL_VAD0_CTRL2:
+	case REG_MICFIL_VAD0_STAT:
+	case REG_MICFIL_VAD0_SCONFIG:
+	case REG_MICFIL_VAD0_NCONFIG:
+	case REG_MICFIL_VAD0_NDATA:
+	case REG_MICFIL_VAD0_ZCD:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_micfil_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_MICFIL_CTRL1:
+	case REG_MICFIL_CTRL2:
+	case REG_MICFIL_STAT:		/* Write 1 to Clear */
+	case REG_MICFIL_FIFO_CTRL:
+	case REG_MICFIL_FIFO_STAT:	/* Write 1 to Clear */
+	case REG_MICFIL_DC_CTRL:
+	case REG_MICFIL_OUT_CTRL:
+	case REG_MICFIL_OUT_STAT:	/* Write 1 to Clear */
+	case REG_MICFIL_VAD0_CTRL1:
+	case REG_MICFIL_VAD0_CTRL2:
+	case REG_MICFIL_VAD0_STAT:	/* Write 1 to Clear */
+	case REG_MICFIL_VAD0_SCONFIG:
+	case REG_MICFIL_VAD0_NCONFIG:
+	case REG_MICFIL_VAD0_ZCD:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_micfil_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_MICFIL_STAT:
+	case REG_MICFIL_DATACH0:
+	case REG_MICFIL_DATACH1:
+	case REG_MICFIL_DATACH2:
+	case REG_MICFIL_DATACH3:
+	case REG_MICFIL_DATACH4:
+	case REG_MICFIL_DATACH5:
+	case REG_MICFIL_DATACH6:
+	case REG_MICFIL_DATACH7:
+	case REG_MICFIL_VAD0_STAT:
+	case REG_MICFIL_VAD0_NDATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config fsl_micfil_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+
+	.max_register = REG_MICFIL_VAD0_ZCD,
+	.reg_defaults = fsl_micfil_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_micfil_reg_defaults),
+	.readable_reg = fsl_micfil_readable_reg,
+	.volatile_reg = fsl_micfil_volatile_reg,
+	.writeable_reg = fsl_micfil_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/* END OF REGMAP */
+
+static irqreturn_t micfil_isr(int irq, void *devid)
+{
+	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
+	struct platform_device *pdev = micfil->pdev;
+	u32 stat_reg;
+	u32 fifo_stat_reg;
+	u32 ctrl1_reg;
+	bool dma_enabled;
+	int i;
+
+	regmap_read(micfil->regmap, REG_MICFIL_STAT, &stat_reg);
+	regmap_read(micfil->regmap, REG_MICFIL_CTRL1, &ctrl1_reg);
+	regmap_read(micfil->regmap, REG_MICFIL_FIFO_STAT, &fifo_stat_reg);
+
+	dma_enabled = MICFIL_DMA_ENABLED(ctrl1_reg);
+
+	/* Channel 0-7 Output Data Flags */
+	for (i = 0; i < MICFIL_OUTPUT_CHANNELS; i++) {
+		if (stat_reg & MICFIL_STAT_CHXF_MASK(i))
+			dev_dbg(&pdev->dev,
+				"Data available in Data Channel %d\n", i);
+		/* if DMA is not enabled, field must be written with 1
+		 * to clear
+		 */
+		if (!dma_enabled)
+			regmap_write_bits(micfil->regmap,
+					  REG_MICFIL_STAT,
+					  MICFIL_STAT_CHXF_MASK(i),
+					  1);
+	}
+
+	for (i = 0; i < MICFIL_FIFO_NUM; i++) {
+		if (fifo_stat_reg & MICFIL_FIFO_STAT_FIFOX_OVER_MASK(i))
+			dev_dbg(&pdev->dev,
+				"FIFO Overflow Exception flag for channel %d\n",
+				i);
+
+		if (fifo_stat_reg & MICFIL_FIFO_STAT_FIFOX_UNDER_MASK(i))
+			dev_dbg(&pdev->dev,
+				"FIFO Underflow Exception flag for channel %d\n",
+				i);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t micfil_err_isr(int irq, void *devid)
+{
+	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
+	struct platform_device *pdev = micfil->pdev;
+	u32 stat_reg;
+
+	regmap_read(micfil->regmap, REG_MICFIL_STAT, &stat_reg);
+
+	if (stat_reg & MICFIL_STAT_BSY_FIL_MASK)
+		dev_dbg(&pdev->dev, "isr: Decimation Filter is running\n");
+
+	if (stat_reg & MICFIL_STAT_FIR_RDY_MASK)
+		dev_dbg(&pdev->dev, "isr: FIR Filter Data ready\n");
+
+	if (stat_reg & MICFIL_STAT_LOWFREQF_MASK) {
+		dev_dbg(&pdev->dev, "isr: ipg_clk_app is too low\n");
+		regmap_write_bits(micfil->regmap, REG_MICFIL_STAT,
+				  MICFIL_STAT_LOWFREQF_MASK, 1);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int fsl_micfil_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	struct fsl_micfil *micfil;
+	struct resource *res;
+	void __iomem *regs;
+	int ret, i;
+	unsigned long irqflag = 0;
+
+	micfil = devm_kzalloc(&pdev->dev, sizeof(*micfil), GFP_KERNEL);
+	if (!micfil)
+		return -ENOMEM;
+
+	micfil->pdev = pdev;
+	strncpy(micfil->name, np->name, sizeof(micfil->name) - 1);
+
+	of_id = of_match_device(fsl_micfil_dt_ids, &pdev->dev);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
+	micfil->soc = of_id->data;
+
+	/* ipg_clk is used to control the registers
+	 * ipg_clk_app is used to operate the filter
+	 */
+	micfil->mclk = devm_clk_get(&pdev->dev, "ipg_clk_app");
+	if (IS_ERR(micfil->mclk)) {
+		dev_err(&pdev->dev, "failed to get core clock: %ld\n",
+			PTR_ERR(micfil->mclk));
+		return PTR_ERR(micfil->mclk);
+	}
+
+	/* init regmap */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	micfil->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
+						   "ipg_clk",
+						   regs,
+						   &fsl_micfil_regmap_config);
+	if (IS_ERR(micfil->regmap)) {
+		dev_err(&pdev->dev, "failed to init MICFIL regmap: %ld\n",
+			PTR_ERR(micfil->regmap));
+		return PTR_ERR(micfil->regmap);
+	}
+
+	/* dataline mask for RX */
+	ret = of_property_read_u32_index(np,
+					 "fsl,dataline",
+					 0,
+					 &micfil->dataline);
+	if (ret)
+		micfil->dataline = 1;
+
+	if (micfil->dataline & ~micfil->soc->dataline) {
+		dev_err(&pdev->dev, "dataline setting error, Mask is 0x%X\n",
+			micfil->soc->dataline);
+		return -EINVAL;
+	}
+
+	/* get IRQs */
+	for (i = 0; i < MICFIL_IRQ_LINES; i++) {
+		micfil->irq[i] = platform_get_irq(pdev, i);
+		dev_err(&pdev->dev, "GET IRQ: %d\n", micfil->irq[i]);
+		if (micfil->irq[i] < 0) {
+			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+			return micfil->irq[i];
+		}
+	}
+
+	if (of_property_read_bool(np, "fsl,shared-interrupt"))
+		irqflag = IRQF_SHARED;
+
+	/* Digital Microphone interface interrupt - IRQ 109 */
+	ret = devm_request_irq(&pdev->dev, micfil->irq[0],
+			       micfil_isr, irqflag,
+			       micfil->name, micfil);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to claim mic interface irq %u\n",
+			micfil->irq[0]);
+		return ret;
+	}
+
+	/* Digital Microphone interface error interrupt - IRQ 110 */
+	ret = devm_request_irq(&pdev->dev, micfil->irq[1],
+			       micfil_err_isr, irqflag,
+			       micfil->name, micfil);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to claim mic interface error irq %u\n",
+			micfil->irq[1]);
+		return ret;
+	}
+
+	micfil->dma_params_rx.chan_name = "rx";
+	micfil->dma_params_rx.addr = res->start + REG_MICFIL_DATACH0;
+	micfil->dma_params_rx.maxburst = MICFIL_DMA_MAXBURST_RX;
+
+
+	platform_set_drvdata(pdev, micfil);
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
+					      &fsl_micfil_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register component %s\n",
+			fsl_micfil_component.name);
+		return ret;
+	}
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret)
+		dev_err(&pdev->dev, "failed to pcm register\n");
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int __maybe_unused fsl_micfil_runtime_suspend(struct device *dev)
+{
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+
+	regcache_cache_only(micfil->regmap, true);
+
+	clk_disable_unprepare(micfil->mclk);
+
+	return 0;
+}
+
+static int __maybe_unused fsl_micfil_runtime_resume(struct device *dev)
+{
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(micfil->mclk);
+	if (ret < 0)
+		return ret;
+
+	regcache_cache_only(micfil->regmap, false);
+	regcache_mark_dirty(micfil->regmap);
+	regcache_sync(micfil->regmap);
+
+	return 0;
+}
+#endif /* CONFIG_PM*/
+
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused fsl_micfil_suspend(struct device *dev)
+{
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int __maybe_unused fsl_micfil_resume(struct device *dev)
+{
+	pm_runtime_force_resume(dev);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_micfil_pm_ops = {
+	SET_RUNTIME_PM_OPS(fsl_micfil_runtime_suspend,
+			   fsl_micfil_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_micfil_suspend,
+				fsl_micfil_resume)
+};
+
+static struct platform_driver fsl_micfil_driver = {
+	.probe = fsl_micfil_probe,
+	.driver = {
+		.name = "fsl-micfil-dai",
+		.pm = &fsl_micfil_pm_ops,
+		.of_match_table = fsl_micfil_dt_ids,
+	},
+};
+module_platform_driver(fsl_micfil_driver);
+
+MODULE_AUTHOR("Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>");
+MODULE_DESCRIPTION("NXP PDM Microphone Interface (MICFIL) driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
new file mode 100644
index 0000000..bac825c
--- /dev/null
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PDM Microphone Interface for the NXP i.MX SoC
+ * Copyright 2018 NXP
+ */
+
+#ifndef _FSL_MICFIL_H
+#define _FSL_MICFIL_H
+
+/* MICFIL Register Map */
+#define REG_MICFIL_CTRL1		0x00
+#define REG_MICFIL_CTRL2		0x04
+#define REG_MICFIL_STAT			0x08
+#define REG_MICFIL_FIFO_CTRL		0x10
+#define REG_MICFIL_FIFO_STAT		0x14
+#define REG_MICFIL_DATACH0		0x24
+#define REG_MICFIL_DATACH1		0x28
+#define REG_MICFIL_DATACH2		0x2C
+#define REG_MICFIL_DATACH3		0x30
+#define REG_MICFIL_DATACH4		0x34
+#define REG_MICFIL_DATACH5		0x38
+#define REG_MICFIL_DATACH6		0x3C
+#define REG_MICFIL_DATACH7		0x40
+#define REG_MICFIL_DC_CTRL		0x64
+#define REG_MICFIL_OUT_CTRL		0x74
+#define REG_MICFIL_OUT_STAT		0x7C
+#define REG_MICFIL_VAD0_CTRL1		0x90
+#define REG_MICFIL_VAD0_CTRL2		0x94
+#define REG_MICFIL_VAD0_STAT		0x98
+#define REG_MICFIL_VAD0_SCONFIG		0x9C
+#define REG_MICFIL_VAD0_NCONFIG		0xA0
+#define REG_MICFIL_VAD0_NDATA		0xA4
+#define REG_MICFIL_VAD0_ZCD		0xA8
+
+/* MICFIL Control Register 1 -- REG_MICFILL_CTRL1 0x00 */
+#define MICFIL_CTRL1_MDIS_SHIFT		31
+#define MICFIL_CTRL1_MDIS_MASK		BIT(MICFIL_CTRL1_MDIS_SHIFT)
+#define MICFIL_CTRL1_MDIS		BIT(MICFIL_CTRL1_MDIS_SHIFT)
+#define MICFIL_CTRL1_DOZEN_SHIFT	30
+#define MICFIL_CTRL1_DOZEN_MASK		BIT(MICFIL_CTRL1_DOZEN_SHIFT)
+#define MICFIL_CTRL1_DOZEN		BIT(MICFIL_CTRL1_DOZEN_SHIFT)
+#define MICFIL_CTRL1_PDMIEN_SHIFT	29
+#define MICFIL_CTRL1_PDMIEN_MASK	BIT(MICFIL_CTRL1_PDMIEN_SHIFT)
+#define MICFIL_CTRL1_PDMIEN		BIT(MICFIL_CTRL1_PDMIEN_SHIFT)
+#define MICFIL_CTRL1_DBG_SHIFT		28
+#define MICFIL_CTRL1_DBG_MASK		BIT(MICFIL_CTRL1_DBG_SHIFT)
+#define MICFIL_CTRL1_DBG		BIT(MICFIL_CTRL1_DBG_SHIFT)
+#define MICFIL_CTRL1_SRES_SHIFT		27
+#define MICFIL_CTRL1_SRES_MASK		BIT(MICFIL_CTRL1_SRES_SHIFT)
+#define MICFIL_CTRL1_SRES		BIT(MICFIL_CTRL1_SRES_SHIFT)
+#define MICFIL_CTRL1_DBGE_SHIFT		26
+#define MICFIL_CTRL1_DBGE_MASK		BIT(MICFIL_CTRL1_DBGE_SHIFT)
+#define MICFIL_CTRL1_DBGE		BIT(MICFIL_CTRL1_DBGE_SHIFT)
+#define MICFIL_CTRL1_DISEL_SHIFT	24
+#define MICFIL_CTRL1_DISEL_WIDTH	2
+#define MICFIL_CTRL1_DISEL_MASK		((BIT(MICFIL_CTRL1_DISEL_WIDTH) - 1) \
+					 << MICFIL_CTRL1_DISEL_SHIFT)
+#define MICFIL_CTRL1_DISEL(v)		(((v) << MICFIL_CTRL1_DISEL_SHIFT) \
+					 & MICFIL_CTRL1_DISEL_MASK)
+#define MICFIL_CTRL1_ERREN_SHIFT	23
+#define MICFIL_CTRL1_ERREN_MASK		BIT(MICFIL_CTRL1_ERREN_SHIFT)
+#define MICFIL_CTRL1_ERREN		BIT(MICFIL_CTRL1_ERREN_SHIFT)
+#define MICFIL_CTRL1_CHEN_SHIFT		0
+#define MICFIL_CTRL1_CHEN_WIDTH		8
+#define MICFIL_CTRL1_CHEN_MASK(x)	(BIT(x) << MICFIL_CTRL1_CHEN_SHIFT)
+#define MICFIL_CTRL1_CHEN(x)		(MICFIL_CTRL1_CHEN_MASK(x))
+
+/* MICFIL Control Register 2 -- REG_MICFILL_CTRL2 0x04 */
+#define MICFIL_CTRL2_QSEL_SHIFT		25
+#define MICFIL_CTRL2_QSEL_WIDTH		3
+#define MICFIL_CTRL2_QSEL_MASK		((BIT(MICFIL_CTRL2_QSEL_WIDTH) - 1) \
+					 << MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_HIGH_QUALITY		BIT(MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_MEDIUM_QUALITY		(0 << MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_LOW_QUALITY		(7 << MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_VLOW0_QUALITY		(6 << MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_VLOW1_QUALITY		(5 << MICFIL_CTRL2_QSEL_SHIFT)
+#define MICFIL_VLOW2_QUALITY		(4 << MICFIL_CTRL2_QSEL_SHIFT)
+
+#define MICFIL_CTRL2_CICOSR_SHIFT	16
+#define MICFIL_CTRL2_CICOSR_WIDTH	4
+#define MICFIL_CTRL2_CICOSR_MASK	((BIT(MICFIL_CTRL2_CICOSR_WIDTH) - 1) \
+					 << MICFIL_CTRL2_CICOSR_SHIFT)
+#define MICFIL_CTRL2_CICOSR(v)		(((v) << MICFIL_CTRL2_CICOSR_SHIFT) \
+					 & MICFIL_CTRL2_CICOSR_MASK)
+#define MICFIL_CTRL2_CLKDIV_SHIFT	0
+#define MICFIL_CTRL2_CLKDIV_WIDTH	8
+#define MICFIL_CTRL2_CLKDIV_MASK	((BIT(MICFIL_CTRL2_CLKDIV_WIDTH) - 1) \
+					 << MICFIL_CTRL2_CLKDIV_SHIFT)
+#define MICFIL_CTRL2_CLKDIV(v)		(((v) << MICFIL_CTRL2_CLKDIV_SHIFT) \
+					 & MICFIL_CTRL2_CLKDIV_MASK)
+
+/* MICFIL Status Register -- REG_MICFIL_STAT 0x08 */
+#define MICFIL_STAT_BSY_FIL_SHIFT	31
+#define MICFIL_STAT_BSY_FIL_MASK	BIT(MICFIL_STAT_BSY_FIL_SHIFT)
+#define MICFIL_STAT_BSY_FIL		BIT(MICFIL_STAT_BSY_FIL_SHIFT)
+#define MICFIL_STAT_FIR_RDY_SHIFT	30
+#define MICFIL_STAT_FIR_RDY_MASK	BIT(MICFIL_STAT_FIR_RDY_SHIFT)
+#define MICFIL_STAT_FIR_RDY		BIT(MICFIL_STAT_FIR_RDY_SHIFT)
+#define MICFIL_STAT_LOWFREQF_SHIFT	29
+#define MICFIL_STAT_LOWFREQF_MASK	BIT(MICFIL_STAT_LOWFREQF_SHIFT)
+#define MICFIL_STAT_LOWFREQF		BIT(MICFIL_STAT_LOWFREQF_SHIFT)
+#define MICFIL_STAT_CHXF_SHIFT(v)	(v)
+#define MICFIL_STAT_CHXF_MASK(v)	BIT(MICFIL_STAT_CHXF_SHIFT(v))
+#define MICFIL_STAT_CHXF(v)		BIT(MICFIL_STAT_CHXF_SHIFT(v))
+
+/* MICFIL FIFO Control Register -- REG_MICFIL_FIFO_CTRL 0x10 */
+#define MICFIL_FIFO_CTRL_FIFOWMK_SHIFT	0
+#define MICFIL_FIFO_CTRL_FIFOWMK_WIDTH	3
+#define MICFIL_FIFO_CTRL_FIFOWMK_MASK	((BIT(MICFIL_FIFO_CTRL_FIFOWMK_WIDTH) - 1) \
+					 << MICFIL_FIFO_CTRL_FIFOWMK_SHIFT)
+#define MICFIL_FIFO_CTRL_FIFOWMK(v)	(((v) << MICFIL_FIFO_CTRL_FIFOWMK_SHIFT) \
+					 & MICFIL_FIFO_CTRL_FIFOWMK_MASK)
+
+/* MICFIL FIFO Status Register -- REG_MICFIL_FIFO_STAT 0x14 */
+#define MICFIL_FIFO_STAT_FIFOX_OVER_SHIFT(v)	(v)
+#define MICFIL_FIFO_STAT_FIFOX_OVER_MASK(v)	BIT(MICFIL_FIFO_STAT_FIFOX_OVER_SHIFT(v))
+#define MICFIL_FIFO_STAT_FIFOX_UNDER_SHIFT(v)	((v) + 8)
+#define MICFIL_FIFO_STAT_FIFOX_UNDER_MASK(v)	BIT(MICFIL_FIFO_STAT_FIFOX_UNDER_SHIFT(v))
+
+/* MICFIL HWVAD0 Control 1 Register -- REG_MICFIL_VAD0_CTRL1*/
+#define MICFIL_VAD0_CTRL1_CHSEL_SHIFT	24
+#define MICFIL_VAD0_CTRL1_CHSEL_WIDTH	3
+#define MICFIL_VAD0_CTRL1_CHSEL_MASK	((BIT(MICFIL_VAD0_CTRL1_CHSEL_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL1_CHSEL_SHIFT)
+#define MICFIL_VAD0_CTRL1_CHSEL(v)	(((v) << MICFIL_VAD0_CTRL1_CHSEL_SHIFT) \
+					 & MICFIL_VAD0_CTRL1_CHSEL_MASK)
+#define MICFIL_VAD0_CTRL1_CICOSR_SHIFT	16
+#define MICFIL_VAD0_CTRL1_CICOSR_WIDTH	4
+#define MICFIL_VAD0_CTRL1_CICOSR_MASK	((BIT(MICFIL_VAD0_CTRL1_CICOSR_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL1_CICOSR_SHIFT)
+#define MICFIL_VAD0_CTRL1_CICOSR(v)	(((v) << MICFIL_VAD0_CTRL1_CICOSR_SHIFT) \
+					 & MICFIL_VAD0_CTRL1_CICOSR_MASK)
+#define MICFIL_VAD0_CTRL1_INITT_SHIFT	8
+#define MICFIL_VAD0_CTRL1_INITT_WIDTH	5
+#define MICFIL_VAD0_CTRL1_INITT_MASK	((BIT(MICFIL_VAD0_CTRL1_INITT_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL1_INITT_SHIFT)
+#define MICFIL_VAD0_CTRL1_INITT(v)	(((v) << MICFIL_VAD0_CTRL1_INITT_SHIFT) \
+					 & MICFIL_VAD0_CTRL1_INITT_MASK)
+#define MICFIL_VAD0_CTRL1_ST10_SHIFT	4
+#define MICFIL_VAD0_CTRL1_ST10_MASK	BIT(MICFIL_VAD0_CTRL1_ST10_SHIFT)
+#define MICFIL_VAD0_CTRL1_ST10		BIT(MICFIL_VAD0_CTRL1_ST10_SHIFT)
+#define MICFIL_VAD0_CTRL1_ERIE_SHIFT	3
+#define MICFIL_VAD0_CTRL1_ERIE_MASK	BIT(MICFIL_VAD0_CTRL1_ERIE_SHIFT)
+#define MICFIL_VAD0_CTRL1_ERIE		BIT(MICFIL_VAD0_CTRL1_ERIE_SHIFT)
+#define MICFIL_VAD0_CTRL1_IE_SHIFT	2
+#define MICFIL_VAD0_CTRL1_IE_MASK	BIT(MICFIL_VAD0_CTRL1_IE_SHIFT)
+#define MICFIL_VAD0_CTRL1_IE		BIT(MICFIL_VAD0_CTRL1_IE_SHIFT)
+#define MICFIL_VAD0_CTRL1_RST_SHIFT	1
+#define MICFIL_VAD0_CTRL1_RST_MASK	BIT(MICFIL_VAD0_CTRL1_RST_SHIFT)
+#define MICFIL_VAD0_CTRL1_RST		BIT(MICFIL_VAD0_CTRL1_RST_SHIFT)
+#define MICFIL_VAD0_CTRL1_EN_SHIFT	0
+#define MICFIL_VAD0_CTRL1_EN_MASK	BIT(MICFIL_VAD0_CTRL1_EN_SHIFT)
+#define MICFIL_VAD0_CTRL1_EN		BIT(MICFIL_VAD0_CTRL1_EN_SHIFT)
+
+/* MICFIL HWVAD0 Control 2 Register -- REG_MICFIL_VAD0_CTRL2*/
+#define MICFIL_VAD0_CTRL2_FRENDIS_SHIFT	31
+#define MICFIL_VAD0_CTRL2_FRENDIS_MASK	BIT(MICFIL_VAD0_CTRL2_FRENDIS_SHIFT)
+#define MICFIL_VAD0_CTRL2_FRENDIS	BIT(MICFIL_VAD0_CTRL2_FRENDIS_SHIFT)
+#define MICFIL_VAD0_CTRL2_PREFEN_SHIFT	30
+#define MICFIL_VAD0_CTRL2_PREFEN_MASK	BIT(MICFIL_VAD0_CTRL2_PREFEN_SHIFT)
+#define MICFIL_VAD0_CTRL2_PREFEN	BIT(MICFIL_VAD0_CTRL2_PREFEN_SHIFT)
+#define MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT	28
+#define MICFIL_VAD0_CTRL2_FOUTDIS_MASK	BIT(MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT)
+#define MICFIL_VAD0_CTRL2_FOUTDIS	BIT(MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT)
+#define MICFIL_VAD0_CTRL2_FRAMET_SHIFT	16
+#define MICFIL_VAD0_CTRL2_FRAMET_WIDTH	6
+#define MICFIL_VAD0_CTRL2_FRAMET_MASK	((BIT(MICFIL_VAD0_CTRL2_FRAMET_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL2_FRAMET_SHIFT)
+#define MICFIL_VAD0_CTRL2_FRAMET(v)	(((v) << MICFIL_VAD0_CTRL2_FRAMET_SHIFT) \
+					 & MICFIL_VAD0_CTRL2_FRAMET_MASK)
+#define MICFIL_VAD0_CTRL2_INPGAIN_SHIFT	8
+#define MICFIL_VAD0_CTRL2_INPGAIN_WIDTH	4
+#define MICFIL_VAD0_CTRL2_INPGAIN_MASK	((BIT(MICFIL_VAD0_CTRL2_INPGAIN_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL2_INPGAIN_SHIFT)
+#define MICFIL_VAD0_CTRL2_INPGAIN(v)	(((v) << MICFIL_VAD0_CTRL2_INPGAIN_SHIFT) \
+					& MICFIL_VAD0_CTRL2_INPGAIN_MASK)
+#define MICFIL_VAD0_CTRL2_HPF_SHIFT	0
+#define MICFIL_VAD0_CTRL2_HPF_WIDTH	2
+#define MICFIL_VAD0_CTRL2_HPF_MASK	((BIT(MICFIL_VAD0_CTRL2_HPF_WIDTH) - 1) \
+					 << MICFIL_VAD0_CTRL2_HPF_SHIFT)
+#define MICFIL_VAD0_CTRL2_HPF(v)	(((v) << MICFIL_VAD0_CTRL2_HPF_SHIFT) \
+					 & MICFIL_VAD0_CTRL2_HPF_MASK)
+
+/* MICFIL HWVAD0 Signal CONFIG Register -- REG_MICFIL_VAD0_SCONFIG */
+#define MICFIL_VAD0_SCONFIG_SFILEN_SHIFT	31
+#define MICFIL_VAD0_SCONFIG_SFILEN_MASK		BIT(MICFIL_VAD0_SCONFIG_SFILEN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SFILEN		BIT(MICFIL_VAD0_SCONFIG_SFILEN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT	30
+#define MICFIL_VAD0_SCONFIG_SMAXEN_MASK		BIT(MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SMAXEN		BIT(MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SGAIN_SHIFT		0
+#define MICFIL_VAD0_SCONFIG_SGAIN_WIDTH		4
+#define MICFIL_VAD0_SCONFIG_SGAIN_MASK		((BIT(MICFIL_VAD0_SCONFIG_SGAIN_WIDTH) - 1) \
+						<< MICFIL_VAD0_SCONFIG_SGAIN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SGAIN(v)		(((v) << MICFIL_VAD0_SCONFIG_SGAIN_SHIFT) \
+						 & MICFIL_VAD0_SCONFIG_SGAIN_MASK)
+
+/* MICFIL HWVAD0 Noise CONFIG Register -- REG_MICFIL_VAD0_NCONFIG */
+#define MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT	31
+#define MICFIL_VAD0_NCONFIG_NFILAUT_MASK	BIT(MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NFILAUT		BIT(MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NMINEN_SHIFT	30
+#define MICFIL_VAD0_NCONFIG_NMINEN_MASK		BIT(MICFIL_VAD0_NCONFIG_NMINEN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NMINEN		BIT(MICFIL_VAD0_NCONFIG_NMINEN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NDECEN_SHIFT	29
+#define MICFIL_VAD0_NCONFIG_NDECEN_MASK		BIT(MICFIL_VAD0_NCONFIG_NDECEN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NDECEN		BIT(MICFIL_VAD0_NCONFIG_NDECEN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NOREN_SHIFT		28
+#define MICFIL_VAD0_NCONFIG_NOREN		BIT(MICFIL_VAD0_NCONFIG_NOREN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NFILADJ_SHIFT	8
+#define MICFIL_VAD0_NCONFIG_NFILADJ_WIDTH	5
+#define MICFIL_VAD0_NCONFIG_NFILADJ_MASK	((BIT(MICFIL_VAD0_NCONFIG_NFILADJ_WIDTH) - 1) \
+						 << MICFIL_VAD0_NCONFIG_NFILADJ_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NFILADJ(v)		(((v) << MICFIL_VAD0_NCONFIG_NFILADJ_SHIFT) \
+						 & MICFIL_VAD0_NCONFIG_NFILADJ_MASK)
+#define MICFIL_VAD0_NCONFIG_NGAIN_SHIFT		0
+#define MICFIL_VAD0_NCONFIG_NGAIN_WIDTH		4
+#define MICFIL_VAD0_NCONFIG_NGAIN_MASK		((BIT(MICFIL_VAD0_NCONFIG_NGAIN_WIDTH) - 1) \
+						 << MICFIL_VAD0_NCONFIG_NGAIN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NGAIN(v)		(((v) << MICFIL_VAD0_NCONFIG_NGAIN_SHIFT) \
+						 & MICFIL_VAD0_NCONFIG_NGAIN_MASK)
+
+/* MICFIL HWVAD0 Zero-Crossing Detector - REG_MICFIL_VAD0_ZCD */
+#define MICFIL_VAD0_ZCD_ZCDTH_SHIFT	16
+#define MICFIL_VAD0_ZCD_ZCDTH_WIDTH	10
+#define MICFIL_VAD0_ZCD_ZCDTH_MASK	((BIT(MICFIL_VAD0_ZCD_ZCDTH_WIDTH) - 1) \
+					 << MICFIL_VAD0_ZCD_ZCDTH_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDTH(v)	(((v) << MICFIL_VAD0_ZCD_ZCDTH_SHIFT)\
+					 & MICFIL_VAD0_ZCD_ZCDTH_MASK)
+#define MICFIL_VAD0_ZCD_ZCDADJ_SHIFT	8
+#define MICFIL_VAD0_ZCD_ZCDADJ_WIDTH	4
+#define MICFIL_VAD0_ZCD_ZCDADJ_MASK	((BIT(MICFIL_VAD0_ZCD_ZCDADJ_WIDTH) - 1)\
+					 << MICFIL_VAD0_ZCD_ZCDADJ_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDADJ(v)	(((v) << MICFIL_VAD0_ZCD_ZCDADJ_SHIFT)\
+					 & MICFIL_VAD0_ZCD_ZCDADJ_MASK)
+#define MICFIL_VAD0_ZCD_ZCDAND_SHIFT	4
+#define MICFIL_VAD0_ZCD_ZCDAND_MASK	BIT(MICFIL_VAD0_ZCD_ZCDAND_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDAND		BIT(MICFIL_VAD0_ZCD_ZCDAND_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDAUT_SHIFT	2
+#define MICFIL_VAD0_ZCD_ZCDAUT_MASK	BIT(MICFIL_VAD0_ZCD_ZCDAUT_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDAUT		BIT(MICFIL_VAD0_ZCD_ZCDAUT_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDEN_SHIFT	0
+#define MICFIL_VAD0_ZCD_ZCDEN_MASK	BIT(MICFIL_VAD0_ZCD_ZCDEN_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDEN		BIT(MICFIL_VAD0_ZCD_ZCDEN_SHIFT)
+
+/* MICFIL HWVAD0 Status Register - REG_MICFIL_VAD0_STAT */
+#define MICFIL_VAD0_STAT_INITF_SHIFT	31
+#define MICFIL_VAD0_STAT_INITF_MASK	BIT(MICFIL_VAD0_STAT_INITF_SHIFT)
+#define MICFIL_VAD0_STAT_INITF		BIT(MICFIL_VAD0_STAT_INITF_SHIFT)
+#define MICFIL_VAD0_STAT_INSATF_SHIFT	16
+#define MICFIL_VAD0_STAT_INSATF_MASK	BIT(MICFIL_VAD0_STAT_INSATF_SHIFT)
+#define MICFIL_VAD0_STAT_INSATF		BIT(MICFIL_VAD0_STAT_INSATF_SHIFT)
+#define MICFIL_VAD0_STAT_EF_SHIFT	15
+#define MICFIL_VAD0_STAT_EF_MASK	BIT(MICFIL_VAD0_STAT_EF_SHIFT)
+#define MICFIL_VAD0_STAT_EF		BIT(MICFIL_VAD0_STAT_EF_SHIFT)
+#define MICFIL_VAD0_STAT_IF_SHIFT	0
+#define MICFIL_VAD0_STAT_IF_MASK	BIT(MICFIL_VAD0_STAT_IF_SHIFT)
+#define MICFIL_VAD0_STAT_IF		BIT(MICFIL_VAD0_STAT_IF_SHIFT)
+
+/* MICFIL Output Control Register */
+#define MICFIL_OUTGAIN_CHX_SHIFT(v)	(4 * (v))
+
+/* Constants */
+#define MICFIL_DMA_IRQ_DISABLED(v)	((v) & MICFIL_CTRL1_DISEL_MASK)
+#define MICFIL_DMA_ENABLED(v)		((0x1 << MICFIL_CTRL1_DISEL_SHIFT) \
+					 == ((v) & MICFIL_CTRL1_DISEL_MASK))
+#define MICFIL_IRQ_ENABLED(v)		((0x2 << MICFIL_CTRL1_DISEL_SHIFT) \
+					 == ((v) & MICFIL_CTRL1_DISEL_MASK))
+#define MICFIL_OUTPUT_CHANNELS		8
+#define MICFIL_FIFO_NUM			8
+
+#define FIFO_PTRWID			3
+#define FIFO_LEN			BIT(FIFO_PTRWID)
+
+#define MICFIL_IRQ_LINES		2
+#define MICFIL_MAX_RETRY		25
+#define MICFIL_SLEEP_MIN		90000 /* in us */
+#define MICFIL_SLEEP_MAX		100000 /* in us */
+#define MICFIL_DMA_MAXBURST_RX		6
+#define MICFIL_CTRL2_OSR_DEFAULT	(0 << MICFIL_CTRL2_CICOSR_SHIFT)
+
+#endif /* _FSL_MICFIL_H */
-- 
2.7.4
