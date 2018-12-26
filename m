From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] sound: sb: fix a missing check of snd_ctl_add
Date: Tue, 25 Dec 2018 19:45:32 -0600
Message-ID: <20181226014534.71083-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_ctl_add() could fail, so let's check its return value and return its
error code upstream upon failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/isa/sb/sb16_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 37e6ce7b0b13..c9b25dc1f78e 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -879,8 +879,14 @@ int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
 
-	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
-		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
+	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16) {
+		err =
+			snd_ctl_add(card,
+					snd_ctl_new1(&snd_sb16_dma_control,
+						chip));
+		if (err < 0)
+			return err;
+	}
 	else
 		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
 
-- 
2.17.2 (Apple Git-113)
