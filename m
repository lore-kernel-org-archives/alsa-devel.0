From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] pcm: support for audio timestamps
Date: Fri, 28 Sep 2012 03:16:29 -0500
Message-ID: <1348820190-15866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC1D2615CD
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 10:16:36 +0200 (CEST)
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

add new snd_pcm_status_get_audio_htstamp() routine to
query the audio timestamps provided by the kernel.

This change provides applications with better ways
to track elapsed time. Before this patch, applications
would subtract queued samples (delay) from written samples,
resulting in a 1-2 sample error.

Also add snd_pcm_hw_params_supports_audio_wallclock_ts()
to query what the hardware supports.

TODO: check protocol compatibility?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/pcm.h          |    2 ++
 include/sound/asound.h |    7 +++++--
 src/pcm/pcm.c          |   31 +++++++++++++++++++++++++++++++
 test/audio_time.c      |   27 +++++++++++++++++----------
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 4997557..8d08471 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -550,6 +550,7 @@ int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num,
 				      unsigned int *rate_den);
@@ -858,6 +859,7 @@ void snd_pcm_status_get_trigger_tstamp(const snd_pcm_status_t *obj, snd_timestam
 void snd_pcm_status_get_trigger_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
 void snd_pcm_status_get_tstamp(const snd_pcm_status_t *obj, snd_timestamp_t *ptr);
 void snd_pcm_status_get_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
+void snd_pcm_status_get_audio_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
 snd_pcm_sframes_t snd_pcm_status_get_delay(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail_max(const snd_pcm_status_t *obj);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 07c03fa..109302e 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -160,7 +160,7 @@ enum {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 11)
 
 typedef unsigned long sndrv_pcm_uframes_t;
 typedef long sndrv_pcm_sframes_t;
@@ -285,6 +285,7 @@ enum sndrv_pcm_subformat {
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
 
 enum sndrv_pcm_state {
 	SNDRV_PCM_STATE_OPEN = 0,	/* stream is open */
@@ -426,7 +427,8 @@ struct sndrv_pcm_status {
 	sndrv_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	sndrv_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	int suspended_state;		/* suspended stream state */
-	unsigned char reserved[60];	/* must be filled with zero */
+	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	unsigned char reserved[60-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct sndrv_pcm_mmap_status {
@@ -435,6 +437,7 @@ struct sndrv_pcm_mmap_status {
 	sndrv_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
 	int suspended_state;		/* RO: suspended stream state */
+	struct timespec audio_tstamp;	/* from sample counter or wall clock */
 };
 
 struct sndrv_pcm_mmap_control {
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 18b43b3..748e8a6 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3123,6 +3123,26 @@ int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *param
 }
 
 /**
+ * \brief Check if hardware supports audio wallclock timestamps
+ * \param params Configuration space
+ * \retval 0 Hardware doesn't support audio wallclock timestamps
+ * \retval 1 Hardware supports audio wallclock timestamps
+ *
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
+ */
+int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params)
+{
+	assert(params);
+	if (CHECK_SANITY(params->info == ~0U)) {
+		SNDMSG("invalid PCM info field");
+		return 0; /* FIXME: should be a negative error? */
+	}
+	return !!(params->info & SNDRV_PCM_INFO_HAS_WALL_CLOCK);
+}
+
+/**
  * \brief Get rate exact info from a configuration space
  * \param params Configuration space
  * \param rate_num Pointer to returned rate numerator
@@ -6213,6 +6233,17 @@ void snd_pcm_status_get_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *p
 use_default_symbol_version(__snd_pcm_status_get_htstamp, snd_pcm_status_get_htstamp, ALSA_0.9.0rc8);
 
 /** 
+ * \brief Get "now" hi-res audio timestamp from a PCM status container
+ * \param obj pointer to #snd_pcm_status_t
+ * \param ptr Pointer to returned timestamp
+ */
+void snd_pcm_status_get_audio_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr)
+{
+	assert(obj && ptr);
+	*ptr = obj->audio_tstamp;
+}
+
+/**
  * \brief Get delay from a PCM status container (see #snd_pcm_delay)
  * \return Delay in frames
  *
diff --git a/test/audio_time.c b/test/audio_time.c
index a910783..de8df17 100644
--- a/test/audio_time.c
+++ b/test/audio_time.c
@@ -33,6 +33,7 @@ long long timediff(snd_htimestamp_t t1, snd_htimestamp_t t2)
 
 void gettimestamp(snd_pcm_t *handle, snd_htimestamp_t *timestamp,
 		  snd_htimestamp_t *trigger_timestamp,
+		  snd_htimestamp_t *audio_timestamp,
 		  snd_pcm_uframes_t *avail, snd_pcm_sframes_t *delay)
 {
 	int err;
@@ -45,6 +46,7 @@ void gettimestamp(snd_pcm_t *handle, snd_htimestamp_t *timestamp,
 	}
 	snd_pcm_status_get_trigger_htstamp(status, trigger_timestamp);
 	snd_pcm_status_get_htstamp(status, timestamp);
+	snd_pcm_status_get_audio_htstamp(status, audio_timestamp);
 	*avail = snd_pcm_status_get_avail(status);
 	*delay = snd_pcm_status_get_delay(status);
 }
@@ -65,6 +67,7 @@ int main(void)
         snd_pcm_sframes_t frames;
 	snd_htimestamp_t tstamp_c, tstamp_p;
 	snd_htimestamp_t trigger_tstamp_c, trigger_tstamp_p;
+	snd_htimestamp_t audio_tstamp_c, audio_tstamp_p;
 	unsigned char buffer_p[PERIOD*4*4];
 	unsigned char buffer_c[PERIOD*4*4];
 
@@ -202,26 +205,30 @@ int main(void)
 		frame_count_p += frames;
 
 #if defined(TRACK_PLAYBACK)
-		gettimestamp(handle_p, &tstamp_p, &trigger_tstamp_p, &avail_p, &delay_p);
+		gettimestamp(handle_p, &tstamp_p, &trigger_tstamp_p, &audio_tstamp_p, &avail_p, &delay_p);
 
 		curr_count_p = frame_count_p - delay_p; /* written minus queued */
 
-		printf("playback: systime: %lli nsec, sample time %lli nsec \tsystime delta %lli \n",
-			timediff(tstamp_p,trigger_tstamp_p),
-			(long long)round(((float)curr_count_p * 1000000000.0 / 48000.0)),
-		       timediff(tstamp_p, trigger_tstamp_p) - (long long)round((double)curr_count_p * 1000000000.0 / 48000.0)
+		/* uncomment next line to see difference between old sample count and audio timestamps.
+		printf("curr_count %lli driver count %lli\n", (long long)curr_count_p * 1000000000LL / 48000, timestamp2ns(audio_tstamp_p));
+		*/
+
+		printf("playback: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+		       timediff(tstamp_p, trigger_tstamp_p),
+		       timestamp2ns(audio_tstamp_p),
+		       timediff(tstamp_p, trigger_tstamp_p) - timestamp2ns(audio_tstamp_p)
 		       );
 #endif
 
 #if defined(TRACK_CAPTURE)
-		gettimestamp(handle_c, &tstamp_c, &trigger_tstamp_c, &avail_c, &delay_c);
+		gettimestamp(handle_c, &tstamp_c, &trigger_tstamp_c, &audio_tstamp_c, &avail_c, &delay_c);
 
 		curr_count_c = frame_count_c + delay_c; /* read plus queued */
 
-		printf("\t capture: systime: %lli nsec, sample time %lli nsec \tsystime delta %lli \n",
-			timediff(tstamp_c,trigger_tstamp_c),
-			(long long)round(((float)curr_count_c * 1000000000.0 / 48000.0)),
-		       timediff(tstamp_c, trigger_tstamp_c) - (long long)round((double)curr_count_c * 1000000000.0 / 48000.0)
+		printf("\t capture: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+		       timediff(tstamp_c, trigger_tstamp_c),
+		       timestamp2ns(audio_tstamp_c),
+		       timediff(tstamp_c, trigger_tstamp_c) - timestamp2ns(audio_tstamp_c)
 		       );
 #endif
 
-- 
1.7.9.5
