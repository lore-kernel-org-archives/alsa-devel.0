From: libin.yang@intel.com
Subject: [PATCH] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN trigger
Date: Wed, 31 Dec 2014 11:03:40 +0800
Message-ID: <1419995020-120186-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 520B826086A
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 04:09:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: libin.yang@intel.com, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Add SNDRV_PCM_TRIGGER_DRAIN trigger for pcm drain.

Some audio devices require notification of drain events
in order to properly drain and shutdown an audio stream.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/pcm.h         |  1 +
 include/uapi/sound/asound.h |  1 +
 sound/core/pcm_native.c     | 10 +++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 3652c94..bf32cea 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -106,6 +106,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_TRIGGER_PAUSE_RELEASE	4
 #define SNDRV_PCM_TRIGGER_SUSPEND	5
 #define SNDRV_PCM_TRIGGER_RESUME	6
+#define SNDRV_PCM_TRIGGER_DRAIN		7
 
 #define SNDRV_PCM_POS_XRUN		((snd_pcm_uframes_t)-1)
 
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1f23cd6..0e88e7a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -268,6 +268,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
 #define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
+#define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 095d957..bd57f6e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -420,7 +420,8 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 
 	hw = &substream->runtime->hw;
 	if (!params->info) {
-		params->info = hw->info & ~SNDRV_PCM_INFO_FIFO_IN_FRAMES;
+		params->info = hw->info & ~SNDRV_PCM_INFO_FIFO_IN_FRAMES
+			& ~SNDRV_PCM_INFO_DRAIN_TRIGGER;
 		if (!hw_support_mmap(substream))
 			params->info &= ~(SNDRV_PCM_INFO_MMAP |
 					  SNDRV_PCM_INFO_MMAP_VALID);
@@ -1566,6 +1567,13 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 			snd_pcm_post_stop(substream, new_state);
 		}
 	}
+
+	if (runtime->status->state == SNDRV_PCM_STATE_DRAINING &&
+		substream->runtime->trigger_master == substream &&
+		(substream->runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER))
+		return substream->ops->trigger(substream,
+				SNDRV_PCM_TRIGGER_DRAIN);
+
 	return 0;
 }
 
-- 
1.9.1
