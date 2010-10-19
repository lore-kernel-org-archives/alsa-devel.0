From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Tue, 19 Oct 2010 16:07:05 +0900
Message-ID: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id DF576103885
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The I2S controllers since S3C64XX are incremental revisions, with
a new feature added to the last one. The programming i/f doesn't
conflict between these revisions, so it is possible to have one
common driver that could manage various versions of I2S (v3, 4 & 5)

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-samsung/include/plat/audio.h |   24 +
 sound/soc/s3c24xx/Kconfig                  |    3 +
 sound/soc/s3c24xx/Makefile                 |    2 +
 sound/soc/s3c24xx/i2s.c                    | 1251 ++++++++++++++++++++++++++++
 sound/soc/s3c24xx/i2s.h                    |   29 +
 5 files changed, 1309 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/i2s.c
 create mode 100644 sound/soc/s3c24xx/i2s.h

diff --git a/arch/arm/plat-samsung/include/plat/audio.h b/arch/arm/plat-samsung/include/plat/audio.h
index e32f9ed..b72ad03 100644
--- a/arch/arm/plat-samsung/include/plat/audio.h
+++ b/arch/arm/plat-samsung/include/plat/audio.h
@@ -16,10 +16,34 @@
 #define S3C64XX_AC97_GPE  1
 extern void s3c64xx_ac97_setup_gpio(int);
 
+struct samsung_i2s {
+/* If the Primary DAI has 5.1 Channels */
+#define QUIRK_PRI_6CHAN		(1 << 0)
+/* If the I2S block has a Stereo Overlay Channel */
+#define QUIRK_SEC_DAI		(1 << 1)
+/*
+ * If the I2S block has no internal prescalar or MUX (I2SMOD[10] bit)
+ * The Machine driver must provide suitably set clock to the I2S block.
+ */
+#define QUIRK_NO_MUXPSR		(1 << 2)
+#define QUIRK_NEED_RSTCLR	(1 << 3)
+	/* Quirks of the I2S controller */
+	u32 quirks;
+
+	/*
+	 * Array of clock names that can be used to generate I2S signals.
+	 * Also corresponds to clocks of I2SMOD[10]
+	 */
+	const char **src_clk;
+};
+
 /**
  * struct s3c_audio_pdata - common platform data for audio device drivers
  * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
+	union {
+		struct samsung_i2s i2s;
+	} type;
 };
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 6efdf65..20fe288 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -40,6 +40,9 @@ config SND_S5P_SOC_SPDIF
 	tristate
 	select SND_SOC_SPDIF
 
+config SND_SAMSUNG_I2S
+	tristate
+
 config SND_S3C24XX_SOC_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
 	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 93de2a0..1d6fc07 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -8,6 +8,7 @@ snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
+snd-soc-i2s-objs := i2s.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
@@ -18,6 +19,7 @@ obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_S5P_SOC_SPDIF) += snd-soc-samsung-spdif.o
 obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-pcm.o
+obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-i2s.o
 
 # S3C24XX Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o
diff --git a/sound/soc/s3c24xx/i2s.c b/sound/soc/s3c24xx/i2s.c
new file mode 100644
index 0000000..6869f51
--- /dev/null
+++ b/sound/soc/s3c24xx/i2s.c
@@ -0,0 +1,1251 @@
+/* sound/soc/s3c24xx/i2s.c
+ *
+ * ALSA SoC Audio Layer - Samsung I2S Controller driver
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <plat/audio.h>
+
+#include "dma.h"
+#include "i2s.h"
+
+#define I2SCON		0x0
+#define I2SMOD		0x4
+#define I2SFIC		0x8
+#define I2SPSR		0xc
+#define I2STXD		0x10
+#define I2SRXD		0x14
+#define I2SFICS		0x18
+#define I2STXDS		0x1c
+
+#define CON_RSTCLR		(1 << 31)
+#define CON_FRXOFSTATUS		(1 << 26)
+#define CON_FRXORINTEN		(1 << 25)
+#define CON_FTXSURSTAT		(1 << 24)
+#define CON_FTXSURINTEN		(1 << 23)
+#define CON_TXSDMA_PAUSE	(1 << 20)
+#define CON_TXSDMA_ACTIVE	(1 << 18)
+
+#define CON_FTXURSTATUS		(1 << 17)
+#define CON_FTXURINTEN		(1 << 16)
+#define CON_TXFIFO2_EMPTY	(1 << 15)
+#define CON_TXFIFO1_EMPTY	(1 << 14)
+#define CON_TXFIFO2_FULL	(1 << 13)
+#define CON_TXFIFO1_FULL	(1 << 12)
+
+#define CON_LRINDEX		(1 << 11)
+#define CON_TXFIFO_EMPTY	(1 << 10)
+#define CON_RXFIFO_EMPTY	(1 << 9)
+#define CON_TXFIFO_FULL		(1 << 8)
+#define CON_RXFIFO_FULL		(1 << 7)
+#define CON_TXDMA_PAUSE		(1 << 6)
+#define CON_RXDMA_PAUSE		(1 << 5)
+#define CON_TXCH_PAUSE		(1 << 4)
+#define CON_RXCH_PAUSE		(1 << 3)
+#define CON_TXDMA_ACTIVE	(1 << 2)
+#define CON_RXDMA_ACTIVE	(1 << 1)
+#define CON_ACTIVE		(1 << 0)
+
+#define MOD_OPCLK_CDCLK_OUT	(0 << 30)
+#define MOD_OPCLK_CDCLK_IN	(1 << 30)
+#define MOD_OPCLK_BCLK_OUT	(2 << 30)
+#define MOD_OPCLK_PCLK		(3 << 30)
+#define MOD_OPCLK_MASK		(3 << 30)
+#define MOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
+
+#define MOD_BLCS_SHIFT	26
+#define MOD_BLCS_16BIT	(0 << MOD_BLCS_SHIFT)
+#define MOD_BLCS_8BIT	(1 << MOD_BLCS_SHIFT)
+#define MOD_BLCS_24BIT	(2 << MOD_BLCS_SHIFT)
+#define MOD_BLCS_MASK	(3 << MOD_BLCS_SHIFT)
+#define MOD_BLCP_SHIFT	24
+#define MOD_BLCP_16BIT	(0 << MOD_BLCP_SHIFT)
+#define MOD_BLCP_8BIT	(1 << MOD_BLCP_SHIFT)
+#define MOD_BLCP_24BIT	(2 << MOD_BLCP_SHIFT)
+#define MOD_BLCP_MASK	(3 << MOD_BLCP_SHIFT)
+
+#define MOD_C2DD_HHALF		(1 << 21) /* Discard Higher-half */
+#define MOD_C2DD_LHALF		(1 << 20) /* Discard Lower-half */
+#define MOD_C1DD_HHALF		(1 << 19)
+#define MOD_C1DD_LHALF		(1 << 18)
+#define MOD_DC2_EN		(1 << 17)
+#define MOD_DC1_EN		(1 << 16)
+#define MOD_BLC_16BIT		(0 << 13)
+#define MOD_BLC_8BIT		(1 << 13)
+#define MOD_BLC_24BIT		(2 << 13)
+#define MOD_BLC_MASK		(3 << 13)
+
+#define MOD_IMS_SYSMUX		(1 << 10)
+#define MOD_SLAVE		(1 << 11)
+#define MOD_TXONLY		(0 << 8)
+#define MOD_RXONLY		(1 << 8)
+#define MOD_TXRX		(2 << 8)
+#define MOD_MASK		(3 << 8)
+#define MOD_LR_LLOW		(0 << 7)
+#define MOD_LR_RLOW		(1 << 7)
+#define MOD_SDF_IIS		(0 << 5)
+#define MOD_SDF_MSB		(1 << 5)
+#define MOD_SDF_LSB		(2 << 5)
+#define MOD_SDF_MASK		(3 << 5)
+#define MOD_RCLK_256FS		(0 << 3)
+#define MOD_RCLK_512FS		(1 << 3)
+#define MOD_RCLK_384FS		(2 << 3)
+#define MOD_RCLK_768FS		(3 << 3)
+#define MOD_RCLK_MASK		(3 << 3)
+#define MOD_BCLK_32FS		(0 << 1)
+#define MOD_BCLK_48FS		(1 << 1)
+#define MOD_BCLK_16FS		(2 << 1)
+#define MOD_BCLK_24FS		(3 << 1)
+#define MOD_BCLK_MASK		(3 << 1)
+#define MOD_8BIT		(1 << 0)
+
+#define MOD_CDCLKCON		(1 << 12)
+
+#define PSR_PSREN		(1 << 15)
+
+#define FIC_TX2COUNT(x)		(((x) >>  24) & 0xf)
+#define FIC_TX1COUNT(x)		(((x) >>  16) & 0xf)
+
+#define FIC_TXFLUSH		(1 << 15)
+#define FIC_RXFLUSH		(1 << 7)
+#define FIC_TXCOUNT(x)		(((x) >>  8) & 0xf)
+#define FIC_RXCOUNT(x)		(((x) >>  0) & 0xf)
+#define FICS_TXCOUNT(x)		(((x) >>  8) & 0x7f)
+
+#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
+
+struct i2s_dai {
+	/* Platform device for this DAI */
+	struct platform_device *pdev;
+	/* IOREMAP'd SFRs */
+	void __iomem	*addr;
+	/* Physical base address of SFRs */
+	u32	base;
+	/* Rate of RCLK source clock */
+	unsigned long rclk_srcrate;
+	/* Frame Clock */
+	unsigned frmclk;
+	/*
+	 * Specifically requested RCLK,BCLK by MACHINE Driver.
+	 * 0 indicates CPU driver is free to choose any value.
+	 */
+	unsigned rfs, bfs;
+	/* I2S Controller's core clock */
+	struct clk *clk;
+	/* Clock for generating I2S signals */
+	struct clk *op_clk;
+	/* Array of clock names for op_clk */
+	const char **src_clk;
+	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
+	struct i2s_dai *pri_dai;
+	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
+	struct i2s_dai *sec_dai;
+#define DAI_OPENED	(1 << 0) /* Dai is opened */
+#define DAI_MANAGER	(1 << 1) /* Dai is the manager */
+	unsigned mode;
+	/* Driver for this DAI */
+	struct snd_soc_dai_driver s3c_i2s_drv;
+	/* DMA parameters */
+	struct s3c_dma_params dma_playback;
+	struct s3c_dma_params dma_capture;
+	u32	quirks;
+	u32	suspend_i2smod;
+	u32	suspend_i2scon;
+	u32	suspend_i2spsr;
+};
+
+/* Lock for cross i/f checks */
+static DEFINE_SPINLOCK(lock);
+
+/* If this is the 'overlay' stereo DAI */
+static inline bool is_secondary(struct i2s_dai *i2s)
+{
+	return i2s->pri_dai ? true : false;
+}
+
+/* If operating in SoC-Slave mode */
+static inline bool is_slave(struct i2s_dai *i2s)
+{
+	return (readl(i2s->addr + I2SMOD) & MOD_SLAVE) ? true : false;
+}
+
+/* If this interface of the controller is transmitting data */
+static inline bool tx_active(struct i2s_dai *i2s)
+{
+	u32 active;
+
+	if (!i2s)
+		return false;
+
+	active = readl(i2s->addr + I2SMOD);
+
+	if (is_secondary(i2s))
+		active &= CON_TXSDMA_ACTIVE;
+	else
+		active &= CON_TXDMA_ACTIVE;
+
+	return active ? true : false;
+}
+
+/* If the other interface of the controller is transmitting data */
+static inline bool other_tx_active(struct i2s_dai *i2s)
+{
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+
+	return tx_active(other);
+}
+
+/* If any interface of the controller is transmitting data */
+static inline bool any_tx_active(struct i2s_dai *i2s)
+{
+	return tx_active(i2s) || other_tx_active(i2s);
+}
+
+/* If this interface of the controller is receiving data */
+static inline bool rx_active(struct i2s_dai *i2s)
+{
+	u32 active;
+
+	if (!i2s)
+		return false;
+
+	active = readl(i2s->addr + I2SMOD) & CON_RXDMA_ACTIVE;
+
+	return active ? true : false;
+}
+
+/* If the other interface of the controller is receiving data */
+static inline bool other_rx_active(struct i2s_dai *i2s)
+{
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+
+	return rx_active(other);
+}
+
+/* If any interface of the controller is receiving data */
+static inline bool any_rx_active(struct i2s_dai *i2s)
+{
+	return rx_active(i2s) || other_rx_active(i2s);
+}
+
+/* If the other DAI is transmitting or receiving data */
+static inline bool other_active(struct i2s_dai *i2s)
+{
+	return other_rx_active(i2s) || other_tx_active(i2s);
+}
+
+/* If this DAI is transmitting or receiving data */
+static inline bool this_active(struct i2s_dai *i2s)
+{
+	return tx_active(i2s) || rx_active(i2s);
+}
+
+/* If the controller is active anyway */
+static inline bool any_active(struct i2s_dai *i2s)
+{
+	return this_active(i2s) || other_active(i2s);
+}
+
+static inline struct i2s_dai *to_info(struct snd_soc_dai *dai)
+{
+	return snd_soc_dai_get_drvdata(dai);
+}
+
+static inline bool is_opened(struct i2s_dai *i2s)
+{
+	if (i2s && (i2s->mode & DAI_OPENED))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_manager(struct i2s_dai *i2s)
+{
+	if (is_opened(i2s) && (i2s->mode & DAI_MANAGER))
+		return true;
+	else
+		return false;
+}
+
+/* Read RCLK of I2S (in multiples of LRCLK) */
+static inline unsigned get_rfs(struct i2s_dai *i2s)
+{
+	u32 rfs = (readl(i2s->addr + I2SMOD) >> 3) & 0x3;
+
+	switch (rfs) {
+	case 3:	return 768;
+	case 2: return 384;
+	case 1:	return 512;
+	default: return 256;
+	}
+}
+
+/* Write RCLK of I2S (in multiples of LRCLK) */
+static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
+{
+	u32 mod = readl(i2s->addr + I2SMOD);
+
+	mod &= ~MOD_RCLK_MASK;
+
+	switch (rfs) {
+	case 768:
+		mod |= MOD_RCLK_768FS;
+		break;
+	case 512:
+		mod |= MOD_RCLK_512FS;
+		break;
+	case 384:
+		mod |= MOD_RCLK_384FS;
+		break;
+	default:
+		mod |= MOD_RCLK_256FS;
+		break;
+	}
+
+	writel(mod, i2s->addr + I2SMOD);
+}
+
+/* Read Bit-Clock of I2S (in multiples of LRCLK) */
+static inline unsigned get_bfs(struct i2s_dai *i2s)
+{
+	u32 bfs = (readl(i2s->addr + I2SMOD) >> 1) & 0x3;
+
+	switch (bfs) {
+	case 3: return 24;
+	case 2: return 16;
+	case 1:	return 48;
+	default: return 32;
+	}
+}
+
+/* Write Bit-Clock of I2S (in multiples of LRCLK) */
+static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
+{
+	u32 mod = readl(i2s->addr + I2SMOD);
+
+	mod &= ~MOD_BCLK_MASK;
+
+	switch (bfs) {
+	case 48:
+		mod |= MOD_BCLK_48FS;
+		break;
+	case 32:
+		mod |= MOD_BCLK_32FS;
+		break;
+	case 24:
+		mod |= MOD_BCLK_24FS;
+		break;
+	default:
+		mod |= MOD_BCLK_16FS;
+		break;
+	}
+
+	writel(mod, i2s->addr + I2SMOD);
+}
+
+/* Sample-Size */
+static inline int get_blc(struct i2s_dai *i2s)
+{
+	int blc = readl(i2s->addr + I2SMOD);
+
+	blc = (blc >> 13) & 0x3;
+
+	switch (blc) {
+	case 2: return 24;
+	case 1:	return 8;
+	default: return 16;
+	}
+}
+
+/* TX Channel Control */
+static void s3c_i2sv2_txctrl(struct i2s_dai *i2s, int on)
+{
+	void __iomem *addr = i2s->addr;
+	u32 con = readl(addr + I2SCON);
+	u32 mod = readl(addr + I2SMOD) & ~MOD_MASK;
+
+	if (on) {
+		con |= CON_ACTIVE;
+		con &= ~CON_TXCH_PAUSE;
+
+		if (is_secondary(i2s)) {
+			con |= CON_TXSDMA_ACTIVE;
+			con &= ~CON_TXSDMA_PAUSE;
+		} else {
+			con |= CON_TXDMA_ACTIVE;
+			con &= ~CON_TXDMA_PAUSE;
+		}
+
+		if (any_rx_active(i2s))
+			mod |= MOD_TXRX;
+		else
+			mod |= MOD_TXONLY;
+	} else {
+		if (is_secondary(i2s)) {
+			con |=  CON_TXSDMA_PAUSE;
+			con &= ~CON_TXSDMA_ACTIVE;
+		} else {
+			con |=  CON_TXDMA_PAUSE;
+			con &= ~CON_TXDMA_ACTIVE;
+		}
+
+		if (other_tx_active(i2s)) {
+			writel(con, addr + I2SCON);
+			return;
+		}
+
+		con |=  CON_TXCH_PAUSE;
+
+		if (any_rx_active(i2s))
+			mod |= MOD_RXONLY;
+		else
+			con &= ~CON_ACTIVE;
+	}
+
+	writel(mod, addr + I2SMOD);
+	writel(con, addr + I2SCON);
+}
+
+/* RX Channel Control */
+static void s3c_i2sv2_rxctrl(struct i2s_dai *i2s, int on)
+{
+	void __iomem *addr = i2s->addr;
+	u32 con = readl(addr + I2SCON);
+	u32 mod = readl(addr + I2SMOD) & ~MOD_MASK;
+
+	if (on) {
+		con |= CON_RXDMA_ACTIVE | CON_ACTIVE;
+		con &= ~(CON_RXDMA_PAUSE | CON_RXCH_PAUSE);
+
+		if (any_tx_active(i2s))
+			mod |= MOD_TXRX;
+		else
+			mod |= MOD_RXONLY;
+	} else {
+		con |=  CON_RXDMA_PAUSE | CON_RXCH_PAUSE;
+		con &= ~CON_RXDMA_ACTIVE;
+
+		if (any_tx_active(i2s))
+			mod |= MOD_TXONLY;
+		else
+			con &= ~CON_ACTIVE;
+	}
+
+	writel(mod, addr + I2SMOD);
+	writel(con, addr + I2SCON);
+}
+
+/* Flush FIFO of an interface */
+static inline void s3c_i2sv2_fifo(struct i2s_dai *i2s, u32 flush)
+{
+	void __iomem *fic;
+	u32 val;
+
+	if (!i2s)
+		return;
+
+	if (is_secondary(i2s))
+		fic = i2s->addr + I2SFICS;
+	else
+		fic = i2s->addr + I2SFIC;
+
+	/* Flush the FIFO */
+	writel(readl(fic) | flush, fic);
+
+	/* Be patient */
+	val = msecs_to_loops(1) / 1000; /* 1 usec */
+	while (--val)
+		cpu_relax();
+
+	writel(readl(fic) & ~flush, fic);
+}
+
+static int s3c_i2sv2_set_sysclk(struct snd_soc_dai *dai,
+	  int clk_id, unsigned int rfs, int dir)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	u32 mod = readl(i2s->addr + I2SMOD);
+
+	switch (clk_id) {
+	case SAMSUNG_I2S_CDCLK:
+		/* Shouldn't matter in GATING(CLOCK_IN) mode */
+		if (dir == SND_SOC_CLOCK_IN)
+			rfs = 0;
+
+		if ((rfs && other->rfs && (other->rfs != rfs)) ||
+				(any_active(i2s) &&
+				(((dir == SND_SOC_CLOCK_IN)
+					&& !(mod & MOD_CDCLKCON)) ||
+				((dir == SND_SOC_CLOCK_OUT)
+					&& (mod & MOD_CDCLKCON))))) {
+			dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+			return -EAGAIN;
+		}
+
+		if (dir == SND_SOC_CLOCK_IN)
+			mod |= MOD_CDCLKCON;
+		else
+			mod &= ~MOD_CDCLKCON;
+
+		i2s->rfs = rfs;
+		break;
+
+	case SAMSUNG_I2S_RCLKSRC_0: /* clock corrsponding to IISMOD[10] := 0 */
+	case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
+		if ((i2s->quirks & QUIRK_NO_MUXPSR)
+				|| (clk_id == SAMSUNG_I2S_RCLKSRC_0))
+			clk_id = 0;
+		else
+			clk_id = 1;
+
+		if (!any_active(i2s)) {
+			if (i2s->op_clk) {
+				if ((clk_id && !(mod & MOD_IMS_SYSMUX)) ||
+					(!clk_id && (mod & MOD_IMS_SYSMUX))) {
+					clk_disable(i2s->op_clk);
+					clk_put(i2s->op_clk);
+				} else {
+					return 0;
+				}
+			}
+
+			i2s->op_clk = clk_get(&i2s->pdev->dev,
+						i2s->src_clk[clk_id]);
+			clk_enable(i2s->op_clk);
+			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
+
+			/* Over-ride the other's */
+			if (other) {
+				other->op_clk = i2s->op_clk;
+				other->rclk_srcrate = i2s->rclk_srcrate;
+			}
+		} else if ((!clk_id && (mod & MOD_IMS_SYSMUX))
+				|| (clk_id && !(mod & MOD_IMS_SYSMUX))) {
+			dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+			return -EAGAIN;
+		} else {
+			/* Call can't be on the active DAI */
+			i2s->op_clk = other->op_clk;
+			i2s->rclk_srcrate = other->rclk_srcrate;
+			return 0;
+		}
+
+		if (clk_id == 0)
+			mod &= ~MOD_IMS_SYSMUX;
+		else
+			mod |= MOD_IMS_SYSMUX;
+		break;
+
+	default:
+		dev_err(&i2s->pdev->dev, "We don't serve that!\n");
+		return -EINVAL;
+	}
+
+	writel(mod, i2s->addr + I2SMOD);
+
+	return 0;
+}
+
+static int i2sv2_i2s_set_fmt(struct snd_soc_dai *dai,
+	unsigned int fmt)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	u32 mod = readl(i2s->addr + I2SMOD);
+	u32 tmp = 0;
+
+	/* Format is priority */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		tmp |= MOD_LR_RLOW;
+		tmp |= MOD_SDF_MSB;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		tmp |= MOD_LR_RLOW;
+		tmp |= MOD_SDF_LSB;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		tmp |= MOD_SDF_IIS;
+		break;
+	default:
+		dev_err(&i2s->pdev->dev, "Format not supported\n");
+		return -EINVAL;
+	}
+
+	/* Allow LRCLK-inverted version of the supported formats */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		if (tmp & MOD_LR_RLOW)
+			tmp &= ~MOD_LR_RLOW;
+		else
+			tmp |= MOD_LR_RLOW;
+		break;
+	default:
+		dev_err(&i2s->pdev->dev, "Polarity not supported\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		tmp |= MOD_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Set default source clock in Master mode */
+		if (i2s->rclk_srcrate == 0)
+			s3c_i2sv2_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
+							0, SND_SOC_CLOCK_IN);
+		break;
+	default:
+		dev_err(&i2s->pdev->dev, "master/slave format not supported\n");
+		return -EINVAL;
+	}
+
+	if (any_active(i2s) &&
+			((mod & (MOD_SDF_MASK | MOD_LR_RLOW
+				| MOD_SLAVE)) != tmp)) {
+		dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+		return -EAGAIN;
+	}
+
+	mod &= ~(MOD_SDF_MASK | MOD_LR_RLOW | MOD_SLAVE);
+	mod |= tmp;
+	writel(mod, i2s->addr + I2SMOD);
+
+	return 0;
+}
+
+static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	u32 mod = readl(i2s->addr + I2SMOD);
+
+	if (!is_secondary(i2s))
+		mod &= ~(MOD_DC2_EN | MOD_DC1_EN);
+
+	switch (params_channels(params)) {
+	case 6:
+		mod |= MOD_DC2_EN;
+	case 4:
+		mod |= MOD_DC1_EN;
+		break;
+	case 2:
+		break;
+	default:
+		dev_err(&i2s->pdev->dev, "%d channels not supported\n",
+				params_channels(params));
+		return -EINVAL;
+	}
+
+	if (is_secondary(i2s))
+		mod &= ~MOD_BLCS_MASK;
+	else
+		mod &= ~MOD_BLCP_MASK;
+
+	if (is_manager(i2s))
+		mod &= ~MOD_BLC_MASK;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		if (is_secondary(i2s))
+			mod |= MOD_BLCS_8BIT;
+		else
+			mod |= MOD_BLCP_8BIT;
+		if (is_manager(i2s))
+			mod |= MOD_BLC_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		if (is_secondary(i2s))
+			mod |= MOD_BLCS_16BIT;
+		else
+			mod |= MOD_BLCP_16BIT;
+		if (is_manager(i2s))
+			mod |= MOD_BLC_16BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		if (is_secondary(i2s))
+			mod |= MOD_BLCS_24BIT;
+		else
+			mod |= MOD_BLCP_24BIT;
+		if (is_manager(i2s))
+			mod |= MOD_BLC_24BIT;
+		break;
+	default:
+		dev_err(&i2s->pdev->dev, "Format(%d) not supported\n",
+				params_format(params));
+		return -EINVAL;
+	}
+	writel(mod, i2s->addr + I2SMOD);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_dai_set_dma_data(dai, substream,
+			(void *)&i2s->dma_playback);
+	else
+		snd_soc_dai_set_dma_data(dai, substream,
+			(void *)&i2s->dma_capture);
+
+	i2s->frmclk = params_rate(params);
+
+	return 0;
+}
+
+/* We set constraints on the substream acc to the version of I2S */
+static int s3c_i2sv2_startup(struct snd_pcm_substream *substream,
+	  struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+
+	i2s->mode |= DAI_OPENED;
+
+	if (is_manager(other))
+		i2s->mode &= ~DAI_MANAGER;
+	else
+		i2s->mode |= DAI_MANAGER;
+
+	/* Enforce set_sysclk in Master mode */
+	i2s->rclk_srcrate = 0;
+
+	spin_unlock_irqrestore(&lock, flags);
+
+	return 0;
+}
+
+static void s3c_i2sv2_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+
+	i2s->mode &= ~DAI_OPENED;
+	i2s->mode &= ~DAI_MANAGER;
+
+	if (is_opened(other))
+		other->mode |= DAI_MANAGER;
+
+	/* Reset any constraint on RFS and BFS */
+	i2s->rfs = 0;
+	i2s->bfs = 0;
+
+	spin_unlock_irqrestore(&lock, flags);
+
+	/* Gate CDCLK by default */
+	if (!is_opened(other))
+		s3c_i2sv2_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
+				0, SND_SOC_CLOCK_IN);
+}
+
+static int config_setup(struct i2s_dai *i2s)
+{
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	unsigned rfs, bfs, blc;
+	u32 psr;
+
+	blc = get_blc(i2s);
+
+	bfs = i2s->bfs;
+
+	if (!bfs && other)
+		bfs = other->bfs;
+
+	/* Select least possible multiple(2) if no constraint set */
+	if (!bfs)
+		bfs = blc * 2;
+
+	rfs = i2s->rfs;
+
+	if (!rfs && other)
+		rfs = other->rfs;
+
+	if ((rfs == 256 || rfs == 512) && (blc == 24)) {
+		dev_err(&i2s->pdev->dev,
+			"%d-RFS not supported for 24-blc\n", rfs);
+		return -EINVAL;
+	}
+
+	if (!rfs) {
+		if (bfs == 16 || bfs == 32)
+			rfs = 256;
+		else
+			rfs = 384;
+	}
+
+	/* If already setup and running */
+	if (any_active(i2s) && (get_rfs(i2s) != rfs || get_bfs(i2s) != bfs)) {
+		dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+		return -EAGAIN;
+	}
+
+	/* We don't care about BFS in Slave mode */
+	if (is_slave(i2s))
+		return 0;
+
+	set_bfs(i2s, bfs);
+	set_rfs(i2s, rfs);
+
+	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
+		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
+		dev_dbg(&i2s->pdev->dev,
+			"RCLK_SRC=%luHz PSR=%u, RCLK=%dfs, BCLK=%dfs\n",
+				i2s->rclk_srcrate, psr, rfs, bfs);
+	}
+
+	return 0;
+}
+
+static int i2sv2_i2s_trigger(struct snd_pcm_substream *substream,
+	int cmd, struct snd_soc_dai *dai)
+{
+	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct i2s_dai *i2s = to_info(rtd->cpu_dai);
+	unsigned long flags;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		local_irq_save(flags);
+
+		if (capture)
+			s3c_i2sv2_fifo(i2s, FIC_RXFLUSH);
+		else
+			s3c_i2sv2_fifo(i2s, FIC_TXFLUSH);
+
+		if (config_setup(i2s)) {
+			local_irq_restore(flags);
+			return -EINVAL;
+		}
+
+		if (capture)
+			s3c_i2sv2_rxctrl(i2s, 1);
+		else
+			s3c_i2sv2_txctrl(i2s, 1);
+
+		local_irq_restore(flags);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		local_irq_save(flags);
+
+		if (capture)
+			s3c_i2sv2_rxctrl(i2s, 0);
+		else
+			s3c_i2sv2_txctrl(i2s, 0);
+
+		local_irq_restore(flags);
+		break;
+	}
+
+	return 0;
+}
+
+static int i2sv2_i2s_set_clkdiv(struct snd_soc_dai *dai,
+	int div_id, int div)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+
+	if (div_id == SAMSUNG_I2S_DIV_BCLK) {
+		if ((any_active(i2s) && div && (get_bfs(i2s) != div))
+			|| (other && other->bfs && (other->bfs != div))) {
+			dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+			return -EAGAIN;
+		}
+		i2s->bfs = div;
+	} else {
+		dev_err(&i2s->pdev->dev,
+			"Invalid clock divider(%d)\n", div_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_sframes_t
+i2sv2_i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	u32 reg = readl(i2s->addr + I2SFIC);
+	snd_pcm_sframes_t delay;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		delay = FIC_RXCOUNT(reg);
+	else if (is_secondary(i2s))
+		delay = FICS_TXCOUNT(readl(i2s->addr + I2SFICS));
+	else
+		delay = FIC_TXCOUNT(reg);
+
+	return delay;
+}
+
+#ifdef CONFIG_PM
+static int i2sv2_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+
+	if (dai->active) {
+		i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
+		i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
+		i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
+	}
+
+	return 0;
+}
+
+static int i2sv2_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+
+	if (dai->active) {
+		writel(i2s->suspend_i2scon, i2s->addr + I2SCON);
+		writel(i2s->suspend_i2smod, i2s->addr + I2SMOD);
+		writel(i2s->suspend_i2spsr, i2s->addr + I2SPSR);
+	}
+
+	return 0;
+}
+#else
+#define i2sv2_i2s_suspend NULL
+#define i2sv2_i2s_resume  NULL
+#endif
+
+static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+
+	if (other && other->clk) /* If this is probe on secondary */
+		goto probe_exit;
+
+	i2s->addr = ioremap(i2s->base, 0x100);
+	if (i2s->addr == NULL) {
+		dev_err(&i2s->pdev->dev, "cannot ioremap registers\n");
+		return -ENXIO;
+	}
+
+	i2s->clk = clk_get(&i2s->pdev->dev, "iis");
+	if (IS_ERR(i2s->clk)) {
+		dev_err(&i2s->pdev->dev, "failed to get i2s_clock\n");
+		iounmap(i2s->addr);
+		return -ENOENT;
+	}
+	clk_enable(i2s->clk);
+
+	if (other) {
+		other->addr = i2s->addr;
+		other->clk = i2s->clk;
+	}
+
+	if (i2s->quirks & QUIRK_NEED_RSTCLR)
+		writel(CON_RSTCLR, i2s->addr + I2SCON);
+
+probe_exit:
+	/* Reset any constraint on RFS and BFS */
+	i2s->rfs = 0;
+	i2s->bfs = 0;
+	s3c_i2sv2_txctrl(i2s, 0);
+	s3c_i2sv2_rxctrl(i2s, 0);
+	s3c_i2sv2_fifo(i2s, FIC_TXFLUSH);
+	s3c_i2sv2_fifo(other, FIC_TXFLUSH);
+	s3c_i2sv2_fifo(i2s, FIC_RXFLUSH);
+
+	/* Gate CDCLK by default */
+	if (!is_opened(other))
+		s3c_i2sv2_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
+				0, SND_SOC_CLOCK_IN);
+
+	return 0;
+}
+
+static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
+{
+	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
+	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+
+	if (!other || !other->clk) {
+
+		if (i2s->quirks & QUIRK_NEED_RSTCLR)
+			writel(0, i2s->addr + I2SCON);
+
+		clk_disable(i2s->clk);
+		clk_put(i2s->clk);
+
+		iounmap(i2s->addr);
+	}
+
+	i2s->clk = NULL;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops samsung_i2s_dai_ops = {
+	.trigger = i2sv2_i2s_trigger,
+	.hw_params = s3c_i2sv2_hw_params,
+	.set_fmt = i2sv2_i2s_set_fmt,
+	.set_clkdiv = i2sv2_i2s_set_clkdiv,
+	.set_sysclk = s3c_i2sv2_set_sysclk,
+	.startup = s3c_i2sv2_startup,
+	.shutdown = s3c_i2sv2_shutdown,
+	.delay = i2sv2_i2s_delay,
+};
+
+#define SAMSUNG_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define SAMSUNG_I2S_FMTS \
+	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
+	 SNDRV_PCM_FMTBIT_S24_LE)
+
+static __devinit
+struct i2s_dai *s3c_alloc_dai(struct platform_device *pdev, bool sec)
+{
+	struct i2s_dai *i2s;
+
+	i2s = kzalloc(sizeof(struct i2s_dai), GFP_KERNEL);
+	if (i2s == NULL)
+		return NULL;
+
+	i2s->pdev = pdev;
+	i2s->pri_dai = NULL;
+	i2s->sec_dai = NULL;
+	i2s->s3c_i2s_drv.symmetric_rates = 1;
+	i2s->s3c_i2s_drv.probe = samsung_i2s_dai_probe;
+	i2s->s3c_i2s_drv.remove = samsung_i2s_dai_remove;
+	i2s->s3c_i2s_drv.ops = &samsung_i2s_dai_ops;
+	i2s->s3c_i2s_drv.suspend = i2sv2_i2s_suspend;
+	i2s->s3c_i2s_drv.resume = i2sv2_i2s_resume;
+	i2s->s3c_i2s_drv.playback.channels_min = 2;
+	i2s->s3c_i2s_drv.playback.channels_max = 2;
+	i2s->s3c_i2s_drv.playback.rates = SAMSUNG_I2S_RATES;
+	i2s->s3c_i2s_drv.playback.formats = SAMSUNG_I2S_FMTS;
+
+	if (!sec) {
+		i2s->s3c_i2s_drv.capture.channels_min = 2;
+		i2s->s3c_i2s_drv.capture.channels_max = 2;
+		i2s->s3c_i2s_drv.capture.rates = SAMSUNG_I2S_RATES;
+		i2s->s3c_i2s_drv.capture.formats = SAMSUNG_I2S_FMTS;
+	} else {	/* Create a new platform_device for Secondary */
+		i2s->pdev = platform_device_register_resndata(NULL,
+				pdev->name, pdev->id + MAX_I2S,
+				NULL, 0, NULL, 0);
+		if (IS_ERR(i2s->pdev)) {
+			kfree(i2s);
+			return NULL;
+		}
+	}
+
+	/* Pre-assign snd_soc_dai_set_drvdata */
+	dev_set_drvdata(&i2s->pdev->dev, i2s);
+
+	return i2s;
+}
+
+static __devinit int samsung_i2s_probe(struct platform_device *pdev)
+{
+	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
+	struct i2s_dai *pri_dai, *sec_dai = NULL;
+	struct s3c_audio_pdata *i2s_pdata;
+	struct samsung_i2s *i2s_cfg;
+	struct resource *res;
+	u32 regs_base, quirks;
+	int ret = 0;
+
+	/* Call during Seconday interface registration */
+	if (pdev->id >= MAX_I2S) {
+		sec_dai = dev_get_drvdata(&pdev->dev);
+		snd_soc_register_dai(&sec_dai->pdev->dev,
+			&sec_dai->s3c_i2s_drv);
+		return 0;
+	}
+
+	i2s_pdata = pdev->dev.platform_data;
+	if (i2s_pdata == NULL) {
+		dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
+		return -ENXIO;
+	}
+	dma_pl_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
+		return -ENXIO;
+	}
+	dma_cp_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 2);
+	if (res)
+		dma_pl_sec_chan = res->start;
+	else
+		dma_pl_sec_chan = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
+		return -ENXIO;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+							"samsung-i2s")) {
+		dev_err(&pdev->dev, "Unable to request SFR region\n");
+		return -EBUSY;
+	}
+	regs_base = res->start;
+
+	i2s_cfg = &i2s_pdata->type.i2s;
+	quirks = i2s_cfg->quirks;
+
+	pri_dai = s3c_alloc_dai(pdev, false);
+	if (!pri_dai) {
+		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
+	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
+	pri_dai->dma_playback.client =
+		(struct s3c2410_dma_client *)&pri_dai->dma_playback;
+	pri_dai->dma_capture.client =
+		(struct s3c2410_dma_client *)&pri_dai->dma_capture;
+	pri_dai->dma_playback.channel = dma_pl_chan;
+	pri_dai->dma_capture.channel = dma_cp_chan;
+	pri_dai->src_clk = i2s_cfg->src_clk;
+	pri_dai->dma_playback.dma_size = 4;
+	pri_dai->dma_capture.dma_size = 4;
+	pri_dai->base = regs_base;
+	pri_dai->quirks = quirks;
+
+	if (quirks & QUIRK_PRI_6CHAN)
+		pri_dai->s3c_i2s_drv.playback.channels_max = 6;
+
+	if (quirks & QUIRK_SEC_DAI) {
+		sec_dai = s3c_alloc_dai(pdev, true);
+		if (!sec_dai) {
+			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
+			ret = -ENOMEM;
+			goto err2;
+		}
+		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
+		sec_dai->dma_playback.client =
+			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
+		/* Use iDMA always if SysDMA not provided */
+		sec_dai->dma_playback.channel = dma_pl_sec_chan ? : -1;
+		sec_dai->src_clk = i2s_cfg->src_clk;
+		sec_dai->dma_playback.dma_size = 4;
+		sec_dai->base = regs_base;
+		sec_dai->quirks = quirks;
+		sec_dai->pri_dai = pri_dai;
+		pri_dai->sec_dai = sec_dai;
+	}
+
+	if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		ret = -EINVAL;
+		goto err3;
+	}
+
+	snd_soc_register_dai(&pri_dai->pdev->dev, &pri_dai->s3c_i2s_drv);
+
+	return 0;
+err3:
+	kfree(sec_dai);
+err2:
+	kfree(pri_dai);
+err1:
+	release_mem_region(regs_base, resource_size(res));
+
+	return ret;
+}
+
+static __devexit int samsung_i2s_remove(struct platform_device *pdev)
+{
+	struct i2s_dai *i2s, *other;
+
+	i2s = dev_get_drvdata(&pdev->dev);
+	other = i2s->pri_dai ? : i2s->sec_dai;
+
+	if (other) {
+		other->pri_dai = NULL;
+		other->sec_dai = NULL;
+	} else {
+		struct resource *res;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res)
+			release_mem_region(res->start, resource_size(res));
+	}
+
+	i2s->pri_dai = NULL;
+	i2s->sec_dai = NULL;
+
+	kfree(i2s);
+
+	snd_soc_unregister_dai(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver samsung_i2s_driver = {
+	.probe  = samsung_i2s_probe,
+	.remove = samsung_i2s_remove,
+	.driver = {
+		.name = "samsung-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init samsung_i2s_init(void)
+{
+	return platform_driver_register(&samsung_i2s_driver);
+}
+module_init(samsung_i2s_init);
+
+static void __exit samsung_i2s_exit(void)
+{
+	platform_driver_unregister(&samsung_i2s_driver);
+}
+module_exit(samsung_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_DESCRIPTION("Samsung I2S Interface");
+MODULE_ALIAS("platform:samsung-i2s");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/i2s.h b/sound/soc/s3c24xx/i2s.h
new file mode 100644
index 0000000..77b7965
--- /dev/null
+++ b/sound/soc/s3c24xx/i2s.h
@@ -0,0 +1,29 @@
+/* sound/soc/s3c24xx/i2s.h
+ *
+ * ALSA SoC Audio Layer - Samsung I2S Controller driver
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SND_SOC_SAMSUNG_I2S_H
+#define __SND_SOC_SAMSUNG_I2S_H
+
+/*
+ * Maximum number of I2S blocks that any SoC can have.
+ * The secondary interface of a CPU dai(if there exists any),
+ * is indexed at [cpu-dai's ID + MAX_I2S]
+ */
+#define MAX_I2S	4
+
+#define SAMSUNG_I2S_DIV_BCLK	1
+
+#define SAMSUNG_I2S_RCLKSRC_0	0
+#define SAMSUNG_I2S_RCLKSRC_1	1
+#define SAMSUNG_I2S_CDCLK		2
+
+#endif /* __SND_SOC_SAMSUNG_I2S_H */
-- 
1.6.2.5
