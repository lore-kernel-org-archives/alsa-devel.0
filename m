From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 03/11] ASoC: ipq806x: add LPAIF header file
Date: Mon,  8 Dec 2014 14:01:05 -0800
Message-ID: <1418076073-12623-4-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add the LPASS LPAIF header file in Qualcomm Technologies
SoCs.  This primarily contains the register definitions.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/lpass-lpaif.h | 154 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-lpaif.h

diff --git a/sound/soc/qcom/lpass-lpaif.h b/sound/soc/qcom/lpass-lpaif.h
new file mode 100644
index 0000000000000000000000000000000000000000..cdc81fbe6d0be9d57860b4ba80e0b3549e4cca76
--- /dev/null
+++ b/sound/soc/qcom/lpass-lpaif.h
@@ -0,0 +1,154 @@
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
+#define LPAIF_BANK_OFFSET		0x1000
+
+/* LPAIF DMA Configuration/Control */
+
+#define LPAIF_DMA_BASE			0x6000
+#define LPAIF_DMA_INDEX(ch)		(LPAIF_BANK_OFFSET * (ch))
+#define LPAIF_DMA_ADDR(ch, addr)	(LPAIF_DMA_BASE \
+						+ (LPAIF_DMA_INDEX(ch) \
+						+ (addr)))
+
+#define LPAIF_DMA_CTL(x)		LPAIF_DMA_ADDR((x), 0x00)
+#define LPAIF_DMA_BASEADDR(x)		LPAIF_DMA_ADDR((x), 0x04)
+#define	LPAIF_DMA_BUFFLEN(x)		LPAIF_DMA_ADDR((x), 0x08)
+#define LPAIF_DMA_CURRADDR(x)		LPAIF_DMA_ADDR((x), 0x0c)
+#define	LPAIF_DMA_PERLEN(x)		LPAIF_DMA_ADDR((x), 0x10)
+#define	LPAIF_DMA_PERCNT(x)		LPAIF_DMA_ADDR((x), 0x14)
+#define	LPAIF_DMA_FRM(x)		LPAIF_DMA_ADDR((x), 0x18)
+#define LPAIF_DMA_FRMCLR(x)		LPAIF_DMA_ADDR((x), 0x1c)
+#define LPAIF_DMA_SETBUFFCNT(x)		LPAIF_DMA_ADDR((x), 0x20)
+#define	LPAIF_DMA_SETPERCNT(x)		LPAIF_DMA_ADDR((x), 0x24)
+
+#define LPAIF_DMACTL_BURST_EN_SHIFT	11
+#define LPAIF_DMACTL_BURST_EN		(1 << LPAIF_DMACTL_BURST_EN_SHIFT)
+
+#define LPAIF_DMACTL_WPSCNT_MASK	0x700
+#define LPAIF_DMACTL_WPSCNT_SHIFT	8
+#define LPAIF_DMACTL_WPSCNT_SINGLE	(0 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_DOUBLE	(1 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_TRIPLE	(2 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_QUAD	(3 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_SIXPACK	(5 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_OCTAL	(7 << LPAIF_DMACTL_WPSCNT_SHIFT)
+
+#define LPAIF_DMACTL_AUDIO_INTF_MASK	0x0F0
+#define LPAIF_DMACTL_AUDIO_INTF_SHIFT	4
+#define LPAIF_DMACTL_AUDIO_INTF_NONE	(0 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_CODEC	(1 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_PCM	(2 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_SEC_I2S	(3 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_MI2S	(4 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_HDMI	(5 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_MIXOUT	(6 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_LB1	(7 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+#define LPAIF_DMACTL_AUDIO_INTF_LB2	(8 << LPAIF_DMACTL_AUDIO_INTF_SHIFT)
+
+#define LPAIF_DMACTL_FIFO_WM_MASK	0x00E
+#define LPAIF_DMACTL_FIFO_WM_SHIFT	1
+#define LPAIF_DMACTL_FIFO_WM_1		(0 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_2		(1 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_3		(2 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_4		(3 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_5		(4 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_6		(5 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_7		(6 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+#define LPAIF_DMACTL_FIFO_WM_8		(7 << LPAIF_DMACTL_FIFO_WM_SHIFT)
+
+#define LPAIF_DMACTL_ENABLE_SHIFT	0
+#define LPAIF_DMACTL_ENABLE		(1 << LPAIF_DMACTL_ENABLE_SHIFT)
+
+/* LPAIF DMA Interrupt Control */
+
+#define LPAIF_DMAIRQ_BASE		0x3000
+#define LPAIF_DMAIRQ_INDEX(x)		(LPAIF_BANK_OFFSET * (x))
+#define LPAIF_DMAIRQ_ADDR(irq, addr)	(LPAIF_DMAIRQ_BASE  \
+						+ LPAIF_DMAIRQ_INDEX(irq) \
+						+ (addr))
+
+#define LPAIF_DMAIRQ_EN(x)		LPAIF_DMAIRQ_ADDR((x), 0x00)
+#define LPAIF_DMAIRQ_STAT(x)		LPAIF_DMAIRQ_ADDR((x), 0x04)
+#define LPAIF_DMAIRQ_RAW_STAT(x)	LPAIF_DMAIRQ_ADDR((x), 0x08)
+#define LPAIF_DMAIRQ_CLEAR(x)		LPAIF_DMAIRQ_ADDR((x), 0x0c)
+#define LPAIF_DMAIRQ_FORCE(x)		LPAIF_DMAIRQ_ADDR((x), 0x10)
+
+#define LPAIF_DMAIRQ_SHIFT		3
+#define LPAIF_DMAIRQ_PER(x)		(1 << (LPAIF_DMAIRQ_SHIFT * (x)))
+#define LPAIF_DMAIRQ_XRUN(x)		(2 << (LPAIF_DMAIRQ_SHIFT * (x)))
+#define LPAIF_DMAIRQ_ERR(x)		(4 << (LPAIF_DMAIRQ_SHIFT * (x)))
+#define LPAIF_DMAIRQ_ALL(x)		(7 << (LPAIF_DMAIRQ_SHIFT * (x)))
+
+/* LPAIF I2S Configuration/Control */
+
+#define LPAIF_MI2S_CTL_OFFSET(x)	(0x0010 + 0x4 * (x))
+
+#define LPAIF_MI2SCTL_LB_SHIFT		15
+#define LPAIF_MI2SCTL_LB		(1 << LPAIF_MI2SCTL_LB_SHIFT)
+
+#define LPAIF_MI2SCTL_SPKEN_SHIFT	14
+#define LPAIF_MI2SCTL_SPKEN		(1 << LPAIF_MI2SCTL_SPKEN_SHIFT)
+
+#define LPAIF_MI2SCTL_SPKMODE_MASK	0x3C00
+#define LPAIF_MI2SCTL_SPKMODE_SHIFT	10
+#define LPAIF_MI2SCTL_SPKMODE_NONE	(0 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_SD0	(1 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_SD1	(2 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_SD2	(3 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_SD3	(4 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_QUAD01	(5 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_QUAD23	(6 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_6CH	(7 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+#define LPAIF_MI2SCTL_SPKMODE_8CH	(8 << LPAIF_MI2SCTL_SPKMODE_SHIFT)
+
+#define LPAIF_MI2SCTL_SPKMONO_MASK	0x0200
+#define LPAIF_MI2SCTL_SPKMONO_SHIFT	9
+#define LPAIF_MI2SCTL_SPKMONO_STEREO	(0 << LPAIF_MI2SCTL_SPKMONO_SHIFT)
+#define LPAIF_MI2SCTL_SPKMONO_MONO	(1 << LPAIF_MI2SCTL_SPKMONO_SHIFT)
+
+#define LPAIF_MI2SCTL_WS_SHIFT		2
+#define LPAIF_MI2SCTL_WS		(1 << LPAIF_MI2SCTL_WS_SHIFT)
+
+#define LPAIF_MI2SCTL_BITRATE_MASK	0x3
+#define LPAIF_MI2SCTL_BITRATE_SHIFT	0
+#define LPAIF_MI2SCTL_BITRATE_16	(0 << LPAIF_MI2SCTL_BITRATE_SHIFT)
+#define LPAIF_MI2SCTL_BITRATE_24	(1 << LPAIF_MI2SCTL_BITRATE_SHIFT)
+#define LPAIF_MI2SCTL_BITRATE_32	(2 << LPAIF_MI2SCTL_BITRATE_SHIFT)
+
+enum lpaif_dma_interface_channels {
+	LPAIF_DMA_RD_CH_MI2S = 0,
+	LPAIF_DMA_RD_CH_PCM0 = 1,
+	LPAIF_DMA_RD_CH_PCM1 = 2,
+	LPAIF_DMA_WR_CH_PCM0 = 5,
+	LPAIF_DMA_WR_CH_PCM1 = 6,
+	LPAIF_DMA_WR_CH_MI2S = 6,
+};
+
+enum lpaif_i2s_interface_ports {
+	LPAIF_I2S_PORT_CODEC_SPK = 0,
+	LPAIF_I2S_PORT_CODEC_MIC = 1,
+	LPAIF_I2S_PORT_SEC_SPK   = 2,
+	LPAIF_I2S_PORT_SEC_MIC   = 3,
+	LPAIF_I2S_PORT_MI2S      = 4,
+};
+
+enum lpaif_irq_receivers {
+	LPAIF_IRQ_RECV_HOST = 0,
+	LPAIF_IRQ_RECV_ADSP = 1,
+};
+
+#endif /* _LPASS_LPAIF_H */
-- 
1.8.2.1
