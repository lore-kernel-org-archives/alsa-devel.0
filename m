From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: hda: Use new non-cached allocation
	for non-snoop mode
Date: Mon, 27 Aug 2018 10:59:50 +0200
Message-ID: <20180827085953.10614-6-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C57267864
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 11:00:03 +0200 (CEST)
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

Now the ALSA memory allocator helper supports the new non-cached
pages, let's use the new type, SNDRV_DMA_TYPE_DEV_UC_SG, for HD-audio
driver.  This allows us to reduce lots of codes.

As another positive side-effect by this patch, the long-standing issue
with non-snoop mode playing in the non-mmap mode is fixed.  The core
memalloc helper does the proper pgprot setup for non-cached pages for
vmap(), which was missing in the past.

Reported-and-tested-by: Hans Hu <HansHu@zhaoxin.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c |  5 ++-
 sound/pci/hda/hda_controller.h |  1 -
 sound/pci/hda/hda_intel.c      | 81 ++--------------------------------
 3 files changed, 8 insertions(+), 79 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a12e594d4e3b..8bc46676c278 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -732,6 +732,7 @@ int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
 	int pcm_dev = cpcm->device;
 	unsigned int size;
 	int s, err;
+	int type = SNDRV_DMA_TYPE_DEV_SG;
 
 	list_for_each_entry(apcm, &chip->pcm_list, list) {
 		if (apcm->pcm->device == pcm_dev) {
@@ -770,7 +771,9 @@ int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
 	size = CONFIG_SND_HDA_PREALLOC_SIZE * 1024;
 	if (size > MAX_PREALLOC_SIZE)
 		size = MAX_PREALLOC_SIZE;
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+	if (chip->uc_buffer)
+		type = SNDRV_DMA_TYPE_DEV_UC_SG;
+	snd_pcm_lib_preallocate_pages_for_all(pcm, type,
 					      chip->card->dev,
 					      size, MAX_PREALLOC_SIZE);
 	return 0;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 53c3cd28bc99..c4b3de6c42b8 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -76,7 +76,6 @@ struct azx_dev {
 	 *  when link position is not greater than FIFO size
 	 */
 	unsigned int insufficient:1;
-	unsigned int wc_marked:1;
 };
 
 #define azx_stream(dev)		(&(dev)->core)
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e5482fd21568..03ddd1abb44d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -397,61 +397,6 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
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
-		if (!chip->uc_buffer)
-			return; /* deal with only CORB/RIRB buffers */
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
 
 /*
@@ -2054,22 +1999,14 @@ static int dma_alloc_pages(struct hdac_bus *bus,
 			   struct snd_dma_buffer *buf)
 {
 	struct azx *chip = bus_to_azx(bus);
-	int err;
 
-	err = snd_dma_alloc_pages(type,
-				  bus->dev,
-				  size, buf);
-	if (err < 0)
-		return err;
-	mark_pages_wc(chip, buf, true);
-	return 0;
+	if (!azx_snoop(chip) && type == SNDRV_DMA_TYPE_DEV)
+		type = SNDRV_DMA_TYPE_DEV_UC;
+	return snd_dma_alloc_pages(type, bus->dev, size, buf);
 }
 
 static void dma_free_pages(struct hdac_bus *bus, struct snd_dma_buffer *buf)
 {
-	struct azx *chip = bus_to_azx(bus);
-
-	mark_pages_wc(chip, buf, false);
 	snd_dma_free_pages(buf);
 }
 
@@ -2077,22 +2014,12 @@ static int substream_alloc_pages(struct azx *chip,
 				 struct snd_pcm_substream *substream,
 				 size_t size)
 {
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	int ret;
-
-	mark_runtime_wc(chip, azx_dev, substream, false);
-	ret = snd_pcm_lib_malloc_pages(substream, size);
-	if (ret < 0)
-		return ret;
-	mark_runtime_wc(chip, azx_dev, substream, true);
-	return 0;
+	return snd_pcm_lib_malloc_pages(substream, size);
 }
 
 static int substream_free_pages(struct azx *chip,
 				struct snd_pcm_substream *substream)
 {
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-	mark_runtime_wc(chip, azx_dev, substream, false);
 	return snd_pcm_lib_free_pages(substream);
 }
 
-- 
2.18.0
