From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ALSA: core: Allow drivers to set R/W wait
	time.
Date: Mon,  2 Jul 2018 17:04:54 +0100
Message-ID: <20180702160454.6895-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 74CAE2676AB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 00:17:38 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently ALSA core blocks userspace for about 10 seconds for PCM R/W IO.
This needs to be configurable for modern hardware like DSPs where no
pointer update in milliseconds can indicate terminal DSP errors.

Add a substream variable to set the wait time in ms. This allows userspace
and drivers to recover more quickly from terminal DSP errors.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---

Changes since V1 :-

 o Remove API method and alow drivers to set directly.
 o Validate time is driver supplied times.

 include/sound/pcm.h  |  1 +
 sound/core/pcm_lib.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e054c583d3b3..edad4a506b93 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -462,6 +462,7 @@ struct snd_pcm_substream {
         /* -- timer section -- */
 	struct snd_timer *timer;		/* timer */
 	unsigned timer_running: 1;	/* time is running */
+	unsigned wait_time;	/* time in ms for R/W to wait for avail */
 	/* -- next substream -- */
 	struct snd_pcm_substream *next;
 	/* -- linked substreams -- */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 44b5ae833082..6909b896a6a1 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1832,12 +1832,18 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	if (runtime->no_period_wakeup)
 		wait_time = MAX_SCHEDULE_TIMEOUT;
 	else {
-		wait_time = 10;
+		/* use wait time from substream if available */
+		if (substream->wait_time) {
+			wait_time = substream->wait_time;
+		} else {
+			wait_time = 10 * 1000; /* 10 secs */
+		}
+
 		if (runtime->rate) {
 			long t = runtime->period_size * 2 / runtime->rate;
 			wait_time = max(t, wait_time);
 		}
-		wait_time = msecs_to_jiffies(wait_time * 1000);
+		wait_time = msecs_to_jiffies(wait_time);
 	}
 
 	for (;;) {
-- 
2.17.1
