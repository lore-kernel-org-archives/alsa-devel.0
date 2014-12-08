From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 2/9] ALSA: core: allow for trigger_tstamp
	snapshot in .trigger
Date: Mon,  8 Dec 2014 16:23:39 -0600
Message-ID: <1418077426-8309-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2239426057E
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:35 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
 sound/core/pcm_native.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e7f74a..83c669f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -281,6 +281,8 @@ struct snd_pcm_runtime {
 	/* -- Status -- */
 	struct snd_pcm_substream *trigger_master;
 	struct timespec trigger_tstamp;	/* trigger timestamp */
+	int trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
+	int trigger_tstamp_pending_update; /* trigger timestamp being updated from initial estimate */
 	int overrange;
 	snd_pcm_uframes_t avail_max;
 	snd_pcm_uframes_t hw_ptr_base;	/* Position at buffer restart */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 5dc83fb..37a7137 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -806,10 +806,14 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->trigger_master == NULL)
 		return;
 	if (runtime->trigger_master == substream) {
-		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		if (runtime->trigger_tstamp_latched == 0)
+			snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		else
+			runtime->trigger_tstamp_latched = 0;
 	} else {
 		snd_pcm_trigger_tstamp(runtime->trigger_master);
 		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
-- 
2.1.0
