From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 3/9] ASoC: ipq806x: add native LPAIF driver
Date: Wed, 19 Nov 2014 10:52:43 -0800
Message-ID: <1416423169-21865-4-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add the native LPAIF driver for LPASS block in Qualcomm
Technologies SoCs.

Change-Id: I0f06f73a1267d7721209e58ce18e0d4897001141
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/lpass-lpaif.c | 488 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/lpass-lpaif.h | 181 ++++++++++++++++
 2 files changed, 669 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-lpaif.c
 create mode 100644 sound/soc/qcom/lpass-lpaif.h

diff --git a/sound/soc/qcom/lpass-lpaif.c b/sound/soc/qcom/lpass-lpaif.c
new file mode 100644
index 0000000000000000000000000000000000000000..e62843fe9bc4c63c3c7c119a9f076085b16a56b3
--- /dev/null
+++ b/sound/soc/qcom/lpass-lpaif.c
@@ -0,0 +1,488 @@
+/*
+ * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/types.h>
+#include <sound/soc.h>
+#include "lpass-lpaif.h"
+
+#define DRV_NAME	"lpass-lpaif"
+#define DRV_VERSION	"1.0"
+
+struct lpaif_dai_baseinfo {
+	void __iomem *base;
+};
+
+struct lpaif_dai_drv {
+	unsigned char *buffer;
+	dma_addr_t buffer_phys;
+	int channels;
+	irqreturn_t (*callback)(int intrsrc, void *private_data);
+	void *private_data;
+	int in_use;
+	unsigned int buffer_len;
+	unsigned int period_len;
+	unsigned int master_mode;
+};
+
+static struct lpaif_dai_baseinfo lpaif_dai_info;
+static struct lpaif_dai_drv *lpaif_dai[LPAIF_MAX_CHANNELS];
+static spinlock_t lpaif_lock;
+static struct resource *lpaif_irq;
+
+static int lpaif_pcm_int_enable(uint8_t dma_ch)
+{
+	uint32_t intr_val;
+	uint32_t status_val;
+	unsigned long flags;
+
+	if (dma_ch >= LPAIF_MAX_CHANNELS) {
+		pr_err("%s: invalid DMA channel given: %hhu\n",
+				__func__, dma_ch);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	/* clear status before enabling interrupt */
+	status_val = readl(lpaif_dai_info.base + LPAIF_IRQ_CLEAR(0));
+	status_val |= LPAIF_PER_CH(dma_ch);
+	writel(status_val, lpaif_dai_info.base + LPAIF_IRQ_CLEAR(0));
+
+	intr_val = readl(lpaif_dai_info.base + LPAIF_IRQ_EN(0));
+	intr_val |= LPAIF_PER_CH(dma_ch);
+	writel(intr_val, lpaif_dai_info.base + LPAIF_IRQ_EN(0));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+
+	return 0;
+}
+
+static int lpaif_pcm_int_disable(uint8_t dma_ch)
+{
+	uint32_t intr_val;
+	unsigned long flags;
+
+	if (dma_ch >= LPAIF_MAX_CHANNELS) {
+		pr_err("%s: invalid DMA channel given: %hhu\n",
+				__func__, dma_ch);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	intr_val = readl(lpaif_dai_info.base + LPAIF_IRQ_EN(0));
+	intr_val &= ~LPAIF_PER_CH(dma_ch);
+	writel(intr_val, lpaif_dai_info.base + LPAIF_IRQ_EN(0));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+
+	return 0;
+}
+
+void lpaif_cfg_i2s_playback(uint8_t enable, uint32_t mode, uint32_t off)
+{
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+
+	if (enable)
+		cfg |= LPAIF_SPK_EN;
+	else
+		cfg &= ~LPAIF_SPK_EN;
+
+	cfg |= mode << LPAIF_SPK_MODE;
+	cfg &= ~LPAIF_WS;
+
+	writel(cfg, lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+}
+
+int lpaif_cfg_mi2s_hwparams_bit_width(uint32_t bit_width, uint32_t off)
+{
+	int ret = 0;
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+	cfg &= ~LPAIF_BIT_MASK;
+
+	switch (bit_width) {
+	case SNDRV_PCM_FORMAT_S16:
+		cfg |= LPAIF_BIT_RATE16;
+		break;
+	case SNDRV_PCM_FORMAT_S24:
+		cfg |= LPAIF_BIT_RATE24;
+		break;
+	case SNDRV_PCM_FORMAT_S32:
+		cfg |= LPAIF_BIT_RATE32;
+		break;
+	default:
+		pr_err("%s: invalid bitwidth given: %u\n",
+				__func__, bit_width);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (!ret)
+		writel(cfg, lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+
+	return ret;
+}
+
+int lpaif_cfg_mi2s_playback_hwparams_channels(uint32_t channels, uint32_t off,
+		uint32_t bit_width)
+{
+	int ret = 0;
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+	cfg &= ~LPAIF_SPK_MODE_MASK;
+
+	switch (channels) {
+	case 2:
+		cfg |= LPAIF_SPK_MODE_SD0;
+		break;
+	case 4:
+		cfg |= LPAIF_SPK_MODE_QUAD01;
+		break;
+	case 6:
+		cfg |= LPAIF_SPK_MODE_6CH;
+		break;
+	case 8:
+		cfg |= LPAIF_SPK_MODE_8CH;
+		break;
+	default:
+		pr_err("%s: invalid channels given: %u\n", __func__, channels);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (!ret)
+		writel(cfg, lpaif_dai_info.base + LPAIF_MI2S_CTL_OFFSET(off));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+
+	return ret;
+}
+
+static int lpaif_dai_config_dma(uint32_t dma_ch)
+{
+	if (dma_ch >= LPAIF_MAX_CHANNELS) {
+		pr_err("%s: invalid DMA channel given: %u\n",
+				__func__, dma_ch);
+		return -EINVAL;
+	}
+
+	writel(lpaif_dai[dma_ch]->buffer_phys,
+			lpaif_dai_info.base + LPAIF_DMA_BASE(dma_ch));
+	writel(((lpaif_dai[dma_ch]->buffer_len >> 2) - 1),
+			lpaif_dai_info.base + LPAIF_DMA_BUFF_LEN(dma_ch));
+	writel(((lpaif_dai[dma_ch]->period_len >> 2) - 1),
+			lpaif_dai_info.base + LPAIF_DMA_PER_LEN(dma_ch));
+
+	return 0;
+}
+
+static int lpaif_dai_cfg_dma_ch(uint32_t dma_ch, uint32_t channels,
+		uint32_t bit_width)
+{
+	int ret = 0;
+	uint32_t cfg;
+	unsigned long flags;
+
+	if (dma_ch >= LPAIF_MAX_CHANNELS) {
+		pr_err("%s: invalid DMA channel given: %u\n",
+				__func__, dma_ch);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&lpaif_lock, flags);
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+
+	if ((dma_ch == LPAIF_MI2S_DMA_RD_CH) ||
+			(dma_ch == LPAIF_MI2S_DMA_WR_CH)) {
+		cfg |= LPAIF_DMACTL_AUDIO_INTF_MI2S;
+		cfg &= ~LPAIF_DMACTL_WPSCNT_MASK;
+
+		if ((bit_width == 16) && (channels == 2)) {
+			cfg |= LPAIF_DMACTL_WPSCNT_MONO;
+		} else if (((bit_width == 16) && (channels == 4)) ||
+				(((bit_width == 24) || (bit_width == 32)) &&
+				(channels == 2))) {
+			cfg |= LPAIF_DMACTL_WPSCNT_STEREO;
+		} else if ((bit_width == 16) && (channels == 6)) {
+			cfg |= LPAIF_DMACTL_WPSCNT_3CH;
+		} else if (((bit_width == 16) && (channels == 8)) ||
+				(((bit_width == 32) || (bit_width == 24)) &&
+				(channels == 4))) {
+			cfg |= LPAIF_DMACTL_WPSCNT_4CH;
+		} else if (((bit_width == 24) || (bit_width == 32)) &&
+				(channels == 6)) {
+			cfg |= LPAIF_DMACTL_WPSCNT_6CH;
+		} else if (((bit_width == 24) || (bit_width == 32)) &&
+				(channels == 8)) {
+			cfg |= LPAIF_DMACTL_WPSCNT_8CH;
+		} else {
+			pr_err("%s: invalid PCM config given: bw=%u, ch=%u\n",
+					__func__, bit_width, channels);
+			ret = -EINVAL;
+		}
+	}
+
+	if (!ret)
+		writel(cfg, lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+
+	spin_unlock_irqrestore(&lpaif_lock, flags);
+	return ret;
+}
+
+int lpaif_cfg_dma(uint32_t dma_ch, struct lpaif_dai_dma_params *params,
+		uint32_t bit_width, bool enable_intr)
+{
+	int ret;
+	uint32_t cfg;
+
+	lpaif_dai[dma_ch]->buffer = params->buffer;
+	lpaif_dai[dma_ch]->buffer_phys = params->src_start;
+	lpaif_dai[dma_ch]->channels = params->channels;
+	lpaif_dai[dma_ch]->buffer_len = params->buffer_size;
+	lpaif_dai[dma_ch]->period_len = params->period_size;
+
+	ret = lpaif_dai_config_dma(dma_ch);
+	if (ret) {
+		pr_err("%s: error configuring DMA block: %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (enable_intr)
+		lpaif_pcm_int_enable(dma_ch);
+
+	ret = lpaif_dai_cfg_dma_ch(dma_ch, params->channels, bit_width);
+	if (ret) {
+		pr_err("%s: error configuring DMA channel: %d\n",
+				__func__, ret);
+		lpaif_pcm_int_disable(dma_ch);
+		return ret;
+	}
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+	cfg |= LPAIF_DMACTL_FIFO_WM_8 | LPAIF_DMACTL_BURST_EN;
+	writel(cfg, lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+	cfg |= LPAIF_DMACTL_ENABLE;
+	writel(cfg, lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+
+	return 0;
+}
+
+int lpaif_dai_stop(uint32_t dma_ch)
+{
+	writel(0x0, lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+	return 0;
+}
+
+uint8_t lpaif_dma_stop(uint8_t dma_ch)
+{
+	uint32_t cfg;
+
+	cfg = readl(lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+	cfg &= ~LPAIF_DMACTL_ENABLE;
+	writel(cfg, lpaif_dai_info.base + LPAIF_DMA_CTL(dma_ch));
+	return 0;
+}
+
+void lpaif_register_dma_irq_handler(int dma_ch,
+		irqreturn_t (*callback)(int intrsrc, void *private_data),
+		void *private_data)
+{
+	lpaif_dai[dma_ch]->callback = callback;
+	lpaif_dai[dma_ch]->private_data = private_data;
+}
+
+void lpaif_unregister_dma_irq_handler(int dma_ch)
+{
+	lpaif_dai[dma_ch]->callback = NULL;
+	lpaif_dai[dma_ch]->private_data = NULL;
+}
+
+/*
+ * Logic to find the dma channel from interrupt.
+ * In total we have 9 channels, each channel records the transcation
+ * status. Either one of ths 3 status will be recorded per transcation
+ * (PER_CH,UNDER_RUN,OVER_RUN)
+ */
+static int lpaif_dai_find_dma_channel(uint32_t intrsrc)
+{
+	uint32_t dma_channel = 0;
+
+	while (dma_channel < LPAIF_MAX_CHANNELS) {
+		if (intrsrc & LPAIF_PER_CH(dma_channel))
+			return dma_channel;
+
+		dma_channel++;
+	}
+
+	return -1;
+}
+
+/* ISR for handling LPAIF interrupts  */
+static irqreturn_t lpaif_dai_irq_handler(int irq, void *data)
+{
+	unsigned long flag;
+	uint32_t intrsrc;
+	uint32_t dma_ch;
+	irqreturn_t ret = IRQ_NONE;
+
+	spin_lock_irqsave(&lpaif_lock, flag);
+	intrsrc = readl(lpaif_dai_info.base + LPAIF_IRQ_STAT(0));
+	writel(intrsrc, lpaif_dai_info.base + LPAIF_IRQ_CLEAR(0));
+	spin_unlock_irqrestore(&lpaif_lock, flag);
+
+	while (intrsrc) {
+		dma_ch = lpaif_dai_find_dma_channel(intrsrc);
+		if (dma_ch != -1) {
+			if (lpaif_dai[dma_ch]->callback) {
+
+				ret = lpaif_dai[dma_ch]->callback(intrsrc,
+					lpaif_dai[dma_ch]->private_data);
+			}
+			intrsrc &= ~LPAIF_PER_CH(dma_ch);
+		} else {
+			pr_err("%s: error getting channel\n", __func__);
+			break;
+		}
+	}
+	return ret;
+}
+
+static void lpaif_dai_ch_free(void)
+{
+	int i;
+
+	for (i = 0; i < LPAIF_MAX_CHANNELS; i++)
+		kfree(lpaif_dai[i]);
+}
+
+static int lpaif_dai_probe(struct platform_device *pdev)
+{
+	uint8_t i;
+	int32_t rc;
+	struct resource *lpa_res;
+	struct device *lpaif_device;
+
+	lpaif_device = &pdev->dev;
+
+	lpa_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"lpass-lpaif-mem");
+	if (!lpa_res) {
+		dev_err(&pdev->dev, "%s: error getting resource\n", __func__);
+		return -ENODEV;
+	}
+	lpaif_dai_info.base = ioremap(lpa_res->start,
+			(lpa_res->end - lpa_res->start));
+	if (!lpaif_dai_info.base) {
+		dev_err(&pdev->dev, "%s: error remapping resource\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	lpaif_irq = platform_get_resource_byname(
+			pdev, IORESOURCE_IRQ, "lpass-lpaif-irq");
+	if (!lpaif_irq) {
+		dev_err(&pdev->dev, "%s: failed get irq res\n", __func__);
+		rc = -ENODEV;
+		goto error;
+	}
+
+	rc = request_irq(lpaif_irq->start, lpaif_dai_irq_handler,
+			IRQF_TRIGGER_RISING, "lpass-lpaif-intr", NULL);
+
+	if (rc < 0) {
+		dev_err(&pdev->dev, "%s: irq resource request failed\n",
+				__func__);
+		goto error;
+	}
+
+	/*
+	 * Allocating memory for all the LPA_IF DMA channels
+	 */
+	for (i = 0; i < LPAIF_MAX_CHANNELS; i++) {
+		lpaif_dai[i] = kzalloc(sizeof(struct lpaif_dai_drv),
+				GFP_KERNEL);
+		if (!lpaif_dai[i]) {
+			rc = -ENOMEM;
+			goto error_irq;
+		}
+	}
+	spin_lock_init(&lpaif_lock);
+	return 0;
+
+error_irq:
+	free_irq(lpaif_irq->start, NULL);
+	lpaif_dai_ch_free();
+error:
+	iounmap(lpaif_dai_info.base);
+	return rc;
+}
+
+static int lpaif_dai_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < LPAIF_MAX_CHANNELS; i++)
+		lpaif_dai_stop(i);
+	synchronize_irq(lpaif_irq->start);
+	free_irq(lpaif_irq->start, NULL);
+	iounmap(lpaif_dai_info.base);
+	lpaif_dai_ch_free();
+	return 0;
+}
+
+static const struct of_device_id lpaif_dai_dt_match[] = {
+	{.compatible = "qcom,lpass-lpaif"},
+	{}
+};
+
+static struct platform_driver lpass_lpaif_driver = {
+	.probe = lpaif_dai_probe,
+	.remove = lpaif_dai_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = lpaif_dai_dt_match,
+		},
+};
+module_platform_driver(lpass_lpaif_driver);
+
+MODULE_DESCRIPTION("QCOM LPASS LPAIF Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, lpaif_dai_dt_match);
+MODULE_VERSION(DRV_VERSION);
diff --git a/sound/soc/qcom/lpass-lpaif.h b/sound/soc/qcom/lpass-lpaif.h
new file mode 100644
index 0000000000000000000000000000000000000000..e10731bb2cef96e31ebf7a92b9ba3e8ee22e0360
--- /dev/null
+++ b/sound/soc/qcom/lpass-lpaif.h
@@ -0,0 +1,181 @@
+/*
+ * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LPASS_LPAIF_H
+#define _LPASS_LPAIF_H
+
+#define LPAIF_BANK_OFFSET			0x1000
+
+/* Audio DMA registers for DMA channel confuguration */
+#define LPAIF_DMA_CH_CTL_BASE			0x6000
+#define LPAIF_DMA_CH_INDEX(ch)			(LPAIF_BANK_OFFSET * ch)
+
+#define LPAIF_DMA_CTRL_ADDR(ch, addr)		(LPAIF_DMA_CH_CTL_BASE \
+						+ (LPAIF_DMA_CH_INDEX(ch) \
+						+ addr))
+
+#define LPAIF_DMA_CTL(x)			LPAIF_DMA_CTRL_ADDR(x, 0x00)
+#define LPAIF_BURST_EN				(1 << 11)
+#define LPAIF_WPSCNT_ONE			(0 << 8)
+#define LPAIF_WPSCNT_TWO			(1 << 8)
+#define LPAIF_WPSCNT_THREE			(2 << 8)
+#define LPAIF_WPSCNT_FOUR			(3 << 8)
+#define LPAIF_WPSCNT_SIX			(5 << 8)
+#define LPAIF_WPSCNT_EIGHT			(7 << 8)
+#define LPAIF_AUDIO_INTF_NONE			(0 << 4)
+#define LPAIF_AUDIO_INTF_CODEC			(1 << 4)
+#define LPAIF_AUDIO_INTF_PCM			(2 << 4)
+#define LPAIF_AUDIO_INTF_SEC_I2S		(3 << 4)
+#define LPAIF_AUDIO_INTF_MI2S			(4 << 4)
+#define LPAIF_AUDIO_INTF_HDMI			(5 << 4)
+#define LPAIF_AUDIO_INTF_MIXOUT			(6 << 4)
+#define LPAIF_AUDIO_INTF_LOOPBACK1		(7 << 4)
+#define LPAIF_AUDIO_INTF_LOOPBACK2		(8 << 4)
+#define LPAIF_FIFO_WATERMRK(x)			((x & 0x7) << 1)
+#define LPAIF_ENABLE				(1 << 0)
+
+#define LPAIF_DMA_BASE(x)			LPAIF_DMA_CTRL_ADDR(x, 0x04)
+#define LPAIF_BASE_ADDR				(0xFFFFFFFF << 4)
+
+#define	LPAIF_DMA_BUFF_LEN(x)			LPAIF_DMA_CTRL_ADDR(x, 0x08)
+#define LPAIF_DMA_CURR_ADDR(x)			LPAIF_DMA_CTRL_ADDR(x, 0x0c)
+#define	LPAIF_DMA_PER_LEN(x)			LPAIF_DMA_CTRL_ADDR(x, 0x10)
+#define	LPAIF_DMA_PER_CNT(x)			LPAIF_DMA_CTRL_ADDR(x, 0x14)
+#define	LPAIF_DMA_FRM(x)			LPAIF_DMA_CTRL_ADDR(x, 0x18)
+#define LPAIF_DMA_FRMCLR(x)			LPAIF_DMA_CTRL_ADDR(x, 0x1c)
+#define LPAIF_DMA_SET_BUFF_CNT(x)		LPAIF_DMA_CTRL_ADDR(x, 0x20)
+#define	LPAIF_DMA_SET_PER_CNT(x)		LPAIF_DMA_CTRL_ADDR(x, 0x24)
+
+#define LPAIF_MAX_CHANNELS			9
+
+#define LPAIF_CODEC_SPK				0x0
+#define LPAIF_CODEC_MIC				0x1
+#define LPAIF_SEC_SPK				0x2
+#define LPAIF_SEC_MIC				0x3
+#define LPAIF_MI2S				0x4
+
+#define LPAIF_LB				(1 << 15)
+#define LPAIF_SPK_EN				(1 << 14)
+
+#define LPAIF_SPK_MODE_MASK			0x3C00
+#define LPAIF_SPK_MODE				10
+#define LPAIF_SPK_MODE_NONE			(0 << 10)
+#define LPAIF_SPK_MODE_SD0			(1 << 10)
+#define LPAIF_SPK_MODE_SD1			(2 << 10)
+#define LPAIF_SPK_MODE_SD2			(3 << 10)
+#define LPAIF_SPK_MODE_SD3			(4 << 10)
+#define LPAIF_SPK_MODE_QUAD01			(5 << 10)
+#define LPAIF_SPK_MODE_QUAD23			(6 << 10)
+#define LPAIF_SPK_MODE_6CH			(7 << 10)
+#define LPAIF_SPK_MODE_8CH			(8 << 10)
+
+#define LPAIF_WS				(1 << 2)
+
+#define LPAIF_BIT_MASK				(0x3)
+#define LPAIF_BIT_RATE16			(0 << 0)
+#define LPAIF_BIT_RATE24			(1 << 0)
+#define LPAIF_BIT_RATE32			(2 << 0)
+
+#define LPAIF_MI2S_CTL_OFFSET(x)		(0x0010 + (0x4 * x))
+
+/* LPAIF INTERRUPT CTRL */
+
+#define LPAIF_DMA_IRQ_BASE			0x3000
+#define LPAIF_DMA_IRQ_INDEX(x)			(LPAIF_BANK_OFFSET * x)
+#define LPAIF_DMA_IRQ_ADDR(irq, addr)		(LPAIF_DMA_IRQ_BASE  \
+						+ LPAIF_DMA_IRQ_INDEX(irq) \
+						+ addr)
+
+#define LPAIF_IRQ_EN(x)				LPAIF_DMA_IRQ_ADDR(x, 0x00)
+#define LPAIF_IRQ_STAT(x)			LPAIF_DMA_IRQ_ADDR(x, 0x04)
+#define LPAIF_IRQ_RAW_STAT(x)			LPAIF_DMA_IRQ_ADDR(x, 0x08)
+#define LPAIF_IRQ_CLEAR(x)			LPAIF_DMA_IRQ_ADDR(x, 0x0c)
+#define LPAIF_IRQ_FORCE(x)			LPAIF_DMA_IRQ_ADDR(x, 0x10)
+#define LPAIF_PER_CH(x)				(1 << (3 * x))
+#define LPAIF_UNDER_CH(x)			(2 << (3 * x))
+#define LPAIF_ERR_CH(x)				(4 << (3 * x))
+
+/* DMA CTRL */
+
+#define LPAIF_DMACTL_BURST_EN			(1 << 11)
+#define LPAIF_DMACTL_WPSCNT_MASK		(0x700)
+#define LPAIF_DMACTL_WPSCNT_MONO		(0 << 8)
+#define LPAIF_DMACTL_WPSCNT_STEREO		(1 << 8)
+#define LPAIF_DMACTL_WPSCNT_STEREO_2CH		(0 << 8)
+#define LPAIF_DMACTL_WPSCNT_3CH			(2 << 8)
+#define LPAIF_DMACTL_WPSCNT_4CH			(3 << 8)
+#define LPAIF_DMACTL_WPSCNT_5CH			(4 << 8)
+#define LPAIF_DMACTL_WPSCNT_6CH			(5 << 8)
+#define LPAIF_DMACTL_WPSCNT_7CH			(6 << 8)
+#define LPAIF_DMACTL_WPSCNT_8CH			(7 << 8)
+
+#define LPAIF_DMACTL_AUDIO_INTF_MASK		(0xF0)
+#define LPAIF_DMACTL_AUDIO_INTF_NONE		(0 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_CODEC		(1 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_PCM		(2 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_SEC_I2S		(3 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_MI2S		(4 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_HDMI		(5 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_MIXOUT		(6 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_LB1		(7 << 4)
+#define LPAIF_DMACTL_AUDIO_INTF_LB2		(8 << 4)
+
+#define LPAIF_DMACTL_FIFO_WM_1			(0 << 1)
+#define LPAIF_DMACTL_FIFO_WM_2			(1 << 1)
+#define LPAIF_DMACTL_FIFO_WM_3			(2 << 1)
+#define LPAIF_DMACTL_FIFO_WM_4			(3 << 1)
+#define LPAIF_DMACTL_FIFO_WM_5			(4 << 1)
+#define LPAIF_DMACTL_FIFO_WM_6			(5 << 1)
+#define LPAIF_DMACTL_FIFO_WM_7			(6 << 1)
+#define LPAIF_DMACTL_FIFO_WM_8			(7 << 1)
+
+#define LPAIF_DMACTL_ENABLE			(1 << 0)
+
+enum lpaif_dma_intf_wr_ch {
+	LPAIF_MIN_DMA_WR_CH	= 5,
+	LPAIF_PCM0_DMA_WR_CH	= 5,
+	LPAIF_PCM1_DMA_WR_CH	= 6,
+	LPAIF_MI2S_DMA_WR_CH	= 6,
+	LPAIF_MAX_DMA_WR_CH	= 8,
+};
+
+enum lpaif_dma_intf_rd_ch {
+	LPAIF_MIN_DMA_RD_CH	= 0,
+	LPAIF_MI2S_DMA_RD_CH	= 0,
+	LPAIF_PCM0_DMA_RD_CH	= 1,
+	LPAIF_PCM1_DMA_RD_CH	= 2,
+	LPAIF_MAX_DMA_RD_CH	= 4,
+};
+
+struct lpaif_dai_dma_params {
+	u8 *buffer;
+	uint32_t src_start;
+	uint32_t bus_id;
+	int buffer_size;
+	int period_size;
+	int channels;
+};
+
+void lpaif_cfg_i2s_playback(uint8_t enable, uint32_t mode, uint32_t off);
+int lpaif_cfg_mi2s_hwparams_bit_width(uint32_t bit_width, uint32_t off);
+int lpaif_cfg_mi2s_playback_hwparams_channels(uint32_t channels,
+		uint32_t off, uint32_t bit_width);
+int lpaif_cfg_dma(uint32_t dma_ch, struct lpaif_dai_dma_params *params,
+		uint32_t bit_width, bool enable_intr);
+int lpaif_dai_stop(uint32_t dma_ch);
+uint8_t lpaif_dma_stop(uint8_t dma_ch);
+void lpaif_register_dma_irq_handler(int dma_ch,
+		irqreturn_t (*callback)(int intr_src, void *private_data),
+		void *private_data);
+void lpaif_unregister_dma_irq_handler(int dma_ch);
+#endif /* _LPASS_LPAIF_H */
-- 
1.8.2.1
