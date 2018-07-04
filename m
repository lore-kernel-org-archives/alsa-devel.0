From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: pcm: trace XRUN event at injection,
	too
Date: Wed,  4 Jul 2018 15:34:31 +0200
Message-ID: <20180704133432.13925-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3202670D7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 15:34:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1D032AE60
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 13:34:37 +0000 (UTC)
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

The PCM xrun injection triggers directly snd_pcm_stop() without the
standard xrun handler, hence it's not recorded on the event buffer.
Ditto for snd_pcm_stop_xrun() call and SNDRV_PCM_IOCTL_XRUN ioctl.
They are inconvenient from the debugging POV.

Let's make them to trigger XRUN via the standard helper more
consistently.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c        | 2 +-
 sound/core/pcm_lib.c    | 7 ++++---
 sound/core/pcm_local.h  | 2 ++
 sound/core/pcm_native.c | 8 ++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index c352bfb973cc..6f037a4b8b52 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -497,7 +497,7 @@ static void snd_pcm_xrun_injection_write(struct snd_info_entry *entry,
 	snd_pcm_stream_lock_irq(substream);
 	runtime = substream->runtime;
 	if (runtime && runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		__snd_pcm_xrun(substream);
 	snd_pcm_stream_unlock_irq(substream);
 }
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 44b5ae833082..c1d2e8e1fc6b 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -153,7 +153,8 @@ EXPORT_SYMBOL(snd_pcm_debug_name);
 			dump_stack();				\
 	} while (0)
 
-static void xrun(struct snd_pcm_substream *substream)
+/* call with stream lock held */
+void __snd_pcm_xrun(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -201,7 +202,7 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 		}
 	} else {
 		if (avail >= runtime->stop_threshold) {
-			xrun(substream);
+			__snd_pcm_xrun(substream);
 			return -EPIPE;
 		}
 	}
@@ -297,7 +298,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 
 	if (pos == SNDRV_PCM_POS_XRUN) {
-		xrun(substream);
+		__snd_pcm_xrun(substream);
 		return -EPIPE;
 	}
 	if (pos >= runtime->buffer_size) {
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index 7a499d02df6c..c515612969a4 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -65,4 +65,6 @@ static inline void snd_pcm_timer_init(struct snd_pcm_substream *substream) {}
 static inline void snd_pcm_timer_done(struct snd_pcm_substream *substream) {}
 #endif
 
+void __snd_pcm_xrun(struct snd_pcm_substream *substream);
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cecc79772c94..20174d0c0527 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1337,13 +1337,12 @@ int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
 	if (snd_pcm_running(substream))
-		ret = snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		__snd_pcm_xrun(substream);
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stop_xrun);
 
@@ -1591,7 +1590,8 @@ static int snd_pcm_xrun(struct snd_pcm_substream *substream)
 		result = 0;	/* already there */
 		break;
 	case SNDRV_PCM_STATE_RUNNING:
-		result = snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		__snd_pcm_xrun(substream);
+		result = 0;
 		break;
 	default:
 		result = -EBADFD;
-- 
2.18.0
