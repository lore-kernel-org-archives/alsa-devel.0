From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: hda - Make position_fix as generic
	callback
Date: Mon, 30 Jun 2014 14:20:57 +0200
Message-ID: <1404130862-3152-3-git-send-email-tiwai@suse.de>
References: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E75026557E
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 79A38AD5B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
In-Reply-To: <1404130862-3152-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... and move most parts into hda_intel.c from the generic controller
code.  This is a clean up, and there should be no functional change by
this patch.

Now, struct azx obtains the generic callbacks for getting the position
and the delay.  As default NULL, posbuf is read.  These replace the
old position_fix[], and each is implemented as a callback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 127 ++++++----------------------------
 sound/pci/hda/hda_controller.h |   6 +-
 sound/pci/hda/hda_intel.c      | 151 ++++++++++++++++++++++++++++++++++++++---
 sound/pci/hda/hda_priv.h       |  17 ++---
 sound/pci/hda/hda_tegra.c      |   2 -
 5 files changed, 174 insertions(+), 129 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 875e0ebf56eb..a562d86c02fb 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -152,8 +152,8 @@ static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
 		      upper_32_bits(azx_dev->bdl.addr));
 
 	/* enable the position buffer */
-	if (chip->position_fix[0] != POS_FIX_LPIB ||
-	    chip->position_fix[1] != POS_FIX_LPIB) {
+	if (chip->get_position[0] != azx_get_pos_lpib ||
+	    chip->get_position[1] != azx_get_pos_lpib) {
 		if (!(azx_readl(chip, DPLBASE) & ICH6_DPLBASE_ENABLE))
 			azx_writel(chip, DPLBASE,
 				(u32)chip->posbuf.addr | ICH6_DPLBASE_ENABLE);
@@ -673,125 +673,40 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-/* get the current DMA position with correction on VIA chips */
-static unsigned int azx_via_get_position(struct azx *chip,
-					 struct azx_dev *azx_dev)
+unsigned int azx_get_pos_lpib(struct azx *chip, struct azx_dev *azx_dev)
 {
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
+	return azx_sd_readl(chip, azx_dev, SD_LPIB);
+}
+EXPORT_SYMBOL_GPL(azx_get_pos_lpib);
 
-	/* Calculate real DMA position we want */
-	return bound_pos + mod_dma_pos;
+unsigned int azx_get_pos_posbuf(struct azx *chip, struct azx_dev *azx_dev)
+{
+	return le32_to_cpu(*azx_dev->posbuf);
 }
+EXPORT_SYMBOL_GPL(azx_get_pos_posbuf);
 
 unsigned int azx_get_position(struct azx *chip,
-			      struct azx_dev *azx_dev,
-			      bool with_check)
+			      struct azx_dev *azx_dev)
 {
 	struct snd_pcm_substream *substream = azx_dev->substream;
-	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	unsigned int pos;
 	int stream = substream->stream;
-	struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
 	int delay = 0;
 
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
+	if (chip->get_position[stream])
+		pos = chip->get_position[stream](chip, azx_dev);
+	else /* use the position buffer as default */
+		pos = azx_get_pos_posbuf(chip, azx_dev);
 
 	if (pos >= azx_dev->bufsize)
 		pos = 0;
 
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
 	if (substream->runtime) {
+		struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+		struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
+
+		if (chip->get_delay[stream])
+			delay += chip->get_delay[stream](chip, azx_dev, pos);
 		if (hinfo->ops.get_delay)
 			delay += hinfo->ops.get_delay(hinfo, apcm->codec,
 						      substream);
@@ -809,7 +724,7 @@ static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	return bytes_to_frames(substream->runtime,
-			       azx_get_position(chip, azx_dev, false));
+			       azx_get_position(chip, azx_dev));
 }
 
 static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index baf0e77330af..91f04958e2b0 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -25,9 +25,9 @@ static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 {
 	return substream->runtime->private_data;
 }
-unsigned int azx_get_position(struct azx *chip,
-			      struct azx_dev *azx_dev,
-			      bool with_check);
+unsigned int azx_get_position(struct azx *chip, struct azx_dev *azx_dev);
+unsigned int azx_get_pos_lpib(struct azx *chip, struct azx_dev *azx_dev);
+unsigned int azx_get_pos_posbuf(struct azx *chip, struct azx_dev *azx_dev);
 
 /* Stream control. */
 void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 25753db97071..cb5d807bbd0c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -66,6 +66,15 @@
 #include "hda_controller.h"
 #include "hda_priv.h"
 
+/* position fix mode */
+enum {
+	POS_FIX_AUTO,
+	POS_FIX_LPIB,
+	POS_FIX_POSBUF,
+	POS_FIX_VIACOMBO,
+	POS_FIX_COMBO,
+};
+
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
@@ -434,6 +443,38 @@ static void azx_init_pci(struct azx *chip)
         }
 }
 
+/* calculate runtime delay from LPIB */
+static int azx_get_delay_from_lpib(struct azx *chip, struct azx_dev *azx_dev,
+				   unsigned int pos)
+{
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	int stream = substream->stream;
+	unsigned int lpib_pos = azx_get_pos_lpib(chip, azx_dev);
+	int delay;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = pos - lpib_pos;
+	else
+		delay = lpib_pos - pos;
+	if (delay < 0) {
+		if (delay >= azx_dev->delay_negative_threshold)
+			delay = 0;
+		else
+			delay += azx_dev->bufsize;
+	}
+
+	if (delay >= azx_dev->period_bytes) {
+		dev_info(chip->card->dev,
+			 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
+			 delay, azx_dev->period_bytes);
+		delay = 0;
+		chip->driver_caps &= ~AZX_DCAPS_COUNT_LPIB_DELAY;
+		chip->get_delay[stream] = NULL;
+	}
+
+	return bytes_to_frames(substream->runtime, delay);
+}
+
 static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
 
 /* called from IRQ */
@@ -464,6 +505,8 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
  */
 static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 {
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	int stream = substream->stream;
 	u32 wallclk;
 	unsigned int pos;
 
@@ -471,7 +514,25 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
 		return -1;	/* bogus (too early) interrupt */
 
-	pos = azx_get_position(chip, azx_dev, true);
+	if (chip->get_position[stream])
+		pos = chip->get_position[stream](chip, azx_dev);
+	else { /* use the position buffer as default */
+		pos = azx_get_pos_posbuf(chip, azx_dev);
+		if (!pos || pos == (u32)-1) {
+			dev_info(chip->card->dev,
+				 "Invalid position buffer, using LPIB read method instead.\n");
+			chip->get_position[stream] = azx_get_pos_lpib;
+			pos = azx_get_pos_lpib(chip, azx_dev);
+			chip->get_delay[stream] = NULL;
+		} else {
+			chip->get_position[stream] = azx_get_pos_posbuf;
+			if (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)
+				chip->get_delay[stream] = azx_get_delay_from_lpib;
+		}
+	}
+
+	if (pos >= azx_dev->bufsize)
+		pos = 0;
 
 	if (WARN_ONCE(!azx_dev->period_bytes,
 		      "hda-intel: zero azx_dev->period_bytes"))
@@ -554,6 +615,62 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 	return 0;
 }
 
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
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
@@ -1084,6 +1201,30 @@ static int check_position_fix(struct azx *chip, int fix)
 	return POS_FIX_AUTO;
 }
 
+static void assign_position_fix(struct azx *chip, int fix)
+{
+	static azx_get_pos_callback_t callbacks[] = {
+		[POS_FIX_AUTO] = NULL,
+		[POS_FIX_LPIB] = azx_get_pos_lpib,
+		[POS_FIX_POSBUF] = azx_get_pos_posbuf,
+		[POS_FIX_VIACOMBO] = azx_via_get_position,
+		[POS_FIX_COMBO] = azx_get_pos_lpib,
+	};
+
+	chip->get_position[0] = chip->get_position[1] = callbacks[fix];
+
+	/* combo mode uses LPIB only for playback */
+	if (fix == POS_FIX_COMBO)
+		chip->get_position[1] = NULL;
+
+	if (fix == POS_FIX_POSBUF &&
+	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
+		chip->get_delay[0] = chip->get_delay[1] =
+			azx_get_delay_from_lpib;
+	}
+
+}
+
 /*
  * black-lists for probe_mask
  */
@@ -1258,13 +1399,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	init_vga_switcheroo(chip);
 	init_completion(&chip->probe_wait);
 
-	chip->position_fix[0] = chip->position_fix[1] =
-		check_position_fix(chip, position_fix[dev]);
-	/* combo mode uses LPIB for playback */
-	if (chip->position_fix[0] == POS_FIX_COMBO) {
-		chip->position_fix[0] = POS_FIX_LPIB;
-		chip->position_fix[1] = POS_FIX_AUTO;
-	}
+	assign_position_fix(chip, check_position_fix(chip, position_fix[dev]));
 
 	check_probe_mask(chip, dev);
 
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index da12d10b778f..43dd8a19cc09 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -188,15 +188,6 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 
-/* position fix mode */
-enum {
-	POS_FIX_AUTO,
-	POS_FIX_LPIB,
-	POS_FIX_POSBUF,
-	POS_FIX_VIACOMBO,
-	POS_FIX_COMBO,
-};
-
 /* Defines for ATI HD Audio support in SB450 south bridge */
 #define ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR   0x42
 #define ATI_SB450_HDAUDIO_ENABLE_SNOOP      0x02
@@ -321,6 +312,9 @@ struct azx_pcm {
 	struct list_head list;
 };
 
+typedef unsigned int (*azx_get_pos_callback_t)(struct azx *, struct azx_dev *);
+typedef int (*azx_get_delay_callback_t)(struct azx *, struct azx_dev *, unsigned int pos);
+
 struct azx {
 	struct snd_card *card;
 	struct pci_dev *pci;
@@ -339,6 +333,10 @@ struct azx {
 	/* Register interaction. */
 	const struct hda_controller_ops *ops;
 
+	/* position adjustment callbacks */
+	azx_get_pos_callback_t get_position[2];
+	azx_get_delay_callback_t get_delay[2];
+
 	/* pci resources */
 	unsigned long addr;
 	void __iomem *remap_addr;
@@ -374,7 +372,6 @@ struct azx {
 #endif
 
 	/* flags */
-	int position_fix[2]; /* for both playback/capture streams */
 	const int *bdl_pos_adj;
 	int poll_count;
 	unsigned int running:1;
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index a366ba9293a8..12920b99d238 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -480,8 +480,6 @@ static int hda_tegra_create(struct snd_card *card,
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->list);
 
-	chip->position_fix[0] = POS_FIX_AUTO;
-	chip->position_fix[1] = POS_FIX_AUTO;
 	chip->codec_probe_mask = -1;
 
 	chip->single_cmd = false;
-- 
2.0.0
