From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 1/5] pcm: add helper functions to query
	timestamping capabilities
Date: Wed,  1 Jul 2015 15:40:54 -0500
Message-ID: <1435783258-23730-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1435783258-23730-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B39D26516E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 22:41:18 +0200 (CEST)
In-Reply-To: <1435783258-23730-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

extend support to link, link_estimated and link_synchronized
timestamp. wall-clock is deprecated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/pcm.h |  3 ++-
 src/pcm/pcm.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 0655e7f..2aa1eff 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -668,7 +668,8 @@ int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *params);
-int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params); /* deprecated, use audio_ts_type */
+int snd_pcm_hw_params_supports_audio_ts_type(const snd_pcm_hw_params_t *params, int type);
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num,
 				      unsigned int *rate_den);
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index bc18954..846d502 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3190,12 +3190,45 @@ int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *param
  */
 int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params)
 {
+	/* deprecated */
+	return snd_pcm_hw_params_supports_audio_ts_type(params,
+							SNDRV_PCM_AUDIO_TSTAMP_TYPE_COMPAT);
+}
+
+/**
+ * \brief Check if hardware supports type of audio timestamps
+ * \param params Configuration space
+ * \param type   Audio timestamp type
+ * \retval 0 Hardware doesn't support type of audio timestamps
+ * \retval 1 Hardware supports type of audio timestamps
+ *
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
+ */
+int snd_pcm_hw_params_supports_audio_ts_type(const snd_pcm_hw_params_t *params, int type)
+{
 	assert(params);
 	if (CHECK_SANITY(params->info == ~0U)) {
 		SNDMSG("invalid PCM info field");
 		return 0; /* FIXME: should be a negative error? */
 	}
-	return !!(params->info & SNDRV_PCM_INFO_HAS_WALL_CLOCK);
+	switch (type) {
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_COMPAT:
+		return !!(params->info & SNDRV_PCM_INFO_HAS_WALL_CLOCK); /* deprecated */
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT:
+		return 1; /* always supported, based on hw_ptr */
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK:
+		return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_ATIME);
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE:
+		return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME);
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED:
+		return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME);
+	case SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED:
+		return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME);
+	default:
+		return 0;
+	}
 }
 
 /**
-- 
1.9.1
