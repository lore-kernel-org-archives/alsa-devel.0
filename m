From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: dmix: Do not discard slave reported delay
	in status result
Date: Tue, 29 Nov 2016 15:03:07 +0100
Message-ID: <20161129140307.8335-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BD672667C9
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 15:03:09 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F1937ABC3
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 14:03:08 +0000 (UTC)
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

Like the change done for dshare plugin, we can calculate the delay
more precisely from the slave PCM.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_dmix.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 2fedb1c14a3b..825677ffeb3f 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -391,23 +391,14 @@ static void snd_pcm_dmix_sync_area(snd_pcm_t *pcm)
 /*
  *  synchronize hardware pointer (hw_ptr) with ours
  */
-static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
+static int snd_pcm_dmix_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
-	snd_pcm_uframes_t slave_hw_ptr, old_slave_hw_ptr, avail;
+	snd_pcm_uframes_t old_slave_hw_ptr, avail;
 	snd_pcm_sframes_t diff;
 	
-	switch (snd_pcm_state(dmix->spcm)) {
-	case SND_PCM_STATE_DISCONNECTED:
-		dmix->state = SND_PCM_STATE_DISCONNECTED;
-		return -ENODEV;
-	default:
-		break;
-	}
-	if (dmix->slowptr)
-		snd_pcm_hwsync(dmix->spcm);
 	old_slave_hw_ptr = dmix->slave_hw_ptr;
-	slave_hw_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
+	dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
 	diff = slave_hw_ptr - old_slave_hw_ptr;
 	if (diff == 0)		/* fast path */
 		return 0;
@@ -440,6 +431,24 @@ static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
+{
+	snd_pcm_direct_t *dmix = pcm->private_data;
+
+	switch (snd_pcm_state(dmix->spcm)) {
+	case SND_PCM_STATE_DISCONNECTED:
+		dmix->state = SND_PCM_STATE_DISCONNECTED;
+		return -ENODEV;
+	default:
+		break;
+	}
+
+	if (dmix->slowptr)
+		snd_pcm_hwsync(dmix->spcm);
+
+	return snd_pcm_dmix_sync_ptr0(pcm, *dmix->spcm->hw.ptr);
+}
+
 /*
  *  plugin implementation
  */
@@ -467,22 +476,24 @@ static int snd_pcm_dmix_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
 
+	memset(status, 0, sizeof(*status));
+	snd_pcm_status(dmix->spcm, status);
+
 	switch (dmix->state) {
 	case SNDRV_PCM_STATE_DRAINING:
 	case SNDRV_PCM_STATE_RUNNING:
-		snd_pcm_dmix_sync_ptr(pcm);
+		snd_pcm_dmix_sync_ptr0(pcm, status->hw_ptr);
+		status->delay += snd_pcm_mmap_playback_delay(pcm)
+				+ status->avail - dmix->spcm->buffer_size;
 		break;
 	default:
 		break;
 	}
-	memset(status, 0, sizeof(*status));
-	snd_pcm_status(dmix->spcm, status);
-	status->state = snd_pcm_dmix_state(pcm);
+
 	status->trigger_tstamp = dmix->trigger_tstamp;
 	status->avail = snd_pcm_mmap_playback_avail(pcm);
 	status->avail_max = status->avail > dmix->avail_max ? status->avail : dmix->avail_max;
 	dmix->avail_max = 0;
-	status->delay = snd_pcm_mmap_playback_delay(pcm);
 	return 0;
 }
 
-- 
2.10.2
