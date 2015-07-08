From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/4] ALSA: core: add .notify callback for
	pcm ops
Date: Wed,  8 Jul 2015 05:10:34 -0500
Message-ID: <1436350236-17509-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FF042605A1
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 12:10:56 +0200 (CEST)
In-Reply-To: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When appl_ptr is updated let low-level driver know.

This is only enabled when the NO_REWIND hardware flag is used,
so that the low-level driver/hardware to opportunistically pre-fetch
data.

FIXME: should we rely on .ack for this?
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/pcm.h     |  2 ++
 sound/core/pcm_native.c | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 25310b7..d5eff03 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -87,6 +87,8 @@ struct snd_pcm_ops {
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	int (*notify)(struct snd_pcm_substream *substream);
+	/* FIXME: what's the difference between ack and notify ? */
 };
 
 /*
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a70e52d..dd519b8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2565,6 +2565,10 @@ static snd_pcm_sframes_t snd_pcm_playback_forward(struct snd_pcm_substream *subs
 		appl_ptr -= runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (runtime->no_rewinds && substream->ops->notify)
+		substream->ops->notify(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2614,6 +2618,10 @@ static snd_pcm_sframes_t snd_pcm_capture_forward(struct snd_pcm_substream *subst
 		appl_ptr -= runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (runtime->no_rewinds && substream->ops->notify)
+		substream->ops->notify(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2713,8 +2721,16 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			return err;
 	}
 	snd_pcm_stream_lock_irq(substream);
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL))
+	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
+		/* FIXME: this code is used by mmap_commit, should it handle boundary
+		 *   wrap-around as done for read/write in pcm_lib.c
+		 */
+
 		control->appl_ptr = sync_ptr.c.control.appl_ptr;
+		/* if supported, let low-level driver know about appl_ptr change */
+		if (runtime->no_rewinds && substream->ops->notify)
+			substream->ops->notify(substream);
+	}
 	else
 		sync_ptr.c.control.appl_ptr = control->appl_ptr;
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-- 
1.9.1
