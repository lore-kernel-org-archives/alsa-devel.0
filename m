From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/5] ALSA: hda: move common hda controller
	register defines up
Date: Wed,  1 Apr 2015 17:00:59 +0530
Message-ID: <1427887862-29054-3-git-send-email-vinod.koul@intel.com>
References: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 25FA62651D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:35:31 +0200 (CEST)
In-Reply-To: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The HDA register defines would be accessed by both existing codes as well as
new code, so move it up to include/sound
No code change, fixed few alignment though

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_registers.h  |  168 ++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  164 +--------------------------------------
 2 files changed, 169 insertions(+), 163 deletions(-)
 create mode 100644 include/sound/hda_registers.h

diff --git a/include/sound/hda_registers.h b/include/sound/hda_registers.h
new file mode 100644
index 000000000000..6afb26191f4d
--- /dev/null
+++ b/include/sound/hda_registers.h
@@ -0,0 +1,168 @@
+#ifndef __SOUND_HDA_REGISTERS_H
+#define __SOUND_HDA_REGISTERS_H
+
+/*
+ * registers
+ */
+#define AZX_REG_GCAP			0x00
+#define AZX_GCAP_64OK			(1 << 0)   /* 64bit address support */
+#define AZX_GCAP_NSDO			(3 << 1)   /* # of serial data out signals */
+#define AZX_GCAP_BSS			(31 << 3)  /* # of bidirectional streams */
+#define AZX_GCAP_ISS			(15 << 8)  /* # of input streams */
+#define AZX_GCAP_OSS			(15 << 12) /* # of output streams */
+#define AZX_REG_VMIN			0x02
+#define AZX_REG_VMAJ			0x03
+#define AZX_REG_OUTPAY			0x04
+#define AZX_REG_INPAY			0x06
+#define AZX_REG_GCTL			0x08
+#define AZX_GCTL_RESET			(1 << 0)   /* controller reset */
+#define AZX_GCTL_FCNTRL			(1 << 1)   /* flush control */
+#define AZX_GCTL_UNSOL			(1 << 8)   /* accept unsol. response enable */
+#define AZX_REG_WAKEEN			0x0c
+#define AZX_REG_STATESTS		0x0e
+#define AZX_REG_GSTS			0x10
+#define AZX_GSTS_FSTS			(1 << 1)   /* flush status */
+#define AZX_REG_INTCTL			0x20
+#define AZX_REG_INTSTS			0x24
+#define AZX_REG_WALLCLK			0x30	/* 24Mhz source */
+#define AZX_REG_OLD_SSYNC		0x34	/* SSYNC for old ICH */
+#define AZX_REG_SSYNC			0x38
+#define AZX_REG_CORBLBASE		0x40
+#define AZX_REG_CORBUBASE		0x44
+#define AZX_REG_CORBWP			0x48
+#define AZX_REG_CORBRP			0x4a
+#define AZX_CORBRP_RST			(1 << 15)  /* read pointer reset */
+#define AZX_REG_CORBCTL			0x4c
+#define AZX_CORBCTL_RUN			(1 << 1)   /* enable DMA */
+#define AZX_CORBCTL_CMEIE		(1 << 0)   /* enable memory error irq */
+#define AZX_REG_CORBSTS			0x4d
+#define AZX_CORBSTS_CMEI		(1 << 0)   /* memory error indication */
+#define AZX_REG_CORBSIZE		0x4e
+
+#define AZX_REG_RIRBLBASE		0x50
+#define AZX_REG_RIRBUBASE		0x54
+#define AZX_REG_RIRBWP			0x58
+#define AZX_RIRBWP_RST			(1 << 15)  /* write pointer reset */
+#define AZX_REG_RINTCNT			0x5a
+#define AZX_REG_RIRBCTL			0x5c
+#define AZX_RBCTL_IRQ_EN		(1 << 0)   /* enable IRQ */
+#define AZX_RBCTL_DMA_EN		(1 << 1)   /* enable DMA */
+#define AZX_RBCTL_OVERRUN_EN		(1 << 2)   /* enable overrun irq */
+#define AZX_REG_RIRBSTS			0x5d
+#define AZX_RBSTS_IRQ			(1 << 0)   /* response irq */
+#define AZX_RBSTS_OVERRUN		(1 << 2)   /* overrun irq */
+#define AZX_REG_RIRBSIZE		0x5e
+
+#define AZX_REG_IC			0x60
+#define AZX_REG_IR			0x64
+#define AZX_REG_IRS			0x68
+#define AZX_IRS_VALID			(1<<1)
+#define AZX_IRS_BUSY			(1<<0)
+
+#define AZX_REG_DPLBASE			0x70
+#define AZX_REG_DPUBASE			0x74
+#define AZX_DPLBASE_ENABLE		0x1	/* Enable position buffer */
+
+/* SD offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
+enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
+
+/* stream register offsets from stream base */
+#define AZX_REG_SD_CTL			0x00
+#define AZX_REG_SD_STS			0x03
+#define AZX_REG_SD_LPIB			0x04
+#define AZX_REG_SD_CBL			0x08
+#define AZX_REG_SD_LVI			0x0c
+#define AZX_REG_SD_FIFOW		0x0e
+#define AZX_REG_SD_FIFOSIZE		0x10
+#define AZX_REG_SD_FORMAT		0x12
+#define AZX_REG_SD_BDLPL		0x18
+#define AZX_REG_SD_BDLPU		0x1c
+
+/* PCI space */
+#define AZX_PCIREG_TCSEL		0x44
+
+/*
+ * other constants
+ */
+
+/* max number of fragments - we may use more if allocating more pages for BDL */
+#define BDL_SIZE		4096
+#define AZX_MAX_BDL_ENTRIES	(BDL_SIZE / 16)
+#define AZX_MAX_FRAG		32
+/* max buffer size - no h/w limit, you can increase as you like */
+#define AZX_MAX_BUF_SIZE	(1024*1024*1024)
+
+/* RIRB int mask: overrun[2], response[0] */
+#define RIRB_INT_RESPONSE	0x01
+#define RIRB_INT_OVERRUN	0x04
+#define RIRB_INT_MASK		0x05
+
+/* STATESTS int mask: S3,SD2,SD1,SD0 */
+#define AZX_DEFAULT_CODECS	4
+#define STATESTS_INT_MASK	((1 << HDA_MAX_CODECS) - 1)
+
+/* SD_CTL bits */
+#define SD_CTL_STREAM_RESET	0x01	/* stream reset bit */
+#define SD_CTL_DMA_START	0x02	/* stream DMA start bit */
+#define SD_CTL_STRIPE		(3 << 16)	/* stripe control */
+#define SD_CTL_TRAFFIC_PRIO	(1 << 18)	/* traffic priority */
+#define SD_CTL_DIR		(1 << 19)	/* bi-directional stream */
+#define SD_CTL_STREAM_TAG_MASK	(0xf << 20)
+#define SD_CTL_STREAM_TAG_SHIFT	20
+
+/* SD_CTL and SD_STS */
+#define SD_INT_DESC_ERR		0x10	/* descriptor error interrupt */
+#define SD_INT_FIFO_ERR		0x08	/* FIFO error interrupt */
+#define SD_INT_COMPLETE		0x04	/* completion interrupt */
+#define SD_INT_MASK		(SD_INT_DESC_ERR|SD_INT_FIFO_ERR|\
+				 SD_INT_COMPLETE)
+
+/* SD_STS */
+#define SD_STS_FIFO_READY	0x20	/* FIFO ready */
+
+/* INTCTL and INTSTS */
+#define AZX_INT_ALL_STREAM	0xff	   /* all stream interrupts */
+#define AZX_INT_CTRL_EN		0x40000000 /* controller interrupt enable bit */
+#define AZX_INT_GLOBAL_EN	0x80000000 /* global interrupt enable bit */
+
+/* below are so far hardcoded - should read registers in future */
+#define AZX_MAX_CORB_ENTRIES	256
+#define AZX_MAX_RIRB_ENTRIES	256
+
+/* HD Audio class code */
+#define PCI_CLASS_MULTIMEDIA_HD_AUDIO	0x0403
+
+/*
+ * macros for easy use
+ */
+
+#define azx_writel(chip, reg, value) \
+	((chip)->ops->reg_writel(value, (chip)->remap_addr + AZX_REG_##reg))
+#define azx_readl(chip, reg) \
+	((chip)->ops->reg_readl((chip)->remap_addr + AZX_REG_##reg))
+#define azx_writew(chip, reg, value) \
+	((chip)->ops->reg_writew(value, (chip)->remap_addr + AZX_REG_##reg))
+#define azx_readw(chip, reg) \
+	((chip)->ops->reg_readw((chip)->remap_addr + AZX_REG_##reg))
+#define azx_writeb(chip, reg, value) \
+	((chip)->ops->reg_writeb(value, (chip)->remap_addr + AZX_REG_##reg))
+#define azx_readb(chip, reg) \
+	((chip)->ops->reg_readb((chip)->remap_addr + AZX_REG_##reg))
+
+#define azx_sd_writel(chip, dev, reg, value) \
+	((chip)->ops->reg_writel(value, (dev)->sd_addr + AZX_REG_##reg))
+#define azx_sd_readl(chip, dev, reg) \
+	((chip)->ops->reg_readl((dev)->sd_addr + AZX_REG_##reg))
+#define azx_sd_writew(chip, dev, reg, value) \
+	((chip)->ops->reg_writew(value, (dev)->sd_addr + AZX_REG_##reg))
+#define azx_sd_readw(chip, dev, reg) \
+	((chip)->ops->reg_readw((dev)->sd_addr + AZX_REG_##reg))
+#define azx_sd_writeb(chip, dev, reg, value) \
+	((chip)->ops->reg_writeb(value, (dev)->sd_addr + AZX_REG_##reg))
+#define azx_sd_readb(chip, dev, reg) \
+	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
+
+#define azx_has_pm_runtime(chip) \
+	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
+
+#endif
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 2aa75e34a718..608e31597c22 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -20,136 +20,9 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
+#include <sound/hda_registers.h>
 #include "hda_codec.h"
 
-/*
- * registers
- */
-#define AZX_REG_GCAP			0x00
-#define   AZX_GCAP_64OK		(1 << 0)   /* 64bit address support */
-#define   AZX_GCAP_NSDO		(3 << 1)   /* # of serial data out signals */
-#define   AZX_GCAP_BSS		(31 << 3)  /* # of bidirectional streams */
-#define   AZX_GCAP_ISS		(15 << 8)  /* # of input streams */
-#define   AZX_GCAP_OSS		(15 << 12) /* # of output streams */
-#define AZX_REG_VMIN			0x02
-#define AZX_REG_VMAJ			0x03
-#define AZX_REG_OUTPAY			0x04
-#define AZX_REG_INPAY			0x06
-#define AZX_REG_GCTL			0x08
-#define   AZX_GCTL_RESET	(1 << 0)   /* controller reset */
-#define   AZX_GCTL_FCNTRL	(1 << 1)   /* flush control */
-#define   AZX_GCTL_UNSOL	(1 << 8)   /* accept unsol. response enable */
-#define AZX_REG_WAKEEN			0x0c
-#define AZX_REG_STATESTS		0x0e
-#define AZX_REG_GSTS			0x10
-#define   AZX_GSTS_FSTS		(1 << 1)   /* flush status */
-#define AZX_REG_INTCTL			0x20
-#define AZX_REG_INTSTS			0x24
-#define AZX_REG_WALLCLK			0x30	/* 24Mhz source */
-#define AZX_REG_OLD_SSYNC		0x34	/* SSYNC for old ICH */
-#define AZX_REG_SSYNC			0x38
-#define AZX_REG_CORBLBASE		0x40
-#define AZX_REG_CORBUBASE		0x44
-#define AZX_REG_CORBWP			0x48
-#define AZX_REG_CORBRP			0x4a
-#define   AZX_CORBRP_RST	(1 << 15)  /* read pointer reset */
-#define AZX_REG_CORBCTL			0x4c
-#define   AZX_CORBCTL_RUN	(1 << 1)   /* enable DMA */
-#define   AZX_CORBCTL_CMEIE	(1 << 0)   /* enable memory error irq */
-#define AZX_REG_CORBSTS			0x4d
-#define   AZX_CORBSTS_CMEI	(1 << 0)   /* memory error indication */
-#define AZX_REG_CORBSIZE		0x4e
-
-#define AZX_REG_RIRBLBASE		0x50
-#define AZX_REG_RIRBUBASE		0x54
-#define AZX_REG_RIRBWP			0x58
-#define   AZX_RIRBWP_RST	(1 << 15)  /* write pointer reset */
-#define AZX_REG_RINTCNT			0x5a
-#define AZX_REG_RIRBCTL			0x5c
-#define   AZX_RBCTL_IRQ_EN	(1 << 0)   /* enable IRQ */
-#define   AZX_RBCTL_DMA_EN	(1 << 1)   /* enable DMA */
-#define   AZX_RBCTL_OVERRUN_EN	(1 << 2)   /* enable overrun irq */
-#define AZX_REG_RIRBSTS			0x5d
-#define   AZX_RBSTS_IRQ		(1 << 0)   /* response irq */
-#define   AZX_RBSTS_OVERRUN	(1 << 2)   /* overrun irq */
-#define AZX_REG_RIRBSIZE		0x5e
-
-#define AZX_REG_IC			0x60
-#define AZX_REG_IR			0x64
-#define AZX_REG_IRS			0x68
-#define   AZX_IRS_VALID		(1<<1)
-#define   AZX_IRS_BUSY		(1<<0)
-
-#define AZX_REG_DPLBASE			0x70
-#define AZX_REG_DPUBASE			0x74
-#define   AZX_DPLBASE_ENABLE	0x1	/* Enable position buffer */
-
-/* SD offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
-enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
-
-/* stream register offsets from stream base */
-#define AZX_REG_SD_CTL			0x00
-#define AZX_REG_SD_STS			0x03
-#define AZX_REG_SD_LPIB			0x04
-#define AZX_REG_SD_CBL			0x08
-#define AZX_REG_SD_LVI			0x0c
-#define AZX_REG_SD_FIFOW		0x0e
-#define AZX_REG_SD_FIFOSIZE		0x10
-#define AZX_REG_SD_FORMAT		0x12
-#define AZX_REG_SD_BDLPL		0x18
-#define AZX_REG_SD_BDLPU		0x1c
-
-/* PCI space */
-#define AZX_PCIREG_TCSEL		0x44
-
-/*
- * other constants
- */
-
-/* max number of fragments - we may use more if allocating more pages for BDL */
-#define BDL_SIZE		4096
-#define AZX_MAX_BDL_ENTRIES	(BDL_SIZE / 16)
-#define AZX_MAX_FRAG		32
-/* max buffer size - no h/w limit, you can increase as you like */
-#define AZX_MAX_BUF_SIZE	(1024*1024*1024)
-
-/* RIRB int mask: overrun[2], response[0] */
-#define RIRB_INT_RESPONSE	0x01
-#define RIRB_INT_OVERRUN	0x04
-#define RIRB_INT_MASK		0x05
-
-/* STATESTS int mask: S3,SD2,SD1,SD0 */
-#define AZX_DEFAULT_CODECS	4
-#define STATESTS_INT_MASK	((1 << HDA_MAX_CODECS) - 1)
-
-/* SD_CTL bits */
-#define SD_CTL_STREAM_RESET	0x01	/* stream reset bit */
-#define SD_CTL_DMA_START	0x02	/* stream DMA start bit */
-#define SD_CTL_STRIPE		(3 << 16)	/* stripe control */
-#define SD_CTL_TRAFFIC_PRIO	(1 << 18)	/* traffic priority */
-#define SD_CTL_DIR		(1 << 19)	/* bi-directional stream */
-#define SD_CTL_STREAM_TAG_MASK	(0xf << 20)
-#define SD_CTL_STREAM_TAG_SHIFT	20
-
-/* SD_CTL and SD_STS */
-#define SD_INT_DESC_ERR		0x10	/* descriptor error interrupt */
-#define SD_INT_FIFO_ERR		0x08	/* FIFO error interrupt */
-#define SD_INT_COMPLETE		0x04	/* completion interrupt */
-#define SD_INT_MASK		(SD_INT_DESC_ERR|SD_INT_FIFO_ERR|\
-				 SD_INT_COMPLETE)
-
-/* SD_STS */
-#define SD_STS_FIFO_READY	0x20	/* FIFO ready */
-
-/* INTCTL and INTSTS */
-#define AZX_INT_ALL_STREAM	0xff	   /* all stream interrupts */
-#define AZX_INT_CTRL_EN	0x40000000 /* controller interrupt enable bit */
-#define AZX_INT_GLOBAL_EN	0x80000000 /* global interrupt enable bit */
-
-/* below are so far hardcoded - should read registers in future */
-#define AZX_MAX_CORB_ENTRIES	256
-#define AZX_MAX_RIRB_ENTRIES	256
-
 /* driver quirks (capabilities) */
 /* bits 0-7 are used for indicating driver type */
 #define AZX_DCAPS_NO_TCSEL	(1 << 8)	/* No Intel TCSEL bit */
@@ -182,9 +55,6 @@ enum {
 	AZX_SNOOP_TYPE_NVIDIA,
 };
 
-/* HD Audio class code */
-#define PCI_CLASS_MULTIMEDIA_HD_AUDIO	0x0403
-
 struct azx_dev {
 	struct snd_dma_buffer bdl; /* BDL buffer */
 	u32 *posbuf;		/* position buffer pointer */
@@ -372,38 +242,6 @@ struct azx {
 #define azx_snoop(chip)		true
 #endif
 
-/*
- * macros for easy use
- */
-
-#define azx_writel(chip, reg, value) \
-	((chip)->ops->reg_writel(value, (chip)->remap_addr + AZX_REG_##reg))
-#define azx_readl(chip, reg) \
-	((chip)->ops->reg_readl((chip)->remap_addr + AZX_REG_##reg))
-#define azx_writew(chip, reg, value) \
-	((chip)->ops->reg_writew(value, (chip)->remap_addr + AZX_REG_##reg))
-#define azx_readw(chip, reg) \
-	((chip)->ops->reg_readw((chip)->remap_addr + AZX_REG_##reg))
-#define azx_writeb(chip, reg, value) \
-	((chip)->ops->reg_writeb(value, (chip)->remap_addr + AZX_REG_##reg))
-#define azx_readb(chip, reg) \
-	((chip)->ops->reg_readb((chip)->remap_addr + AZX_REG_##reg))
-
-#define azx_sd_writel(chip, dev, reg, value) \
-	((chip)->ops->reg_writel(value, (dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_readl(chip, dev, reg) \
-	((chip)->ops->reg_readl((dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_writew(chip, dev, reg, value) \
-	((chip)->ops->reg_writew(value, (dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_readw(chip, dev, reg) \
-	((chip)->ops->reg_readw((dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_writeb(chip, dev, reg, value) \
-	((chip)->ops->reg_writeb(value, (dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_readb(chip, dev, reg) \
-	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
-
-#define azx_has_pm_runtime(chip) \
-	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
 
 /* PCM setup */
 static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
-- 
1.7.9.5
