From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 1/6] ARM: DaVinci: ASoC: Add mcasp support
	for DM646x
Date: Thu, 16 Apr 2009 18:37:47 -0400
Message-ID: <1239921467-26768-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id DB015103941
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:25:50 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBPjDN021899
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:25:50 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Steve Chen <schen@mvista.com>, "Naresh.Medisetty" <naresh@ti.com>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh.Medisetty <naresh@ti.com>

Adds driver support for the two instances of McASP on TI's DM646x.

The multichannel audio serial port (McASP) functions as a general-purpose audio
serial port optimized for the needs of multichannel audio application.
(http://www.ti.com/litv/pdf/spruer1b).

There are two instances of McASP on DM646x. The McASP0 module includes up to 4
serializers that can be individually enabled to either transmit or receive
in different modes. The McASP1 module is limited with only 1 pinned-out
serializer that can be enabled to only transmit in DIT mode (neither receiving
in any mode nor transmitting in either Burst or TDM mode is supported).

The codec on the DM646x EVM is AIC32 which is connected to Serializer0 and
Serializer1 of McASP0. The McASP0 consists of transmit and receive sections
that may operate synchronized, or completely independently with separate master
clocks, bit clocks, and frame syncs, and using different transmit modes with
different bit-stream formats.

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/davinci/Kconfig             |   15 +-
 sound/soc/davinci/Makefile            |    3 +
 sound/soc/davinci/davinci-i2s-mcasp.c |  890 +++++++++++++++++++++++++++++++++
 sound/soc/davinci/davinci-i2s-mcasp.h |   56 ++
 sound/soc/davinci/davinci-pcm.h       |   17 +-
 5 files changed, 972 insertions(+), 9 deletions(-)
 create mode 100644 sound/soc/davinci/davinci-i2s-mcasp.c
 create mode 100644 sound/soc/davinci/davinci-i2s-mcasp.h

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index bd7392c..0ae84d4 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -9,6 +9,9 @@ config SND_DAVINCI_SOC
 config SND_DAVINCI_SOC_I2S
 	tristate
 
+config SND_DAVINCI_SOC_I2S_MCASP
+        tristate
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_EVM
@@ -16,7 +19,17 @@ config SND_DAVINCI_SOC_EVM
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci EVM platform.
+	  DaVinci DM6446 or DM355 EVM platforms.
+
+config  SND_DM6467_SOC_EVM
+        tristate "SoC Audio support for DaVinci DM6467 EVM"
+        depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM
+        select SND_DAVINCI_SOC_I2S_MCASP
+        select SND_SOC_TLV320AIC3X
+        help
+          Say Y if you want to add support for SoC audio on TI
+          DaVinci DM6467 EVM platform.
+
 
 config SND_DAVINCI_SOC_SFFSDR
 	tristate "SoC Audio support for SFFSDR"
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index ca8bae1..152d59c 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -1,13 +1,16 @@
 # DAVINCI Platform Support
 snd-soc-davinci-objs := davinci-pcm.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
+snd-soc-davinci-i2s-mcasp-objs:= davinci-i2s-mcasp.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
+obj-$(CONFIG_SND_DAVINCI_SOC_I2S_MCASP) += snd-soc-davinci-i2s-mcasp.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
 snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-i2s-mcasp.c b/sound/soc/davinci/davinci-i2s-mcasp.c
new file mode 100644
index 0000000..5e9ba49
--- /dev/null
+++ b/sound/soc/davinci/davinci-i2s-mcasp.c
@@ -0,0 +1,890 @@
+/*
+ * ALSA SoC I2S (McASP) Audio Layer for TI DAVINCI processor
+ *
+ * Author: Nirmal Pandey <n-pandey@ti.com>,
+ *         Suresh Rajashekara <suresh.r@ti.com>
+ *         Steve Chen, <schen@.mvista.com>
+ *
+ * Copyright:   (C) 2009 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2009  Texas Instruments, India
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "davinci-pcm.h"
+#include "davinci-i2s-mcasp.h"
+
+/*
+ * McASP register definitions
+ */
+#define DAVINCI_MCASP_PID_REG		0x00
+#define DAVINCI_MCASP_PWREMUMGT_REG	0x04
+
+#define DAVINCI_MCASP_PFUNC_REG		0x10
+#define DAVINCI_MCASP_PDIR_REG		0x14
+#define DAVINCI_MCASP_PDOUT_REG		0x18
+#define DAVINCI_MCASP_PDSET_REG		0x1c
+
+#define DAVINCI_MCASP_PDCLR_REG		0x20
+
+#define DAVINCI_MCASP_TLGC_REG		0x30
+#define DAVINCI_MCASP_TLMR_REG		0x34
+
+#define DAVINCI_MCASP_GBLCTL_REG	0x44
+#define DAVINCI_MCASP_AMUTE_REG		0x48
+#define DAVINCI_MCASP_LBCTL_REG		0x4c
+
+#define DAVINCI_MCASP_TXDITCTL_REG	0x50
+
+#define DAVINCI_MCASP_GBLCTLR_REG	0x60
+#define DAVINCI_MCASP_RXMASK_REG	0x64
+#define DAVINCI_MCASP_RXFMT_REG		0x68
+#define DAVINCI_MCASP_RXFMCTL_REG	0x6c
+
+#define DAVINCI_MCASP_ACLKRCTL_REG	0x70
+#define DAVINCI_MCASP_AHCLKRCTL_REG	0x74
+#define DAVINCI_MCASP_RXTDM_REG		0x78
+#define DAVINCI_MCASP_EVTCTLR_REG	0x7c
+
+#define DAVINCI_MCASP_RXSTAT_REG	0x80
+#define DAVINCI_MCASP_RXTDMSLOT_REG	0x84
+#define DAVINCI_MCASP_RXCLKCHK_REG	0x88
+#define DAVINCI_MCASP_REVTCTL_REG	0x8c
+
+#define DAVINCI_MCASP_GBLCTLX_REG	0xa0
+#define DAVINCI_MCASP_TXMASK_REG	0xa4
+#define DAVINCI_MCASP_TXFMT_REG		0xa8
+#define DAVINCI_MCASP_TXFMCTL_REG	0xac
+
+#define DAVINCI_MCASP_ACLKXCTL_REG	0xb0
+#define DAVINCI_MCASP_AHCLKXCTL_REG	0xb4
+#define DAVINCI_MCASP_TXTDM_REG		0xb8
+#define DAVINCI_MCASP_EVTCTLX_REG	0xbc
+
+#define DAVINCI_MCASP_TXSTAT_REG	0xc0
+#define DAVINCI_MCASP_TXTDMSLOT_REG	0xc4
+#define DAVINCI_MCASP_TXCLKCHK_REG	0xc8
+#define DAVINCI_MCASP_XEVTCTL_REG	0xcc
+
+/* Left (even TDM Slot) Channel Status Register File*/
+#define DAVINCI_MCASP_DITCSRA_REG	0x100
+/* Right (odd TDM slot) Channel Status RegisterFile*/
+#define DAVINCI_MCASP_DITCSRB_REG	0x118
+/* Left (even TDM slot) User Data Register File */
+#define DAVINCI_MCASP_DITUDRA_REG	0x130
+/* Right (odd TDM Slot) User Data Register File */
+#define DAVINCI_MCASP_DITUDRB_REG	0x148
+
+/* Serializer n Control Register */
+#define DAVINCI_MCASP_XRSRCTL_BASE_REG	0x180
+#define DAVINCI_MCASP_XRSRCTL_REG(n)	(DAVINCI_MCASP_XRSRCTL_BASE_REG + \
+					 (n << 2))
+
+/* Transmit Buffer for Serializer n */
+#define DAVINCI_MCASP_TXBUF_REG		0x200
+/* Receive Buffer for Serializer n */
+#define DAVINCI_MCASP_RXBUF_REG		0x280
+
+
+/*
+ * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
+ *     Register Bits
+ */
+#define MCASP_FREE         BIT(0)
+#define MCASP_SOFT         BIT(1)
+
+/*
+ * DAVINCI_MCASP_PFUNC_REG - Pin Function / GPIO Enable Register Bits
+ */
+#define AXR(n)       (1<<n)
+#define PFUNC_AMUTE  BIT(25)
+#define ACLKX        BIT(26)
+#define AHCLKX       BIT(27)
+#define AFSX         BIT(28)
+#define ACLKR        BIT(29)
+#define AHCLKR       BIT(30)
+#define AFSR         BIT(31)
+
+/*
+ * DAVINCI_MCASP_PDIR_REG - Pin Direction Register Bits
+ */
+#define AXR(n)       (1<<n)
+#define PDIR_AMUTE   BIT(25)
+#define ACLKX        BIT(26)
+#define AHCLKX       BIT(27)
+#define AFSX         BIT(28)
+#define ACLKR        BIT(29)
+#define AHCLKR       BIT(30)
+#define AFSR         BIT(31)
+
+/*
+ * DAVINCI_MCASP_TXDITCTL_REG - Transmit DIT Control Register Bits
+ */
+#define DITEN        BIT(0)	/* Transmit DIT mode enable/disable */
+#define VA           BIT(2)
+#define VB           BIT(3)
+
+/*
+ * DAVINCI_MCASP_TXFMT_REG - Transmit Bitstream Format Register Bits
+ */
+#define TXROT(val)   (val)
+#define TXSEL        BIT(3)
+#define TXSSZ(val)   (val<<4)
+#define TXPBIT(val)  (val<<8)
+#define TXPAD(val)   (val<<13)
+#define TXORD        BIT(15)
+#define FSXDLY(val)  (val<<16)
+
+/*
+ * DAVINCI_MCASP_RXFMT_REG - Receive Bitstream Format Register Bits
+ */
+#define RXROT(val)   (val)
+#define RXSEL        BIT(3)
+#define RXSSZ(val)   (val<<4)
+#define RXPBIT(val)  (val<<8)
+#define RXPAD(val)   (val<<13)
+#define RXORD        BIT(15)
+#define FSRDLY(val)  (val<<16)
+
+/*
+ * DAVINCI_MCASP_TXFMCTL_REG -  Transmit Frame Control Register Bits
+  */
+#define FSXPOL       BIT(0)
+#define AFSXE        BIT(1)
+#define FSXDUR       BIT(4)
+#define FSXMOD(val)  (val<<7)
+
+/*
+ * DAVINCI_MCASP_RXFMCTL_REG - Receive Frame Control Register Bits
+ */
+#define FSRPOL       BIT(0)
+#define AFSRE        BIT(1)
+#define FSRDUR       BIT(4)
+#define FSRMOD(val)  (val<<7)
+
+/*
+ * DAVINCI_MCASP_ACLKXCTL_REG - Transmit Clock Control Register Bits
+ */
+#define ACLKXDIV(val) (val)
+#define ACLKXE       BIT(5)
+#define TX_ASYNC     BIT(6)
+#define ACLKXPOL     BIT(7)
+
+/*
+ * DAVINCI_MCASP_ACLKRCTL_REG Receive Clock Control Register Bits
+ */
+#define ACLKRDIV(val) (val)
+#define ACLKRE       BIT(5)
+#define RX_ASYNC     BIT(6)
+#define ACLKRPOL     BIT(7)
+
+/*
+ * DAVINCI_MCASP_AHCLKXCTL_REG - High Frequency Transmit Clock Control
+ *     Register Bits
+ */
+#define AHCLKXDIV(val) (val)
+#define AHCLKXPOL    BIT(14)
+#define AHCLKXE      BIT(15)
+
+/*
+ * DAVINCI_MCASP_AHCLKRCTL_REG - High Frequency Receive Clock Control
+ *     Register Bits
+ */
+#define AHCLKRDIV(val) (val)
+#define AHCLKRPOL    BIT(14)
+#define AHCLKRE      BIT(15)
+
+/*
+ * DAVINCI_MCASP_XRSRCTL_BASE_REG -  Serializer Control Register Bits
+ */
+#define MODE(val)    (val)
+#define DISMOD(val)  (val<<2)
+#define TXSTATE      BIT(4)
+#define RXSTATE      BIT(5)
+
+/*
+ * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
+ */
+#define LBEN         BIT(0)
+#define LBORD        BIT(1)
+#define LBGENMODE(val) (val<<2)
+
+/*
+ * DAVINCI_MCASP_TXTDMSLOT_REG - Transmit TDM Slot Register configuration
+ */
+#define TXTDMS(n)    (1<<n)
+
+/*
+ * DAVINCI_MCASP_RXTDMSLOT_REG - Receive TDM Slot Register configuration
+ */
+#define RXTDMS(n)    (1<<n)
+
+/*
+ * DAVINCI_MCASP_GBLCTL_REG -  Global Control Register Bits
+ */
+#define RXCLKRST     BIT(0)	/* Receiver Clock Divider Reset */
+#define RXHCLKRST    BIT(1)	/* Receiver High Frequency Clock Divider */
+#define RXSERCLR     BIT(2)	/* Receiver Serializer Clear */
+#define RXSMRST      BIT(3)	/* Receiver State Machine Reset */
+#define RXFSRST      BIT(4)	/* Frame Sync Generator Reset */
+#define TXCLKRST     BIT(8)	/* Transmitter Clock Divider Reset */
+#define TXHCLKRST    BIT(9)	/* Transmitter High Frequency Clock Divider*/
+#define TXSERCLR     BIT(10)	/* Transmit Serializer Clear */
+#define TXSMRST      BIT(11)	/* Transmitter State Machine Reset */
+#define TXFSRST      BIT(12)	/* Frame Sync Generator Reset */
+
+/*
+ * DAVINCI_MCASP_AMUTE_REG -  Mute Control Register Bits
+ */
+#define MUTENA(val)  (val)
+#define MUTEINPOL    BIT(2)
+#define MUTEINENA    BIT(3)
+#define MUTEIN       BIT(4)
+#define MUTER        BIT(5)
+#define MUTEX        BIT(6)
+#define MUTEFSR      BIT(7)
+#define MUTEFSX      BIT(8)
+#define MUTEBADCLKR  BIT(9)
+#define MUTEBADCLKX  BIT(10)
+#define MUTERXDMAERR BIT(11)
+#define MUTETXDMAERR BIT(12)
+
+/*
+ * DAVINCI_MCASP_REVTCTL_REG - Receiver DMA Event Control Register bits
+ */
+#define RXDATADMADIS BIT(0)
+
+/*
+ * DAVINCI_MCASP_XEVTCTL_REG - Transmitter DMA Event Control Register bits
+ */
+#define TXDATADMADIS BIT(0)
+
+
+
+#define DAVINCI_MCASP_NUM_SERIALIZER	16
+
+
+static inline void mcasp_set_bits(void __iomem *reg, u32 val)
+{
+	__raw_writel(__raw_readl(reg) | val, reg);
+}
+
+static inline void mcasp_clr_bits(void __iomem *reg, u32 val)
+{
+	__raw_writel((__raw_readl(reg) & ~(val)), reg);
+}
+
+static inline void mcasp_mod_bits(void __iomem *reg, u32 val, u32 mask)
+{
+	__raw_writel((__raw_readl(reg) & ~mask) | val, reg);
+}
+
+static inline void mcasp_set_reg(void __iomem *reg, u32 val)
+{
+	__raw_writel(val, reg);
+}
+
+static inline u32 mcasp_get_reg(void __iomem *reg)
+{
+	return (unsigned int)__raw_readl(reg);
+}
+
+static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
+{
+	int i = 0;
+	mcasp_set_bits(regs, val);
+
+	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
+	/* loop count is to avoid the lock-up */
+	for (i = 0; i < 1000; i++) {
+		if ((mcasp_get_reg(regs) & val) == val)
+			break;
+	}
+	if (i == 1000 && ((mcasp_get_reg(regs) & val) != val))
+		printk(KERN_ERR "GBLCTL write error\n");
+}
+
+static int davinci_i2s_startup(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	cpu_dai->dma_data = dev->dma_params[substream->stream];
+	return 0;
+}
+
+static void mcasp_start_rx(struct davinci_audio_dev *dev)
+{
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+}
+
+static void mcasp_start_tx(struct davinci_audio_dev *dev)
+{
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
+	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+}
+
+static void davinci_mcasp_start(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		mcasp_start_tx(dev);
+	else
+		mcasp_start_rx(dev);
+}
+
+static void mcasp_stop_rx(struct davinci_audio_dev *dev)
+{
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, 0);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+}
+
+static void mcasp_stop_tx(struct davinci_audio_dev *dev)
+{
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+}
+
+static void davinci_mcasp_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		mcasp_stop_tx(dev);
+	else
+		mcasp_stop_rx(dev);
+}
+
+static int davinci_i2s_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+					 unsigned int fmt)
+{
+	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	void __iomem *base = dev->base;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* codec is clock and frame slave */
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x7 << 26));
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* codec is clock and frame master */
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG, (0x3f << 26));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int davinci_config_channel_size(struct snd_pcm_substream *substream,
+				       int channel_size)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+	u32 fmt = 0;
+
+	switch (channel_size) {
+	case DAVINCI_AUDIO_WORD_8:
+		fmt = 0x03;
+		break;
+
+	case DAVINCI_AUDIO_WORD_12:
+		fmt = 0x05;
+		break;
+
+	case DAVINCI_AUDIO_WORD_16:
+		fmt = 0x07;
+		break;
+
+	case DAVINCI_AUDIO_WORD_20:
+		fmt = 0x09;
+		break;
+
+	case DAVINCI_AUDIO_WORD_24:
+		fmt = 0x0B;
+		break;
+
+	case DAVINCI_AUDIO_WORD_28:
+		fmt = 0x0D;
+		break;
+
+	case DAVINCI_AUDIO_WORD_32:
+		fmt = 0x0F;
+		break;
+
+	default:
+		return -1;
+	}
+
+	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+					RXSSZ(fmt), RXSSZ(0x0F));
+	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+					TXSSZ(fmt), TXSSZ(0x0F));
+	return 0;
+}
+
+static void davinci_hw_common_param(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+	int i;
+
+	/* Default configuration */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
+
+	/* All PINS as McASP */
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG,
+				TXDATADMADIS);
+	} else {
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_REVTCTL_REG,
+				RXDATADMADIS);
+	}
+
+	for (i = 0; i < dev->num_serializer; i++) {
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
+			       dev->serial_dir[i]);
+		if (dev->serial_dir[i] == TX_MODE)
+			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+				       AXR(i));
+		else if (dev->serial_dir[i] == RX_MODE)
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+				       AXR(i));
+	}
+}
+
+static void davinci_hw_param(struct snd_pcm_substream *substream)
+{
+	int i, active_slots;
+	u32 mask = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+
+	active_slots = (dev->tdm_slots > 31) ? 32 : dev->tdm_slots;
+	for (i = 0; i < active_slots; i++)
+		mask |= (1 << i);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* bit stream is MSB first  with no delay */
+		/* DSP_B mode */
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
+				AHCLKXE);
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, mask);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
+
+		if ((dev->tdm_slots >= 2) || (dev->tdm_slots <= 32))
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
+				       FSXMOD(dev->tdm_slots), FSXMOD(0x1FF));
+		else
+			printk(KERN_ERR "playback tdm slot %d not supported\n",
+				dev->tdm_slots);
+
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+
+	} else {
+		/* bit stream is MSB first with no delay */
+		/* DSP_B mode */
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG,
+				AHCLKRE);
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXTDM_REG, mask);
+
+		if ((dev->tdm_slots >= 2) || (dev->tdm_slots <= 32))
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG,
+				       FSRMOD(dev->tdm_slots), FSRMOD(0x1FF));
+		else
+			printk(KERN_ERR "capture tdm slot %d not supported\n",
+				dev->tdm_slots);
+
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+	}
+}
+
+/* S/PDIF */
+static void davinci_hw_dit_param(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+
+	/* Set the PDIR for Serialiser as output */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AFSX);
+
+	/* TXMASK for 24 bits */
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
+
+	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
+	   and LSB first */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+		       TXROT(6) | TXSSZ(15));
+
+	/* Set TX frame synch : DIT Mode, 1 bit width, internal, rising edge */
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
+		      AFSXE | FSXMOD(0x180));
+
+	/* Set the TX tdm : for all the slots */
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, 0xFFFFFFFF);
+
+	/* Set the TX clock controls : div = 1 and internal */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG,
+		       ACLKXE | TX_ASYNC);
+
+	mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
+
+	/* Only 44100 and 48000 are valid, both have the same setting */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
+		       AHCLKXDIV(3));
+
+	/* Enable the DIT */
+	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXDITCTL_REG, DITEN);
+}
+
+static int davinci_i2s_mcasp_hw_params(
+					struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	struct davinci_pcm_dma_params *dma_params =
+					dev->dma_params[substream->stream];
+	int word_length;
+
+	davinci_hw_common_param(substream);
+
+	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
+		davinci_hw_dit_param(substream);
+	else
+		davinci_hw_param(substream);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		dma_params->data_type = 1;
+		word_length = DAVINCI_AUDIO_WORD_8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dma_params->data_type = 2;
+		word_length = DAVINCI_AUDIO_WORD_16;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dma_params->data_type = 4;
+		word_length = DAVINCI_AUDIO_WORD_32;
+		break;
+	default:
+		printk(KERN_WARNING "davinci-i2s: unsupported PCM format");
+		return -EINVAL;
+	}
+	davinci_config_channel_size(substream, word_length);
+
+	return 0;
+}
+
+static int davinci_i2s_mcasp_trigger(struct snd_pcm_substream *substream,
+				     int cmd, struct snd_soc_dai *cpu_dai)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		davinci_mcasp_start(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		davinci_mcasp_stop(substream);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
+	.startup 	= davinci_i2s_startup,
+	.trigger	= davinci_i2s_mcasp_trigger,
+	.hw_params	= davinci_i2s_mcasp_hw_params,
+	.set_fmt	= davinci_i2s_mcasp_set_dai_fmt,
+
+};
+
+struct snd_soc_dai davinci_iis_mcasp_dai[] = {
+	{
+		.name 		= "davinci-i2s",
+		.id 		= 0,
+		.playback	= {
+			.channels_min	= 1,
+			.channels_max 	= 384,
+			.rates 			= DAVINCI_I2S_RATES,
+			.formats 		= SNDRV_PCM_FMTBIT_S8 |
+						SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S32_LE,
+
+		},
+		.capture 	= {
+			.channels_min 	= 1,
+			.channels_max 	= 384,
+			.rates 			= DAVINCI_I2S_RATES,
+			.formats		= SNDRV_PCM_FMTBIT_S8 |
+						SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops 				= &davinci_i2s_dai_ops,
+
+	},
+	{
+		.name 		= "davinci-dit",
+		.id 		= 1,
+		.playback 	= {
+			.channels_min	= 1,
+			.channels_max	= 384,
+			.rates 			= DAVINCI_I2S_RATES,
+			.formats 		= SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops 				= &davinci_i2s_dai_ops,
+	},
+
+};
+EXPORT_SYMBOL_GPL(davinci_iis_mcasp_dai);
+
+static int davinci_i2s_mcasp_probe(struct platform_device *pdev)
+{
+	int tmp, link_cnt, num_links = 2;
+	int count = 0;
+	struct davinci_audio_dev *dev;
+	struct resource *mem, *ioarea;
+	struct evm_snd_platform_data *parray = pdev->dev.platform_data;
+	struct evm_snd_platform_data *pdata;
+	struct davinci_pcm_dma_params *dma_data;
+	int ret = 0;
+
+	dev = kzalloc(sizeof(struct davinci_audio_dev) * num_links,
+					  GFP_KERNEL);
+	if (!dev)
+		return	-ENOMEM;
+
+	dma_data = kzalloc(sizeof(struct davinci_pcm_dma_params) *
+				(num_links << 1), GFP_KERNEL);
+
+	if (!dma_data) {
+		ret = -ENOMEM;
+		goto err_release_dev;
+	}
+
+	for (link_cnt = 0; link_cnt < num_links; link_cnt++) {
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, link_cnt);
+		if (!mem) {
+			dev_err(&pdev->dev, "no mem resource?\n");
+			ret = -ENODEV;
+			goto err_release_data;
+		}
+		ioarea = request_mem_region(mem->start,
+				(mem->end - mem->start) + 1, pdev->name);
+		if (!ioarea) {
+			dev_err(&pdev->dev, "Audio region already claimed\n");
+			ret = -EBUSY;
+			goto err_release_data;
+		}
+
+		pdata = &parray[link_cnt];
+		dev[link_cnt].clk = clk_get(&pdev->dev, pdata->clk_name);
+
+		if (IS_ERR(dev[link_cnt].clk)) {
+			ret = -ENODEV;
+			goto err_release_region;
+		}
+		clk_enable(dev[link_cnt].clk);
+
+		dev[link_cnt].base = (void __iomem *)IO_ADDRESS(mem->start);
+		dev[link_cnt].op_mode = pdata->op_mode;
+		dev[link_cnt].tdm_slots = pdata->tdm_slots;
+		dev[link_cnt].num_serializer = pdata->num_serializer;
+		dev[link_cnt].serial_dir = pdata->serial_dir;
+		dev[link_cnt].codec_fmt = pdata->codec_fmt;
+
+
+		dma_data[count].name = "I2S PCM Stereo out";
+		dma_data[count].channel = pdata->tx_dma_ch;
+		dma_data[count].eventq_no = pdata->eventq_no;
+		dma_data[count].dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
+					   io_v2p(dev[link_cnt].base));
+		dev[link_cnt].dma_params[SNDRV_PCM_STREAM_PLAYBACK] =
+				&dma_data[count];
+
+
+		count++;
+		dma_data[count].name = "I2S PCM Stereo in";
+		dma_data[count].channel = pdata->rx_dma_ch;
+		dma_data[count].eventq_no = pdata->eventq_no;
+		dma_data[count].dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
+					    io_v2p(dev[link_cnt].base));
+		dev[link_cnt].dma_params[SNDRV_PCM_STREAM_CAPTURE] =
+				&dma_data[count];
+		count++;
+		davinci_iis_mcasp_dai[link_cnt].private_data = &dev[link_cnt];
+	}
+	ret = snd_soc_register_dais(davinci_iis_mcasp_dai,
+				ARRAY_SIZE(davinci_iis_mcasp_dai));
+	if (ret != 0)
+		goto err_release_region;
+	return 0;
+
+err_release_region:
+	for (tmp = link_cnt; tmp >= 0; tmp--) {
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, tmp);
+		release_mem_region(mem->start,
+				   (mem->end - mem->start) + 1);
+	}
+err_release_data:
+	kfree(dma_data);
+err_release_dev:
+	kfree(dev);
+
+	return ret;
+}
+
+static int davinci_i2s_mcasp_remove(struct platform_device *pdev)
+{
+	int i, num_links = 2;
+	struct davinci_audio_dev *dev;
+	struct resource *mem;
+	struct davinci_pcm_dma_params *dma_data;
+
+	snd_soc_unregister_dais(davinci_iis_mcasp_dai,
+					ARRAY_SIZE(davinci_iis_mcasp_dai));
+
+	for (i = 0; i < num_links; i++) {
+		dev = davinci_iis_mcasp_dai[i].private_data;
+		clk_disable(dev->clk);
+		clk_put(dev->clk);
+		dev->clk = NULL;
+
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	}
+
+	dev = davinci_iis_mcasp_dai[0].private_data;
+	dma_data = dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
+	kfree(dma_data);
+	kfree(dev);
+	return 0;
+}
+
+static struct platform_driver davinci_asoc_driver = {
+	.probe		= davinci_i2s_mcasp_probe,
+	.remove		= davinci_i2s_mcasp_remove,
+	.driver		= {
+		.name	= "davinci-asoc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init davinci_i2s_mcasp_init(void)
+{
+
+	return platform_driver_register(&davinci_asoc_driver);
+
+}
+module_init(davinci_i2s_mcasp_init);
+
+static void __exit davinci_i2s_mcasp_exit(void)
+{
+
+	platform_driver_unregister(&davinci_asoc_driver);
+
+}
+module_exit(davinci_i2s_mcasp_exit);
+
+
+
+MODULE_AUTHOR("Steve Chen");
+MODULE_DESCRIPTION("TI DAVINCI I2S (McASP) SoC Interface");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/davinci/davinci-i2s-mcasp.h b/sound/soc/davinci/davinci-i2s-mcasp.h
new file mode 100644
index 0000000..6469e7d
--- /dev/null
+++ b/sound/soc/davinci/davinci-i2s-mcasp.h
@@ -0,0 +1,56 @@
+/*
+ * ALSA SoC I2S (McASP) Audio Layer for TI DAVINCI processor
+ *
+ * Author: Nirmal Pandey <n-pandey@ti.com>,
+ *         Suresh Rajashekara <suresh.r@ti.com>
+ *         Steve Chen, <schen@.mvista.com>
+ *
+ * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2008  Texas Instruments, India
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#ifndef DAVINCI_I2S_MCASP_H
+#define DAVINCI_I2S_MCASP_H
+
+#include <linux/io.h>
+#include <mach/asp.h>
+#include "davinci-pcm.h"
+
+extern struct snd_soc_dai davinci_iis_mcasp_dai[];
+extern struct snd_soc_dai davinci_dit_mcasp_dai;
+
+
+#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
+
+enum {
+	DAVINCI_AUDIO_WORD_8 = 0,
+	DAVINCI_AUDIO_WORD_12,
+	DAVINCI_AUDIO_WORD_16,
+	DAVINCI_AUDIO_WORD_20,
+	DAVINCI_AUDIO_WORD_24,
+	DAVINCI_AUDIO_WORD_32,
+	DAVINCI_AUDIO_WORD_28,  /* This is only valid for McASP */
+};
+
+struct davinci_audio_dev {
+	void __iomem *base;
+	int sample_rate;
+	struct clk *clk;
+	struct davinci_pcm_dma_params *dma_params[2];
+	unsigned int codec_fmt;
+
+	/* McASP specific data */
+	int	tdm_slots;
+	u8	op_mode;
+	u8	num_serializer;
+	u8	*serial_dir;
+};
+
+
+
+#endif	/* DAVINCI_I2S_MCASP_H */
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 62cb4eb..3cbe281 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -12,17 +12,18 @@
 #ifndef _DAVINCI_PCM_H
 #define _DAVINCI_PCM_H
 
+#include <mach/edma.h>
+#include <mach/asp.h>
+
+
 struct davinci_pcm_dma_params {
-	char *name;		/* stream identifier */
-	int channel;		/* sync dma channel ID */
-	dma_addr_t dma_addr;	/* device physical address for DMA */
-	unsigned int data_type;	/* xfer data type */
+	char *name;			/* stream identifier */
+	int channel;			/* sync dma channel ID */
+	dma_addr_t dma_addr;		/* device physical address for DMA */
+	unsigned int data_type;		/* xfer data type */
+	enum dma_event_q eventq_no;	/* event queue number */
 };
 
-struct evm_snd_platform_data {
-	int tx_dma_ch;
-	int rx_dma_ch;
-};
 
 extern struct snd_soc_platform davinci_soc_platform;
 
-- 
1.5.6
