From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH] ALSA: pcm: Update hardware pointer before
	start capture
Date: Fri, 7 Sep 2018 16:58:54 -0300
Message-ID: <20180907195854.GA17424@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E0FE26781E
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 21:59:05 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so17484305qtc.8
 for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2018 12:59:04 -0700 (PDT)
Content-Disposition: inline
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This ensures the transfer loop won't waste a run to read
the few frames (if any) between start and hw_ptr update.
It will wait for the next interrupt with wait_for_avail().

Signed-off-by: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
---
 sound/core/pcm_lib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7f71c2449..40013b26f 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2172,6 +2172,10 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto _end_unlock;
 
+	runtime->twake = runtime->control->avail_min ? : 1;
+	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+		snd_pcm_update_hw_ptr(substream);
+
 	if (!is_playback &&
 	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
 		if (size >= runtime->start_threshold) {
@@ -2185,10 +2189,8 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		}
 	}
 
-	runtime->twake = runtime->control->avail_min ? : 1;
-	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-		snd_pcm_update_hw_ptr(substream);
 	avail = snd_pcm_avail(substream);
+
 	while (size > 0) {
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
 		snd_pcm_uframes_t cont;
-- 
2.17.1
