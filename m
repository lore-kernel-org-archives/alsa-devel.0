From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] media: Drop superfluous PCM preallocation
	error checks
Date: Wed,  6 Feb 2019 18:32:39 +0100
Message-ID: <20190206173239.18046-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36D0C267917
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 18:32:42 +0100 (CET)
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
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is a piece I overlooked in the previous patchset:
   https://www.spinics.net/lists/alsa-devel/msg87223.html

Media people, please give ACK if this is OK.  Then I'll merge it together
with other relevant patches.  Thanks!

 drivers/media/pci/solo6x10/solo6x10-g723.c | 4 +---
 drivers/media/pci/tw686x/tw686x-audio.c    | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
index 2cc05a9d57ac..a16242a9206f 100644
--- a/drivers/media/pci/solo6x10/solo6x10-g723.c
+++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
@@ -360,13 +360,11 @@ static int solo_snd_pcm_init(struct solo_dev *solo_dev)
 	     ss; ss = ss->next, i++)
 		sprintf(ss->name, "Camera #%d Audio", i);
 
-	ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
 					SNDRV_DMA_TYPE_CONTINUOUS,
 					snd_dma_continuous_data(GFP_KERNEL),
 					G723_PERIOD_BYTES * PERIODS,
 					G723_PERIOD_BYTES * PERIODS);
-	if (ret < 0)
-		return ret;
 
 	solo_dev->snd_pcm = pcm;
 
diff --git a/drivers/media/pci/tw686x/tw686x-audio.c b/drivers/media/pci/tw686x/tw686x-audio.c
index a28329698e20..fb0e7573b5ae 100644
--- a/drivers/media/pci/tw686x/tw686x-audio.c
+++ b/drivers/media/pci/tw686x/tw686x-audio.c
@@ -301,11 +301,12 @@ static int tw686x_snd_pcm_init(struct tw686x_dev *dev)
 	     ss; ss = ss->next, i++)
 		snprintf(ss->name, sizeof(ss->name), "vch%u audio", i);
 
-	return snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
 				SNDRV_DMA_TYPE_DEV,
 				snd_dma_pci_data(dev->pci_dev),
 				TW686X_AUDIO_PAGE_MAX * AUDIO_DMA_SIZE_MAX,
 				TW686X_AUDIO_PAGE_MAX * AUDIO_DMA_SIZE_MAX);
+	return 0;
 }
 
 static void tw686x_audio_dma_free(struct tw686x_dev *dev,
-- 
2.16.4
