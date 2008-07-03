From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: ASoC: Au12x0/Au1550 PSC Audio support.
Date: Thu, 3 Jul 2008 12:09:25 +0200
Message-ID: <20080703100925.GA25364@roarinelk.homelinux.net>
References: <20080703073309.GA24116@roarinelk.homelinux.net>
	<1215077359.4882.115.camel@localhost.localdomain>
	<20080703095344.GA24177@roarinelk.homelinux.net>
	<1215078947.4882.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id A2DB82486A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 12:09:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215078947.4882.117.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 03, 2008 at 10:55:47AM +0100, Liam Girdwood wrote:
> On Thu, 2008-07-03 at 11:53 +0200, Manuel Lauss wrote:
> > On Thu, Jul 03, 2008 at 10:29:19AM +0100, Liam Girdwood wrote:
> > > 
> > > Btw, any plans to fix or remove some of the 'Fixmes' in your other ASoC
> > > code. We could upstream the Au1x000 stuff after a little cleanup and
> > > resolution of the fixmes.
> > 
> > I've updated the code considerably since the last year.  It's still ASoC v1,
> > and lots of the FIXMEs in the ac97 part won't disappear until it's moved to
> > ASoC v2 (I hope, didn't investigate).
> > 
> > If you're interested I can send you a patch (against current linus' HEAD)
> > with the newest, most awesome au1xxx psc asoc code ;-)
> > 
> 
> Yes please.

Here you go, apply on top of linus' head + the ac97 PM patch.

--- 

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Audio for Au12x0/Au1550 PSCs in AC97 and I2S mode, for ASoC v1 framework.

- DBDMA, AC97 and I2S drivers
- sample AC97 machine code (Db1200)

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 include/asm-mips/mach-au1x00/au1xxx_psc.h |   51 ++---
 sound/soc/Kconfig                         |    1 +
 sound/soc/Makefile                        |    2 +-
 sound/soc/au1x/Kconfig                    |   36 +++
 sound/soc/au1x/Makefile                   |   13 +
 sound/soc/au1x/dbdma2.c                   |  435 +++++++++++++++++++++++++++++
 sound/soc/au1x/psc-ac97.c                 |  378 +++++++++++++++++++++++++
 sound/soc/au1x/psc-i2s.c                  |  426 ++++++++++++++++++++++++++++
 sound/soc/au1x/psc.h                      |   48 ++++
 sound/soc/au1x/sample-ac97.c              |  144 ++++++++++
 10 files changed, 1499 insertions(+), 35 deletions(-)
 create mode 100644 sound/soc/au1x/Kconfig
 create mode 100644 sound/soc/au1x/Makefile
 create mode 100644 sound/soc/au1x/dbdma2.c
 create mode 100644 sound/soc/au1x/psc-ac97.c
 create mode 100644 sound/soc/au1x/psc-i2s.c
 create mode 100644 sound/soc/au1x/psc.h
 create mode 100644 sound/soc/au1x/sample-ac97.c

diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
index dae4eca..912768d 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -69,29 +69,16 @@
 #define PSC_CTRL_ENABLE 	3
 
 /* AC97 Registers. */
-#define PSC_AC97CFG_OFFSET	0x00000008
-#define PSC_AC97MSK_OFFSET	0x0000000c
-#define PSC_AC97PCR_OFFSET	0x00000010
-#define PSC_AC97STAT_OFFSET	0x00000014
-#define PSC_AC97EVNT_OFFSET	0x00000018
-#define PSC_AC97TXRX_OFFSET	0x0000001c
-#define PSC_AC97CDC_OFFSET	0x00000020
-#define PSC_AC97RST_OFFSET	0x00000024
-#define PSC_AC97GPO_OFFSET	0x00000028
-#define PSC_AC97GPI_OFFSET	0x0000002c
-
-#define AC97_PSC_SEL		(AC97_PSC_BASE + PSC_SEL_OFFSET)
-#define AC97_PSC_CTRL		(AC97_PSC_BASE + PSC_CTRL_OFFSET)
-#define PSC_AC97CFG		(AC97_PSC_BASE + PSC_AC97CFG_OFFSET)
-#define PSC_AC97MSK		(AC97_PSC_BASE + PSC_AC97MSK_OFFSET)
-#define PSC_AC97PCR		(AC97_PSC_BASE + PSC_AC97PCR_OFFSET)
-#define PSC_AC97STAT		(AC97_PSC_BASE + PSC_AC97STAT_OFFSET)
-#define PSC_AC97EVNT		(AC97_PSC_BASE + PSC_AC97EVNT_OFFSET)
-#define PSC_AC97TXRX		(AC97_PSC_BASE + PSC_AC97TXRX_OFFSET)
-#define PSC_AC97CDC		(AC97_PSC_BASE + PSC_AC97CDC_OFFSET)
-#define PSC_AC97RST		(AC97_PSC_BASE + PSC_AC97RST_OFFSET)
-#define PSC_AC97GPO		(AC97_PSC_BASE + PSC_AC97GPO_OFFSET)
-#define PSC_AC97GPI		(AC97_PSC_BASE + PSC_AC97GPI_OFFSET)
+#define PSC_AC97CFG		0x00000008
+#define PSC_AC97MSK		0x0000000c
+#define PSC_AC97PCR		0x00000010
+#define PSC_AC97STAT		0x00000014
+#define PSC_AC97EVNT		0x00000018
+#define PSC_AC97TXRX		0x0000001c
+#define PSC_AC97CDC		0x00000020
+#define PSC_AC97RST		0x00000024
+#define PSC_AC97GPO		0x00000028
+#define PSC_AC97GPI		0x0000002c
 
 /* AC97 Config Register. */
 #define PSC_AC97CFG_RT_MASK	(3 << 30)
@@ -192,17 +179,13 @@
 #define PSC_AC97RST_SNC		(1 << 0)
 
 /* PSC in I2S Mode. */
-typedef struct	psc_i2s {
-	u32	psc_sel;
-	u32	psc_ctrl;
-	u32	psc_i2scfg;
-	u32	psc_i2smsk;
-	u32	psc_i2spcr;
-	u32	psc_i2sstat;
-	u32	psc_i2sevent;
-	u32	psc_i2stxrx;
-	u32	psc_i2sudf;
-} psc_i2s_t;
+#define PSC_I2SCFG		0x08
+#define PSC_I2SMASK		0x0C
+#define PSC_I2SPCR		0x10
+#define PSC_I2SSTAT		0x14
+#define PSC_I2SEVENT		0x18
+#define PSC_I2SRXTX		0x1C
+#define PSC_I2SUDF		0x20
 
 /* I2S Config Register. */
 #define PSC_I2SCFG_RT_MASK	(3 << 30)
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 18f28ac..caacf95 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -25,6 +25,7 @@ config SND_SOC
 
 # All the supported Soc's
 source "sound/soc/at91/Kconfig"
+source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/sh/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 782db21..5dafddd 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/ omap/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ au1x/ pxa/ s3c24xx/ sh/ fsl/ davinci/ omap/
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
new file mode 100644
index 0000000..8ef9015
--- /dev/null
+++ b/sound/soc/au1x/Kconfig
@@ -0,0 +1,36 @@
+menu "SoC Audio for the Alchemy/AMD/RMI Au1xxx"
+	depends on SOC_AU1200 || SOC_AU1550
+
+##
+## Au1200/Au1550 PSC + DBDMA
+##
+config SND_SOC_AU1XPSC
+	tristate "SoC Audio for Au1200/Au1250/Au1550"
+	depends on SND_SOC && (SOC_AU1200 || SOC_AU1550)
+	help
+	  This option enables support for the Programmable Serial
+	  Controllers in AC97 and I2S mode, and the Descriptor-Based DMA
+	  Controller (DBDMA) as found on the Au1200/Au1250/Au1550 SoC.
+
+config SND_SOC_AU1XPSC_I2S
+	tristate
+
+config SND_SOC_AU1XPSC_AC97
+	tristate
+	select AC97_BUS
+	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
+
+
+##
+## Boards
+##
+config SND_SOC_SAMPLE_PSC_AC97
+	tristate "Sample Au12x0/Au1550 PSC AC97 sound machine"
+	select SND_SOC_AU1XPSC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  This is a sample AC97 sound machine for use in Au12x0/Au1550
+	  based systems which have audio on PSC1 (e.g. Db1200 demoboard).
+
+endmenu
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
new file mode 100644
index 0000000..6c6950b
--- /dev/null
+++ b/sound/soc/au1x/Makefile
@@ -0,0 +1,13 @@
+# Au1200/Au1550 PSC audio
+snd-soc-au1xpsc-dbdma-objs := dbdma2.o
+snd-soc-au1xpsc-i2s-objs := psc-i2s.o
+snd-soc-au1xpsc-ac97-objs := psc-ac97.o
+
+obj-$(CONFIG_SND_SOC_AU1XPSC) += snd-soc-au1xpsc-dbdma.o
+obj-$(CONFIG_SND_SOC_AU1XPSC_I2S) += snd-soc-au1xpsc-i2s.o
+obj-$(CONFIG_SND_SOC_AU1XPSC_AC97) += snd-soc-au1xpsc-ac97.o
+
+# Boards
+snd-soc-sample-ac97-objs := sample-ac97.o
+
+obj-$(CONFIG_SND_SOC_SAMPLE_PSC_AC97) += snd-soc-sample-ac97.o
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
new file mode 100644
index 0000000..f924c54
--- /dev/null
+++ b/sound/soc/au1x/dbdma2.c
@@ -0,0 +1,435 @@
+/*
+ * Au12x0/Au1550 PSC ALSA ASoC audio support.
+ *
+ * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * DMA glue for Au1x-PSC audio.
+ *
+ * NOTE: all of these drivers can only work with a SINGLE instance
+ *	 of a PSC. Multiple independent audio devices are impossible
+ *	 with ASoC v1.
+ */
+
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+#include "psc.h"
+
+/*#define PCM_DEBUG*/
+
+#define MSG(x...)	printk(KERN_INFO "au1x-dbdma: " x)
+#ifdef PCM_DEBUG
+#define DBG		MSG
+#else
+#define DBG(x...)	do {} while (0)
+#endif
+
+struct au1xpsc_audio_dmadata {
+	/* DDMA control data */
+	unsigned int ddma_id;		/* DDMA direction ID for this PSC */
+	u32 ddma_chan;			/* DDMA context */
+
+	/* PCM context (for irq handlers) */
+	struct snd_pcm_substream *substream;
+	unsigned long curr_period;	/* current segment DDMA is working on */
+	unsigned long q_period;		/* queue period(s) */
+	unsigned long dma_area;		/* address of DMA area (phyical area) */
+	unsigned long dma_area_s;	/* start address of DMA area (phyical area) */
+	unsigned long pos;		/* current byte position being played */
+	unsigned long periods;		/* number of SG segments in total */
+	unsigned long period_bytes;	/* size in bytes of one SG segment */
+
+	/* runtime data */
+	int msbits;
+};
+
+static struct au1xpsc_audio_dmadata *au1xpsc_audio_pcmdma[2];
+
+/*
+ * These settings are somewhat okay, at least on my machine audio plays
+ * almost skip-free. Especially the 64kB buffer seems to help a LOT.
+ */
+#define AU1XPSC_PERIOD_MIN_BYTES	1024
+#define AU1XPSC_BUFFER_MIN_BYTES	65536
+
+#define AU1XPSC_PCM_FMTS		\
+	SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |		\
+	SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |	\
+	SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |	\
+	SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |	\
+	SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |	\
+	0
+
+/* PCM hardware DMA capabilities - platform specific */
+static const struct snd_pcm_hardware au1xpsc_pcm_hardware = {
+	.info		  = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+			    SNDRV_PCM_INFO_INTERLEAVED,
+	.formats	  = AU1XPSC_PCM_FMTS,
+	.period_bytes_min = AU1XPSC_PERIOD_MIN_BYTES,
+	.period_bytes_max = 4096 * 1024 - 1,
+	.periods_min	  = 2,
+	.periods_max	  = 4096,	/* 2 to as-much-as-you-like */
+	.buffer_bytes_max = 4096 * 1024 - 1,
+	.fifo_size	  = 16,		/* fifo entries of AC97/I2S PSC */
+};
+
+static void au1x_pcm_queue_tx(struct au1xpsc_audio_dmadata *cd)
+{
+	au1xxx_dbdma_put_source_flags(cd->ddma_chan,
+				(void *)phys_to_virt(cd->dma_area),
+				cd->period_bytes, DDMA_FLAGS_IE);
+
+	/* update next-to-queue period */
+	++cd->q_period;
+	cd->dma_area += cd->period_bytes;
+	if (cd->q_period >= cd->periods) {
+		cd->q_period = 0;
+		cd->dma_area = cd->dma_area_s;
+	}
+}
+
+static void au1x_pcm_queue_rx(struct au1xpsc_audio_dmadata *cd)
+{
+	au1xxx_dbdma_put_dest_flags(cd->ddma_chan,
+				(void *)phys_to_virt(cd->dma_area),
+				cd->period_bytes, DDMA_FLAGS_IE);
+
+	/* update next-to-queue period */
+	++cd->q_period;
+	cd->dma_area += cd->period_bytes;
+	if (cd->q_period >= cd->periods) {
+		cd->q_period = 0;
+		cd->dma_area = cd->dma_area_s;
+	}
+}
+
+static void au1x_pcm_dmatx_cb(int irq, void *dev_id)
+{
+	struct au1xpsc_audio_dmadata *cd = dev_id;
+
+	cd->pos += cd->period_bytes;
+	if (++cd->curr_period >= cd->periods) {
+		cd->pos = 0;
+		cd->curr_period = 0;
+	}
+	snd_pcm_period_elapsed(cd->substream);
+	au1x_pcm_queue_tx(cd);
+}
+
+static void au1x_pcm_dmarx_cb(int irq, void *dev_id)
+{
+	struct au1xpsc_audio_dmadata *cd = dev_id;
+
+	cd->pos += cd->period_bytes;
+	if (++cd->curr_period >= cd->periods) {
+		cd->pos = 0;
+		cd->curr_period = 0;
+	}
+	snd_pcm_period_elapsed(cd->substream);
+	au1x_pcm_queue_rx(cd);
+}
+
+static void au1x_pcm_dbdma_free(struct au1xpsc_audio_dmadata *pcd)
+{
+	if (pcd->ddma_chan) {
+		au1xxx_dbdma_stop(pcd->ddma_chan);
+		au1xxx_dbdma_reset(pcd->ddma_chan);
+		au1xxx_dbdma_chan_free(pcd->ddma_chan);
+		pcd->ddma_chan = 0;
+		pcd->msbits = 0;
+	}
+}
+
+/* in case of missing DMA ring or changed TX-source / RX-dest bit widths,
+ * allocate (or reallocate) a 2-descriptor DMA ring with bit depth according
+ * to ALSA-supplied sample depth.  This is due to limitations in the dbdma api
+ * (cannot adjust source/dest widths of already allocated descriptor ring).
+ */
+static int au1x_pcm_dbdma_realloc(struct au1xpsc_audio_dmadata *pcd, int is_rx,
+				 int msbits)
+{
+	/* DMA only in 8/16/32 bit widths */
+	if (msbits == 24)
+		msbits = 32;
+
+	/* check current config: correct bits and descriptors allocated? */
+	if ((pcd->ddma_chan) && (msbits == pcd->msbits))
+		goto out;	/* all ok! */
+
+	au1x_pcm_dbdma_free(pcd);
+
+	if (is_rx)
+		pcd->ddma_chan = au1xxx_dbdma_chan_alloc(pcd->ddma_id,
+					DSCR_CMD0_ALWAYS,
+					au1x_pcm_dmarx_cb, (void *)pcd);
+	else
+		pcd->ddma_chan = au1xxx_dbdma_chan_alloc(DSCR_CMD0_ALWAYS,
+					pcd->ddma_id,
+					au1x_pcm_dmatx_cb, (void *)pcd);
+
+	if (!pcd->ddma_chan)
+		return -ENOMEM;;
+
+	au1xxx_dbdma_set_devwidth(pcd->ddma_chan, msbits);
+	au1xxx_dbdma_ring_alloc(pcd->ddma_chan, 2);
+
+	pcd->msbits = msbits;
+
+	au1xxx_dbdma_stop(pcd->ddma_chan);
+	au1xxx_dbdma_reset(pcd->ddma_chan);
+
+out:
+	return 0;
+}
+
+/*
+ * Called by ALSA when the hardware params are set by application. This
+ * function can also be called multiple times and can allocate buffers
+ * (using snd_pcm_lib_* ). It's non-atomic.
+ */
+static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct au1xpsc_audio_dmadata *pcd;
+	int is_rx, ret;
+
+	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	if (ret < 0)
+		goto out;
+
+	is_rx  = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	pcd = au1xpsc_audio_pcmdma[is_rx];
+
+	DBG("runtime->dma_area = 0x%08lx dma_addr_t = 0x%08lx dma_size = %d "
+	    "runtime->min_align %d\n",
+		(unsigned long)runtime->dma_area,
+		(unsigned long)runtime->dma_addr, runtime->dma_bytes,
+		runtime->min_align);
+
+	DBG("bits %d  frags %d  frag_bytes %d  is_rx %d\n", params->msbits,
+		params_periods(params), params_period_bytes(params), is_rx);
+
+	ret = au1x_pcm_dbdma_realloc(pcd, is_rx, params->msbits);
+	if (ret) {
+		MSG("DDMA channel (re)alloc failed!\n");
+		goto out;
+	}
+
+	pcd->substream = substream;
+	pcd->period_bytes = params_period_bytes(params);
+	pcd->periods = params_periods(params);
+	pcd->dma_area_s = pcd->dma_area = (unsigned long)runtime->dma_addr;
+	pcd->q_period = 0;
+	pcd->curr_period = 0;
+	pcd->pos = 0;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int au1xpsc_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_lib_free_pages(substream);
+	return 0;
+}
+
+static int au1xpsc_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct au1xpsc_audio_dmadata *pcd;
+	int is_rx;
+
+	is_rx  = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	pcd = au1xpsc_audio_pcmdma[is_rx];
+
+	au1xxx_dbdma_reset(pcd->ddma_chan);
+
+	if (is_rx) {
+		au1x_pcm_queue_rx(pcd);
+		au1x_pcm_queue_rx(pcd);
+	} else {
+		au1x_pcm_queue_tx(pcd);
+		au1x_pcm_queue_tx(pcd);
+	}
+
+	return 0;
+}
+
+static int au1xpsc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int is_rx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	u32 chan = au1xpsc_audio_pcmdma[is_rx]->ddma_chan;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		au1xxx_dbdma_start(chan);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		au1xxx_dbdma_stop(chan);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static snd_pcm_uframes_t
+au1xpsc_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	int is_rx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+
+	return bytes_to_frames(substream->runtime,
+				au1xpsc_audio_pcmdma[is_rx]->pos);
+}
+
+static int au1xpsc_pcm_open(struct snd_pcm_substream *substream)
+{
+	snd_soc_set_runtime_hwparams(substream, &au1xpsc_pcm_hardware);
+
+	return 0;
+}
+
+static int au1xpsc_pcm_close(struct snd_pcm_substream *substream)
+{
+	int is_rx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+
+	au1x_pcm_dbdma_free(au1xpsc_audio_pcmdma[is_rx]);
+
+	return 0;
+}
+
+struct snd_pcm_ops au1xpsc_pcm_ops = {
+	.open		= au1xpsc_pcm_open,
+	.close		= au1xpsc_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= au1xpsc_pcm_hw_params,
+	.hw_free	= au1xpsc_pcm_hw_free,
+	.prepare	= au1xpsc_pcm_prepare,
+	.trigger	= au1xpsc_pcm_trigger,
+	.pointer	= au1xpsc_pcm_pointer,
+};
+
+static void au1xpsc_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int au1xpsc_pcm_new(struct snd_card *card,
+			   struct snd_soc_codec_dai *dai,
+			   struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		card->dev, AU1XPSC_BUFFER_MIN_BYTES, (4096 * 1024) - 1);
+
+	return 0;
+}
+
+static int au1xpsc_pcm_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	int ret;
+
+	if (au1xpsc_audio_pcmdma[0])
+		return -EBUSY;
+
+	/* TX DMA */
+	au1xpsc_audio_pcmdma[0]
+		= kzalloc(sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
+	if (!au1xpsc_audio_pcmdma[0])
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out1;
+	}
+	(au1xpsc_audio_pcmdma[0])->ddma_id = r->start;
+
+	/* RX DMA */
+	au1xpsc_audio_pcmdma[1]
+		= kzalloc(sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
+	if (!au1xpsc_audio_pcmdma[1])
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r) {
+		ret = -ENODEV;
+		goto out2;
+	}
+	(au1xpsc_audio_pcmdma[1])->ddma_id = r->start;
+
+	return 0;
+
+out2:
+	kfree(au1xpsc_audio_pcmdma[1]);
+	au1xpsc_audio_pcmdma[1] = NULL;
+out1:
+	kfree(au1xpsc_audio_pcmdma[0]);
+	au1xpsc_audio_pcmdma[0] = NULL;
+	return ret;
+}
+
+static int au1xpsc_pcm_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (au1xpsc_audio_pcmdma[i]) {
+			au1x_pcm_dbdma_free(au1xpsc_audio_pcmdma[i]);
+			kfree(au1xpsc_audio_pcmdma[i]);
+			au1xpsc_audio_pcmdma[i] = NULL;
+		}
+	}
+
+	return 0;
+}
+
+/* au1xpsc audio platform */
+struct snd_soc_platform au1xpsc_soc_platform = {
+	.name		= "au1xpsc-pcm-dbdma",
+	.probe		= au1xpsc_pcm_probe,
+	.remove		= au1xpsc_pcm_remove,
+	.pcm_ops 	= &au1xpsc_pcm_ops,
+	.pcm_new	= au1xpsc_pcm_new,
+	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(au1xpsc_soc_platform);
+
+static int __init au1xpsc_audio_dbdma_init(void)
+{
+	au1xpsc_audio_pcmdma[0] = NULL;
+	au1xpsc_audio_pcmdma[1] = NULL;
+	return 0;
+}
+
+static void __exit au1xpsc_audio_dbdma_exit(void)
+{
+}
+
+module_init(au1xpsc_audio_dbdma_init);
+module_exit(au1xpsc_audio_dbdma_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au12x0/Au1550 PSC Audio DMA driver");
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
new file mode 100644
index 0000000..c9cf72b
--- /dev/null
+++ b/sound/soc/au1x/psc-ac97.c
@@ -0,0 +1,378 @@
+/*
+ * Au12x0/Au1550 PSC ALSA ASoC audio support.
+ *
+ * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Au1xxx-PSC AC97 glue.
+ *
+ * NOTE: all of these drivers can only work with a SINGLE instance
+ *	 of a PSC. Multiple independent audio devices are impossible
+ *	 with ASoC v1.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/suspend.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+#include "psc.h"
+
+#define AC97_RD		(1<<25)
+
+#define AC97_DIR	\
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AC97_RATES	\
+	SNDRV_PCM_RATE_8000_48000
+
+#define AC97_FMTS	\
+	SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3BE
+
+/* instance data. There can be only one, MacLeod!!!! */
+static struct au1xpsc_audio_data *au1xpsc_ac97_workdata;
+
+/* AC97 controller reads codec register */
+static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
+	unsigned short reg)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	unsigned short data, tmo;
+
+	au_writel(AC97_RD | ((reg & 127) << 16), AC97_CDC(pscdata));
+	au_sync();
+
+	tmo = 1000;
+	while ((!(au_readl(AC97_EVNT(pscdata)) & (1<<24))) && --tmo)
+		udelay(2);
+
+	if (!tmo)
+		data = 0xffff;
+	else
+		data = au_readl(AC97_CDC(pscdata)) & 0xffff;
+
+	au_writel(1<<24, AC97_EVNT(pscdata));
+	au_sync();
+
+	return data;
+}
+
+/* AC97 controller writes to codec register */
+static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+	unsigned short val)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	unsigned int tmo;
+
+	au_writel(((reg & 127) << 16) | (val & 0xffff), AC97_CDC(pscdata));
+	au_sync();
+	tmo = 1000;
+	while ((!(au_readl(AC97_EVNT(pscdata)) & (1 << 24))) && --tmo)
+		au_sync();
+
+	au_writel(1 << 24, AC97_EVNT(pscdata));
+	au_sync();
+}
+
+/* AC97 controller asserts a warm reset */
+static void au1xpsc_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+
+	au_writel(1, AC97_RST(pscdata));
+	au_sync();
+	msleep(10);
+	au_writel(0, AC97_RST(pscdata));
+	au_sync();
+}
+
+static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	int i;
+
+	/* disable PSC during cold reset */
+	au_writel(0, PSC_CTRL(pscdata));
+
+	/* issue cold reset */
+	au_writel(2, AC97_RST(pscdata));
+	au_sync();
+	msleep(500);
+	au_writel(0, AC97_RST(pscdata));
+	au_sync();
+
+	/* enable PSC */
+	au_writel(3, PSC_CTRL(pscdata));
+	au_sync();
+
+	/* wait for PSC to indicate it's ready */
+	i = 100000;
+	while (((au_readl(AC97_STAT(pscdata)) & 1) == 0) && (--i))
+		au_sync();
+
+	if (i == 0) {
+		printk(KERN_ALERT "psc-ac97: PSC not ready!\n");
+		return;
+	}
+
+	/* enable the ac97 function */
+	au_writel(pscdata->cfg | 0x04000000, AC97_CFG(pscdata));
+	au_sync();
+
+	/* wait for AC97 core to become ready */
+	i = 100000;
+	while (((au_readl(AC97_STAT(pscdata)) & 2) == 0) && (--i))
+		au_sync();
+	if (i == 0)
+		printk(KERN_ALERT "psc-ac97: AC97 ctrl not ready\n");
+}
+
+/* AC97 controller operations */
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= au1xpsc_ac97_read,
+	.write		= au1xpsc_ac97_write,
+	.reset		= au1xpsc_ac97_cold_reset,
+	.warm_reset	= au1xpsc_ac97_warm_reset,
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	unsigned long r;
+	int chans, recv;
+
+	chans = params_channels(params);
+	recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+
+	/* need to disable the controller before changing any other
+	 *  AC97CFG reg contents
+	 */
+	r = au_readl(AC97_CFG(pscdata));
+	au_writel(r & ~(1<<26), AC97_CFG(pscdata));
+	au_sync();
+
+	/* set sample bitdepth: REG[24:21]=(BITS-2)/2 */
+	r &= ~(0xf << 21);
+	r |= (((params->msbits-2)>>1) & 0xf) << 21;
+
+	/* channels */
+	r |= (3 << (1 + (recv ? 0 : 10)));	/* stereo pair */
+
+	/* set FIFO params: max fifo threshold, 8 slots TX/RX  */
+	r |= (3<<30) | (3<<28);
+
+	/* finally enable the AC97 controller again */
+	au_writel(r | (1<<26), AC97_CFG(pscdata));
+	au_sync();
+
+	return 0;
+}
+
+static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
+				int cmd)
+{
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	int ret, rcv;
+
+	rcv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		au_writel(1 << (rcv ? 4 : 0), AC97_PCR(pscdata));
+		au_sync();
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		au_writel(1 << (rcv ? 5 : 1), AC97_PCR(pscdata));
+		au_sync();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int au1xpsc_ac97_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	unsigned long sel;
+
+	if (au1xpsc_ac97_workdata)
+		return -EBUSY;
+
+	au1xpsc_ac97_workdata =
+		kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
+	if (!au1xpsc_ac97_workdata)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	ret = -EBUSY;
+	au1xpsc_ac97_workdata->ioarea =
+		request_mem_region(r->start, r->end - r->start + 1,
+					"au1xpsc_ac97");
+	if (!au1xpsc_ac97_workdata->ioarea)
+		goto out0;
+
+	au1xpsc_ac97_workdata->mmio = ioremap(r->start, 0xffff);
+	if (!au1xpsc_ac97_workdata->mmio)
+		goto out1;
+
+	/* preserve PSC clock source set up by platform (dev.platform_data
+	 * is already occupied by soc layer)
+	 */
+	sel = au_readl(PSC_SEL(au1xpsc_ac97_workdata)) & PSC_SEL_CLK_MASK;
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(0, PSC_SEL(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(au1xpsc_ac97_workdata));
+	au_sync();
+	/* enable PSC */
+	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+
+	return 0;
+
+out1:
+	release_resource(au1xpsc_ac97_workdata->ioarea);
+	kfree(au1xpsc_ac97_workdata->ioarea);
+out0:
+	kfree(au1xpsc_ac97_workdata);
+	au1xpsc_ac97_workdata = NULL;
+	return ret;
+}
+
+static void au1xpsc_ac97_remove(struct platform_device *pdev)
+{
+	/* disable PSC completely */
+	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+
+	iounmap(au1xpsc_ac97_workdata->mmio);
+	release_resource(au1xpsc_ac97_workdata->ioarea);
+	kfree(au1xpsc_ac97_workdata->ioarea);
+	kfree(au1xpsc_ac97_workdata);
+	au1xpsc_ac97_workdata = NULL;
+}
+
+static int au1xpsc_ac97_suspend(struct platform_device *pdev,
+				struct snd_soc_cpu_dai *cpu_dai)
+{
+	/* save interesting registers and disable PSC */
+	au1xpsc_ac97_workdata->pm[0] =
+			au_readl(PSC_SEL(au1xpsc_ac97_workdata));
+	au1xpsc_ac97_workdata->pm[1] =
+			au_readl(AC97_CFG(au1xpsc_ac97_workdata));
+
+	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+
+	return 0;
+}
+
+static int au1xpsc_ac97_resume(struct platform_device *pdev,
+			       struct snd_soc_cpu_dai *cpu_dai)
+{
+	int i;
+
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(0, PSC_SEL(au1xpsc_ac97_workdata));
+	au_sync();
+
+	au_writel(au1xpsc_ac97_workdata->pm[0],
+			PSC_SEL(au1xpsc_ac97_workdata));
+	au_sync();
+	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	au_sync();
+
+	/* enable PSC */
+	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_sync();
+
+	/* wait for PSC to indicate it's ready */
+	i = 100000;
+	while ((!(au_readl(AC97_STAT(au1xpsc_ac97_workdata)) & 1)) && (--i))
+		au_sync();
+
+	/* after this point the ac97 core will cold-reset the codec.
+	 * During cold-reset the code will write pre-defined data to
+	 * the config register.
+	 */
+	au1xpsc_ac97_workdata->cfg = au1xpsc_ac97_workdata->pm[1];
+
+	return 0;
+}
+
+struct snd_soc_cpu_dai au1xpsc_ac97_dai = {
+	.name			= "au1xpsc_ac97",
+	.type			= SND_SOC_DAI_AC97,
+	.probe			= au1xpsc_ac97_probe,
+	.remove			= au1xpsc_ac97_remove,
+	.suspend		= au1xpsc_ac97_suspend,
+	.resume			= au1xpsc_ac97_resume,
+	.playback = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = {
+		.trigger	= au1xpsc_ac97_trigger,
+		.hw_params	= au1xpsc_ac97_hw_params,
+	},
+};
+
+EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
+
+static int __init au1xpsc_ac97_init(void)
+{
+	au1xpsc_ac97_workdata = NULL;
+	return 0;
+}
+
+static void __exit au1xpsc_ac97_exit(void)
+{
+}
+
+module_init(au1xpsc_ac97_init);
+module_exit(au1xpsc_ac97_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au12x0/Au1550 PSC AC97 ALSA ASoC audio driver");
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
new file mode 100644
index 0000000..42d4488
--- /dev/null
+++ b/sound/soc/au1x/psc-i2s.c
@@ -0,0 +1,426 @@
+/*
+ * Au12x0/Au1550 PSC ALSA ASoC audio support.
+ *
+ * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Au1xxx-PSC I2S glue.
+ *
+ * NOTE: all of these drivers can only work with a SINGLE instance
+ *	 of a PSC. Multiple independent audio devices are impossible
+ *	 with ASoC v1.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+#include "psc.h"
+
+/* supported I2S DAI hardware formats */
+#define AU1XPSC_I2S_DAIFMT \
+	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J |	\
+	 SND_SOC_DAIFMT_NB_NF)
+
+/* supported I2S direction */
+#define AU1XPSC_I2S_DIR \
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AU1XPSC_I2S_RATES \
+	SNDRV_PCM_RATE_8000_192000
+
+#define AU1XPSC_I2S_FMTS \
+	(SNDRV_PCM_FMTBIT_S16_LE/* | SNDRV_PCM_FMTBIT_S24_LE*/)
+
+
+/* instance data. There can be only one, MacLeod!!!! */
+static struct au1xpsc_audio_data *au1xpsc_i2s_workdata;
+
+static int au1xpsc_i2s_set_fmt(struct snd_soc_cpu_dai *cpu_dai,
+			       unsigned int fmt)
+{
+	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+	unsigned long ct;
+	int ret;
+
+	ret = -EINVAL;
+
+	ct = pscdata->cfg;
+
+	ct &= ~((1<<9)|(1<<10));	/* MSB (left-) justified*/
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ct |= (1<<9);		/* enable I2S mode */
+		break;
+	case SND_SOC_DAIFMT_MSB:
+		break;
+	case SND_SOC_DAIFMT_LSB:
+		ct |= (1<<10);		/* LSB (right-) justified */
+		break;
+	default:
+		goto out;
+	}
+
+	ct &= ~((1 << 12) | (1 << 15));		/* IB-IF */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		ct |= (1<<12) | (1<<15);	/* NF: left = low */
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		ct |= (1<<12);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ct |= (1<<15);	/* IB-NF */
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+	default:
+		goto out;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:	/* CODEC master */
+		ct |= (1<<0);		/* PSC I2S slave mode */
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:	/* CODEC slave */
+		ct &= ~(1<<0);		/* PSC I2S Master mode */
+		break;
+	default:
+		goto out;
+	}
+
+	pscdata->cfg = ct;
+	ret = 0;
+out:
+	return ret;
+}
+
+static int au1xpsc_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+
+	int cfgbits;
+	unsigned long stat;
+
+	/* check if the PSC is already streaming data */
+	/* FIXME: should probably ONLY check if pscdata->rate is != 0 */
+	stat = au_readl(I2S_STAT(pscdata));
+	if (stat & (3<<4)) {
+		/* already active, check settings (don't trust pscdata->cfg) */
+		cfgbits = au_readl(I2S_CFG(pscdata));
+		cfgbits = ((cfgbits >> 4) & 0x1f) + 1;
+		if (cfgbits != params->msbits)
+			return -EINVAL;
+
+		/* FIXME: does ALSA/ASoC already check? */
+		if (params_rate(params) != pscdata->rate)
+			return -EINVAL;
+
+	} else {
+		/* set sample bitdepth */
+		pscdata->cfg &= ~(0x1f << 4);
+		pscdata->cfg |= (((params->msbits - 1) & 0x1f) << 4);
+		/* remember current rate for other stream */
+		pscdata->rate = params_rate(params);
+	}
+	return 0;
+}
+
+/* Configure PSC late:  on my devel systems the codec  is I2S master and
+ * supplies the i2sbitclock __AND__ i2sMclk (!) to the PSC unit.  ASoC
+ * uses aggressive PM and  switches the codec off  when it is not in use
+ * which also means the PSC unit doesn't get any clocks and is therefore
+ * dead. That's why this chunk here gets called from the trigger callback
+ * because I can be reasonably certain the codec is driving the clocks.
+ */
+static int au1xpsc_i2s_configure(struct au1xpsc_audio_data *pscdata)
+{
+	unsigned long tmo;
+
+	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(pscdata));
+	au_sync();
+
+	/* wait for PSC unit to become ready */
+	tmo = 1000000;
+	while (!(au_readl(I2S_STAT(pscdata)) & 1) && tmo)
+		tmo--;
+
+	if (!tmo)
+		return -ETIMEDOUT;
+
+	/* configure the I2S controller; need to disable it first. */
+	au_writel(0, I2S_CFG(pscdata));
+	au_sync();
+
+	/* start I2S controller: config | max_tx_thresh | max_rx_thresh | enable */
+	au_writel(pscdata->cfg | (1<<26), I2S_CFG(pscdata));
+	au_sync();
+
+	/* wait for I2S controller to become ready */
+	tmo = 1000000;
+	while (!(au_readl(I2S_STAT(pscdata)) & 2) && tmo)
+		tmo--;
+
+	return (tmo == 0) ? -ETIMEDOUT : 0;
+}
+
+static int au1xpsc_i2s_start(struct au1xpsc_audio_data *pscdata, int play)
+{
+	unsigned long tmo;
+	int ret;
+
+	ret = 0;
+
+	/* if both TX and RX are idle, configure the PSC  */
+	if ((au_readl(I2S_STAT(pscdata)) & ((1<<4)|(1<<5))) == 0) {
+		ret = au1xpsc_i2s_configure(pscdata);
+		if (ret)
+			goto out;
+	}
+
+	/* clear fifo */
+	au_writel(play ? (1<<2) : (1<<6), I2S_PCR(pscdata));
+	au_sync();
+
+	/* and start */
+	au_writel(play ? (1<<0) : (1<<4), I2S_PCR(pscdata));
+	au_sync();
+
+	/* wait for start confirmation */
+	tmo = 1000000;
+	while ((0 == (au_readl(I2S_STAT(pscdata)) & (play ? (1<<4) : (1<<5)))) && tmo)
+		tmo--;
+
+	if (!tmo) {
+		au_writel(play ? (1<<1) : (1<<5), I2S_PCR(pscdata));
+		au_sync();
+		ret = -ETIMEDOUT;
+	}
+out:
+	return ret;
+}
+
+static int au1xpsc_i2s_stop(struct au1xpsc_audio_data *pscdata, int play)
+{
+	unsigned long tmo, stat;
+
+	au_writel(play ? (1<<1) : (1<<5), I2S_PCR(pscdata));
+	au_sync();
+	/* wait for stop confirmation */
+	tmo = 1000000;
+	do {
+		stat = au_readl(I2S_STAT(pscdata));
+		tmo--;
+	} while ((stat & (play ? (1<<4) : (1<<5))) && tmo);
+
+	/* if both TX and RX are idle, disable the I2S and PSC */
+	stat = au_readl(I2S_STAT(pscdata)) & (3<<4);
+	if (!stat) {
+		/* disable I2S controller */
+		au_writel(0, I2S_CFG(pscdata));
+		au_sync();
+
+		/* suspend PSC */
+		au_writel(PSC_CTRL_SUSPEND, PSC_CTRL(pscdata));
+		au_sync();
+
+		pscdata->rate = 0;
+		/* don't change pscdata->cfg! PM depends on it! */
+	}
+	return 0;
+}
+
+static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+	int ret, play;
+
+	play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 1 : 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = au1xpsc_i2s_start(pscdata, play);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = au1xpsc_i2s_stop(pscdata, play);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int au1xpsc_i2s_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	unsigned long sel;
+
+	if (au1xpsc_i2s_workdata)
+		return -EBUSY;
+
+	au1xpsc_i2s_workdata =
+		kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
+	if (!au1xpsc_i2s_workdata)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	ret = -EBUSY;
+	au1xpsc_i2s_workdata->ioarea =
+		request_mem_region(r->start, r->end - r->start + 1,
+					"au1xpsc_i2s");
+	if (!au1xpsc_i2s_workdata->ioarea)
+		goto out0;
+
+	au1xpsc_i2s_workdata->mmio = ioremap(r->start, 0xffff);
+	if (!au1xpsc_i2s_workdata->mmio)
+		goto out1;
+
+	/* preserve PSC clock source set up by platform (dev.platform_data
+	 * is already occupied by soc layer)
+	 */
+	sel = au_readl(PSC_SEL(au1xpsc_i2s_workdata)) & PSC_SEL_CLK_MASK;
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(PSC_SEL_PS_I2SMODE | sel, PSC_SEL(au1xpsc_i2s_workdata));
+	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+
+	/* preconfigure: set max rx/tx fifo depths */
+	au1xpsc_i2s_workdata->cfg |= (3<<30) | (3<<28);
+
+	/* controller might not become ready if it is clocked by the codec;
+	 * codec is initialized later on and parameters are set even later
+	 */
+
+	return 0;
+
+out1:
+	release_resource(au1xpsc_i2s_workdata->ioarea);
+	kfree(au1xpsc_i2s_workdata->ioarea);
+out0:
+	kfree(au1xpsc_i2s_workdata);
+	au1xpsc_i2s_workdata = NULL;
+	return ret;
+}
+
+static void au1xpsc_i2s_remove(struct platform_device *pdev)
+{
+	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+
+	iounmap(au1xpsc_i2s_workdata->mmio);
+	release_resource(au1xpsc_i2s_workdata->ioarea);
+	kfree(au1xpsc_i2s_workdata->ioarea);
+	kfree(au1xpsc_i2s_workdata);
+	au1xpsc_i2s_workdata = NULL;
+}
+
+
+static int au1xpsc_i2s_suspend(struct platform_device *pdev,
+			       struct snd_soc_cpu_dai *cpu_dai)
+{
+	/* save interesting registers and disable PSC */
+	au1xpsc_i2s_workdata->pm[0] =
+		au_readl(PSC_SEL(au1xpsc_i2s_workdata));
+	au1xpsc_i2s_workdata->pm[1] =
+		au_readl(I2S_CFG(au1xpsc_i2s_workdata));
+
+	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+
+	return 0;
+}
+
+static int au1xpsc_i2s_resume(struct platform_device *pdev,
+			      struct snd_soc_cpu_dai *cpu_dai)
+{
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(0, PSC_SEL(au1xpsc_i2s_workdata));
+	au_sync();
+	au_writel(au1xpsc_i2s_workdata->pm[0],
+			PSC_SEL(au1xpsc_i2s_workdata));
+	au_sync();
+
+	/* enable PSC */
+	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_sync();
+
+	/* same comment as in probe() callback also applies here */
+
+	/* write back saved config */
+	au_writel(au1xpsc_i2s_workdata->pm[1],
+			I2S_CFG(au1xpsc_i2s_workdata));
+	au_sync();
+
+	return 0;
+}
+
+struct snd_soc_cpu_dai au1xpsc_i2s_dai = {
+	.name			= "au1xpsc_i2s",
+	.type			= SND_SOC_DAI_I2S,
+	.probe			= au1xpsc_i2s_probe,
+	.remove			= au1xpsc_i2s_remove,
+	.suspend		= au1xpsc_i2s_suspend,
+	.resume			= au1xpsc_i2s_resume,
+	.playback = {
+		.rates		= AU1XPSC_I2S_RATES,
+		.formats	= AU1XPSC_I2S_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 8,},
+	.capture = {
+		.rates		= AU1XPSC_I2S_RATES,
+		.formats	= AU1XPSC_I2S_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 8,},
+	.ops = {
+		.trigger	= au1xpsc_i2s_trigger,
+		.hw_params	= au1xpsc_i2s_hw_params,
+	},
+	.dai_ops = {
+		.set_fmt	= au1xpsc_i2s_set_fmt,
+	},
+};
+EXPORT_SYMBOL(au1xpsc_i2s_dai);
+
+static int __init au1xpsc_i2s_init(void)
+{
+	au1xpsc_i2s_workdata = NULL;
+	return 0;
+}
+
+static void __exit au1xpsc_i2s_exit(void)
+{
+}
+
+module_init(au1xpsc_i2s_init);
+module_exit(au1xpsc_i2s_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au12x0/Au1550 PSC I2S ALSA ASoC audio driver");
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
new file mode 100644
index 0000000..98e29eb
--- /dev/null
+++ b/sound/soc/au1x/psc.h
@@ -0,0 +1,48 @@
+/*
+ * Au12x0/Au1550 PSC ALSA ASoC audio support.
+ *
+ * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * NOTE: all of these drivers can only work with a SINGLE instance
+ *	 of a PSC. Multiple independent audio devices are impossible
+ *	 with ASoC v1.
+ */
+
+#ifndef _AU1X_PCM_H
+#define _AU1X_PCM_H
+
+extern struct snd_soc_cpu_dai au1xpsc_ac97_dai;
+extern struct snd_soc_cpu_dai au1xpsc_i2s_dai;
+extern struct snd_soc_platform au1xpsc_soc_platform;
+extern struct snd_ac97_bus_ops soc_ac97_ops;
+
+struct au1xpsc_audio_data {
+	void __iomem *mmio;
+	int irq;
+	struct resource *ioarea;
+
+	unsigned long cfg;
+	unsigned long rate;
+
+	unsigned long pm[2];
+};
+
+/* easy access macros */
+#define PSC_CTRL(x)	((unsigned long)((x)->mmio) + PSC_CTRL_OFFSET)
+#define PSC_SEL(x)	((unsigned long)((x)->mmio) + PSC_SEL_OFFSET)
+#define I2S_STAT(x)	((unsigned long)((x)->mmio) + PSC_I2SSTAT)
+#define I2S_CFG(x)	((unsigned long)((x)->mmio) + PSC_I2SCFG)
+#define I2S_PCR(x)	((unsigned long)((x)->mmio) + PSC_I2SPCR)
+#define AC97_CFG(x)	((unsigned long)((x)->mmio) + PSC_AC97CFG)
+#define AC97_CDC(x)	((unsigned long)((x)->mmio) + PSC_AC97CDC)
+#define AC97_EVNT(x)	((unsigned long)((x)->mmio) + PSC_AC97EVNT)
+#define AC97_PCR(x)	((unsigned long)((x)->mmio) + PSC_AC97PCR)
+#define AC97_RST(x)	((unsigned long)((x)->mmio) + PSC_AC97RST)
+#define AC97_STAT(x)	((unsigned long)((x)->mmio) + PSC_AC97STAT)
+
+#endif
diff --git a/sound/soc/au1x/sample-ac97.c b/sound/soc/au1x/sample-ac97.c
new file mode 100644
index 0000000..fce81da
--- /dev/null
+++ b/sound/soc/au1x/sample-ac97.c
@@ -0,0 +1,144 @@
+/*
+ * Sample Au12x0/Au1550 PSC AC97 sound machine.
+ *
+ * Copyright (c) 2007-2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms outlined in the file COPYING at the root of this
+ *  source archive.
+ *
+ * This is a very generic AC97 sound machine driver for boards which
+ * have (AC97) audio at PSC1 (e.g. DB1200 demoboards).
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+#include "../codecs/ac97.h"
+#include "psc.h"
+
+static int au1xpsc_sample_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync_endpoints(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link au1xpsc_sample_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.cpu_dai	= &au1xpsc_ac97_dai,	/* see psc-ac97.c */
+	.codec_dai	= &ac97_dai,		/* see codecs/ac97.c */
+	.init		= au1xpsc_sample_ac97_init,
+	.ops		= NULL,
+};
+
+static struct snd_soc_machine au1xpsc_sample_ac97_machine = {
+	.name		= "Au1xxx PSC AC97 Audio",
+	.dai_link	= &au1xpsc_sample_ac97_dai,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device au1xpsc_sample_ac97_devdata = {
+	.machine	= &au1xpsc_sample_ac97_machine,
+	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
+	.codec_dev	= &soc_codec_dev_ac97,
+};
+
+static struct resource au1xpsc_psc1_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(PSC1_BASE_ADDR),
+		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+#ifdef CONFIG_SOC_AU1200
+		.start	= AU1200_PSC1_INT,
+		.end	= AU1200_PSC1_INT,
+#elif defined(CONFIG_SOC_AU1550)
+		.start	= AU1550_PSC1_INT,
+		.end	= AU1550_PSC1_INT,
+#endif
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC1_TX,
+		.end	= DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC1_RX,
+		.end	= DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device *au1xpsc_sample_ac97_dev = NULL;
+
+static int __init au1xpsc_sample_ac97_load(void)
+{
+	int ret;
+
+#ifdef CONFIG_SOC_AU1200
+	unsigned long io;
+
+	/* modify sys_pinfunc for AC97 on PSC1 */
+	io = au_readl(SYS_PINFUNC);
+	io |= SYS_PINFUNC_P1C;
+	io &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B);
+	au_writel(io, SYS_PINFUNC);
+	au_sync();
+#endif
+
+	ret = -ENOMEM;
+
+	/* setup PSC clock source for AC97 part: external clock provided
+	 * by codec.  The psc-ac97.c driver depends on this setting!
+	 */
+	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
+	au_sync();
+
+	au1xpsc_sample_ac97_dev = platform_device_alloc("soc-audio", -1);
+	if (!au1xpsc_sample_ac97_dev)
+		goto out;
+
+	au1xpsc_sample_ac97_dev->resource =
+		kmemdup(au1xpsc_psc1_res, sizeof(struct resource) *
+			ARRAY_SIZE(au1xpsc_psc1_res), GFP_KERNEL);
+	au1xpsc_sample_ac97_dev->num_resources = ARRAY_SIZE(au1xpsc_psc1_res);
+	au1xpsc_sample_ac97_dev->id = 1;
+
+	platform_set_drvdata(au1xpsc_sample_ac97_dev,
+			     &au1xpsc_sample_ac97_devdata);
+	au1xpsc_sample_ac97_devdata.dev = &au1xpsc_sample_ac97_dev->dev;
+	ret = platform_device_add(au1xpsc_sample_ac97_dev);
+
+	if (ret) {
+		platform_device_put(au1xpsc_sample_ac97_dev);
+		au1xpsc_sample_ac97_dev = NULL;
+	}
+
+out:
+	return ret;
+}
+
+static void __exit au1xpsc_sample_ac97_exit(void)
+{
+	platform_device_unregister(au1xpsc_sample_ac97_dev);
+}
+
+module_init(au1xpsc_sample_ac97_load);
+module_exit(au1xpsc_sample_ac97_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au1xxx PSC sample AC97 machine");
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.5.6.1
