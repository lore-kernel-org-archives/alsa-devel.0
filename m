From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: intel8x0: Use the new non-cached
	allocation for 440MX workaround
Date: Mon, 27 Aug 2018 10:59:52 +0200
Message-ID: <20180827085953.10614-8-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 178D2267861
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

intel8x0 driver requires the non-cached pages for 440MX workaround,
and this can be implemented more easily with the new memalloc type,
SNDRV_DMA_TYPE_DEV_UC.  This allows us to reduce lots of code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 89 ++++++--------------------------------------
 1 file changed, 12 insertions(+), 77 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5ee468d1aefe..9517f9b8f1d4 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -38,11 +38,6 @@
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 #include <sound/initval.h>
-/* for 440MX workaround */
-#include <asm/pgtable.h>
-#ifdef CONFIG_X86
-#include <asm/set_memory.h>
-#endif
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; SiS 7012; Ali 5455");
@@ -374,7 +369,6 @@ struct ichdev {
 	unsigned int ali_slot;			/* ALI DMA slot */
 	struct ac97_pcm *pcm;
 	int pcm_open_flag;
-	unsigned int page_attr_changed: 1;
 	unsigned int suspended: 1;
 };
 
@@ -724,25 +718,6 @@ static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct ichdev *ich
 	iputbyte(chip, port + ichdev->roff_sr, ICH_FIFOE | ICH_BCIS | ICH_LVBCI);
 }
 
-#ifdef __i386__
-/*
- * Intel 82443MX running a 100MHz processor system bus has a hardware bug,
- * which aborts PCI busmaster for audio transfer.  A workaround is to set
- * the pages as non-cached.  For details, see the errata in
- *	http://download.intel.com/design/chipsets/specupdt/24505108.pdf
- */
-static void fill_nocache(void *buf, int size, int nocache)
-{
-	size = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (nocache)
-		set_pages_uc(virt_to_page(buf), size);
-	else
-		set_pages_wb(virt_to_page(buf), size);
-}
-#else
-#define fill_nocache(buf, size, nocache) do { ; } while (0)
-#endif
-
 /*
  *  Interrupt handler
  */
@@ -938,23 +913,12 @@ static int snd_intel8x0_hw_params(struct snd_pcm_substream *substream,
 {
 	struct intel8x0 *chip = snd_pcm_substream_chip(substream);
 	struct ichdev *ichdev = get_ichdev(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int dbl = params_rate(hw_params) > 48000;
 	int err;
 
-	if (chip->fix_nocache && ichdev->page_attr_changed) {
-		fill_nocache(runtime->dma_area, runtime->dma_bytes, 0); /* clear */
-		ichdev->page_attr_changed = 0;
-	}
 	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 	if (err < 0)
 		return err;
-	if (chip->fix_nocache) {
-		if (runtime->dma_area && ! ichdev->page_attr_changed) {
-			fill_nocache(runtime->dma_area, runtime->dma_bytes, 1);
-			ichdev->page_attr_changed = 1;
-		}
-	}
 	if (ichdev->pcm_open_flag) {
 		snd_ac97_pcm_close(ichdev->pcm);
 		ichdev->pcm_open_flag = 0;
@@ -974,17 +938,12 @@ static int snd_intel8x0_hw_params(struct snd_pcm_substream *substream,
 
 static int snd_intel8x0_hw_free(struct snd_pcm_substream *substream)
 {
-	struct intel8x0 *chip = snd_pcm_substream_chip(substream);
 	struct ichdev *ichdev = get_ichdev(substream);
 
 	if (ichdev->pcm_open_flag) {
 		snd_ac97_pcm_close(ichdev->pcm);
 		ichdev->pcm_open_flag = 0;
 	}
-	if (chip->fix_nocache && ichdev->page_attr_changed) {
-		fill_nocache(substream->runtime->dma_area, substream->runtime->dma_bytes, 0);
-		ichdev->page_attr_changed = 0;
-	}
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -1510,6 +1469,9 @@ struct ich_pcm_table {
 	int ac97_idx;
 };
 
+#define intel8x0_dma_type(chip) \
+	((chip)->fix_nocache ? SNDRV_DMA_TYPE_DEV_UC : SNDRV_DMA_TYPE_DEV)
+
 static int snd_intel8x0_pcm1(struct intel8x0 *chip, int device,
 			     struct ich_pcm_table *rec)
 {
@@ -1540,7 +1502,7 @@ static int snd_intel8x0_pcm1(struct intel8x0 *chip, int device,
 		strcpy(pcm->name, chip->card->shortname);
 	chip->pcm[device] = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+	snd_pcm_lib_preallocate_pages_for_all(pcm, intel8x0_dma_type(chip),
 					      snd_dma_pci_data(chip->pci),
 					      rec->prealloc_size, rec->prealloc_max_size);
 
@@ -2629,11 +2591,8 @@ static int snd_intel8x0_free(struct intel8x0 *chip)
       __hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	if (chip->bdbars.area) {
-		if (chip->fix_nocache)
-			fill_nocache(chip->bdbars.area, chip->bdbars.bytes, 0);
+	if (chip->bdbars.area)
 		snd_dma_free_pages(&chip->bdbars);
-	}
 	if (chip->addr)
 		pci_iounmap(chip->pci, chip->addr);
 	if (chip->bmaddr)
@@ -2657,17 +2616,6 @@ static int intel8x0_suspend(struct device *dev)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	for (i = 0; i < chip->pcm_devs; i++)
 		snd_pcm_suspend_all(chip->pcm[i]);
-	/* clear nocache */
-	if (chip->fix_nocache) {
-		for (i = 0; i < chip->bdbars_count; i++) {
-			struct ichdev *ichdev = &chip->ichd[i];
-			if (ichdev->substream && ichdev->page_attr_changed) {
-				struct snd_pcm_runtime *runtime = ichdev->substream->runtime;
-				if (runtime->dma_area)
-					fill_nocache(runtime->dma_area, runtime->dma_bytes, 0);
-			}
-		}
-	}
 	for (i = 0; i < chip->ncodecs; i++)
 		snd_ac97_suspend(chip->ac97[i]);
 	if (chip->device_type == DEVICE_INTEL_ICH4)
@@ -2708,25 +2656,9 @@ static int intel8x0_resume(struct device *dev)
 			  ICH_PCM_SPDIF_1011);
 	}
 
-	/* refill nocache */
-	if (chip->fix_nocache)
-		fill_nocache(chip->bdbars.area, chip->bdbars.bytes, 1);
-
 	for (i = 0; i < chip->ncodecs; i++)
 		snd_ac97_resume(chip->ac97[i]);
 
-	/* refill nocache */
-	if (chip->fix_nocache) {
-		for (i = 0; i < chip->bdbars_count; i++) {
-			struct ichdev *ichdev = &chip->ichd[i];
-			if (ichdev->substream && ichdev->page_attr_changed) {
-				struct snd_pcm_runtime *runtime = ichdev->substream->runtime;
-				if (runtime->dma_area)
-					fill_nocache(runtime->dma_area, runtime->dma_bytes, 1);
-			}
-		}
-	}
-
 	/* resume status */
 	for (i = 0; i < chip->bdbars_count; i++) {
 		struct ichdev *ichdev = &chip->ichd[i];
@@ -3057,6 +2989,12 @@ static int snd_intel8x0_create(struct snd_card *card,
 
 	chip->inside_vm = snd_intel8x0_inside_vm(pci);
 
+	/*
+	 * Intel 82443MX running a 100MHz processor system bus has a hardware
+	 * bug, which aborts PCI busmaster for audio transfer.  A workaround
+	 * is to set the pages as non-cached.  For details, see the errata in
+	 *     http://download.intel.com/design/chipsets/specupdt/24505108.pdf
+	 */
 	if (pci->vendor == PCI_VENDOR_ID_INTEL &&
 	    pci->device == PCI_DEVICE_ID_INTEL_440MX)
 		chip->fix_nocache = 1; /* enable workaround */
@@ -3128,7 +3066,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 
 	/* allocate buffer descriptor lists */
 	/* the start of each lists must be aligned to 8 bytes */
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
+	if (snd_dma_alloc_pages(intel8x0_dma_type(chip), snd_dma_pci_data(pci),
 				chip->bdbars_count * sizeof(u32) * ICH_MAX_FRAGS * 2,
 				&chip->bdbars) < 0) {
 		snd_intel8x0_free(chip);
@@ -3137,9 +3075,6 @@ static int snd_intel8x0_create(struct snd_card *card,
 	}
 	/* tables must be aligned to 8 bytes here, but the kernel pages
 	   are much bigger, so we don't care (on i386) */
-	/* workaround for 440MX */
-	if (chip->fix_nocache)
-		fill_nocache(chip->bdbars.area, chip->bdbars.bytes, 1);
 	int_sta_masks = 0;
 	for (i = 0; i < chip->bdbars_count; i++) {
 		ichdev = &chip->ichd[i];
-- 
2.18.0
