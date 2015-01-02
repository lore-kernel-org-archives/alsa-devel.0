From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ALSA: oxygen: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 15:03:42 +0100
Message-ID: <1420207423-10184-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-239.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id A43632604E0
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 15:03:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Geoff Levand <geoff@infradead.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed when the PCM
itself is freed. There is no need to do this manually in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/oxygen/oxygen_pcm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_pcm.c b/sound/pci/oxygen/oxygen_pcm.c
index 0282824..af22a74 100644
--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -676,11 +676,6 @@ static struct snd_pcm_ops oxygen_ac97_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static void oxygen_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 int oxygen_pcm_init(struct oxygen *chip)
 {
 	struct snd_pcm *pcm;
@@ -705,7 +700,6 @@ int oxygen_pcm_init(struct oxygen *chip)
 			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 					&oxygen_rec_b_ops);
 		pcm->private_data = chip;
-		pcm->private_free = oxygen_pcm_free;
 		strcpy(pcm->name, "Multichannel");
 		if (outs)
 			snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
@@ -734,7 +728,6 @@ int oxygen_pcm_init(struct oxygen *chip)
 			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 					&oxygen_rec_c_ops);
 		pcm->private_data = chip;
-		pcm->private_free = oxygen_pcm_free;
 		strcpy(pcm->name, "Digital");
 		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 						      snd_dma_pci_data(chip->pci),
@@ -765,7 +758,6 @@ int oxygen_pcm_init(struct oxygen *chip)
 			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 					&oxygen_rec_b_ops);
 		pcm->private_data = chip;
-		pcm->private_free = oxygen_pcm_free;
 		strcpy(pcm->name, outs ? "Front Panel" : "Analog 2");
 		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 						      snd_dma_pci_data(chip->pci),
-- 
1.8.0
