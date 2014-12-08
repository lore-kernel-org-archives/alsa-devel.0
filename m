From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 3/4] pcm: add helper functions to query
	timestamping capabilities
Date: Mon,  8 Dec 2014 16:28:45 -0600
Message-ID: <1418077726-8516-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B09FD265382
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:29:04 +0100 (CET)
In-Reply-To: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

extend support to link, link_estimated and link_synchronized
timestamp. wall-clock is deprecated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/pcm.h |  5 ++++-
 src/pcm/pcm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index f963b92..f8c557b 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -684,7 +684,10 @@ int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *params);
-int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params); /* deprecated */
+int snd_pcm_hw_params_supports_audio_link_ts(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_supports_audio_link_estimated_ts(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_supports_audio_link_synchronized_ts(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num,
 				      unsigned int *rate_den);
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index af7d8c9..28a2a4e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3190,12 +3190,68 @@ int snd_pcm_hw_params_can_disable_period_wakeup(const snd_pcm_hw_params_t *param
  */
 int snd_pcm_hw_params_supports_audio_wallclock_ts(const snd_pcm_hw_params_t *params)
 {
+	/* deprecated */
+	return snd_pcm_hw_params_supports_audio_link_ts(params);
+}
+
+/**
+ * \brief Check if hardware supports audio link timestamps
+ * \param params Configuration space
+ * \retval 0 Hardware doesn't support audio link timestamps
+ * \retval 1 Hardware supports audio link timestamps
+ *
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
+ */
+int snd_pcm_hw_params_supports_audio_link_ts(const snd_pcm_hw_params_t *params)
+{
+	assert(params);
+	if (CHECK_SANITY(params->info == ~0U)) {
+		SNDMSG("invalid PCM info field");
+		return 0; /* FIXME: should be a negative error? */
+	}
+	return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_ATIME);
+}
+
+/**
+ * \brief Check if hardware supports audio link estimated timestamps
+ * \param params Configuration space
+ * \retval 0 Hardware doesn't support audio link estimated timestamps
+ * \retval 1 Hardware supports audio link estimated timestamps
+ *
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
+ */
+int snd_pcm_hw_params_supports_audio_link_estimated_ts(const snd_pcm_hw_params_t *params)
+{
+	assert(params);
+	if (CHECK_SANITY(params->info == ~0U)) {
+		SNDMSG("invalid PCM info field");
+		return 0; /* FIXME: should be a negative error? */
+	}
+	return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME);
+}
+
+/**
+ * \brief Check if hardware supports audio link synchronized timestamps
+ * \param params Configuration space
+ * \retval 0 Hardware doesn't support audio link synchronized timestamps
+ * \retval 1 Hardware supports audio link synchronized timestamps
+ *
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
+ */
+int snd_pcm_hw_params_supports_audio_link_synchronized_ts(const snd_pcm_hw_params_t *params)
+{
 	assert(params);
 	if (CHECK_SANITY(params->info == ~0U)) {
 		SNDMSG("invalid PCM info field");
 		return 0; /* FIXME: should be a negative error? */
 	}
-	return !!(params->info & SNDRV_PCM_INFO_HAS_WALL_CLOCK);
+	return !!(params->info & SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME);
 }
 
 /**
-- 
2.1.0
