From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif out
	support
Date: Thu, 28 Jun 2012 12:31:39 +0530
Message-ID: <ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog104.obsmtp.com (eu1sys200aog104.obsmtp.com
	[207.126.144.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E408104023
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 09:01:57 +0200 (CEST)
In-Reply-To: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vipin Kumar <vipin.kumar@st.com>

This patch implements the spdif out driver for ST peripheral. This
peripheral implements IEC60958 standard

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/spdif_out.c      |  387 ++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_out_regs.h |   79 ++++++++
 2 files changed, 466 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
new file mode 100644
index 0000000..25a74f2
--- /dev/null
+++ b/sound/soc/spear/spdif_out.c
@@ -0,0 +1,387 @@
+/*
+ * ALSA SoC SPDIF Out Audio Layer for spear processors
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Vipin Kumar <vipin.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/spear_dma.h>
+#include <sound/spear_spdif.h>
+#include "spdif_out_regs.h"
+
+static int spdif_out_mute;
+
+struct spdif_out_params {
+	u32 rate;
+	u32 core_freq;
+};
+
+struct spdif_out_dev {
+	struct clk *clk;
+	struct spear_dma_data dma_params;
+	struct spdif_out_params saved_params;
+	u32 running;
+	void *io_base;
+};
+
+static void spdif_out_configure(struct spdif_out_dev *host)
+{
+	writel(SPDIF_OUT_RESET, host->io_base + SPDIF_OUT_SOFT_RST);
+	mdelay(1);
+	writel(readl(host->io_base + SPDIF_OUT_SOFT_RST) & ~SPDIF_OUT_RESET,
+			host->io_base + SPDIF_OUT_SOFT_RST);
+
+	writel(SPDIF_OUT_FDMA_TRIG_16 | SPDIF_OUT_MEMFMT_16_16 |
+			SPDIF_OUT_VALID_HW | SPDIF_OUT_USER_HW |
+			SPDIF_OUT_CHNLSTA_HW | SPDIF_OUT_PARITY_HW,
+			host->io_base + SPDIF_OUT_CFG);
+
+	writel(0x7F, host->io_base + SPDIF_OUT_INT_STA_CLR);
+	writel(0x7F, host->io_base + SPDIF_OUT_INT_EN_CLR);
+}
+
+static int spdif_out_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai)
+{
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&host->dma_params);
+
+	ret = clk_enable(host->clk);
+	if (ret)
+		return ret;
+
+	host->running = true;
+	spdif_out_configure(host);
+
+	return 0;
+}
+
+static void spdif_out_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return;
+
+	clk_disable(host->clk);
+	host->running = false;
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+}
+
+static void spdif_out_clock(struct spdif_out_dev *host, u32 core_freq,
+		u32 rate)
+{
+	u32 divider, ctrl;
+
+	clk_set_rate(host->clk, core_freq);
+	divider = DIV_ROUND_CLOSEST(clk_get_rate(host->clk), (rate * 128));
+
+	ctrl = readl(host->io_base + SPDIF_OUT_CTRL);
+	ctrl &= ~SPDIF_DIVIDER_MASK;
+	ctrl |= (divider << SPDIF_DIVIDER_SHIFT) & SPDIF_DIVIDER_MASK;
+	writel(ctrl, host->io_base + SPDIF_OUT_CTRL);
+}
+
+static int spdif_out_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
+	u32 rate, core_freq;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+	case 16000:
+	case 32000:
+	case 64000:
+		/*
+		 * The clock is multiplied by 10 to bring it to feasible range
+		 * of frequencies for sscg
+		 */
+		core_freq = 64000 * 128 * 10;	/* 81.92 MHz */
+		break;
+	case 5512:
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+	case 176400:
+		core_freq = 176400 * 128;	/* 22.5792 MHz */
+		break;
+	case 48000:
+	case 96000:
+	case 192000:
+	default:
+		core_freq = 192000 * 128;	/* 24.576 MHz */
+		break;
+	}
+
+	spdif_out_clock(host, core_freq, rate);
+	host->saved_params.core_freq = core_freq;
+	host->saved_params.rate = rate;
+
+	return 0;
+}
+
+static int spdif_out_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
+{
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
+	u32 ctrl;
+	int ret = 0;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			ctrl = readl(host->io_base + SPDIF_OUT_CTRL);
+			ctrl &= ~SPDIF_OPMODE_MASK;
+			if (!spdif_out_mute)
+				ctrl |= SPDIF_OPMODE_AUD_DATA |
+					SPDIF_STATE_NORMAL;
+			else
+				ctrl |= SPDIF_OPMODE_MUTE_PCM;
+			writel(ctrl, host->io_base + SPDIF_OUT_CTRL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ctrl = readl(host->io_base + SPDIF_OUT_CTRL);
+		ctrl &= ~SPDIF_OPMODE_MASK;
+		ctrl |= SPDIF_OPMODE_OFF;
+		writel(ctrl, host->io_base + SPDIF_OUT_CTRL);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int spdif_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
+	u32 val;
+
+	spdif_out_mute = mute;
+	val = readl(host->io_base + SPDIF_OUT_CTRL);
+	val &= ~SPDIF_OPMODE_MASK;
+
+	if (mute)
+		val |= SPDIF_OPMODE_MUTE_PCM;
+	else {
+		if (host->running)
+			val |= SPDIF_OPMODE_AUD_DATA | SPDIF_STATE_NORMAL;
+		else
+			val |= SPDIF_OPMODE_OFF;
+	}
+
+	writel(val, host->io_base + SPDIF_OUT_CTRL);
+	return 0;
+}
+
+static int spdif_mute_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = spdif_out_mute;
+	return 0;
+}
+
+static int spdif_mute_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	if (spdif_out_mute == ucontrol->value.integer.value[0])
+		return 0;
+
+	spdif_digital_mute(cpu_dai, ucontrol->value.integer.value[0]);
+
+	return 1;
+}
+static const struct snd_kcontrol_new spdif_out_controls[] = {
+	SOC_SINGLE_BOOL_EXT("SPDIF Play Mute", (unsigned long)&spdif_out_mute,
+			spdif_mute_get, spdif_mute_put),
+};
+
+int spdif_soc_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = dai->card;
+	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	return snd_soc_add_codec_controls(codec, spdif_out_controls,
+				ARRAY_SIZE(spdif_out_controls));
+}
+
+static struct snd_soc_dai_ops spdif_out_dai_ops = {
+	.digital_mute	= spdif_digital_mute,
+	.startup	= spdif_out_startup,
+	.shutdown	= spdif_out_shutdown,
+	.trigger	= spdif_out_trigger,
+	.hw_params	= spdif_out_hw_params,
+};
+
+struct snd_soc_dai_driver spdif_out_dai = {
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
+				 SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.probe = spdif_soc_dai_probe,
+	.ops = (struct snd_soc_dai_ops *)&spdif_out_dai_ops,
+};
+
+static int spdif_out_probe(struct platform_device *pdev)
+{
+	struct spdif_out_dev *host;
+	struct spear_spdif_platform_data *pdata;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				resource_size(res), pdev->name)) {
+		dev_warn(&pdev->dev, "Failed to get memory resourse\n");
+		return -ENOENT;
+	}
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host) {
+		dev_warn(&pdev->dev, "kzalloc fail\n");
+		return -ENOMEM;
+	}
+
+	host->io_base = devm_ioremap(&pdev->dev, res->start,
+				resource_size(res));
+	if (!host->io_base) {
+		dev_warn(&pdev->dev, "ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	host->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	host->dma_params.data = pdata->dma_params;
+	host->dma_params.addr = res->start + SPDIF_OUT_FIFO_DATA;
+	host->dma_params.max_burst = 16;
+	host->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_params.filter = pdata->filter;
+
+	dev_set_drvdata(&pdev->dev, host);
+
+	ret = snd_soc_register_dai(&pdev->dev, &spdif_out_dai);
+	if (ret != 0) {
+		clk_put(host->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int spdif_out_remove(struct platform_device *pdev)
+{
+	struct spdif_out_dev *host = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	clk_put(host->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int spdif_out_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spdif_out_dev *host = dev_get_drvdata(&pdev->dev);
+
+	if (host->running)
+		clk_disable(host->clk);
+
+	return 0;
+}
+
+static int spdif_out_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spdif_out_dev *host = dev_get_drvdata(&pdev->dev);
+
+	if (host->running) {
+		clk_enable(host->clk);
+		spdif_out_configure(host);
+		spdif_out_clock(host, host->saved_params.core_freq,
+				host->saved_params.rate);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(spdif_out_dev_pm_ops, spdif_out_suspend, \
+		spdif_out_resume);
+
+#define SPDIF_OUT_DEV_PM_OPS (&spdif_out_dev_pm_ops)
+
+#else
+#define SPDIF_OUT_DEV_PM_OPS NULL
+
+#endif
+
+static struct platform_driver spdif_out_driver = {
+	.probe		= spdif_out_probe,
+	.remove		= spdif_out_remove,
+	.driver		= {
+		.name	= "spdif-out",
+		.owner	= THIS_MODULE,
+		.pm	= SPDIF_OUT_DEV_PM_OPS,
+	},
+};
+
+module_platform_driver(spdif_out_driver);
+
+MODULE_AUTHOR("Vipin Kumar <vipin.kumar@st.com>");
+MODULE_DESCRIPTION("SPEAr SPDIF OUT SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spdif_out");
diff --git a/sound/soc/spear/spdif_out_regs.h b/sound/soc/spear/spdif_out_regs.h
new file mode 100644
index 0000000..a5e5332
--- /dev/null
+++ b/sound/soc/spear/spdif_out_regs.h
@@ -0,0 +1,79 @@
+/*
+ * SPEAr SPDIF OUT controller header file
+ *
+ * Copyright (ST) 2011 Vipin Kumar (vipin.kumar@st.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef SPDIF_OUT_REGS_H
+#define SPDIF_OUT_REGS_H
+
+#define SPDIF_OUT_SOFT_RST	0x00
+	#define SPDIF_OUT_RESET		(1 << 0)
+#define SPDIF_OUT_FIFO_DATA	0x04
+#define SPDIF_OUT_INT_STA	0x08
+#define SPDIF_OUT_INT_STA_CLR	0x0C
+	#define SPDIF_INT_UNDERFLOW	(1 << 0)
+	#define SPDIF_INT_EODATA	(1 << 1)
+	#define SPDIF_INT_EOBLOCK	(1 << 2)
+	#define SPDIF_INT_EOLATENCY	(1 << 3)
+	#define SPDIF_INT_EOPD_DATA	(1 << 4)
+	#define SPDIF_INT_MEMFULLREAD	(1 << 5)
+	#define SPDIF_INT_EOPD_PAUSE	(1 << 6)
+
+#define SPDIF_OUT_INT_EN	0x10
+#define SPDIF_OUT_INT_EN_SET	0x14
+#define SPDIF_OUT_INT_EN_CLR	0x18
+#define SPDIF_OUT_CTRL		0x1C
+	#define SPDIF_OPMODE_MASK	(7 << 0)
+	#define SPDIF_OPMODE_OFF	(0 << 0)
+	#define SPDIF_OPMODE_MUTE_PCM	(1 << 0)
+	#define SPDIF_OPMODE_MUTE_PAUSE	(2 << 0)
+	#define SPDIF_OPMODE_AUD_DATA	(3 << 0)
+	#define SPDIF_OPMODE_ENCODE	(4 << 0)
+	#define SPDIF_STATE_NORMAL	(1 << 3)
+	#define SPDIF_DIVIDER_MASK	(0xff << 5)
+	#define SPDIF_DIVIDER_SHIFT	(5)
+	#define SPDIF_SAMPLEREAD_MASK	(0x1ffff << 15)
+	#define SPDIF_SAMPLEREAD_SHIFT	(15)
+#define SPDIF_OUT_STA		0x20
+#define SPDIF_OUT_PA_PB		0x24
+#define SPDIF_OUT_PC_PD		0x28
+#define SPDIF_OUT_CL1		0x2C
+#define SPDIF_OUT_CR1		0x30
+#define SPDIF_OUT_CL2_CR2_UV	0x34
+#define SPDIF_OUT_PAUSE_LAT	0x38
+#define SPDIF_OUT_FRMLEN_BRST	0x3C
+#define SPDIF_OUT_CFG		0x40
+	#define SPDIF_OUT_MEMFMT_16_0	(0 << 5)
+	#define SPDIF_OUT_MEMFMT_16_16	(1 << 5)
+	#define SPDIF_OUT_VALID_DMA	(0 << 3)
+	#define SPDIF_OUT_VALID_HW	(1 << 3)
+	#define SPDIF_OUT_USER_DMA	(0 << 2)
+	#define SPDIF_OUT_USER_HW	(1 << 2)
+	#define SPDIF_OUT_CHNLSTA_DMA	(0 << 1)
+	#define SPDIF_OUT_CHNLSTA_HW	(1 << 1)
+	#define SPDIF_OUT_PARITY_HW	(0 << 0)
+	#define SPDIF_OUT_PARITY_DMA	(1 << 0)
+	#define SPDIF_OUT_FDMA_TRIG_2	(2 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_6	(6 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_8	(8 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_10	(10 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_12	(12 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_16	(16 << 8)
+	#define SPDIF_OUT_FDMA_TRIG_18	(18 << 8)
+
+#endif /* SPDIF_OUT_REGS_H */
-- 
1.7.0.4
