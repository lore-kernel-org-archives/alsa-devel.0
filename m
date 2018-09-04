From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: rme32: Use
	SNDRV_PCM_INFO_SYNC_APPLPTR info flag
Date: Tue,  4 Sep 2018 08:18:47 +0200
Message-ID: <20180904061851.1934-2-tiwai@suse.de>
References: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C45D2678B3
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 08:18:56 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DD143AFD5
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 06:18:55 +0000 (UTC)
In-Reply-To: <20180904061851.1934-1-tiwai@suse.de>
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

The recently introduced PCM info flag assures the call of ack ops at
each applptr change, and this is mandatory for the indirect PCM
helpers.

Also, with the proper ack callback, we need no longer prefill at
trigger start.  The relevant code can be killed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme32.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index f0906ba416d4..3ac8c71d567c 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -319,7 +319,8 @@ static const struct snd_pcm_hardware snd_rme32_spdif_info = {
 			 SNDRV_PCM_INFO_MMAP_VALID |
 			 SNDRV_PCM_INFO_INTERLEAVED | 
 			 SNDRV_PCM_INFO_PAUSE |
-			 SNDRV_PCM_INFO_SYNC_START),
+			 SNDRV_PCM_INFO_SYNC_START |
+			 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | 
 			 SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	(SNDRV_PCM_RATE_32000 |
@@ -346,7 +347,8 @@ static const struct snd_pcm_hardware snd_rme32_adat_info =
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE |
-			      SNDRV_PCM_INFO_SYNC_START),
+			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats=            SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =             (SNDRV_PCM_RATE_44100 | 
 			      SNDRV_PCM_RATE_48000),
@@ -370,7 +372,8 @@ static const struct snd_pcm_hardware snd_rme32_spdif_fd_info = {
 			 SNDRV_PCM_INFO_MMAP_VALID |
 			 SNDRV_PCM_INFO_INTERLEAVED | 
 			 SNDRV_PCM_INFO_PAUSE |
-			 SNDRV_PCM_INFO_SYNC_START),
+			 SNDRV_PCM_INFO_SYNC_START |
+			 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | 
 			 SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	(SNDRV_PCM_RATE_32000 |
@@ -397,7 +400,8 @@ static const struct snd_pcm_hardware snd_rme32_adat_fd_info =
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE |
-			      SNDRV_PCM_INFO_SYNC_START),
+			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats=            SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =             (SNDRV_PCM_RATE_44100 | 
 			      SNDRV_PCM_RATE_48000),
@@ -1104,16 +1108,6 @@ snd_rme32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		snd_pcm_trigger_done(s, substream);
 	}
 	
-	/* prefill playback buffer */
-	if (cmd == SNDRV_PCM_TRIGGER_START && rme32->fullduplex_mode) {
-		snd_pcm_group_for_each_entry(s, substream) {
-			if (s == rme32->playback_substream) {
-				s->ops->ack(s);
-				break;
-			}
-		}
-	}
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (rme32->running && ! RME32_ISWORKING(rme32))
-- 
2.18.0
