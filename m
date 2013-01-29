From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix non-snoop page handling
Date: Tue, 29 Jan 2013 18:22:43 +0100
Message-ID: <1359480163-30693-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F607261643
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 18:22:43 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 4058CA5233
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 18:22:43 +0100 (CET)
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

For non-snoop mode, we fiddle with the page attributes of CORB/RIRB
and the position buffer, but also the ring buffers.  The problem is
that the current code blindly assumes that the buffer is contiguous.
However, the ring buffers may be SG-buffers, thus a wrong vmapped
address is passed there, leading to Oops.

This patch fixes the handling for SG-buffers.

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=800701

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bf0a004..c78286f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -656,29 +656,43 @@ static char *driver_short_names[] = {
 #define get_azx_dev(substream) (substream->runtime->private_data)
 
 #ifdef CONFIG_X86
-static void __mark_pages_wc(struct azx *chip, void *addr, size_t size, bool on)
+static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
 {
+	int pages;
+
 	if (azx_snoop(chip))
 		return;
-	if (addr && size) {
-		int pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (!dmab || !dmab->area || !dmab->bytes)
+		return;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
+		struct snd_sg_buf *sgbuf = dmab->private_data;
 		if (on)
-			set_memory_wc((unsigned long)addr, pages);
+			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
 		else
-			set_memory_wb((unsigned long)addr, pages);
+			set_pages_array_wb(sgbuf->page_table, sgbuf->pages);
+		return;
 	}
+#endif
+
+	pages = (dmab->bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (on)
+		set_memory_wc((unsigned long)dmab->area, pages);
+	else
+		set_memory_wb((unsigned long)dmab->area, pages);
 }
 
 static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
 				 bool on)
 {
-	__mark_pages_wc(chip, buf->area, buf->bytes, on);
+	__mark_pages_wc(chip, buf, on);
 }
 static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
-				   struct snd_pcm_runtime *runtime, bool on)
+				   struct snd_pcm_substream *substream, bool on)
 {
 	if (azx_dev->wc_marked != on) {
-		__mark_pages_wc(chip, runtime->dma_area, runtime->dma_bytes, on);
+		__mark_pages_wc(chip, snd_pcm_get_dma_buf(substream), on);
 		azx_dev->wc_marked = on;
 	}
 }
@@ -689,7 +703,7 @@ static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
 {
 }
 static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
-				   struct snd_pcm_runtime *runtime, bool on)
+				   struct snd_pcm_substream *substream, bool on)
 {
 }
 #endif
@@ -1968,11 +1982,10 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	int ret;
 
-	mark_runtime_wc(chip, azx_dev, runtime, false);
+	mark_runtime_wc(chip, azx_dev, substream, false);
 	azx_dev->bufsize = 0;
 	azx_dev->period_bytes = 0;
 	azx_dev->format_val = 0;
@@ -1980,7 +1993,7 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 					params_buffer_bytes(hw_params));
 	if (ret < 0)
 		return ret;
-	mark_runtime_wc(chip, azx_dev, runtime, true);
+	mark_runtime_wc(chip, azx_dev, substream, true);
 	return ret;
 }
 
@@ -1989,7 +2002,6 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct azx *chip = apcm->chip;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
 
 	/* reset BDL address */
@@ -2002,7 +2014,7 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
 
-	mark_runtime_wc(chip, azx_dev, runtime, false);
+	mark_runtime_wc(chip, azx_dev, substream, false);
 	return snd_pcm_lib_free_pages(substream);
 }
 
-- 
1.8.1.1
