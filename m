From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] ALSA: emu10k1: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 16:18:40 +0800
Message-ID: <1528705122-34409-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/emu10k1/emupcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index d39458a..69f9b10 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1858,7 +1858,9 @@ int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device)
 	if (!kctl)
 		return -ENOMEM;
 	kctl->id.device = device;
-	snd_ctl_add(emu->card, kctl);
+	err = snd_ctl_add(emu->card, kctl);
+	if (err < 0)
+		return err;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 
-- 
2.7.4
