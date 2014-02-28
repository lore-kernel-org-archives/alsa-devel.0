From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 05/19] ALSA: hda - Move pcm ops and support funcs
	to shared file
Date: Thu, 27 Feb 2014 22:35:48 -0800
Message-ID: <1393569362-27285-6-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f201.google.com (mail-qc0-f201.google.com
 [209.85.216.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 54BE4265090
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-qc0-f201.google.com with SMTP id i17so34380qcy.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Pull the pcm_ops and the functions it uses into a new hda_shared file.
This is done to allow for other hda implementations besides pci to use
the same ops.

This currently shares dsp locking across the two files.  This will be
remedied in a following commit.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/Makefile     |    4 +-
 sound/pci/hda/hda_intel.c  | 1095 +------------------------------------------
 sound/pci/hda/hda_shared.c | 1105 ++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_shared.h |   58 +++
 4 files changed, 1166 insertions(+), 1096 deletions(-)
 create mode 100644 sound/pci/hda/hda_shared.c
 create mode 100644 sound/pci/hda/hda_shared.h

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 083b338..52d8ffe 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,4 +1,4 @@
-snd-hda-intel-objs := hda_intel.o
+snd-hda-intel-objs := hda_shared.o hda_intel.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
@@ -9,7 +9,7 @@ snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 
 # for trace-points
 CFLAGS_hda_codec.o := -I$(src)
-CFLAGS_hda_intel.o := -I$(src)
+CFLAGS_hda_shared.o := -I$(src)
 
 snd-hda-codec-generic-objs :=	hda_generic.o
 snd-hda-codec-realtek-objs :=	patch_realtek.o
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 053137e..838d64e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -51,11 +51,6 @@
 #include <linux/time.h>
 #include <linux/completion.h>
 
-#ifdef CONFIG_X86
-/* for snoop control */
-#include <asm/pgtable.h>
-#include <asm/cacheflush.h>
-#endif
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <linux/vgaarb.h>
@@ -63,6 +58,7 @@
 #include <linux/firmware.h>
 #include "hda_codec.h"
 #include "hda_i915.h"
+#include "hda_shared.h"
 #include "hda_priv.h"
 
 
@@ -200,22 +196,6 @@ MODULE_DESCRIPTION("Intel HDA driver");
 /*
  */
 
-/* DSP lock helpers */
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
-#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
-#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
-#define dsp_is_locked(dev)	((dev)->locked)
-#else
-#define dsp_lock_init(dev)	do {} while (0)
-#define dsp_lock(dev)		do {} while (0)
-#define dsp_unlock(dev)		do {} while (0)
-#define dsp_is_locked(dev)	0
-#endif
-
-#define CREATE_TRACE_POINTS
-#include "hda_intel_trace.h"
-
 /* driver types */
 enum {
 	AZX_DRIVER_ICH,
@@ -334,62 +314,6 @@ static const struct azx_reg_ops pci_reg_ops = {
 	.readb = pci_azx_readb,
 };
 
-/* for pcm support */
-#define get_azx_dev(substream) (substream->runtime->private_data)
-
-#ifdef CONFIG_X86
-static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
-{
-	int pages;
-
-	if (azx_snoop(chip))
-		return;
-	if (!dmab || !dmab->area || !dmab->bytes)
-		return;
-
-#ifdef CONFIG_SND_DMA_SGBUF
-	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
-		struct snd_sg_buf *sgbuf = dmab->private_data;
-		if (on)
-			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
-		else
-			set_pages_array_wb(sgbuf->page_table, sgbuf->pages);
-		return;
-	}
-#endif
-
-	pages = (dmab->bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (on)
-		set_memory_wc((unsigned long)dmab->area, pages);
-	else
-		set_memory_wb((unsigned long)dmab->area, pages);
-}
-
-static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
-				 bool on)
-{
-	__mark_pages_wc(chip, buf, on);
-}
-static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
-				   struct snd_pcm_substream *substream, bool on)
-{
-	if (azx_dev->wc_marked != on) {
-		__mark_pages_wc(chip, snd_pcm_get_dma_buf(substream), on);
-		azx_dev->wc_marked = on;
-	}
-}
-#else
-/* NOP for other archs */
-static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
-				 bool on)
-{
-}
-static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
-				   struct snd_pcm_substream *substream, bool on)
-{
-}
-#endif
-
 static int azx_acquire_irq(struct azx *chip, int do_disconnect);
 static int azx_send_cmd(struct hda_bus *bus, unsigned int val);
 /*
@@ -900,42 +824,6 @@ static void azx_int_clear(struct azx *chip)
 	azx_writel(chip, INTSTS, ICH6_INT_CTRL_EN | ICH6_INT_ALL_STREAM);
 }
 
-/* start a stream */
-static void azx_stream_start(struct azx *chip, struct azx_dev *azx_dev)
-{
-	/*
-	 * Before stream start, initialize parameter
-	 */
-	azx_dev->insufficient = 1;
-
-	/* enable SIE */
-	azx_writel(chip, INTCTL,
-		   azx_readl(chip, INTCTL) | (1 << azx_dev->index));
-	/* set DMA start and interrupt mask */
-	azx_sd_writeb(chip, azx_dev, SD_CTL,
-		      azx_sd_readb(chip, azx_dev, SD_CTL) |
-		      SD_CTL_DMA_START | SD_INT_MASK);
-}
-
-/* stop DMA */
-static void azx_stream_clear(struct azx *chip, struct azx_dev *azx_dev)
-{
-	azx_sd_writeb(chip, azx_dev, SD_CTL,
-		      azx_sd_readb(chip, azx_dev, SD_CTL) &
-		      ~(SD_CTL_DMA_START | SD_INT_MASK));
-	azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
-}
-
-/* stop a stream */
-static void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev)
-{
-	azx_stream_clear(chip, azx_dev);
-	/* disable SIE */
-	azx_writel(chip, INTCTL,
-		   azx_readl(chip, INTCTL) & ~(1 << azx_dev->index));
-}
-
-
 /*
  * reset and start the controller registers
  */
@@ -1036,8 +924,6 @@ static void azx_init_pci(struct azx *chip)
 }
 
 
-static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
-
 /*
  * interrupt handler
  */
@@ -1113,195 +999,6 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-
-/*
- * set up a BDL entry
- */
-static int setup_bdle(struct azx *chip,
-		      struct snd_dma_buffer *dmab,
-		      struct azx_dev *azx_dev, u32 **bdlp,
-		      int ofs, int size, int with_ioc)
-{
-	u32 *bdl = *bdlp;
-
-	while (size > 0) {
-		dma_addr_t addr;
-		int chunk;
-
-		if (azx_dev->frags >= AZX_MAX_BDL_ENTRIES)
-			return -EINVAL;
-
-		addr = snd_sgbuf_get_addr(dmab, ofs);
-		/* program the address field of the BDL entry */
-		bdl[0] = cpu_to_le32((u32)addr);
-		bdl[1] = cpu_to_le32(upper_32_bits(addr));
-		/* program the size field of the BDL entry */
-		chunk = snd_sgbuf_get_chunk_size(dmab, ofs, size);
-		/* one BDLE cannot cross 4K boundary on CTHDA chips */
-		if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY) {
-			u32 remain = 0x1000 - (ofs & 0xfff);
-			if (chunk > remain)
-				chunk = remain;
-		}
-		bdl[2] = cpu_to_le32(chunk);
-		/* program the IOC to enable interrupt
-		 * only when the whole fragment is processed
-		 */
-		size -= chunk;
-		bdl[3] = (size || !with_ioc) ? 0 : cpu_to_le32(0x01);
-		bdl += 4;
-		azx_dev->frags++;
-		ofs += chunk;
-	}
-	*bdlp = bdl;
-	return ofs;
-}
-
-/*
- * set up BDL entries
- */
-static int azx_setup_periods(struct azx *chip,
-			     struct snd_pcm_substream *substream,
-			     struct azx_dev *azx_dev)
-{
-	u32 *bdl;
-	int i, ofs, periods, period_bytes;
-	int pos_adj;
-
-	/* reset BDL address */
-	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
-
-	period_bytes = azx_dev->period_bytes;
-	periods = azx_dev->bufsize / period_bytes;
-
-	/* program the initial BDL entries */
-	bdl = (u32 *)azx_dev->bdl.area;
-	ofs = 0;
-	azx_dev->frags = 0;
-	pos_adj = chip->bdl_pos_adj[chip->dev_index];
-	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
-		struct snd_pcm_runtime *runtime = substream->runtime;
-		int pos_align = pos_adj;
-		pos_adj = (pos_adj * runtime->rate + 47999) / 48000;
-		if (!pos_adj)
-			pos_adj = pos_align;
-		else
-			pos_adj = ((pos_adj + pos_align - 1) / pos_align) *
-				pos_align;
-		pos_adj = frames_to_bytes(runtime, pos_adj);
-		if (pos_adj >= period_bytes) {
-			dev_warn(chip->card->dev,"Too big adjustment %d\n",
-				 chip->bdl_pos_adj[chip->dev_index]);
-			pos_adj = 0;
-		} else {
-			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
-					 azx_dev,
-					 &bdl, ofs, pos_adj, true);
-			if (ofs < 0)
-				goto error;
-		}
-	} else
-		pos_adj = 0;
-	for (i = 0; i < periods; i++) {
-		if (i == periods - 1 && pos_adj)
-			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
-					 azx_dev, &bdl, ofs,
-					 period_bytes - pos_adj, 0);
-		else
-			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
-					 azx_dev, &bdl, ofs,
-					 period_bytes,
-					 !azx_dev->no_period_wakeup);
-		if (ofs < 0)
-			goto error;
-	}
-	return 0;
-
- error:
-	dev_err(chip->card->dev, "Too many BDL entries: buffer=%d, period=%d\n",
-		azx_dev->bufsize, period_bytes);
-	return -EINVAL;
-}
-
-/* reset stream */
-static void azx_stream_reset(struct azx *chip, struct azx_dev *azx_dev)
-{
-	unsigned char val;
-	int timeout;
-
-	azx_stream_clear(chip, azx_dev);
-
-	azx_sd_writeb(chip, azx_dev, SD_CTL,
-		      azx_sd_readb(chip, azx_dev, SD_CTL) |
-		      SD_CTL_STREAM_RESET);
-	udelay(3);
-	timeout = 300;
-	while (!((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
-		 SD_CTL_STREAM_RESET) && --timeout)
-		;
-	val &= ~SD_CTL_STREAM_RESET;
-	azx_sd_writeb(chip, azx_dev, SD_CTL, val);
-	udelay(3);
-
-	timeout = 300;
-	/* waiting for hardware to report that the stream is out of reset */
-	while (((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
-		SD_CTL_STREAM_RESET) && --timeout)
-		;
-
-	/* reset first position - may not be synced with hw at this time */
-	*azx_dev->posbuf = 0;
-}
-
-/*
- * set up the SD for streaming
- */
-static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
-{
-	unsigned int val;
-	/* make sure the run bit is zero for SD */
-	azx_stream_clear(chip, azx_dev);
-	/* program the stream_tag */
-	val = azx_sd_readl(chip, azx_dev, SD_CTL);
-	val = (val & ~SD_CTL_STREAM_TAG_MASK) |
-		(azx_dev->stream_tag << SD_CTL_STREAM_TAG_SHIFT);
-	if (!azx_snoop(chip))
-		val |= SD_CTL_TRAFFIC_PRIO;
-	azx_sd_writel(chip, azx_dev, SD_CTL, val);
-
-	/* program the length of samples in cyclic buffer */
-	azx_sd_writel(chip, azx_dev, SD_CBL, azx_dev->bufsize);
-
-	/* program the stream format */
-	/* this value needs to be the same as the one programmed */
-	azx_sd_writew(chip, azx_dev, SD_FORMAT, azx_dev->format_val);
-
-	/* program the stream LVI (last valid index) of the BDL */
-	azx_sd_writew(chip, azx_dev, SD_LVI, azx_dev->frags - 1);
-
-	/* program the BDL address */
-	/* lower BDL address */
-	azx_sd_writel(chip, azx_dev, SD_BDLPL, (u32)azx_dev->bdl.addr);
-	/* upper BDL address */
-	azx_sd_writel(chip, azx_dev, SD_BDLPU,
-		      upper_32_bits(azx_dev->bdl.addr));
-
-	/* enable the position buffer */
-	if (chip->position_fix[0] != POS_FIX_LPIB ||
-	    chip->position_fix[1] != POS_FIX_LPIB) {
-		if (!(azx_readl(chip, DPLBASE) & ICH6_DPLBASE_ENABLE))
-			azx_writel(chip, DPLBASE,
-				(u32)chip->posbuf.addr | ICH6_DPLBASE_ENABLE);
-	}
-
-	/* set the interrupt enable bits in the descriptor control register */
-	azx_sd_writel(chip, azx_dev, SD_CTL,
-		      azx_sd_readl(chip, azx_dev, SD_CTL) | SD_INT_MASK);
-
-	return 0;
-}
-
 /*
  * Probe the given codec address
  */
@@ -1323,8 +1020,6 @@ static int probe_codec(struct azx *chip, int addr)
 	return 0;
 }
 
-static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
-				 struct hda_pcm *cpcm);
 static void azx_stop_chip(struct azx *chip);
 
 static void azx_bus_reset(struct hda_bus *bus)
@@ -1472,701 +1167,6 @@ static int azx_codec_configure(struct azx *chip)
 	return 0;
 }
 
-
-/*
- * PCM support
- */
-
-/* assign a stream for the PCM */
-static inline struct azx_dev *
-azx_assign_device(struct azx *chip, struct snd_pcm_substream *substream)
-{
-	int dev, i, nums;
-	struct azx_dev *res = NULL;
-	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dev = chip->playback_index_offset;
-		nums = chip->playback_streams;
-	} else {
-		dev = chip->capture_index_offset;
-		nums = chip->capture_streams;
-	}
-	for (i = 0; i < nums; i++, dev++) {
-		struct azx_dev *azx_dev = &chip->azx_dev[dev];
-		dsp_lock(azx_dev);
-		if (!azx_dev->opened && !dsp_is_locked(azx_dev)) {
-			res = azx_dev;
-			if (res->assigned_key == key) {
-				res->opened = 1;
-				res->assigned_key = key;
-				dsp_unlock(azx_dev);
-				return azx_dev;
-			}
-		}
-		dsp_unlock(azx_dev);
-	}
-	if (res) {
-		dsp_lock(res);
-		res->opened = 1;
-		res->assigned_key = key;
-		dsp_unlock(res);
-	}
-	return res;
-}
-
-/* release the assigned stream */
-static inline void azx_release_device(struct azx_dev *azx_dev)
-{
-	azx_dev->opened = 0;
-}
-
-static cycle_t azx_cc_read(const struct cyclecounter *cc)
-{
-	struct azx_dev *azx_dev = container_of(cc, struct azx_dev, azx_cc);
-	struct snd_pcm_substream *substream = azx_dev->substream;
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-
-	return azx_readl(chip, WALLCLK);
-}
-
-static void azx_timecounter_init(struct snd_pcm_substream *substream,
-				bool force, cycle_t last)
-{
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	struct timecounter *tc = &azx_dev->azx_tc;
-	struct cyclecounter *cc = &azx_dev->azx_cc;
-	u64 nsec;
-
-	cc->read = azx_cc_read;
-	cc->mask = CLOCKSOURCE_MASK(32);
-
-	/*
-	 * Converting from 24 MHz to ns means applying a 125/3 factor.
-	 * To avoid any saturation issues in intermediate operations,
-	 * the 125 factor is applied first. The division is applied
-	 * last after reading the timecounter value.
-	 * Applying the 1/3 factor as part of the multiplication
-	 * requires at least 20 bits for a decent precision, however
-	 * overflows occur after about 4 hours or less, not a option.
-	 */
-
-	cc->mult = 125; /* saturation after 195 years */
-	cc->shift = 0;
-
-	nsec = 0; /* audio time is elapsed time since trigger */
-	timecounter_init(tc, cc, nsec);
-	if (force)
-		/*
-		 * force timecounter to use predefined value,
-		 * used for synchronized starts
-		 */
-		tc->cycle_last = last;
-}
-
-static u64 azx_adjust_codec_delay(struct snd_pcm_substream *substream,
-				u64 nsec)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
-	u64 codec_frames, codec_nsecs;
-
-	if (!hinfo->ops.get_delay)
-		return nsec;
-
-	codec_frames = hinfo->ops.get_delay(hinfo, apcm->codec, substream);
-	codec_nsecs = div_u64(codec_frames * 1000000000LL,
-			      substream->runtime->rate);
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		return nsec + codec_nsecs;
-
-	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
-}
-
-static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
-				struct timespec *ts)
-{
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	u64 nsec;
-
-	nsec = timecounter_read(&azx_dev->azx_tc);
-	nsec = div_u64(nsec, 3); /* can be optimized */
-	nsec = azx_adjust_codec_delay(substream, nsec);
-
-	*ts = ns_to_timespec(nsec);
-
-	return 0;
-}
-
-static struct snd_pcm_hardware azx_pcm_hw = {
-	.info =			(SNDRV_PCM_INFO_MMAP |
-				 SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				 SNDRV_PCM_INFO_MMAP_VALID |
-				 /* No full-resume yet implemented */
-				 /* SNDRV_PCM_INFO_RESUME |*/
-				 SNDRV_PCM_INFO_PAUSE |
-				 SNDRV_PCM_INFO_SYNC_START |
-				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
-				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
-	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_48000,
-	.rate_min =		48000,
-	.rate_max =		48000,
-	.channels_min =		2,
-	.channels_max =		2,
-	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
-	.period_bytes_min =	128,
-	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
-	.periods_min =		2,
-	.periods_max =		AZX_MAX_FRAG,
-	.fifo_size =		0,
-};
-
-static int azx_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned long flags;
-	int err;
-	int buff_step;
-
-	mutex_lock(&chip->open_mutex);
-	azx_dev = azx_assign_device(chip, substream);
-	if (azx_dev == NULL) {
-		mutex_unlock(&chip->open_mutex);
-		return -EBUSY;
-	}
-	runtime->hw = azx_pcm_hw;
-	runtime->hw.channels_min = hinfo->channels_min;
-	runtime->hw.channels_max = hinfo->channels_max;
-	runtime->hw.formats = hinfo->formats;
-	runtime->hw.rates = hinfo->rates;
-	snd_pcm_limit_hw_rates(runtime);
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-
-	/* avoid wrap-around with wall-clock */
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
-				20,
-				178000000);
-
-	if (chip->align_buffer_size)
-		/* constrain buffer sizes to be multiple of 128
-		   bytes. This is more efficient in terms of memory
-		   access but isn't required by the HDA spec and
-		   prevents users from specifying exact period/buffer
-		   sizes. For example for 44.1kHz, a period size set
-		   to 20ms will be rounded to 19.59ms. */
-		buff_step = 128;
-	else
-		/* Don't enforce steps on buffer sizes, still need to
-		   be multiple of 4 bytes (HDA spec). Tested on Intel
-		   HDA controllers, may not work on all devices where
-		   option needs to be disabled */
-		buff_step = 4;
-
-	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-				   buff_step);
-	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
-				   buff_step);
-	snd_hda_power_up_d3wait(apcm->codec);
-	err = hinfo->ops.open(hinfo, apcm->codec, substream);
-	if (err < 0) {
-		azx_release_device(azx_dev);
-		snd_hda_power_down(apcm->codec);
-		mutex_unlock(&chip->open_mutex);
-		return err;
-	}
-	snd_pcm_limit_hw_rates(runtime);
-	/* sanity check */
-	if (snd_BUG_ON(!runtime->hw.channels_min) ||
-	    snd_BUG_ON(!runtime->hw.channels_max) ||
-	    snd_BUG_ON(!runtime->hw.formats) ||
-	    snd_BUG_ON(!runtime->hw.rates)) {
-		azx_release_device(azx_dev);
-		hinfo->ops.close(hinfo, apcm->codec, substream);
-		snd_hda_power_down(apcm->codec);
-		mutex_unlock(&chip->open_mutex);
-		return -EINVAL;
-	}
-
-	/* disable WALLCLOCK timestamps for capture streams
-	   until we figure out how to handle digital inputs */
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK;
-
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	azx_dev->substream = substream;
-	azx_dev->running = 0;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-
-	runtime->private_data = azx_dev;
-	snd_pcm_set_sync(substream);
-	mutex_unlock(&chip->open_mutex);
-	return 0;
-}
-
-static int azx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	unsigned long flags;
-
-	mutex_lock(&chip->open_mutex);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	azx_dev->substream = NULL;
-	azx_dev->running = 0;
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	azx_release_device(azx_dev);
-	hinfo->ops.close(hinfo, apcm->codec, substream);
-	snd_hda_power_down(apcm->codec);
-	mutex_unlock(&chip->open_mutex);
-	return 0;
-}
-
-static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *hw_params)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	int ret;
-
-	dsp_lock(azx_dev);
-	if (dsp_is_locked(azx_dev)) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	mark_runtime_wc(chip, azx_dev, substream, false);
-	azx_dev->bufsize = 0;
-	azx_dev->period_bytes = 0;
-	azx_dev->format_val = 0;
-	ret = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (ret < 0)
-		goto unlock;
-	mark_runtime_wc(chip, azx_dev, substream, true);
- unlock:
-	dsp_unlock(azx_dev);
-	return ret;
-}
-
-static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	struct azx *chip = apcm->chip;
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
-
-	/* reset BDL address */
-	dsp_lock(azx_dev);
-	if (!dsp_is_locked(azx_dev)) {
-		azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
-		azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
-		azx_sd_writel(chip, azx_dev, SD_CTL, 0);
-		azx_dev->bufsize = 0;
-		azx_dev->period_bytes = 0;
-		azx_dev->format_val = 0;
-	}
-
-	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
-
-	mark_runtime_wc(chip, azx_dev, substream, false);
-	azx_dev->prepared = 0;
-	dsp_unlock(azx_dev);
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int azx_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int bufsize, period_bytes, format_val, stream_tag;
-	int err;
-	struct hda_spdif_out *spdif =
-		snd_hda_spdif_out_of_nid(apcm->codec, hinfo->nid);
-	unsigned short ctls = spdif ? spdif->ctls : 0;
-
-	dsp_lock(azx_dev);
-	if (dsp_is_locked(azx_dev)) {
-		err = -EBUSY;
-		goto unlock;
-	}
-
-	azx_stream_reset(chip, azx_dev);
-	format_val = snd_hda_calc_stream_format(runtime->rate,
-						runtime->channels,
-						runtime->format,
-						hinfo->maxbps,
-						ctls);
-	if (!format_val) {
-		dev_err(chip->card->dev,
-			"invalid format_val, rate=%d, ch=%d, format=%d\n",
-			runtime->rate, runtime->channels, runtime->format);
-		err = -EINVAL;
-		goto unlock;
-	}
-
-	bufsize = snd_pcm_lib_buffer_bytes(substream);
-	period_bytes = snd_pcm_lib_period_bytes(substream);
-
-	dev_dbg(chip->card->dev, "azx_pcm_prepare: bufsize=0x%x, format=0x%x\n",
-		bufsize, format_val);
-
-	if (bufsize != azx_dev->bufsize ||
-	    period_bytes != azx_dev->period_bytes ||
-	    format_val != azx_dev->format_val ||
-	    runtime->no_period_wakeup != azx_dev->no_period_wakeup) {
-		azx_dev->bufsize = bufsize;
-		azx_dev->period_bytes = period_bytes;
-		azx_dev->format_val = format_val;
-		azx_dev->no_period_wakeup = runtime->no_period_wakeup;
-		err = azx_setup_periods(chip, substream, azx_dev);
-		if (err < 0)
-			goto unlock;
-	}
-
-	/* when LPIB delay correction gives a small negative value,
-	 * we ignore it; currently set the threshold statically to
-	 * 64 frames
-	 */
-	if (runtime->period_size > 64)
-		azx_dev->delay_negative_threshold = -frames_to_bytes(runtime, 64);
-	else
-		azx_dev->delay_negative_threshold = 0;
-
-	/* wallclk has 24Mhz clock source */
-	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
-						runtime->rate) * 1000);
-	azx_setup_controller(chip, azx_dev);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		azx_dev->fifo_size =
-			azx_sd_readw(chip, azx_dev, SD_FIFOSIZE) + 1;
-	else
-		azx_dev->fifo_size = 0;
-
-	stream_tag = azx_dev->stream_tag;
-	/* CA-IBG chips need the playback stream starting from 1 */
-	if ((chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND) &&
-	    stream_tag > chip->capture_streams)
-		stream_tag -= chip->capture_streams;
-	err = snd_hda_codec_prepare(apcm->codec, hinfo, stream_tag,
-				     azx_dev->format_val, substream);
-
- unlock:
-	if (!err)
-		azx_dev->prepared = 1;
-	dsp_unlock(azx_dev);
-	return err;
-}
-
-static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev;
-	struct snd_pcm_substream *s;
-	int rstart = 0, start, nsync = 0, sbits = 0;
-	int nwait, timeout;
-
-	azx_dev = get_azx_dev(substream);
-	trace_azx_pcm_trigger(chip, azx_dev, cmd);
-
-	if (dsp_is_locked(azx_dev) || !azx_dev->prepared)
-		return -EPIPE;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		rstart = 1;
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		start = 1;
-		break;
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
-		start = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	snd_pcm_group_for_each_entry(s, substream) {
-		if (s->pcm->card != substream->pcm->card)
-			continue;
-		azx_dev = get_azx_dev(s);
-		sbits |= 1 << azx_dev->index;
-		nsync++;
-		snd_pcm_trigger_done(s, substream);
-	}
-
-	spin_lock(&chip->reg_lock);
-
-	/* first, set SYNC bits of corresponding streams */
-	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
-		azx_writel(chip, OLD_SSYNC,
-			azx_readl(chip, OLD_SSYNC) | sbits);
-	else
-		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) | sbits);
-
-	snd_pcm_group_for_each_entry(s, substream) {
-		if (s->pcm->card != substream->pcm->card)
-			continue;
-		azx_dev = get_azx_dev(s);
-		if (start) {
-			azx_dev->start_wallclk = azx_readl(chip, WALLCLK);
-			if (!rstart)
-				azx_dev->start_wallclk -=
-						azx_dev->period_wallclk;
-			azx_stream_start(chip, azx_dev);
-		} else {
-			azx_stream_stop(chip, azx_dev);
-		}
-		azx_dev->running = start;
-	}
-	spin_unlock(&chip->reg_lock);
-	if (start) {
-		/* wait until all FIFOs get ready */
-		for (timeout = 5000; timeout; timeout--) {
-			nwait = 0;
-			snd_pcm_group_for_each_entry(s, substream) {
-				if (s->pcm->card != substream->pcm->card)
-					continue;
-				azx_dev = get_azx_dev(s);
-				if (!(azx_sd_readb(chip, azx_dev, SD_STS) &
-				      SD_STS_FIFO_READY))
-					nwait++;
-			}
-			if (!nwait)
-				break;
-			cpu_relax();
-		}
-	} else {
-		/* wait until all RUN bits are cleared */
-		for (timeout = 5000; timeout; timeout--) {
-			nwait = 0;
-			snd_pcm_group_for_each_entry(s, substream) {
-				if (s->pcm->card != substream->pcm->card)
-					continue;
-				azx_dev = get_azx_dev(s);
-				if (azx_sd_readb(chip, azx_dev, SD_CTL) &
-				    SD_CTL_DMA_START)
-					nwait++;
-			}
-			if (!nwait)
-				break;
-			cpu_relax();
-		}
-	}
-	spin_lock(&chip->reg_lock);
-	/* reset SYNC bits */
-	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
-		azx_writel(chip, OLD_SSYNC,
-			azx_readl(chip, OLD_SSYNC) & ~sbits);
-	else
-		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
-	if (start) {
-		azx_timecounter_init(substream, 0, 0);
-		if (nsync > 1) {
-			cycle_t cycle_last;
-
-			/* same start cycle for master and group */
-			azx_dev = get_azx_dev(substream);
-			cycle_last = azx_dev->azx_tc.cycle_last;
-
-			snd_pcm_group_for_each_entry(s, substream) {
-				if (s->pcm->card != substream->pcm->card)
-					continue;
-				azx_timecounter_init(s, 1, cycle_last);
-			}
-		}
-	}
-	spin_unlock(&chip->reg_lock);
-	return 0;
-}
-
-/* get the current DMA position with correction on VIA chips */
-static unsigned int azx_via_get_position(struct azx *chip,
-					 struct azx_dev *azx_dev)
-{
-	unsigned int link_pos, mini_pos, bound_pos;
-	unsigned int mod_link_pos, mod_dma_pos, mod_mini_pos;
-	unsigned int fifo_size;
-
-	link_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
-	if (azx_dev->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* Playback, no problem using link position */
-		return link_pos;
-	}
-
-	/* Capture */
-	/* For new chipset,
-	 * use mod to get the DMA position just like old chipset
-	 */
-	mod_dma_pos = le32_to_cpu(*azx_dev->posbuf);
-	mod_dma_pos %= azx_dev->period_bytes;
-
-	/* azx_dev->fifo_size can't get FIFO size of in stream.
-	 * Get from base address + offset.
-	 */
-	fifo_size = readw(chip->remap_addr + VIA_IN_STREAM0_FIFO_SIZE_OFFSET);
-
-	if (azx_dev->insufficient) {
-		/* Link position never gather than FIFO size */
-		if (link_pos <= fifo_size)
-			return 0;
-
-		azx_dev->insufficient = 0;
-	}
-
-	if (link_pos <= fifo_size)
-		mini_pos = azx_dev->bufsize + link_pos - fifo_size;
-	else
-		mini_pos = link_pos - fifo_size;
-
-	/* Find nearest previous boudary */
-	mod_mini_pos = mini_pos % azx_dev->period_bytes;
-	mod_link_pos = link_pos % azx_dev->period_bytes;
-	if (mod_link_pos >= fifo_size)
-		bound_pos = link_pos - mod_link_pos;
-	else if (mod_dma_pos >= mod_mini_pos)
-		bound_pos = mini_pos - mod_mini_pos;
-	else {
-		bound_pos = mini_pos - mod_mini_pos + azx_dev->period_bytes;
-		if (bound_pos >= azx_dev->bufsize)
-			bound_pos = 0;
-	}
-
-	/* Calculate real DMA position we want */
-	return bound_pos + mod_dma_pos;
-}
-
-static unsigned int azx_get_position(struct azx *chip,
-				     struct azx_dev *azx_dev,
-				     bool with_check)
-{
-	struct snd_pcm_substream *substream = azx_dev->substream;
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	unsigned int pos;
-	int stream = substream->stream;
-	struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
-	int delay = 0;
-
-	switch (chip->position_fix[stream]) {
-	case POS_FIX_LPIB:
-		/* read LPIB */
-		pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
-		break;
-	case POS_FIX_VIACOMBO:
-		pos = azx_via_get_position(chip, azx_dev);
-		break;
-	default:
-		/* use the position buffer */
-		pos = le32_to_cpu(*azx_dev->posbuf);
-		if (with_check && chip->position_fix[stream] == POS_FIX_AUTO) {
-			if (!pos || pos == (u32)-1) {
-				dev_info(chip->card->dev,
-					 "Invalid position buffer, using LPIB read method instead.\n");
-				chip->position_fix[stream] = POS_FIX_LPIB;
-				pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
-			} else
-				chip->position_fix[stream] = POS_FIX_POSBUF;
-		}
-		break;
-	}
-
-	if (pos >= azx_dev->bufsize)
-		pos = 0;
-
-	/* calculate runtime delay from LPIB */
-	if (substream->runtime &&
-	    chip->position_fix[stream] == POS_FIX_POSBUF &&
-	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
-		unsigned int lpib_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-			delay = pos - lpib_pos;
-		else
-			delay = lpib_pos - pos;
-		if (delay < 0) {
-			if (delay >= azx_dev->delay_negative_threshold)
-				delay = 0;
-			else
-				delay += azx_dev->bufsize;
-		}
-		if (delay >= azx_dev->period_bytes) {
-			dev_info(chip->card->dev,
-				 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
-				 delay, azx_dev->period_bytes);
-			delay = 0;
-			chip->driver_caps &= ~AZX_DCAPS_COUNT_LPIB_DELAY;
-		}
-		delay = bytes_to_frames(substream->runtime, delay);
-	}
-
-	if (substream->runtime) {
-		if (hinfo->ops.get_delay)
-			delay += hinfo->ops.get_delay(hinfo, apcm->codec,
-						      substream);
-		substream->runtime->delay = delay;
-	}
-
-	trace_azx_get_position(chip, azx_dev, pos, delay);
-	return pos;
-}
-
-static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	return bytes_to_frames(substream->runtime,
-			       azx_get_position(chip, azx_dev, false));
-}
-
-/*
- * Check whether the current DMA position is acceptable for updating
- * periods.  Returns non-zero if it's OK.
- *
- * Many HD-audio controllers appear pretty inaccurate about
- * the update-IRQ timing.  The IRQ is issued before actually the
- * data is processed.  So, we need to process it afterwords in a
- * workqueue.
- */
-static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
-{
-	u32 wallclk;
-	unsigned int pos;
-
-	wallclk = azx_readl(chip, WALLCLK) - azx_dev->start_wallclk;
-	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
-		return -1;	/* bogus (too early) interrupt */
-
-	pos = azx_get_position(chip, azx_dev, true);
-
-	if (WARN_ONCE(!azx_dev->period_bytes,
-		      "hda-intel: zero azx_dev->period_bytes"))
-		return -1; /* this shouldn't happen! */
-	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
-	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
-		/* NG - it's below the first next period boundary */
-		return chip->bdl_pos_adj[chip->dev_index] ? 0 : -1;
-	azx_dev->start_wallclk += wallclk;
-	return 1; /* OK, it's fine */
-}
-
 /*
  * The work for pending PCM period updates.
  */
@@ -2220,99 +1220,6 @@ static void azx_clear_irq_pending(struct azx *chip)
 	spin_unlock_irq(&chip->reg_lock);
 }
 
-#ifdef CONFIG_X86
-static int azx_pcm_mmap(struct snd_pcm_substream *substream,
-			struct vm_area_struct *area)
-{
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip))
-		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
-	return snd_pcm_lib_default_mmap(substream, area);
-}
-#else
-#define azx_pcm_mmap	NULL
-#endif
-
-static struct snd_pcm_ops azx_pcm_ops = {
-	.open = azx_pcm_open,
-	.close = azx_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = azx_pcm_hw_params,
-	.hw_free = azx_pcm_hw_free,
-	.prepare = azx_pcm_prepare,
-	.trigger = azx_pcm_trigger,
-	.pointer = azx_pcm_pointer,
-	.wall_clock =  azx_get_wallclock_tstamp,
-	.mmap = azx_pcm_mmap,
-	.page = snd_pcm_sgbuf_ops_page,
-};
-
-static void azx_pcm_free(struct snd_pcm *pcm)
-{
-	struct azx_pcm *apcm = pcm->private_data;
-	if (apcm) {
-		list_del(&apcm->list);
-		kfree(apcm);
-	}
-}
-
-#define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
-
-static int
-azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
-		      struct hda_pcm *cpcm)
-{
-	struct azx *chip = bus->private_data;
-	struct snd_pcm *pcm;
-	struct azx_pcm *apcm;
-	int pcm_dev = cpcm->device;
-	unsigned int size;
-	int s, err;
-
-	list_for_each_entry(apcm, &chip->pcm_list, list) {
-		if (apcm->pcm->device == pcm_dev) {
-			dev_err(chip->card->dev, "PCM %d already exists\n",
-				pcm_dev);
-			return -EBUSY;
-		}
-	}
-	err = snd_pcm_new(chip->card, cpcm->name, pcm_dev,
-			  cpcm->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams,
-			  cpcm->stream[SNDRV_PCM_STREAM_CAPTURE].substreams,
-			  &pcm);
-	if (err < 0)
-		return err;
-	strlcpy(pcm->name, cpcm->name, sizeof(pcm->name));
-	apcm = kzalloc(sizeof(*apcm), GFP_KERNEL);
-	if (apcm == NULL)
-		return -ENOMEM;
-	apcm->chip = chip;
-	apcm->pcm = pcm;
-	apcm->codec = codec;
-	pcm->private_data = apcm;
-	pcm->private_free = azx_pcm_free;
-	if (cpcm->pcm_type == HDA_PCM_TYPE_MODEM)
-		pcm->dev_class = SNDRV_PCM_CLASS_MODEM;
-	list_add_tail(&apcm->list, &chip->pcm_list);
-	cpcm->pcm = pcm;
-	for (s = 0; s < 2; s++) {
-		apcm->hinfo[s] = &cpcm->stream[s];
-		if (cpcm->stream[s].substreams)
-			snd_pcm_set_ops(pcm, s, &azx_pcm_ops);
-	}
-	/* buffer pre-allocation */
-	size = CONFIG_SND_HDA_PREALLOC_SIZE * 1024;
-	if (size > MAX_PREALLOC_SIZE)
-		size = MAX_PREALLOC_SIZE;
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      chip->card->dev,
-					      size, MAX_PREALLOC_SIZE);
-	/* link to codec */
-	pcm->dev = &codec->dev;
-	return 0;
-}
-
 /*
  * mixer creation - all stuff is implemented in hda module
  */
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
new file mode 100644
index 0000000..55b0538
--- /dev/null
+++ b/sound/pci/hda/hda_shared.c
@@ -0,0 +1,1105 @@
+/*
+ *
+ *  Implementation of primary alsa driver code base for Intel HD Audio.
+ *
+ *  Copyright(c) 2004 Intel Corporation. All rights reserved.
+ *
+ *  Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
+ *                     PeiSen Hou <pshou@realtek.com.tw>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *
+ */
+
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#ifdef CONFIG_X86
+/* for snoop control */
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+#endif
+#include <sound/core.h>
+#include <sound/initval.h>
+#include "hda_priv.h"
+#include "hda_shared.h"
+
+#define CREATE_TRACE_POINTS
+#include "hda_intel_trace.h"
+
+#ifdef CONFIG_X86
+void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
+{
+	int pages;
+
+	if (azx_snoop(chip))
+		return;
+	if (!dmab || !dmab->area || !dmab->bytes)
+		return;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
+		struct snd_sg_buf *sgbuf = dmab->private_data;
+		if (on)
+			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
+		else
+			set_pages_array_wb(sgbuf->page_table, sgbuf->pages);
+		return;
+	}
+#endif
+
+	pages = (dmab->bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (on)
+		set_memory_wc((unsigned long)dmab->area, pages);
+	else
+		set_memory_wb((unsigned long)dmab->area, pages);
+}
+
+void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf, bool on)
+{
+	__mark_pages_wc(chip, buf, on);
+}
+EXPORT_SYMBOL_GPL(mark_pages_wc);
+
+static void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
+			    struct snd_pcm_substream *substream, bool on)
+{
+	if (azx_dev->wc_marked != on) {
+		__mark_pages_wc(chip, snd_pcm_get_dma_buf(substream), on);
+		azx_dev->wc_marked = on;
+	}
+}
+#else
+static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
+				   struct snd_pcm_substream *substream, bool on)
+{
+}
+#endif
+
+/*
+ * AZX stream operations.
+ */
+
+/* start a stream */
+static void azx_stream_start(struct azx *chip, struct azx_dev *azx_dev)
+{
+	/*
+	 * Before stream start, initialize parameter
+	 */
+	azx_dev->insufficient = 1;
+
+	/* enable SIE */
+	azx_writel(chip, INTCTL,
+		   azx_readl(chip, INTCTL) | (1 << azx_dev->index));
+	/* set DMA start and interrupt mask */
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) |
+		      SD_CTL_DMA_START | SD_INT_MASK);
+}
+
+/* stop DMA */
+static void azx_stream_clear(struct azx *chip, struct azx_dev *azx_dev)
+{
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) &
+		      ~(SD_CTL_DMA_START | SD_INT_MASK));
+	azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
+}
+
+/* stop a stream */
+void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev)
+{
+	azx_stream_clear(chip, azx_dev);
+	/* disable SIE */
+	azx_writel(chip, INTCTL,
+		   azx_readl(chip, INTCTL) & ~(1 << azx_dev->index));
+}
+EXPORT_SYMBOL_GPL(azx_stream_stop);
+
+/* reset stream */
+static void azx_stream_reset(struct azx *chip, struct azx_dev *azx_dev)
+{
+	unsigned char val;
+	int timeout;
+
+	azx_stream_clear(chip, azx_dev);
+
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) |
+		      SD_CTL_STREAM_RESET);
+	udelay(3);
+	timeout = 300;
+	while (!((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
+		 SD_CTL_STREAM_RESET) && --timeout)
+		;
+	val &= ~SD_CTL_STREAM_RESET;
+	azx_sd_writeb(chip, azx_dev, SD_CTL, val);
+	udelay(3);
+
+	timeout = 300;
+	/* waiting for hardware to report that the stream is out of reset */
+	while (((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
+		SD_CTL_STREAM_RESET) && --timeout)
+		;
+
+	/* reset first position - may not be synced with hw at this time */
+	*azx_dev->posbuf = 0;
+}
+
+/*
+ * set up the SD for streaming
+ */
+static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
+{
+	unsigned int val;
+	/* make sure the run bit is zero for SD */
+	azx_stream_clear(chip, azx_dev);
+	/* program the stream_tag */
+	val = azx_sd_readl(chip, azx_dev, SD_CTL);
+	val = (val & ~SD_CTL_STREAM_TAG_MASK) |
+		(azx_dev->stream_tag << SD_CTL_STREAM_TAG_SHIFT);
+	if (!azx_snoop(chip))
+		val |= SD_CTL_TRAFFIC_PRIO;
+	azx_sd_writel(chip, azx_dev, SD_CTL, val);
+
+	/* program the length of samples in cyclic buffer */
+	azx_sd_writel(chip, azx_dev, SD_CBL, azx_dev->bufsize);
+
+	/* program the stream format */
+	/* this value needs to be the same as the one programmed */
+	azx_sd_writew(chip, azx_dev, SD_FORMAT, azx_dev->format_val);
+
+	/* program the stream LVI (last valid index) of the BDL */
+	azx_sd_writew(chip, azx_dev, SD_LVI, azx_dev->frags - 1);
+
+	/* program the BDL address */
+	/* lower BDL address */
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, (u32)azx_dev->bdl.addr);
+	/* upper BDL address */
+	azx_sd_writel(chip, azx_dev, SD_BDLPU,
+		      upper_32_bits(azx_dev->bdl.addr));
+
+	/* enable the position buffer */
+	if (chip->position_fix[0] != POS_FIX_LPIB ||
+	    chip->position_fix[1] != POS_FIX_LPIB) {
+		if (!(azx_readl(chip, DPLBASE) & ICH6_DPLBASE_ENABLE))
+			azx_writel(chip, DPLBASE,
+				(u32)chip->posbuf.addr | ICH6_DPLBASE_ENABLE);
+	}
+
+	/* set the interrupt enable bits in the descriptor control register */
+	azx_sd_writel(chip, azx_dev, SD_CTL,
+		      azx_sd_readl(chip, azx_dev, SD_CTL) | SD_INT_MASK);
+
+	return 0;
+}
+
+/* assign a stream for the PCM */
+static inline struct azx_dev *
+azx_assign_device(struct azx *chip, struct snd_pcm_substream *substream)
+{
+	int dev, i, nums;
+	struct azx_dev *res = NULL;
+	/* make a non-zero unique key for the substream */
+	int key = (substream->pcm->device << 16) | (substream->number << 2) |
+		(substream->stream + 1);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dev = chip->playback_index_offset;
+		nums = chip->playback_streams;
+	} else {
+		dev = chip->capture_index_offset;
+		nums = chip->capture_streams;
+	}
+	for (i = 0; i < nums; i++, dev++) {
+		struct azx_dev *azx_dev = &chip->azx_dev[dev];
+		dsp_lock(azx_dev);
+		if (!azx_dev->opened && !dsp_is_locked(azx_dev)) {
+			res = azx_dev;
+			if (res->assigned_key == key) {
+				res->opened = 1;
+				res->assigned_key = key;
+				dsp_unlock(azx_dev);
+				return azx_dev;
+			}
+		}
+		dsp_unlock(azx_dev);
+	}
+	if (res) {
+		dsp_lock(res);
+		res->opened = 1;
+		res->assigned_key = key;
+		dsp_unlock(res);
+	}
+	return res;
+}
+
+/* release the assigned stream */
+static inline void azx_release_device(struct azx_dev *azx_dev)
+{
+	azx_dev->opened = 0;
+}
+
+static cycle_t azx_cc_read(const struct cyclecounter *cc)
+{
+	struct azx_dev *azx_dev = container_of(cc, struct azx_dev, azx_cc);
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+
+	return azx_readl(chip, WALLCLK);
+}
+
+static void azx_timecounter_init(struct snd_pcm_substream *substream,
+				bool force, cycle_t last)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct timecounter *tc = &azx_dev->azx_tc;
+	struct cyclecounter *cc = &azx_dev->azx_cc;
+	u64 nsec;
+
+	cc->read = azx_cc_read;
+	cc->mask = CLOCKSOURCE_MASK(32);
+
+	/*
+	 * Converting from 24 MHz to ns means applying a 125/3 factor.
+	 * To avoid any saturation issues in intermediate operations,
+	 * the 125 factor is applied first. The division is applied
+	 * last after reading the timecounter value.
+	 * Applying the 1/3 factor as part of the multiplication
+	 * requires at least 20 bits for a decent precision, however
+	 * overflows occur after about 4 hours or less, not a option.
+	 */
+
+	cc->mult = 125; /* saturation after 195 years */
+	cc->shift = 0;
+
+	nsec = 0; /* audio time is elapsed time since trigger */
+	timecounter_init(tc, cc, nsec);
+	if (force)
+		/*
+		 * force timecounter to use predefined value,
+		 * used for synchronized starts
+		 */
+		tc->cycle_last = last;
+}
+
+static u64 azx_adjust_codec_delay(struct snd_pcm_substream *substream,
+				u64 nsec)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	u64 codec_frames, codec_nsecs;
+
+	if (!hinfo->ops.get_delay)
+		return nsec;
+
+	codec_frames = hinfo->ops.get_delay(hinfo, apcm->codec, substream);
+	codec_nsecs = div_u64(codec_frames * 1000000000LL,
+			      substream->runtime->rate);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return nsec + codec_nsecs;
+
+	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
+}
+
+/*
+ * set up a BDL entry
+ */
+static int setup_bdle(struct azx *chip,
+		      struct snd_dma_buffer *dmab,
+		      struct azx_dev *azx_dev, u32 **bdlp,
+		      int ofs, int size, int with_ioc)
+{
+	u32 *bdl = *bdlp;
+
+	while (size > 0) {
+		dma_addr_t addr;
+		int chunk;
+
+		if (azx_dev->frags >= AZX_MAX_BDL_ENTRIES)
+			return -EINVAL;
+
+		addr = snd_sgbuf_get_addr(dmab, ofs);
+		/* program the address field of the BDL entry */
+		bdl[0] = cpu_to_le32((u32)addr);
+		bdl[1] = cpu_to_le32(upper_32_bits(addr));
+		/* program the size field of the BDL entry */
+		chunk = snd_sgbuf_get_chunk_size(dmab, ofs, size);
+		/* one BDLE cannot cross 4K boundary on CTHDA chips */
+		if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY) {
+			u32 remain = 0x1000 - (ofs & 0xfff);
+			if (chunk > remain)
+				chunk = remain;
+		}
+		bdl[2] = cpu_to_le32(chunk);
+		/* program the IOC to enable interrupt
+		 * only when the whole fragment is processed
+		 */
+		size -= chunk;
+		bdl[3] = (size || !with_ioc) ? 0 : cpu_to_le32(0x01);
+		bdl += 4;
+		azx_dev->frags++;
+		ofs += chunk;
+	}
+	*bdlp = bdl;
+	return ofs;
+}
+
+/*
+ * set up BDL entries
+ */
+static int azx_setup_periods(struct azx *chip,
+			     struct snd_pcm_substream *substream,
+			     struct azx_dev *azx_dev)
+{
+	u32 *bdl;
+	int i, ofs, periods, period_bytes;
+	int pos_adj;
+
+	/* reset BDL address */
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+
+	period_bytes = azx_dev->period_bytes;
+	periods = azx_dev->bufsize / period_bytes;
+
+	/* program the initial BDL entries */
+	bdl = (u32 *)azx_dev->bdl.area;
+	ofs = 0;
+	azx_dev->frags = 0;
+	pos_adj = chip->bdl_pos_adj[chip->dev_index];
+	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		int pos_align = pos_adj;
+		pos_adj = (pos_adj * runtime->rate + 47999) / 48000;
+		if (!pos_adj)
+			pos_adj = pos_align;
+		else
+			pos_adj = ((pos_adj + pos_align - 1) / pos_align) *
+				pos_align;
+		pos_adj = frames_to_bytes(runtime, pos_adj);
+		if (pos_adj >= period_bytes) {
+			dev_warn(chip->card->dev,"Too big adjustment %d\n",
+				 chip->bdl_pos_adj[chip->dev_index]);
+			pos_adj = 0;
+		} else {
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev,
+					 &bdl, ofs, pos_adj, true);
+			if (ofs < 0)
+				goto error;
+		}
+	} else
+		pos_adj = 0;
+	for (i = 0; i < periods; i++) {
+		if (i == periods - 1 && pos_adj)
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
+					 period_bytes - pos_adj, 0);
+		else
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
+					 period_bytes,
+					 !azx_dev->no_period_wakeup);
+		if (ofs < 0)
+			goto error;
+	}
+	return 0;
+
+ error:
+	dev_err(chip->card->dev, "Too many BDL entries: buffer=%d, period=%d\n",
+		azx_dev->bufsize, period_bytes);
+	return -EINVAL;
+}
+
+/*
+ * PCM ops
+ */
+
+static int azx_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	unsigned long flags;
+
+	mutex_lock(&chip->open_mutex);
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	azx_dev->substream = NULL;
+	azx_dev->running = 0;
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	azx_release_device(azx_dev);
+	hinfo->ops.close(hinfo, apcm->codec, substream);
+	snd_hda_power_down(apcm->codec);
+	mutex_unlock(&chip->open_mutex);
+	return 0;
+}
+
+static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	int ret;
+
+	dsp_lock(azx_dev);
+	if (dsp_is_locked(azx_dev)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	mark_runtime_wc(chip, azx_dev, substream, false);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+	ret = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (ret < 0)
+		goto unlock;
+	mark_runtime_wc(chip, azx_dev, substream, true);
+ unlock:
+	dsp_unlock(azx_dev);
+	return ret;
+}
+
+static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct azx *chip = apcm->chip;
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+
+	/* reset BDL address */
+	dsp_lock(azx_dev);
+	if (!dsp_is_locked(azx_dev)) {
+		azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+		azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+		azx_sd_writel(chip, azx_dev, SD_CTL, 0);
+		azx_dev->bufsize = 0;
+		azx_dev->period_bytes = 0;
+		azx_dev->format_val = 0;
+	}
+
+	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
+
+	mark_runtime_wc(chip, azx_dev, substream, false);
+	azx_dev->prepared = 0;
+	dsp_unlock(azx_dev);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int azx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int bufsize, period_bytes, format_val, stream_tag;
+	int err;
+	struct hda_spdif_out *spdif =
+		snd_hda_spdif_out_of_nid(apcm->codec, hinfo->nid);
+	unsigned short ctls = spdif ? spdif->ctls : 0;
+
+	dsp_lock(azx_dev);
+	if (dsp_is_locked(azx_dev)) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	azx_stream_reset(chip, azx_dev);
+	format_val = snd_hda_calc_stream_format(runtime->rate,
+						runtime->channels,
+						runtime->format,
+						hinfo->maxbps,
+						ctls);
+	if (!format_val) {
+		dev_err(chip->card->dev,
+			"invalid format_val, rate=%d, ch=%d, format=%d\n",
+			runtime->rate, runtime->channels, runtime->format);
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	bufsize = snd_pcm_lib_buffer_bytes(substream);
+	period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	dev_dbg(chip->card->dev, "azx_pcm_prepare: bufsize=0x%x, format=0x%x\n",
+		bufsize, format_val);
+
+	if (bufsize != azx_dev->bufsize ||
+	    period_bytes != azx_dev->period_bytes ||
+	    format_val != azx_dev->format_val ||
+	    runtime->no_period_wakeup != azx_dev->no_period_wakeup) {
+		azx_dev->bufsize = bufsize;
+		azx_dev->period_bytes = period_bytes;
+		azx_dev->format_val = format_val;
+		azx_dev->no_period_wakeup = runtime->no_period_wakeup;
+		err = azx_setup_periods(chip, substream, azx_dev);
+		if (err < 0)
+			goto unlock;
+	}
+
+	/* when LPIB delay correction gives a small negative value,
+	 * we ignore it; currently set the threshold statically to
+	 * 64 frames
+	 */
+	if (runtime->period_size > 64)
+		azx_dev->delay_negative_threshold = -frames_to_bytes(runtime, 64);
+	else
+		azx_dev->delay_negative_threshold = 0;
+
+	/* wallclk has 24Mhz clock source */
+	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
+						runtime->rate) * 1000);
+	azx_setup_controller(chip, azx_dev);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		azx_dev->fifo_size =
+			azx_sd_readw(chip, azx_dev, SD_FIFOSIZE) + 1;
+	else
+		azx_dev->fifo_size = 0;
+
+	stream_tag = azx_dev->stream_tag;
+	/* CA-IBG chips need the playback stream starting from 1 */
+	if ((chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND) &&
+	    stream_tag > chip->capture_streams)
+		stream_tag -= chip->capture_streams;
+	err = snd_hda_codec_prepare(apcm->codec, hinfo, stream_tag,
+				     azx_dev->format_val, substream);
+
+ unlock:
+	if (!err)
+		azx_dev->prepared = 1;
+	dsp_unlock(azx_dev);
+	return err;
+}
+
+static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev;
+	struct snd_pcm_substream *s;
+	int rstart = 0, start, nsync = 0, sbits = 0;
+	int nwait, timeout;
+
+	azx_dev = get_azx_dev(substream);
+	trace_azx_pcm_trigger(chip, azx_dev, cmd);
+
+	if (dsp_is_locked(azx_dev) || !azx_dev->prepared)
+		return -EPIPE;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		rstart = 1;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		start = 1;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		start = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
+		azx_dev = get_azx_dev(s);
+		sbits |= 1 << azx_dev->index;
+		nsync++;
+		snd_pcm_trigger_done(s, substream);
+	}
+
+	spin_lock(&chip->reg_lock);
+
+	/* first, set SYNC bits of corresponding streams */
+	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
+		azx_writel(chip, OLD_SSYNC,
+			azx_readl(chip, OLD_SSYNC) | sbits);
+	else
+		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) | sbits);
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
+		azx_dev = get_azx_dev(s);
+		if (start) {
+			azx_dev->start_wallclk = azx_readl(chip, WALLCLK);
+			if (!rstart)
+				azx_dev->start_wallclk -=
+						azx_dev->period_wallclk;
+			azx_stream_start(chip, azx_dev);
+		} else {
+			azx_stream_stop(chip, azx_dev);
+		}
+		azx_dev->running = start;
+	}
+	spin_unlock(&chip->reg_lock);
+	if (start) {
+		/* wait until all FIFOs get ready */
+		for (timeout = 5000; timeout; timeout--) {
+			nwait = 0;
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s->pcm->card != substream->pcm->card)
+					continue;
+				azx_dev = get_azx_dev(s);
+				if (!(azx_sd_readb(chip, azx_dev, SD_STS) &
+				      SD_STS_FIFO_READY))
+					nwait++;
+			}
+			if (!nwait)
+				break;
+			cpu_relax();
+		}
+	} else {
+		/* wait until all RUN bits are cleared */
+		for (timeout = 5000; timeout; timeout--) {
+			nwait = 0;
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s->pcm->card != substream->pcm->card)
+					continue;
+				azx_dev = get_azx_dev(s);
+				if (azx_sd_readb(chip, azx_dev, SD_CTL) &
+				    SD_CTL_DMA_START)
+					nwait++;
+			}
+			if (!nwait)
+				break;
+			cpu_relax();
+		}
+	}
+	spin_lock(&chip->reg_lock);
+	/* reset SYNC bits */
+	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
+		azx_writel(chip, OLD_SSYNC,
+			azx_readl(chip, OLD_SSYNC) & ~sbits);
+	else
+		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
+	if (start) {
+		azx_timecounter_init(substream, 0, 0);
+		if (nsync > 1) {
+			cycle_t cycle_last;
+
+			/* same start cycle for master and group */
+			azx_dev = get_azx_dev(substream);
+			cycle_last = azx_dev->azx_tc.cycle_last;
+
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s->pcm->card != substream->pcm->card)
+					continue;
+				azx_timecounter_init(s, 1, cycle_last);
+			}
+		}
+	}
+	spin_unlock(&chip->reg_lock);
+	return 0;
+}
+
+/* get the current DMA position with correction on VIA chips */
+static unsigned int azx_via_get_position(struct azx *chip,
+					 struct azx_dev *azx_dev)
+{
+	unsigned int link_pos, mini_pos, bound_pos;
+	unsigned int mod_link_pos, mod_dma_pos, mod_mini_pos;
+	unsigned int fifo_size;
+
+	link_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
+	if (azx_dev->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* Playback, no problem using link position */
+		return link_pos;
+	}
+
+	/* Capture */
+	/* For new chipset,
+	 * use mod to get the DMA position just like old chipset
+	 */
+	mod_dma_pos = le32_to_cpu(*azx_dev->posbuf);
+	mod_dma_pos %= azx_dev->period_bytes;
+
+	/* azx_dev->fifo_size can't get FIFO size of in stream.
+	 * Get from base address + offset.
+	 */
+	fifo_size = readw(chip->remap_addr + VIA_IN_STREAM0_FIFO_SIZE_OFFSET);
+
+	if (azx_dev->insufficient) {
+		/* Link position never gather than FIFO size */
+		if (link_pos <= fifo_size)
+			return 0;
+
+		azx_dev->insufficient = 0;
+	}
+
+	if (link_pos <= fifo_size)
+		mini_pos = azx_dev->bufsize + link_pos - fifo_size;
+	else
+		mini_pos = link_pos - fifo_size;
+
+	/* Find nearest previous boudary */
+	mod_mini_pos = mini_pos % azx_dev->period_bytes;
+	mod_link_pos = link_pos % azx_dev->period_bytes;
+	if (mod_link_pos >= fifo_size)
+		bound_pos = link_pos - mod_link_pos;
+	else if (mod_dma_pos >= mod_mini_pos)
+		bound_pos = mini_pos - mod_mini_pos;
+	else {
+		bound_pos = mini_pos - mod_mini_pos + azx_dev->period_bytes;
+		if (bound_pos >= azx_dev->bufsize)
+			bound_pos = 0;
+	}
+
+	/* Calculate real DMA position we want */
+	return bound_pos + mod_dma_pos;
+}
+
+static unsigned int azx_get_position(struct azx *chip,
+				     struct azx_dev *azx_dev,
+				     bool with_check)
+{
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	unsigned int pos;
+	int stream = substream->stream;
+	struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
+	int delay = 0;
+
+	switch (chip->position_fix[stream]) {
+	case POS_FIX_LPIB:
+		/* read LPIB */
+		pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
+		break;
+	case POS_FIX_VIACOMBO:
+		pos = azx_via_get_position(chip, azx_dev);
+		break;
+	default:
+		/* use the position buffer */
+		pos = le32_to_cpu(*azx_dev->posbuf);
+		if (with_check && chip->position_fix[stream] == POS_FIX_AUTO) {
+			if (!pos || pos == (u32)-1) {
+				dev_info(chip->card->dev,
+					 "Invalid position buffer, using LPIB read method instead.\n");
+				chip->position_fix[stream] = POS_FIX_LPIB;
+				pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
+			} else
+				chip->position_fix[stream] = POS_FIX_POSBUF;
+		}
+		break;
+	}
+
+	if (pos >= azx_dev->bufsize)
+		pos = 0;
+
+	/* calculate runtime delay from LPIB */
+	if (substream->runtime &&
+	    chip->position_fix[stream] == POS_FIX_POSBUF &&
+	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
+		unsigned int lpib_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			delay = pos - lpib_pos;
+		else
+			delay = lpib_pos - pos;
+		if (delay < 0) {
+			if (delay >= azx_dev->delay_negative_threshold)
+				delay = 0;
+			else
+				delay += azx_dev->bufsize;
+		}
+		if (delay >= azx_dev->period_bytes) {
+			dev_info(chip->card->dev,
+				 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
+				 delay, azx_dev->period_bytes);
+			delay = 0;
+			chip->driver_caps &= ~AZX_DCAPS_COUNT_LPIB_DELAY;
+		}
+		delay = bytes_to_frames(substream->runtime, delay);
+	}
+
+	if (substream->runtime) {
+		if (hinfo->ops.get_delay)
+			delay += hinfo->ops.get_delay(hinfo, apcm->codec,
+						      substream);
+		substream->runtime->delay = delay;
+	}
+
+	trace_azx_get_position(chip, azx_dev, pos, delay);
+	return pos;
+}
+
+static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	return bytes_to_frames(substream->runtime,
+			       azx_get_position(chip, azx_dev, false));
+}
+
+static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
+				struct timespec *ts)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	u64 nsec;
+
+	nsec = timecounter_read(&azx_dev->azx_tc);
+	nsec = div_u64(nsec, 3); /* can be optimized */
+	nsec = azx_adjust_codec_delay(substream, nsec);
+
+	*ts = ns_to_timespec(nsec);
+
+	return 0;
+}
+
+static struct snd_pcm_hardware azx_pcm_hw = {
+	.info =			(SNDRV_PCM_INFO_MMAP |
+				 SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 /* No full-resume yet implemented */
+				 /* SNDRV_PCM_INFO_RESUME |*/
+				 SNDRV_PCM_INFO_PAUSE |
+				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
+				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
+	.period_bytes_min =	128,
+	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
+	.periods_min =		2,
+	.periods_max =		AZX_MAX_FRAG,
+	.fifo_size =		0,
+};
+
+static int azx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct azx *chip = apcm->chip;
+	struct azx_dev *azx_dev;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long flags;
+	int err;
+	int buff_step;
+
+	mutex_lock(&chip->open_mutex);
+	azx_dev = azx_assign_device(chip, substream);
+	if (azx_dev == NULL) {
+		mutex_unlock(&chip->open_mutex);
+		return -EBUSY;
+	}
+	runtime->hw = azx_pcm_hw;
+	runtime->hw.channels_min = hinfo->channels_min;
+	runtime->hw.channels_max = hinfo->channels_max;
+	runtime->hw.formats = hinfo->formats;
+	runtime->hw.rates = hinfo->rates;
+	snd_pcm_limit_hw_rates(runtime);
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	/* avoid wrap-around with wall-clock */
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
+				20,
+				178000000);
+
+	if (chip->align_buffer_size)
+		/* constrain buffer sizes to be multiple of 128
+		   bytes. This is more efficient in terms of memory
+		   access but isn't required by the HDA spec and
+		   prevents users from specifying exact period/buffer
+		   sizes. For example for 44.1kHz, a period size set
+		   to 20ms will be rounded to 19.59ms. */
+		buff_step = 128;
+	else
+		/* Don't enforce steps on buffer sizes, still need to
+		   be multiple of 4 bytes (HDA spec). Tested on Intel
+		   HDA controllers, may not work on all devices where
+		   option needs to be disabled */
+		buff_step = 4;
+
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   buff_step);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   buff_step);
+	snd_hda_power_up_d3wait(apcm->codec);
+	err = hinfo->ops.open(hinfo, apcm->codec, substream);
+	if (err < 0) {
+		azx_release_device(azx_dev);
+		snd_hda_power_down(apcm->codec);
+		mutex_unlock(&chip->open_mutex);
+		return err;
+	}
+	snd_pcm_limit_hw_rates(runtime);
+	/* sanity check */
+	if (snd_BUG_ON(!runtime->hw.channels_min) ||
+	    snd_BUG_ON(!runtime->hw.channels_max) ||
+	    snd_BUG_ON(!runtime->hw.formats) ||
+	    snd_BUG_ON(!runtime->hw.rates)) {
+		azx_release_device(azx_dev);
+		hinfo->ops.close(hinfo, apcm->codec, substream);
+		snd_hda_power_down(apcm->codec);
+		mutex_unlock(&chip->open_mutex);
+		return -EINVAL;
+	}
+
+	/* disable WALLCLOCK timestamps for capture streams
+	   until we figure out how to handle digital inputs */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	azx_dev->substream = substream;
+	azx_dev->running = 0;
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+	runtime->private_data = azx_dev;
+	snd_pcm_set_sync(substream);
+	mutex_unlock(&chip->open_mutex);
+	return 0;
+}
+
+#ifdef CONFIG_X86
+static int azx_pcm_mmap(struct snd_pcm_substream *substream,
+			struct vm_area_struct *area)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	if (!azx_snoop(chip))
+		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+	return snd_pcm_lib_default_mmap(substream, area);
+}
+#else
+#define azx_pcm_mmap	NULL
+#endif
+
+static struct snd_pcm_ops azx_pcm_ops = {
+	.open = azx_pcm_open,
+	.close = azx_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = azx_pcm_hw_params,
+	.hw_free = azx_pcm_hw_free,
+	.prepare = azx_pcm_prepare,
+	.trigger = azx_pcm_trigger,
+	.pointer = azx_pcm_pointer,
+	.wall_clock =  azx_get_wallclock_tstamp,
+	.mmap = azx_pcm_mmap,
+	.page = snd_pcm_sgbuf_ops_page,
+};
+
+static void azx_pcm_free(struct snd_pcm *pcm)
+{
+	struct azx_pcm *apcm = pcm->private_data;
+	if (apcm) {
+		list_del(&apcm->list);
+		kfree(apcm);
+	}
+}
+
+#define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
+
+int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
+			  struct hda_pcm *cpcm)
+{
+	struct azx *chip = bus->private_data;
+	struct snd_pcm *pcm;
+	struct azx_pcm *apcm;
+	int pcm_dev = cpcm->device;
+	unsigned int size;
+	int s, err;
+
+	list_for_each_entry(apcm, &chip->pcm_list, list) {
+		if (apcm->pcm->device == pcm_dev) {
+			dev_err(chip->card->dev, "PCM %d already exists\n",
+				pcm_dev);
+			return -EBUSY;
+		}
+	}
+	err = snd_pcm_new(chip->card, cpcm->name, pcm_dev,
+			  cpcm->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams,
+			  cpcm->stream[SNDRV_PCM_STREAM_CAPTURE].substreams,
+			  &pcm);
+	if (err < 0)
+		return err;
+	strlcpy(pcm->name, cpcm->name, sizeof(pcm->name));
+	apcm = kzalloc(sizeof(*apcm), GFP_KERNEL);
+	if (apcm == NULL)
+		return -ENOMEM;
+	apcm->chip = chip;
+	apcm->pcm = pcm;
+	apcm->codec = codec;
+	pcm->private_data = apcm;
+	pcm->private_free = azx_pcm_free;
+	if (cpcm->pcm_type == HDA_PCM_TYPE_MODEM)
+		pcm->dev_class = SNDRV_PCM_CLASS_MODEM;
+	list_add_tail(&apcm->list, &chip->pcm_list);
+	cpcm->pcm = pcm;
+	for (s = 0; s < 2; s++) {
+		apcm->hinfo[s] = &cpcm->stream[s];
+		if (cpcm->stream[s].substreams)
+			snd_pcm_set_ops(pcm, s, &azx_pcm_ops);
+	}
+	/* buffer pre-allocation */
+	size = CONFIG_SND_HDA_PREALLOC_SIZE * 1024;
+	if (size > MAX_PREALLOC_SIZE)
+		size = MAX_PREALLOC_SIZE;
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+					      chip->card->dev,
+					      size, MAX_PREALLOC_SIZE);
+	/* link to codec */
+	pcm->dev = &codec->dev;
+	return 0;
+}
+
+/*
+ * Check whether the current DMA position is acceptable for updating
+ * periods.  Returns non-zero if it's OK.
+ *
+ * Many HD-audio controllers appear pretty inaccurate about
+ * the update-IRQ timing.  The IRQ is issued before actually the
+ * data is processed.  So, we need to process it afterwords in a
+ * workqueue.
+ */
+int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
+{
+	u32 wallclk;
+	unsigned int pos;
+
+	wallclk = azx_readl(chip, WALLCLK) - azx_dev->start_wallclk;
+	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
+		return -1;	/* bogus (too early) interrupt */
+
+	pos = azx_get_position(chip, azx_dev, true);
+
+	if (WARN_ONCE(!azx_dev->period_bytes,
+		      "hda-intel: zero azx_dev->period_bytes"))
+		return -1; /* this shouldn't happen! */
+	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
+	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
+		/* NG - it's below the first next period boundary */
+		return chip->bdl_pos_adj[chip->dev_index] ? 0 : -1;
+	azx_dev->start_wallclk += wallclk;
+	return 1; /* OK, it's fine */
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
new file mode 100644
index 0000000..bc06d34
--- /dev/null
+++ b/sound/pci/hda/hda_shared.h
@@ -0,0 +1,58 @@
+/*
+ *  Common functionality for the alsa driver code base for HD Audio.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ */
+
+#ifndef __SOUND_HDA_SHARED_H
+#define __SOUND_HDA_SHARED_H
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include "hda_codec.h"
+#include "hda_priv.h"
+
+#ifdef CONFIG_X86
+void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf, bool on);
+#else
+/* NOP for other archs */
+static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
+				 bool on)
+{
+}
+#endif
+
+/* PCM setup */
+int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
+			  struct hda_pcm *cpcm);
+int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
+static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
+{
+	return substream->runtime->private_data;
+}
+
+/* Stream control. */
+void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev);
+
+/* DSP lock helpers */
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
+#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
+#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
+#define dsp_is_locked(dev)	((dev)->locked)
+#else
+#define dsp_lock_init(dev)	do {} while (0)
+#define dsp_lock(dev)		do {} while (0)
+#define dsp_unlock(dev)		do {} while (0)
+#define dsp_is_locked(dev)	0
+#endif
+
+#endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
