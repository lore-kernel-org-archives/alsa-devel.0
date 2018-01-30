From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-lib] [PATCH] pcm: add set and get methods for
	no-rewind flag
Date: Tue, 30 Jan 2018 15:03:28 +0530
Message-ID: <1517304808-16649-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AB20C267523
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 10:40:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Add functions to set/get no-rewind flag

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 include/pcm.h          |  2 ++
 include/sound/asound.h |  1 +
 src/pcm/pcm.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_local.h    |  1 +
 4 files changed, 44 insertions(+)

diff --git a/include/pcm.h b/include/pcm.h
index 2619c8cd8bd4..8c0b19c106b0 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -805,6 +805,8 @@ int snd_pcm_hw_params_set_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *par
 int snd_pcm_hw_params_get_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 int snd_pcm_hw_params_set_period_wakeup(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
 int snd_pcm_hw_params_get_period_wakeup(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
+int snd_pcm_hw_params_set_no_rewind(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
+int snd_pcm_hw_params_get_no_rewind(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 
 int snd_pcm_hw_params_get_period_time(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
 int snd_pcm_hw_params_get_period_time_min(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 6041cab27a23..35fd50ec5395 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -375,6 +375,7 @@ typedef int snd_pcm_hw_param_t;
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
 #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
+#define SNDRV_PCM_HW_PARAMS_NO_REWINDS          (1<<3)  /* disable rewinds */
 
 struct snd_interval {
 	unsigned int min, max;
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 69d7d66500ea..c7041be47be6 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -4763,6 +4763,46 @@ int snd_pcm_hw_params_get_period_wakeup(snd_pcm_t *pcm, snd_pcm_hw_params_t *par
 }
 
 /**
+ * \brief Configure no-rewind flag through configuration space
+ * \param pcm PCM handle
+ * \param params Configuration space
+ * \param val 0 = disable (default), 1 = enable (default) no-rewind flag
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function can be called to inform driver about application uses rewind or not
+ *
+ * Based on no-rewind flag, underlying driver could take decision on buffering scheme.
+ */
+
+/* TODO: Invert the logic with function name set_rewind */
+int snd_pcm_hw_params_set_no_rewind(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val)
+{
+	assert(pcm && params);
+
+	if (val) {
+		params->flags |= SND_PCM_HW_PARAMS_NO_REWINDS;
+	} else
+		params->flags &= ~SND_PCM_HW_PARAMS_NO_REWINDS;
+	params->rmask = ~0;
+
+	return snd_pcm_hw_refine(pcm, params);
+}
+
+/**
+ * \brief Extract no-rewind flag from a configuration space
+ * \param pcm PCM handle
+ * \param params Configuration space
+ * \param val 0 = disabled, 1 = enabled no-rewind flag
+ * \return Zero on success, otherwise a negative error code.
+ */
+int snd_pcm_hw_params_get_no_rewind(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val)
+{
+	assert(pcm && params && val);
+	*val = params->flags & SND_PCM_HW_PARAMS_NO_REWINDS ? 0 : 1;
+	return 0;
+}
+
+/**
  * \brief Extract period time from a configuration space
  * \param params Configuration space
  * \param val Returned approximate period duration in us
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 3d95e1749169..91479cabff88 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -103,6 +103,7 @@
 #define SND_PCM_HW_PARAMS_NORESAMPLE SNDRV_PCM_HW_PARAMS_NORESAMPLE
 #define SND_PCM_HW_PARAMS_EXPORT_BUFFER SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER
 #define SND_PCM_HW_PARAMS_NO_PERIOD_WAKEUP SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP
+#define SND_PCM_HW_PARAMS_NO_REWINDS SNDRV_PCM_HW_PARAMS_NO_REWINDS
 
 #define SND_PCM_INFO_MONOTONIC	0x80000000
 
-- 
2.7.4
