From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Revert capture stream behavior
	change in blocking mode
Date: Thu,  7 Feb 2019 08:26:55 +0100
Message-ID: <20190207072655.30409-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 39C1D267437
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 08:27:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C958DAEBD
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 07:26:59 +0000 (UTC)
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

In the commit 62ba568f7aef ("ALSA: pcm: Return 0 when size <
start_threshold in capture"), we changed the behavior of
__snd_pcm_lib_xfer() to return immediately with 0 when a capture
stream has a high start_threshold.  This was intended to be a
correction of the behavior consistency and looked harmless, but this
was the culprit of the recent breakage reported by syzkaller, which
was fixed by the commit e190161f96b8 ("ALSA: pcm: Fix tight loop of
OSS capture stream").

At the time for the OSS fix, I didn't touch the behavior for ALSA
native API, as assuming that this behavior actually is good.  But this
turned out to be also broken actually for a similar deployment,
e.g. one thread goes to a write loop in blocking mode while another
thread controls the start/stop of the stream manually.

Overall, the original commit is harmful, and it brings less merit to
keep that behavior.  Let's revert it.

Fixes: 62ba568f7aef ("ALSA: pcm: Return 0 when size < start_threshold in capture")
Fixes: e190161f96b8 ("ALSA: pcm: Fix tight loop of OSS capture stream")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 5957aeb1099e..bcb06bd3d81d 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2112,13 +2112,6 @@ int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* allow waiting for a capture stream that hasn't been started */
-#if IS_ENABLED(CONFIG_SND_PCM_OSS)
-#define wait_capture_start(substream)	((substream)->oss.oss)
-#else
-#define wait_capture_start(substream)	false
-#endif
-
 /* the common loop for read/write data */
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *data, bool interleaved,
@@ -2184,16 +2177,11 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		snd_pcm_update_hw_ptr(substream);
 
 	if (!is_playback &&
-	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
-		if (size >= runtime->start_threshold) {
-			err = snd_pcm_start(substream);
-			if (err < 0)
-				goto _end_unlock;
-		} else if (!wait_capture_start(substream)) {
-			/* nothing to do */
-			err = 0;
+	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
+	    size >= runtime->start_threshold) {
+		err = snd_pcm_start(substream);
+		if (err < 0)
 			goto _end_unlock;
-		}
 	}
 
 	avail = snd_pcm_avail(substream);
-- 
2.16.4
