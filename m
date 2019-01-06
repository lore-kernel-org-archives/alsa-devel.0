From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] [v2] ALSA: isa: fix a missing check of snd_ctl_add
Date: Sun,  6 Jan 2019 11:16:00 -0600
Message-ID: <20190106171601.10506-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_ctl_add() could fail, so let's check its return value and return its
error code upstream upon failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/isa/sb/sb16_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 37e6ce7b0b13..981d65d122b6 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -879,10 +879,14 @@ int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
 
-	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
-		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
-	else
+	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16) {
+		err = snd_ctl_add(card, snd_ctl_new1(
+					&snd_sb16_dma_control, chip));
+		if (err)
+			return err;
+	} else {
 		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
+	}
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
-- 
2.17.1
