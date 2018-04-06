From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: pcm: Yet finer pending signal check
	in OSS read/write loop
Date: Fri,  6 Apr 2018 15:34:11 +0200
Message-ID: <20180406133412.10649-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D7EFE26723C
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 15:34:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CC41FAE91
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 13:34:13 +0000 (UTC)
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

PCM OSS emulation has the nested inner loops, and the loops in
snd_pcm_oss_read3() and write3() have no pending signal check, so
potentially they can hog for too long time for processing.
Add the extra check there.

While we're at it, a slight code cleanup using the standard macro for
the PCM state check is used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 481ab0e94ffa..5e009a444d9d 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1221,8 +1221,7 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream, const
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 	while (1) {
-		if (runtime->status->state == SNDRV_PCM_STATE_XRUN ||
-		    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		if (!snd_pcm_running(substream)) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm,
 				"pcm_oss: write: recovering from %s\n",
@@ -1241,6 +1240,8 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream, const
 		/* has not been started */
 		if (runtime->status->state == SNDRV_PCM_STATE_PREPARED)
 			return -EAGAIN;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
 	}
 	return ret;
 }
@@ -1278,10 +1279,11 @@ snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream, char *p
 				if (ret < 0)
 					break;
 			}
-			continue;
-		}
-		if (ret != -ESTRPIPE)
+		} else if (ret != -ESTRPIPE) {
 			break;
+		}
+		if (signal_pending(current))
+			return -ERESTARTSYS;
 	}
 	return ret;
 }
-- 
2.16.3
