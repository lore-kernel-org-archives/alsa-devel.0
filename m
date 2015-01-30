From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 02/10] ALSA: core: allow for trigger_tstamp
	snapshot in .trigger
Date: Fri, 30 Jan 2015 17:55:55 -0600
Message-ID: <1422662163-7391-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 56BE426156A
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:32 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Don't use generic snapshot of trigger_tstamp if low-level driver or
hardware can get a more precise value for better audio/system time
synchronization.

Also add definitions for delayed updates if actual trigger tstamp
can be only be provided after a delay due to hardware constraints.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/pcm.h     | 2 ++
 sound/core/pcm_native.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index cd09c1b..a8b98c5 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -279,6 +279,8 @@ struct snd_pcm_runtime {
 	/* -- Status -- */
 	struct snd_pcm_substream *trigger_master;
 	struct timespec trigger_tstamp;	/* trigger timestamp */
+	bool trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
+	bool trigger_tstamp_pending_update; /* trigger timestamp being updated from initial estimate */
 	int overrange;
 	snd_pcm_uframes_t avail_max;
 	snd_pcm_uframes_t hw_ptr_base;	/* Position at buffer restart */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7bbc34d..4a97029 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -810,7 +810,8 @@ static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 	if (runtime->trigger_master == NULL)
 		return;
 	if (runtime->trigger_master == substream) {
-		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		if (runtime->trigger_tstamp_latched == 0)
+			snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
 	} else {
 		snd_pcm_trigger_tstamp(runtime->trigger_master);
 		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
@@ -979,6 +980,7 @@ static int snd_pcm_pre_start(struct snd_pcm_substream *substream, int state)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    !snd_pcm_playback_data(substream))
 		return -EPIPE;
+	runtime->trigger_tstamp_latched = 0;
 	runtime->trigger_master = substream;
 	return 0;
 }
-- 
1.9.1
