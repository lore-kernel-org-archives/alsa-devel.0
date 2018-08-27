From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: hda: Check the non-cached stream
	buffers more explicitly
Date: Mon, 27 Aug 2018 10:59:49 +0200
Message-ID: <20180827085953.10614-5-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BF0267860
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 11:00:00 +0200 (CEST)
In-Reply-To: <20180827085953.10614-1-tiwai@suse.de>
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
Cc: Hans Hu <HansHu@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

Introduce a new flag, uc_buffer, to indicate that the controller
requires the non-cached pages for stream buffers, either as a
chip-specific requirement or specified via snoop=0 option.
This improves the code-readability.

Also, this patch fixes the incorrect behavior for C-Media chip where
the stream buffers were never handled as non-cached due to the check
of driver_type even if you pass snoop=0 option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h |  1 +
 sound/pci/hda/hda_intel.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a68e75b00ea3..53c3cd28bc99 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -160,6 +160,7 @@ struct azx {
 	unsigned int msi:1;
 	unsigned int probing:1; /* codec probing phase */
 	unsigned int snoop:1;
+	unsigned int uc_buffer:1; /* non-cached pages for stream buffers */
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1b2ce304152a..e5482fd21568 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -410,7 +410,7 @@ static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
 		struct snd_sg_buf *sgbuf = dmab->private_data;
-		if (chip->driver_type == AZX_DRIVER_CMEDIA)
+		if (!chip->uc_buffer)
 			return; /* deal with only CORB/RIRB buffers */
 		if (on)
 			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
@@ -1637,6 +1637,7 @@ static void azx_check_snoop_available(struct azx *chip)
 		dev_info(chip->card->dev, "Force to %s mode by module option\n",
 			 snoop ? "snoop" : "non-snoop");
 		chip->snoop = snoop;
+		chip->uc_buffer = !snoop;
 		return;
 	}
 
@@ -1657,8 +1658,12 @@ static void azx_check_snoop_available(struct azx *chip)
 		snoop = false;
 
 	chip->snoop = snoop;
-	if (!snoop)
+	if (!snoop) {
 		dev_info(chip->card->dev, "Force to non-snoop mode\n");
+		/* C-Media requires non-cached pages only for CORB/RIRB */
+		if (chip->driver_type != AZX_DRIVER_CMEDIA)
+			chip->uc_buffer = true;
+	}
 }
 
 static void azx_probe_work(struct work_struct *work)
@@ -2097,7 +2102,7 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 #ifdef CONFIG_X86
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip) && chip->driver_type != AZX_DRIVER_CMEDIA)
+	if (chip->uc_buffer)
 		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
 #endif
 }
-- 
2.18.0
