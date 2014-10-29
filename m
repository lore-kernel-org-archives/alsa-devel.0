From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add workaround for CMI8888 snoop
	behavior
Date: Wed, 29 Oct 2014 18:20:45 +0100
Message-ID: <1414603245-21179-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7DC2604B5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:20:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4F91ABFA
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 17:20:49 +0000 (UTC)
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

CMI8888 shows the stuttering playback when the snooping is disabled
on the audio buffer.  Meanwhile, we've got reports that CORB/RIRB
doesn't work in the snooped mode.  So, as a compromise, disable the
snoop only for CORB/RIRB and enable the snoop for the stream buffers.

The resultant patch became a bit ugly, unfortunately, but we still can
live with it.

Reported-and-tested-by: Geoffrey McRae <geoff@spacevs.com>
Cc: <stable@vger.kernel.org> # 3.17+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cfcca4c30d4d..9ab1e631cb32 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -374,6 +374,8 @@ static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
 		struct snd_sg_buf *sgbuf = dmab->private_data;
+		if (chip->driver_type == AZX_DRIVER_CMEDIA)
+			return; /* deal with only CORB/RIRB buffers */
 		if (on)
 			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
 		else
@@ -1769,7 +1771,7 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 #ifdef CONFIG_X86
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip))
+	if (!azx_snoop(chip) && chip->driver_type != AZX_DRIVER_CMEDIA)
 		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
 #endif
 }
-- 
2.1.2
