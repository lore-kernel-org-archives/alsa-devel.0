From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] pcm: support for audio wallclock
Date: Thu, 28 Jun 2012 16:13:58 -0500
Message-ID: <1340918038-31479-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id DAAD224454
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 23:14:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

add new snd_pcm_status_get_htstamp_wallclk() routine to
query the audio timestamps read from the wallclock.
Also add snd_pcm_hw_params_supports_audio_wallclock_ts()
to query what the hardware supports.

TODO: check protocol compatibility?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/pcm.h          |    2 ++
 include/sound/asound.h |    7 +++++--
 src/pcm/pcm.c          |   31 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 4997557..542d9a8 100644
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
+void snd_pcm_status_get_htstamp_wallclk(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
 snd_pcm_sframes_t snd_pcm_status_get_delay(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail_max(const snd_pcm_status_t *obj);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 07c03fa..f0d23d6 100644
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
+	struct timespec audio_tstamp;	/* audio wall clock timestamp */
+	unsigned char reserved[60-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct sndrv_pcm_mmap_status {
@@ -435,6 +437,7 @@ struct sndrv_pcm_mmap_status {
 	sndrv_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
 	int suspended_state;		/* RO: suspended stream state */
+	struct timespec audio_tstamp;	/* audio wall clock timestamp */
 };
 
 struct sndrv_pcm_mmap_control {
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 18b43b3..49d7b99 100644
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
+ * \brief Get "now" hi-res audio wallclock timestamp from a PCM status container
+ * \param obj pointer to #snd_pcm_status_t
+ * \param ptr Pointer to returned timestamp
+ */
+void snd_pcm_status_get_htstamp_wallclk(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr)
+{
+	assert(obj && ptr);
+	*ptr = obj->audio_tstamp;
+}
+
+/**
  * \brief Get delay from a PCM status container (see #snd_pcm_delay)
  * \return Delay in frames
  *
-- 
1.7.6.5
