From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 4/4] pcm: hw: Reduce redundant
	sync_ptr() calls
Date: Tue, 20 Jun 2017 17:35:24 +0200
Message-ID: <20170620153524.28099-5-tiwai@suse.de>
References: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D0826735F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:35:28 +0200 (CEST)
In-Reply-To: <20170620153524.28099-1-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

There are lots of places calling sync_ptr() in the PCM hw plugin, but
a few of them are redundant.  For example, the sync_ptr() call after
snd_pcm_hw_params() can be omitted, since the possible  state change
will be fetched again at snd_pcm_hw_state(), and there should be no
hwptr/applptr changes by that.

This patch reduces such redundant sync_ptr() calls for the minor
performance optimization.  The other places calling sync_ptr(),
especially the ones passing SNDRV_PCM_SYNC_PTR_APPL, are still likely
necessary since they need to sync the status after the ioctl, so they
are left as-is.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_hw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 721b18d2bbbb..66658599a6a6 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -342,7 +342,7 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	params->info &= ~0xf0000000;
 	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
 		params->info |= SND_PCM_INFO_MONOTONIC;
-	return sync_ptr(hw, 0);
+	return 0;
 }
 
 static void snd_pcm_hw_close_timer(snd_pcm_hw_t *hw)
@@ -608,7 +608,7 @@ static int snd_pcm_hw_prepare(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_PREPARE failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return 0;
 }
 
 static int snd_pcm_hw_reset(snd_pcm_t *pcm)
@@ -631,7 +631,6 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
 	assert(pcm->stream != SND_PCM_STREAM_PLAYBACK ||
 	       snd_pcm_mmap_playback_hw_avail(pcm) > 0);
 #endif
-	sync_ptr(hw, 0);
 	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_START failed (%i)", err);
-- 
2.13.1
