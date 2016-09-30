From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/7] ALSA: core: add .update_appl_ptr callback
	for pcm ops
Date: Fri, 30 Sep 2016 18:13:25 +0530
Message-ID: <1475239410-16548-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C8AF8261A1A
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:11 +0200 (CEST)
In-Reply-To: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, "Babu, Ramesh" <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When appl_ptr is updated let low-level driver know, e.g.  to let the
low-level driver/hardware pre-fetch data opportunistically.

The existing .ack callback could be used but it would need to be
extended with new arguments, resulting in multiple changes in legacy
code.

Instead a new .appl_ptr_update callback is added.  The difference
between .ack and .appl_ptr_update is that .ack is only called on read or
write. .appl_ptr_update is called on read, write, rewind, forward or
when updating the appl_ptr from userspace.

In the ALSA core, this capability is independent from the NO_REWIND
hardware flag. The low-level driver may however tie both options and
only use the updated appl_ptr when rewinds are disabled due to hardware
limitations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Babu, Ramesh <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/sound/pcm.h     |  1 +
 sound/core/pcm_lib.c    |  6 ++++++
 sound/core/pcm_native.c | 24 +++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 5344c16..1accb8b 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -87,6 +87,7 @@ struct snd_pcm_ops {
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	int (*appl_ptr_update)(struct snd_pcm_substream *substream);
 };
 
 /*
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bb12615..1656ca9 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2090,6 +2090,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		if (substream->ops->ack)
 			substream->ops->ack(substream);
 
+		if (substream->ops->appl_ptr_update)
+			substream->ops->appl_ptr_update(substream);
+
 		offset += frames;
 		size -= frames;
 		xfer += frames;
@@ -2322,6 +2325,9 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		if (substream->ops->ack)
 			substream->ops->ack(substream);
 
+		if (substream->ops->appl_ptr_update)
+			substream->ops->appl_ptr_update(substream);
+
 		offset += frames;
 		size -= frames;
 		xfer += frames;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index be8617b..c56d4ed 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2475,6 +2475,10 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
 		appl_ptr += runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (substream->ops->appl_ptr_update)
+		substream->ops->appl_ptr_update(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2526,6 +2530,10 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
 		appl_ptr += runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (substream->ops->appl_ptr_update)
+		substream->ops->appl_ptr_update(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2575,6 +2583,10 @@ static snd_pcm_sframes_t snd_pcm_playback_forward(struct snd_pcm_substream *subs
 		appl_ptr -= runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (substream->ops->appl_ptr_update)
+		substream->ops->appl_ptr_update(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2624,6 +2636,10 @@ static snd_pcm_sframes_t snd_pcm_capture_forward(struct snd_pcm_substream *subst
 		appl_ptr -= runtime->boundary;
 	runtime->control->appl_ptr = appl_ptr;
 	ret = frames;
+
+	if (substream->ops->appl_ptr_update)
+		substream->ops->appl_ptr_update(substream);
+
  __end:
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
@@ -2723,8 +2739,14 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			return err;
 	}
 	snd_pcm_stream_lock_irq(substream);
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL))
+	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
+		/* boundary wrap-around is assumed to be handled in userspace */
 		control->appl_ptr = sync_ptr.c.control.appl_ptr;
+
+		/* let low-level driver know about appl_ptr change */
+		if (substream->ops->appl_ptr_update)
+			substream->ops->appl_ptr_update(substream);
+	}
 	else
 		sync_ptr.c.control.appl_ptr = control->appl_ptr;
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-- 
1.9.1
