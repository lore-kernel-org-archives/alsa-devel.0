From: Koro Chen <koro.chen@mediatek.com>
Subject: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE
	connection control
Date: Fri, 10 Apr 2015 16:14:08 +0800
Message-ID: <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF37265DDF
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 10:15:09 +0200 (CEST)
In-Reply-To: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: devicetree@vger.kernel.org, koro.chen@mediatek.com, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, galak@codeaurora.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is the AFE inter-connection control APIs.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/mediatek/mtk-afe-common.h     | 105 ++++++++
 sound/soc/mediatek/mtk-afe-connection.c | 416 ++++++++++++++++++++++++++++++++
 sound/soc/mediatek/mtk-afe-connection.h |  30 +++
 3 files changed, 551 insertions(+)
 create mode 100644 sound/soc/mediatek/mtk-afe-common.h
 create mode 100644 sound/soc/mediatek/mtk-afe-connection.c
 create mode 100644 sound/soc/mediatek/mtk-afe-connection.h

diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
new file mode 100644
index 0000000..71b426d
--- /dev/null
+++ b/sound/soc/mediatek/mtk-afe-common.h
@@ -0,0 +1,105 @@
+/*
+ * mtk_afe_common.h  --  Mediatek audio driver common definitions
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Koro Chen <koro.chen@mediatek.com>
+ *             Sascha Hauer <s.hauer@pengutronix.de>
+ *             Hidalgo Huang <hidalgo.huang@mediatek.com>
+ *             Ir Lian <ir.lian@mediatek.com>
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
+#ifndef _MTK_AFE_COMMON_H_
+#define _MTK_AFE_COMMON_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <dt-bindings/sound/mtk-afe.h>
+
+enum {
+	MTK_CLK_INFRASYS_AUD,
+	MTK_CLK_TOP_PDN_AUD,
+	MTK_CLK_TOP_PDN_AUD_BUS,
+	MTK_CLK_I2S0_M,
+	MTK_CLK_I2S1_M,
+	MTK_CLK_I2S2_M,
+	MTK_CLK_I2S3_M,
+	MTK_CLK_I2S3_B,
+	MTK_CLK_BCK0,
+	MTK_CLK_BCK1,
+	MTK_CLK_NUM
+};
+
+struct mtk_afe;
+struct snd_pcm_substream;
+
+struct mtk_afe_io_data {
+	int num;
+	const char *name;
+	int (*startup)(struct mtk_afe *, struct snd_pcm_substream *);
+	void (*shutdown)(struct mtk_afe *, struct snd_pcm_substream *);
+	int (*prepare)(struct mtk_afe *, struct snd_pcm_substream *);
+	int (*start)(struct mtk_afe *, struct snd_pcm_substream *);
+	void (*pause)(struct mtk_afe *, struct snd_pcm_substream *);
+};
+
+struct mtk_afe_io {
+	const struct mtk_afe_io_data *data;
+	struct clk *m_ck;
+	struct clk *b_ck;
+	u32 *connections;
+	int num_connections;
+	int mem[2]; /* playback and capture */
+};
+
+struct mtk_afe_irq_data {
+	int reg_cnt;
+	int cnt_shift;
+	int en_shift;
+	int fs_shift;
+	int clr_shift;
+};
+
+struct mtk_afe_memif_data {
+	int id;
+	const char *name;
+	int reg_ofs_base;
+	int reg_ofs_cur;
+	int fs_shift;
+	int mono_shift;
+	int enable_shift;
+};
+
+struct mtk_afe_memif {
+	unsigned int phys_buf_addr;
+	int buffer_size;
+	unsigned int hw_ptr;		/* Previous IRQ's HW ptr */
+	bool use_sram;
+	struct snd_pcm_substream *substream;
+	const struct mtk_afe_memif_data *data;
+	const struct mtk_afe_irq_data *irqdata;
+};
+
+struct mtk_afe {
+	/* address for ioremap audio hardware register */
+	void __iomem *base_addr;
+	void __iomem *sram_address;
+	u32 sram_phy_address;
+	u32 sram_size;
+	struct device *dev;
+	struct regmap *regmap;
+
+	struct mtk_afe_memif memif[MTK_AFE_MEMIF_NUM];
+	struct mtk_afe_io ios[MTK_AFE_IO_NUM];
+
+	struct clk *clocks[MTK_CLK_NUM];
+};
+#endif
diff --git a/sound/soc/mediatek/mtk-afe-connection.c b/sound/soc/mediatek/mtk-afe-connection.c
new file mode 100644
index 0000000..714e9cd
--- /dev/null
+++ b/sound/soc/mediatek/mtk-afe-connection.c
@@ -0,0 +1,416 @@
+/*
+ * Mediatek AFE audio interconnect support
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Koro Chen <koro.chen@mediatek.com>
+ *             Sascha Hauer <s.hauer@pengutronix.de>
+ *             Hidalgo Huang <hidalgo.huang@mediatek.com>
+ *             Ir Lian <ir.lian@mediatek.com>
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
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/device.h>
+#include "mtk-afe-common.h"
+#include "mtk-afe-connection.h"
+
+#define MTK_AFE_INTERCONN_NUM_INPUT	21
+#define MTK_AFE_INTERCONN_NUM_OUTPUT	23
+
+#define MTK_AFE_HDMI_CONN_INPUT_BASE	30
+#define MTK_AFE_HDMI_CONN_INPUT_MAX	37
+#define MTK_AFE_NUM_HDMI_INPUT		(37 - 30 + 1)
+
+#define MTK_AFE_HDMI_CONN_OUTPUT_BASE	30
+#define MTK_AFE_HDMI_CONN_OUTPUT_MAX	41
+#define MTK_AFE_NUM_HDMI_OUTPUT		(41 - 30 + 1)
+
+struct mtk_afe_connection {
+	short creg, sreg;
+	char cshift, sshift;
+};
+
+/*
+ * The MTK AFE unit has a audio interconnect with MTK_AFE_INTERCONN_NUM_INPUT
+ * inputs and MTK_AFE_INTERCONN_NUM_OUTPUT outputs. Below table holds the
+ * register/bits to set to connect an input with an output.
+ */
+static const struct mtk_afe_connection
+	connections[MTK_AFE_INTERCONN_NUM_INPUT][MTK_AFE_INTERCONN_NUM_OUTPUT] = {
+	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
+	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},
+	[0][2] =   { .creg = 0x024, .cshift =  0, .sreg = 0x024, .sshift = 10},
+	[0][3] =   { .creg = 0x024, .cshift = 16, .sreg = 0x024, .sshift = 26},
+	[0][4] =   { .creg = 0x028, .cshift =  0, .sreg = 0x028, .sshift = 10},
+	[0][5] =   { .creg = 0x028, .cshift = 16, .sreg = 0x030, .sshift = 19},
+	[0][7] =   { .creg = 0x05c, .cshift =  2, },
+	[0][9] =   { .creg = 0x05c, .cshift =  8, },
+	[0][10] =  { .creg = 0x05c, .cshift = 12, },
+	[0][13] =  { .creg = 0x448, .cshift =  2, },
+	[0][14] =  { .creg = 0x448, .cshift = 15, },
+	[0][15] =  { .creg = 0x438, .cshift = 16, .sreg = 0x438, .sshift = 31},
+	[0][16] =  { .creg = 0x438, .cshift = 22, .sreg = 0x440, .sshift = 25},
+	[0][19] =  { .creg = 0x464, .cshift =  8, .sreg = 0x464, .sshift =  9},
+	[0][20] =  { .creg = 0x464, .cshift = 24, .sreg = 0x464, .sshift = 25},
+	[1][0] =   { .creg = 0x020, .cshift =  1, .sreg = 0x020, .sshift = 11},
+	[1][1] =   { .creg = 0x020, .cshift = 17, .sreg = 0x020, .sshift = 27},
+	[1][2] =   { .creg = 0x024, .cshift =  1, .sreg = 0x024, .sshift = 11},
+	[1][3] =   { .creg = 0x024, .cshift = 17, .sreg = 0x024, .sshift = 27},
+	[1][4] =   { .creg = 0x028, .cshift =  1, .sreg = 0x028, .sshift = 11},
+	[1][6] =   { .creg = 0x028, .cshift = 22, .sreg = 0x030, .sshift = 20},
+	[1][7] =   { .creg = 0x05c, .cshift =  3, },
+	[1][8] =   { .creg = 0x05c, .cshift =  6, },
+	[1][9] =   { .creg = 0x05c, .cshift =  9, },
+	[1][10] =  { .creg = 0x05c, .cshift = 13, },
+	[1][13] =  { .creg = 0x448, .cshift =  3, },
+	[1][14] =  { .creg = 0x448, .cshift = 16, },
+	[1][15] =  { .creg = 0x438, .cshift = 17, .sreg = 0x440, .sshift = 16},
+	[1][16] =  { .creg = 0x438, .cshift = 23, .sreg = 0x440, .sshift =  4},
+	[1][19] =  { .creg = 0x464, .cshift = 10, .sreg = 0x464, .sshift = 11},
+	[1][20] =  { .creg = 0x464, .cshift = 26, .sreg = 0x464, .sshift = 27},
+	[1][22] =  { .creg = 0x0bc, .cshift =  2, },
+	[2][1] =   { .creg = 0x020, .cshift = 18, },
+	[2][2] =   { .creg = 0x024, .cshift =  2, },
+	[2][3] =   { .creg = 0x024, .cshift = 18, },
+	[2][7] =   { .creg = 0x030, .cshift = 21, },
+	[2][11] =  { .creg = 0x02c, .cshift =  6, },
+	[2][13] =  { .creg = 0x448, .cshift =  4, },
+	[2][14] =  { .creg = 0x448, .cshift = 17, },
+	[3][0] =   { .creg = 0x020, .cshift =  3, },
+	[3][1] =   { .creg = 0x020, .cshift = 19, },
+	[3][2] =   { .creg = 0x024, .cshift =  3, .sreg = 0x030, .sshift = 25},
+	[3][3] =   { .creg = 0x024, .cshift = 19, },
+	[3][4] =   { .creg = 0x028, .cshift =  3, },
+	[3][5] =   { .creg = 0x028, .cshift = 18, },
+	[3][7] =   { .creg = 0x028, .cshift = 26, },
+	[3][9] =   { .creg = 0x02c, .cshift =  0, },
+	[3][13] =  { .creg = 0x448, .cshift =  5, },
+	[3][14] =  { .creg = 0x448, .cshift = 18, },
+	[3][15] =  { .creg = 0x438, .cshift = 19, },
+	[3][16] =  { .creg = 0x438, .cshift = 25, },
+	[3][19] =  { .creg = 0x464, .cshift = 12, },
+	[3][20] =  { .creg = 0x464, .cshift = 28, },
+	[3][21] =  { .creg = 0x05c, .cshift = 31, },
+	[4][0] =   { .creg = 0x020, .cshift =  4, },
+	[4][1] =   { .creg = 0x020, .cshift = 20, },
+	[4][2] =   { .creg = 0x024, .cshift =  4, .sreg = 0x030, .sshift = 26},
+	[4][3] =   { .creg = 0x024, .cshift = 20, },
+	[4][4] =   { .creg = 0x028, .cshift =  4, },
+	[4][6] =   { .creg = 0x028, .cshift = 23, },
+	[4][8] =   { .creg = 0x028, .cshift = 29, },
+	[4][10] =  { .creg = 0x02c, .cshift =  3, },
+	[4][13] =  { .creg = 0x448, .cshift =  6, },
+	[4][14] =  { .creg = 0x448, .cshift = 19, },
+	[4][15] =  { .creg = 0x438, .cshift = 20, },
+	[4][16] =  { .creg = 0x438, .cshift = 26, },
+	[4][19] =  { .creg = 0x464, .cshift = 13, },
+	[4][20] =  { .creg = 0x464, .cshift = 29, },
+	[4][22] =  { .creg = 0x0bc, .cshift =  3, },
+	[5][0] =   { .creg = 0x020, .cshift =  5, .sreg = 0x020, .sshift = 12},
+	[5][1] =   { .creg = 0x020, .cshift = 21, .sreg = 0x020, .sshift = 28},
+	[5][2] =   { .creg = 0x024, .cshift =  5, .sreg = 0x024, .sshift = 12},
+	[5][3] =   { .creg = 0x024, .cshift = 21, .sreg = 0x024, .sshift = 28},
+	[5][4] =   { .creg = 0x028, .cshift =  5, .sreg = 0x028, .sshift = 12},
+	[5][5] =   { .creg = 0x028, .cshift = 19, },
+	[5][7] =   { .creg = 0x028, .cshift = 27, },
+	[5][9] =   { .creg = 0x02c, .cshift =  1, },
+	[5][13] =  { .creg = 0x420, .cshift = 16, },
+	[5][14] =  { .creg = 0x420, .cshift = 20, },
+	[5][19] =  { .creg = 0x464, .cshift = 14, .sreg = 0x464, .sshift = 15},
+	[5][20] =  { .creg = 0x464, .cshift = 31, .sreg = 0x464, .sshift = 30},
+	[6][0] =   { .creg = 0x020, .cshift =  6, .sreg = 0x020, .sshift = 13},
+	[6][1] =   { .creg = 0x020, .cshift = 22, .sreg = 0x020, .sshift = 29},
+	[6][2] =   { .creg = 0x024, .cshift =  6, .sreg = 0x024, .sshift = 13},
+	[6][3] =   { .creg = 0x024, .cshift = 22, .sreg = 0x024, .sshift = 29},
+	[6][4] =   { .creg = 0x028, .cshift =  6, .sreg = 0x028, .sshift = 13},
+	[6][6] =   { .creg = 0x028, .cshift = 24, },
+	[6][8] =   { .creg = 0x028, .cshift = 30, },
+	[6][10] =  { .creg = 0x02c, .cshift =  4, },
+	[6][12] =  { .creg = 0x02c, .cshift =  9, },
+	[6][13] =  { .creg = 0x420, .cshift = 17, },
+	[6][14] =  { .creg = 0x420, .cshift = 21, },
+	[6][19] =  { .creg = 0x464, .cshift = 16, .sreg = 0x464, .sshift = 17},
+	[7][0] =   { .creg = 0x020, .cshift =  7, .sreg = 0x020, .sshift = 14},
+	[7][1] =   { .creg = 0x020, .cshift = 23, .sreg = 0x020, .sshift = 30},
+	[7][2] =   { .creg = 0x024, .cshift =  7, .sreg = 0x024, .sshift = 14},
+	[7][3] =   { .creg = 0x024, .cshift = 23, .sreg = 0x024, .sshift = 30},
+	[7][4] =   { .creg = 0x028, .cshift =  7, .sreg = 0x028, .sshift = 14},
+	[7][5] =   { .creg = 0x028, .cshift = 20, },
+	[7][7] =   { .creg = 0x028, .cshift = 28, },
+	[7][9] =   { .creg = 0x02c, .cshift =  2, },
+	[7][13] =  { .creg = 0x420, .cshift = 18, },
+	[7][14] =  { .creg = 0x420, .cshift = 22, },
+	[7][19] =  { .creg = 0x464, .cshift = 18, .sreg = 0x464, .sshift = 19},
+	[8][0] =   { .creg = 0x020, .cshift =  8, .sreg = 0x020, .sshift = 15},
+	[8][1] =   { .creg = 0x020, .cshift = 24, .sreg = 0x020, .sshift = 31},
+	[8][2] =   { .creg = 0x024, .cshift =  8, .sreg = 0x024, .sshift = 15},
+	[8][3] =   { .creg = 0x024, .cshift = 24, .sreg = 0x024, .sshift = 31},
+	[8][4] =   { .creg = 0x028, .cshift =  8, .sreg = 0x028, .sshift = 15},
+	[8][6] =   { .creg = 0x028, .cshift = 25, },
+	[8][8] =   { .creg = 0x028, .cshift = 31, },
+	[8][10] =  { .creg = 0x02c, .cshift =  5, },
+	[8][12] =  { .creg = 0x02c, .cshift = 10, },
+	[8][13] =  { .creg = 0x420, .cshift = 19, },
+	[8][14] =  { .creg = 0x420, .cshift = 23, },
+	[8][19] =  { .creg = 0x464, .cshift = 20, .sreg = 0x464, .sshift = 21},
+	[9][0] =   { .creg = 0x020, .cshift =  9, },
+	[9][1] =   { .creg = 0x020, .cshift = 25, },
+	[9][2] =   { .creg = 0x024, .cshift =  9, },
+	[9][3] =   { .creg = 0x024, .cshift = 25, },
+	[9][4] =   { .creg = 0x028, .cshift =  9, },
+	[9][5] =   { .creg = 0x028, .cshift = 21, },
+	[9][9] =   { .creg = 0x05c, .cshift = 10, },
+	[9][12] =  { .creg = 0x02c, .cshift = 11, },
+	[9][13] =  { .creg = 0x448, .cshift =  7, },
+	[9][14] =  { .creg = 0x448, .cshift = 20, },
+	[9][15] =  { .creg = 0x438, .cshift = 21, },
+	[9][16] =  { .creg = 0x438, .cshift = 27, },
+	[9][19] =  { .creg = 0x05c, .cshift = 22, },
+	[9][20] =  { .creg = 0x05c, .cshift =  6, },
+	[10][0] =  { .creg = 0x420, .cshift =  0, .sreg = 0x420, .sshift =  1},
+	[10][3] =  { .creg = 0x420, .cshift =  8, .sreg = 0x420, .sshift =  9},
+	[10][5] =  { .creg = 0x420, .cshift = 12, },
+	[10][7] =  { .creg = 0x420, .cshift = 14, },
+	[10][12] = { .creg = 0x448, .cshift =  0, },
+	[10][19] = { .creg = 0x448, .cshift = 28, },
+	[10][21] = { .creg = 0x448, .cshift =  0, },
+	[10][22] = { .creg = 0x44c, .cshift =  0, },
+	[11][1] =  { .creg = 0x420, .cshift =  2, .sreg = 0x420, .sshift =  3},
+	[11][4] =  { .creg = 0x420, .cshift = 10, .sreg = 0x420, .sshift = 11},
+	[11][6] =  { .creg = 0x420, .cshift = 13, },
+	[11][8] =  { .creg = 0x420, .cshift = 15, },
+	[11][12] = { .creg = 0x448, .cshift =  1, },
+	[11][20] = { .creg = 0x448, .cshift = 29, },
+	[11][21] = { .creg = 0x448, .cshift = 31, },
+	[11][22] = { .creg = 0x44c, .cshift =  1, },
+	[12][0] =  { .creg = 0x438, .cshift =  0, .sreg = 0x438, .sshift =  1},
+	[12][3] =  { .creg = 0x438, .cshift =  8, .sreg = 0x438, .sshift =  9},
+	[12][5] =  { .creg = 0x438, .cshift = 12, },
+	[12][7] =  { .creg = 0x438, .cshift = 14, },
+	[12][19] = { .creg = 0x444, .cshift =  2, },
+	[12][21] = { .creg = 0x444, .cshift =  4, },
+	[12][22] = { .creg = 0x444, .cshift =  6, },
+	[13][1] =  { .creg = 0x438, .cshift =  2, .sreg = 0x438, .sshift =  3},
+	[13][4] =  { .creg = 0x438, .cshift = 10, .sreg = 0x438, .sshift = 11},
+	[13][6] =  { .creg = 0x438, .cshift = 13, },
+	[13][8] =  { .creg = 0x438, .cshift = 15, },
+	[13][20] = { .creg = 0x444, .cshift =  3, },
+	[13][21] = { .creg = 0x444, .cshift =  4, },
+	[13][22] = { .creg = 0x444, .cshift =  7, },
+	[15][0] =  { .creg = 0x02c, .cshift = 13, .sreg = 0x02c, .sshift = 15},
+	[15][1] =  { .creg = 0x02c, .cshift = 18, .sreg = 0x02c, .sshift = 20},
+	[15][3] =  { .creg = 0x02c, .cshift = 28, .sreg = 0x02c, .sshift = 30},
+	[15][4] =  { .creg = 0x030, .cshift =  1, .sreg = 0x030, .sshift =  3},
+	[15][5] =  { .creg = 0x030, .cshift =  6, .sreg = 0x030, .sshift =  7},
+	[15][9] =  { .creg = 0x030, .cshift = 10, },
+	[15][13] = { .creg = 0x448, .cshift =  9, },
+	[15][14] = { .creg = 0x448, .cshift = 22, },
+	[15][15] = { .creg = 0x438, .cshift = 29, .sreg = 0x440, .sshift =  0},
+	[15][16] = { .creg = 0x440, .cshift =  2, },
+	[16][0] =  { .creg = 0x02c, .cshift = 14, .sreg = 0x02c, .sshift = 16},
+	[16][1] =  { .creg = 0x02c, .cshift = 19, .sreg = 0x02c, .sshift = 21},
+	[16][2] =  { .creg = 0x02c, .cshift = 24, .sreg = 0x02c, .sshift = 26},
+	[16][3] =  { .creg = 0x02c, .cshift = 29, .sreg = 0x02c, .sshift = 31},
+	[16][4] =  { .creg = 0x030, .cshift =  2, .sreg = 0x030, .sshift =  4},
+	[16][6] =  { .creg = 0x030, .cshift =  8, .sreg = 0x030, .sshift =  9},
+	[16][10] = { .creg = 0x030, .cshift = 11, },
+	[16][13] = { .creg = 0x448, .cshift = 10, },
+	[16][14] = { .creg = 0x448, .cshift = 23, },
+	[16][15] = { .creg = 0x438, .cshift = 30, },
+	[16][16] = { .creg = 0x440, .cshift =  3, .sreg = 0x440, .sshift =  5},
+	[17][0] =  { .creg = 0x460, .cshift =  0, },
+	[17][2] =  { .creg = 0x02c, .cshift = 27, .sreg = 0x0bc, .sshift = 30},
+	[17][3] =  { .creg = 0x05c, .cshift =  0, },
+	[17][5] =  { .creg = 0x460, .cshift = 22, },
+	[17][7] =  { .creg = 0x460, .cshift = 26, },
+	[17][9] =  { .creg = 0x460, .cshift = 30, },
+	[17][11] = { .creg = 0x464, .cshift =  2, },
+	[17][13] = { .creg = 0x448, .cshift = 11, },
+	[17][14] = { .creg = 0x448, .cshift = 24, },
+	[17][15] = { .creg = 0x440, .cshift = 21, },
+	[17][16] = { .creg = 0x440, .cshift = 30, },
+	[17][19] = { .creg = 0x464, .cshift = 22, },
+	[17][21] = { .creg = 0x0bc, .cshift =  0, },
+	[18][1] =  { .creg = 0x460, .cshift =  3, },
+	[18][2] =  { .creg = 0x02c, .cshift = 28, .sreg = 0x0bc, .sshift = 31},
+	[18][4] =  { .creg = 0x05c, .cshift =  1, },
+	[18][6] =  { .creg = 0x460, .cshift = 24, },
+	[18][8] =  { .creg = 0x460, .cshift = 28, },
+	[18][10] = { .creg = 0x464, .cshift =  0, },
+	[18][12] = { .creg = 0x464, .cshift =  4, },
+	[18][13] = { .creg = 0x448, .cshift = 12, },
+	[18][14] = { .creg = 0x448, .cshift = 25, },
+	[18][15] = { .creg = 0x440, .cshift = 22, },
+	[18][16] = { .creg = 0x440, .cshift = 31, },
+	[18][19] = { .creg = 0x464, .cshift = 23, },
+	[18][22] = { .creg = 0x0bc, .cshift =  4, },
+	[19][0] =  { .creg = 0x460, .cshift =  1, .sreg = 0x460, .sshift =  2},
+	[19][2] =  { .creg = 0x460, .cshift = 10, .sreg = 0x460, .sshift = 11},
+	[19][3] =  { .creg = 0x460, .cshift = 14, .sreg = 0x460, .sshift = 16},
+	[19][4] =  { .creg = 0x460, .cshift = 18, .sreg = 0x460, .sshift = 19},
+	[19][5] =  { .creg = 0x460, .cshift = 23, },
+	[19][7] =  { .creg = 0x460, .cshift = 27, },
+	[19][9] =  { .creg = 0x460, .cshift = 31, },
+	[19][11] = { .creg = 0x464, .cshift =  3, },
+	[19][13] = { .creg = 0x448, .cshift = 13, },
+	[19][14] = { .creg = 0x448, .cshift = 26, },
+	[19][15] = { .creg = 0x440, .cshift = 23, },
+	[19][16] = { .creg = 0x444, .cshift =  0, },
+	[19][19] = { .creg = 0x05c, .cshift = 24, },
+	[19][20] = { .creg = 0x05c, .cshift = 28, },
+	[19][21] = { .creg = 0x0bc, .cshift =  1, },
+	[20][1] =  { .creg = 0x460, .cshift =  4, .sreg = 0x460, .sshift =  5},
+	[20][2] =  { .creg = 0x460, .cshift = 12, .sreg = 0x460, .sshift = 13},
+	[20][3] =  { .creg = 0x460, .cshift = 16, .sreg = 0x460, .sshift = 17},
+	[20][4] =  { .creg = 0x460, .cshift = 20, .sreg = 0x460, .sshift = 21},
+	[20][6] =  { .creg = 0x460, .cshift = 25, },
+	[20][8] =  { .creg = 0x460, .cshift = 29, },
+	[20][10] = { .creg = 0x464, .cshift =  1, },
+	[20][12] = { .creg = 0x464, .cshift =  5, },
+	[20][13] = { .creg = 0x448, .cshift = 14, },
+	[20][14] = { .creg = 0x448, .cshift = 27, },
+	[20][15] = { .creg = 0x440, .cshift = 24, },
+	[20][16] = { .creg = 0x444, .cshift =  1, },
+	[20][19] = { .creg = 0x05c, .cshift = 25, },
+	[20][20] = { .creg = 0x05c, .cshift = 29, },
+	[20][22] = { .creg = 0x0bc, .cshift =  5, },
+};
+
+struct mtk_afe_hdmi_connection {
+	short reg;
+	char shift;
+};
+
+static const struct mtk_afe_hdmi_connection
+	hdmi_connections[MTK_AFE_NUM_HDMI_OUTPUT] = {
+	{ .reg = 0x390, .shift = 0 },
+	{ .reg = 0x390, .shift = 3 },
+	{ .reg = 0x390, .shift = 6 },
+	{ .reg = 0x390, .shift = 9 },
+
+	{ .reg = 0x390, .shift = 12 },
+	{ .reg = 0x390, .shift = 15 },
+	{ .reg = 0x390, .shift = 18 },
+	{ .reg = 0x390, .shift = 21 },
+
+	{ .reg = 0x390, .shift = 24 },
+	{ .reg = 0x390, .shift = 27 },
+	{ .reg = 0x398, .shift = 0 },
+	{ .reg = 0x398, .shift = 2 },
+};
+
+static int mtk_afe_interconn_hdmi(struct mtk_afe *afe_info, u32 in,
+				  u32 out)
+{
+	const struct mtk_afe_hdmi_connection *con;
+
+	if (in < MTK_AFE_HDMI_CONN_INPUT_BASE ||
+	    out < MTK_AFE_HDMI_CONN_OUTPUT_BASE)
+		return -EINVAL;
+
+	in -= MTK_AFE_HDMI_CONN_INPUT_BASE;
+	out -= MTK_AFE_HDMI_CONN_OUTPUT_BASE;
+
+	if (out >= MTK_AFE_NUM_HDMI_OUTPUT)
+		return -EINVAL;
+
+	if (in >= MTK_AFE_NUM_HDMI_INPUT)
+		return -EINVAL;
+
+	con = &hdmi_connections[out];
+
+	regmap_update_bits(afe_info->regmap, con->reg,
+			   0x7 << con->shift, in << con->shift);
+	return 0;
+}
+
+static const struct mtk_afe_connection *mtk_afe_get_connection(
+		struct mtk_afe *afe_info, u32 in, u32 out)
+{
+	if (in >= MTK_AFE_INTERCONN_NUM_INPUT ||
+	    out >= MTK_AFE_INTERCONN_NUM_OUTPUT) {
+		dev_err(afe_info->dev,
+			"out of bound mpConnectionTable[%d][%d]\n", in, out);
+		return NULL;
+	}
+
+	if (connections[in][out].creg == 0) {
+		dev_err(afe_info->dev,
+			"No connection between I%02d and O%02d\n", in, out);
+		return NULL;
+	}
+
+	return &connections[in][out];
+}
+
+/*
+ * mtk_afe_interconn_connect - Connect an input with an output
+ * @afe_info:	Context
+ * @in:		Input number, as in the SoC datasheet
+ * @out:	Output number, as in the SoC datasheet
+ * @rightshift:	Apply a rightshift on the input data
+ *
+ * This function connects an input of the audio interconnect with an
+ * output.
+ */
+int mtk_afe_interconn_connect(struct mtk_afe *afe_info, unsigned int in,
+			      unsigned int out, bool rightshift)
+{
+	const struct mtk_afe_connection *con;
+
+	if (in >= MTK_AFE_HDMI_CONN_INPUT_BASE ||
+	    out >= MTK_AFE_HDMI_CONN_OUTPUT_BASE)
+		return mtk_afe_interconn_hdmi(afe_info, in, out);
+
+	con = mtk_afe_get_connection(afe_info, in, out);
+	if (!con)
+		return -EINVAL;
+
+	regmap_update_bits(afe_info->regmap, con->creg,
+			   1 << con->cshift, 1 << con->cshift);
+
+	if (!con->sreg)
+		return 0;
+
+	if (rightshift)
+		regmap_update_bits(afe_info->regmap, con->sreg,
+				   1 << con->sshift, 1 << con->sshift);
+	else
+		regmap_update_bits(afe_info->regmap, con->sreg,
+				   1 << con->sshift, 0);
+
+	return 0;
+}
+
+/*
+ * mtk_afe_interconn_disconnect - Disconnect an input from an output
+ * @afe_info:	Context
+ * @in:		Input number, as in the SoC datasheet
+ * @out:	Output number, as in the SoC datasheet
+ *
+ * This function disconnects an input of the audio interconnect from an
+ * output.
+ */
+int mtk_afe_interconn_disconnect(struct mtk_afe *afe_info, unsigned int in,
+				 unsigned int out)
+{
+	const struct mtk_afe_connection *con;
+
+	con = mtk_afe_get_connection(afe_info, in, out);
+	if (!con)
+		return -EINVAL;
+
+	regmap_update_bits(afe_info->regmap, con->creg, 1 << con->cshift, 0);
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mtk-afe-connection.h b/sound/soc/mediatek/mtk-afe-connection.h
new file mode 100644
index 0000000..eac2555
--- /dev/null
+++ b/sound/soc/mediatek/mtk-afe-connection.h
@@ -0,0 +1,30 @@
+/*
+ * mtk_afe_connection.h  --  Mediatek AFE connection support
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Koro Chen <koro.chen@mediatek.com>
+ *             Sascha Hauer <s.hauer@pengutronix.de>
+ *             Hidalgo Huang <hidalgo.huang@mediatek.com>
+ *             Ir Lian <ir.lian@mediatek.com>
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
+#ifndef _MTK_AFE_CONNECTION_H_
+#define _MTK_AFE_CONNECTION_H_
+
+struct mtk_afe;
+
+int mtk_afe_interconn_connect(struct mtk_afe *afe_info, unsigned int in,
+			      unsigned int out, bool rightshift);
+int mtk_afe_interconn_disconnect(struct mtk_afe *afe_info, unsigned int in,
+				 unsigned int out);
+
+#endif
-- 
1.8.1.1.dirty
