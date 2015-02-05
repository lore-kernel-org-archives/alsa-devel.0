From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch V4 05/10] ASoC: ipq806x: add LPASS header files
Date: Thu,  5 Feb 2015 12:53:41 -0800
Message-ID: <1423169626-22166-6-git-send-email-kwestfie@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add the LPASS header files for ipq806x SOC.  This
includes the register definitions for the ipq806x
LPAIF, and the structure definition for the driver
data.

Signed-off-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 sound/soc/qcom/lpass-lpaif-ipq806x.h | 170 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/lpass.h               |  64 +++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
 create mode 100644 sound/soc/qcom/lpass.h

diff --git a/sound/soc/qcom/lpass-lpaif-ipq806x.h b/sound/soc/qcom/lpass-lpaif-ipq806x.h
new file mode 100644
index 0000000000000000000000000000000000000000..0f6dc74e37a2b182865497585365974703a5a8b8
--- /dev/null
+++ b/sound/soc/qcom/lpass-lpaif-ipq806x.h
@@ -0,0 +1,170 @@
+/*
+ * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
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
+#ifndef __LPASS_LPAIF_H__
+#define __LPASS_LPAIF_H__
+
+#define LPAIF_BANK_OFFSET		0x1000
+
+/* LPAIF I2S */
+
+#define LPAIF_I2SCTL_REG_BASE		0x0010
+#define LPAIF_I2SCTL_REG_STRIDE		0x4
+#define LPAIF_I2SCTL_REG_ADDR(addr, port) \
+	(LPAIF_I2SCTL_REG_BASE + (addr) + (LPAIF_I2SCTL_REG_STRIDE * (port)))
+
+enum lpaif_i2s_ports {
+	LPAIF_I2S_PORT_MIN		= 0,
+
+	LPAIF_I2S_PORT_CODEC_SPK	= 0,
+	LPAIF_I2S_PORT_CODEC_MIC	= 1,
+	LPAIF_I2S_PORT_SEC_SPK		= 2,
+	LPAIF_I2S_PORT_SEC_MIC		= 3,
+	LPAIF_I2S_PORT_MI2S		= 4,
+
+	LPAIF_I2S_PORT_MAX		= 4,
+	LPAIF_I2S_PORT_NUM		= 5,
+};
+
+#define LPAIF_I2SCTL_REG(port)		LPAIF_I2SCTL_REG_ADDR(0x0, (port))
+
+#define LPAIF_I2SCTL_LOOPBACK_MASK	0x8000
+#define LPAIF_I2SCTL_LOOPBACK_SHIFT	15
+#define LPAIF_I2SCTL_LOOPBACK_DISABLE	(0 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
+#define LPAIF_I2SCTL_LOOPBACK_ENABLE	(1 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
+
+#define LPAIF_I2SCTL_SPKEN_MASK		0x4000
+#define LPAIF_I2SCTL_SPKEN_SHIFT	14
+#define LPAIF_I2SCTL_SPKEN_DISABLE	(0 << LPAIF_I2SCTL_SPKEN_SHIFT)
+#define LPAIF_I2SCTL_SPKEN_ENABLE	(1 << LPAIF_I2SCTL_SPKEN_SHIFT)
+
+#define LPAIF_I2SCTL_SPKMODE_MASK	0x3C00
+#define LPAIF_I2SCTL_SPKMODE_SHIFT	10
+#define LPAIF_I2SCTL_SPKMODE_NONE	(0 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD0	(1 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD1	(2 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD2	(3 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD3	(4 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_QUAD01	(5 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_QUAD23	(6 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_6CH	(7 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_8CH	(8 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+
+#define LPAIF_I2SCTL_SPKMONO_MASK	0x0200
+#define LPAIF_I2SCTL_SPKMONO_SHIFT	9
+#define LPAIF_I2SCTL_SPKMONO_STEREO	(0 << LPAIF_I2SCTL_SPKMONO_SHIFT)
+#define LPAIF_I2SCTL_SPKMONO_MONO	(1 << LPAIF_I2SCTL_SPKMONO_SHIFT)
+
+#define LPAIF_I2SCTL_WSSRC_MASK		0x0004
+#define LPAIF_I2SCTL_WSSRC_SHIFT	2
+#define LPAIF_I2SCTL_WSSRC_INTERNAL	(0 << LPAIF_I2SCTL_WSSRC_SHIFT)
+#define LPAIF_I2SCTL_WSSRC_EXTERNAL	(1 << LPAIF_I2SCTL_WSSRC_SHIFT)
+
+#define LPAIF_I2SCTL_BITWIDTH_MASK	0x0003
+#define LPAIF_I2SCTL_BITWIDTH_SHIFT	0
+#define LPAIF_I2SCTL_BITWIDTH_16	(0 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+#define LPAIF_I2SCTL_BITWIDTH_24	(1 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+#define LPAIF_I2SCTL_BITWIDTH_32	(2 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+
+/* LPAIF IRQ */
+
+#define LPAIF_IRQ_REG_BASE		0x3000
+#define LPAIF_IRQ_REG_STRIDE		0x1000
+#define LPAIF_IRQ_REG_ADDR(addr, port) \
+	(LPAIF_IRQ_REG_BASE + (addr) + (LPAIF_IRQ_REG_STRIDE * (port)))
+
+enum lpaif_irq_ports {
+	LPAIF_IRQ_PORT_MIN		= 0,
+
+	LPAIF_IRQ_PORT_HOST		= 0,
+	LPAIF_IRQ_PORT_ADSP		= 1,
+
+	LPAIF_IRQ_PORT_MAX		= 2,
+	LPAIF_IRQ_PORT_NUM		= 3,
+};
+
+#define LPAIF_IRQEN_REG(port)		LPAIF_IRQ_REG_ADDR(0x0, (port))
+#define LPAIF_IRQSTAT_REG(port)		LPAIF_IRQ_REG_ADDR(0x4, (port))
+#define LPAIF_IRQCLEAR_REG(port)	LPAIF_IRQ_REG_ADDR(0xC, (port))
+
+#define LPAIF_IRQ_BITSTRIDE		3
+#define LPAIF_IRQ_PER(chan)		(1 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+#define LPAIF_IRQ_XRUN(chan)		(2 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+#define LPAIF_IRQ_ERR(chan)		(4 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+#define LPAIF_IRQ_ALL(chan)		(7 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+
+/* LPAIF DMA */
+
+#define LPAIF_RDMA_REG_BASE		0x6000
+#define LPAIF_RDMA_REG_STRIDE		0x1000
+#define LPAIF_RDMA_REG_ADDR(addr, chan) \
+	(LPAIF_RDMA_REG_BASE + (addr) + (LPAIF_RDMA_REG_STRIDE * (chan)))
+
+enum lpaif_dma_channels {
+	LPAIF_RDMA_CHAN_MIN		= 0,
+
+	LPAIF_RDMA_CHAN_MI2S		= 0,
+	LPAIF_RDMA_CHAN_PCM0		= 1,
+	LPAIF_RDMA_CHAN_PCM1		= 2,
+
+	LPAIF_RDMA_CHAN_MAX		= 4,
+	LPAIF_RDMA_CHAN_NUM		= 5,
+};
+
+#define LPAIF_RDMACTL_REG(chan)		LPAIF_RDMA_REG_ADDR(0x00, (chan))
+#define LPAIF_RDMABASE_REG(chan)	LPAIF_RDMA_REG_ADDR(0x04, (chan))
+#define	LPAIF_RDMABUFF_REG(chan)	LPAIF_RDMA_REG_ADDR(0x08, (chan))
+#define LPAIF_RDMACURR_REG(chan)	LPAIF_RDMA_REG_ADDR(0x0C, (chan))
+#define	LPAIF_RDMAPER_REG(chan)		LPAIF_RDMA_REG_ADDR(0x10, (chan))
+
+#define LPAIF_RDMACTL_BURSTEN_MASK	0x800
+#define LPAIF_RDMACTL_BURSTEN_SHIFT	11
+#define LPAIF_RDMACTL_BURSTEN_SINGLE	(0 << LPAIF_RDMACTL_BURSTEN_SHIFT)
+#define LPAIF_RDMACTL_BURSTEN_INCR4	(1 << LPAIF_RDMACTL_BURSTEN_SHIFT)
+
+#define LPAIF_RDMACTL_WPSCNT_MASK	0x700
+#define LPAIF_RDMACTL_WPSCNT_SHIFT	8
+#define LPAIF_RDMACTL_WPSCNT_ONE	(0 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_TWO	(1 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_THREE	(2 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_FOUR	(3 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_SIX	(5 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_EIGHT	(7 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+
+#define LPAIF_RDMACTL_AUDINTF_MASK	0x0F0
+#define LPAIF_RDMACTL_AUDINTF_SHIFT	4
+#define LPAIF_RDMACTL_AUDINTF_NONE	(0 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_CODEC	(1 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_PCM	(2 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_SEC_I2S	(3 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_MI2S	(4 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_HDMI	(5 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_SEC_PCM	(7 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+
+#define LPAIF_RDMACTL_FIFOWM_MASK	0x00E
+#define LPAIF_RDMACTL_FIFOWM_SHIFT	1
+#define LPAIF_RDMACTL_FIFOWM_1		(0 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_2		(1 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_3		(2 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_4		(3 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_5		(4 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_6		(5 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_7		(6 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_8		(7 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+
+#define LPAIF_RDMACTL_ENABLE_MASK	0x1
+#define LPAIF_RDMACTL_ENABLE_SHIFT	0
+#define LPAIF_RDMACTL_ENABLE_OFF	(0 << LPAIF_RDMACTL_ENABLE_SHIFT)
+#define LPAIF_RDMACTL_ENABLE_ON		(1 << LPAIF_RDMACTL_ENABLE_SHIFT)
+
+#endif /* __LPASS_LPAIF_H__ */
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
new file mode 100644
index 0000000000000000000000000000000000000000..7bb7ac5db397dcd0614ee276cc20727bdf55ad64
--- /dev/null
+++ b/sound/soc/qcom/lpass.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
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
+#ifndef __LPASS_H__
+#define __LPASS_H__
+
+#define LPASS_AHBIX_CLOCK_FREQUENCY		131072
+
+/* Both the CPU DAI driver and platform driver will access this data */
+struct lpass_data {
+
+	/* clocks inside the low-power audio subsystem (LPASS) domain */
+	struct clk *ahbix_clk;
+	struct clk *mi2s_bit_clk;
+	struct clk *mi2s_osr_clk;
+
+	/* default system (or OSR) clock frequency */
+	unsigned int default_sysclk_freq;
+
+	/*
+	 * if enabled and the target BIT clock frequency is below the range of
+	 * the clock divider, then the system clock needs to be reduced by
+	 * right-shifting the default clock frequency
+	 */
+	bool sysclk_shift_enable;
+	unsigned int sysclk_shift_compare;
+	unsigned int sysclk_shift_amount;
+
+	/*
+	 * if enabled and the target BIT clock frequency can not be accurately
+	 * derived by the clock divider for the given bitwidth, then use an
+	 * alternate system clock frequency
+	 */
+	bool alt_sysclk_enable;
+	unsigned int alt_sysclk_enable_bitwidth;
+	unsigned int alt_sysclk_freq;
+
+	/* memory-mapped registers for the low-power audio interface (LPAIF) */
+	void __iomem *lpaif;
+	struct regmap *lpaif_map;
+
+	/* handle for the low-power audio interface (LPAIF) interrupts */
+	int lpaif_irq;
+
+	/* memory-mapped RAM designated for holding the audio buffer(s) */
+	void __iomem *lpm;
+	dma_addr_t lpm_phys;
+	unsigned int lpm_size;
+	atomic_t lpm_lock;
+};
+
+int asoc_qcom_lpass_platform_register(struct platform_device *);
+
+#endif /* __LPASS_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
