From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: pcm: Fix negative appl_ptr handling
	in pcm-indirect helpers
Date: Sun, 21 May 2017 21:02:52 +0200
Message-ID: <20170521190258.1178-2-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 88665266C72
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 21:03:05 +0200 (CEST)
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The indirect-PCM helper codes have an implicit assumption that the
appl_ptr always increases.  But the PCM core may deal with the
decrement of appl_ptr via rewind ioctls, and it may screw up the
buffer pointer management.

This patch adds the negative appl_ptr diff in transfer functions and
let returning an error instead of always accepting the appl_ptr
updates.  The callers are usually PCM ack callbacks, and they pass the
error to the upper layer accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm-indirect.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm-indirect.h b/include/sound/pcm-indirect.h
index 1df7acaaa535..7ade285328cf 100644
--- a/include/sound/pcm-indirect.h
+++ b/include/sound/pcm-indirect.h
@@ -43,7 +43,7 @@ typedef void (*snd_pcm_indirect_copy_t)(struct snd_pcm_substream *substream,
 /*
  * helper function for playback ack callback
  */
-static inline void
+static inline int
 snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec,
 				   snd_pcm_indirect_copy_t copy)
@@ -56,6 +56,8 @@ snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
+		if (diff < 0)
+			return -EINVAL;
 		rec->sw_ready += (int)frames_to_bytes(runtime, diff);
 		rec->appl_ptr = appl_ptr;
 	}
@@ -82,6 +84,7 @@ snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 		rec->hw_ready += bytes;
 		rec->sw_ready -= bytes;
 	}
+	return 0;
 }
 
 /*
@@ -109,7 +112,7 @@ snd_pcm_indirect_playback_pointer(struct snd_pcm_substream *substream,
 /*
  * helper function for capture ack callback
  */
-static inline void
+static inline int
 snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 				  struct snd_pcm_indirect *rec,
 				  snd_pcm_indirect_copy_t copy)
@@ -121,6 +124,8 @@ snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
+		if (diff < 0)
+			return -EINVAL;
 		rec->sw_ready -= frames_to_bytes(runtime, diff);
 		rec->appl_ptr = appl_ptr;
 	}
@@ -147,6 +152,7 @@ snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 		rec->hw_ready -= bytes;
 		rec->sw_ready += bytes;
 	}
+	return 0;
 }
 
 /*
-- 
2.13.0
