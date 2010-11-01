From: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Subject: [PATCH 2/2] add API to allow disabling period interrupt
Date: Mon,  1 Nov 2010 17:13:34 -0500
Message-ID: <1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 021BB1038BB
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 23:13:48 +0100 (CET)
Received: by yxs7 with SMTP id 7so4178039yxs.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 15:13:48 -0700 (PDT)
In-Reply-To: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

cleaned-up version of the patch posted on May 17, 2010 by
Clemens Ladisch <clemens@ladisch.de>
(No filtering in pcm_multi and pcm_direct info fields)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
---
 configure.in           |    2 +-
 include/pcm.h          |    3 ++
 include/sound/asound.h |    5 +++-
 src/Versions.in        |    7 +++++
 src/pcm/pcm.c          |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_local.h    |    3 ++
 6 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index c353759..0a67de7 100644
--- a/configure.in
+++ b/configure.in
@@ -12,7 +12,7 @@ dnl add API = c+1:0:a+1
 dnl remove API = c+1:0:0
 dnl *************************************************
 AC_CANONICAL_HOST
-AM_INIT_AUTOMAKE(alsa-lib, 1.0.23)
+AM_INIT_AUTOMAKE(alsa-lib, 1.0.24)
 eval LIBTOOL_VERSION_INFO="2:0:0"
 dnl *************************************************
 AM_CONDITIONAL(INSTALL_M4, test -n "${ACLOCAL}")
diff --git a/include/pcm.h b/include/pcm.h
index f3618c3..cd506ab 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -531,6 +531,7 @@ int snd_pcm_hw_params_can_resume(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num,
 				      unsigned int *rate_den);
@@ -626,6 +627,8 @@ int snd_pcm_hw_params_set_rate_resample(snd_pcm_t *pcm, snd_pcm_hw_params_t *par
 int snd_pcm_hw_params_get_rate_resample(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 int snd_pcm_hw_params_set_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
 int snd_pcm_hw_params_get_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
+int snd_pcm_hw_params_set_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
+int snd_pcm_hw_params_get_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 
 int snd_pcm_hw_params_get_period_time(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
 int snd_pcm_hw_params_get_period_time_min(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index fa88938..fbcfef9 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -278,6 +278,8 @@ enum sndrv_pcm_subformat {
 #define SNDRV_PCM_INFO_HALF_DUPLEX	0x00100000	/* only half duplex */
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
+#define SNDRV_PCM_INFO_NO_PERIOD_IRQ    0x00800000      /* period interrupt can be disabled */
+#define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 enum sndrv_pcm_state {
 	SNDRV_PCM_STATE_OPEN = 0,	/* stream is open */
@@ -346,7 +348,8 @@ enum sndrv_pcm_hw_param {
 
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)  /* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)  /* export buffer */
-
+#define SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ      (1<<2)  /* disable period
+                                                          interrupts */
 struct sndrv_interval {
 	unsigned int min, max;
 	unsigned int openmin:1,
diff --git a/src/Versions.in b/src/Versions.in
index 8d2dd11..112b9ec 100644
--- a/src/Versions.in
+++ b/src/Versions.in
@@ -129,3 +129,10 @@ ALSA_0.9.7 {
     @SYMBOL_PREFIX@alsa_lisp_*;
 } ALSA_0.9.5;
 
+ALSA_1.0.24 {
+  global:
+    @SYMBOL_PREFIX@snd_pcm_hw_params_can_disable_period_irq;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_set_period_irq;
+    @SYMBOL_PREFIX@snd_pcm_hw_params_get_period_irq;
+
+} ALSA_0.9.7;
\ No newline at end of file
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index a49b5b9..6eb7223 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3081,6 +3081,27 @@ int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params)
 }
 
 /**
+ * \brief Check if hardware can disable period interrupts
+ * \param params Configuration space
+ * \return Boolean value
+ * \retval 0 Hardware cannot disable period interrupts
+ * \retval 1 Hardware can disable period interrupts
+ *
+ * It is not allowed to call this function when given configuration is not exactly one.
+ * Usually, #snd_pcm_hw_params() function chooses one configuration
+ * from the configuration space.
+ */
+int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params)
+{
+        assert(params);
+        if (CHECK_SANITY(params->info == ~0U)) {
+                SNDMSG("invalid PCM info field");
+                return 0; /* FIXME: should be a negative error? */
+        }
+        return !!(params->info & SNDRV_PCM_INFO_NO_PERIOD_IRQ);
+}
+
+/**
  * \brief Get rate exact info from a configuration space
  * \param params Configuration space
  * \param rate_num Pointer to returned rate numerator
@@ -4200,6 +4221,46 @@ int snd_pcm_hw_params_get_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *par
 }
 
 /**
+ * \brief Restrict a configuration space to settings without period interrupts
+ * \param pcm PCM handle
+ * \param params Configuration space
+ * \param val 0 = disable, 1 = enable (default) period interrupts
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function should be called only on devices where
+ * #snd_pcm_hw_params_can_disable_period_irq() returns true. (too late, FIXME)
+ *
+ * Even with disabled period interrupts, the period size/time/count parameters
+ * are valid; it is suggested to use #snd_pcm_hw_params_set_period_size_last().
+ *
+ * When period interrupts are disabled, the application must not use poll() or
+ * any functions that could block on this device.
+ */
+int snd_pcm_hw_params_set_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val)
+{
+       assert(pcm && params);
+       if (!val)
+               params->flags |= SND_PCM_HW_PARAMS_NO_PERIOD_IRQ;
+       else
+               params->flags &= ~SND_PCM_HW_PARAMS_NO_PERIOD_IRQ;
+       return snd_pcm_hw_refine(pcm, params);
+}
+
+/**
+ * \brief Extract period interrupt mask from a configuration space
+ * \param pcm PCM handle
+ * \param params Configuration space
+ * \param val overwritten with 0 = disabled, 1 = enabled period interrupts
+ * \return Zero 
+ */
+int snd_pcm_hw_params_get_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val)
+{
+       assert(pcm && params && val);
+       *val = params->flags & SND_PCM_HW_PARAMS_NO_PERIOD_IRQ ? 0 : 1;
+       return 0;
+}
+
+/**
  * \brief Extract period time from a configuration space
  * \param params Configuration space
  * \param val Returned approximate period duration in us
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 2f6fcd2..768f526 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -91,9 +91,12 @@ typedef enum sndrv_pcm_hw_param snd_pcm_hw_param_t;
 #define SND_PCM_INFO_JOINT_DUPLEX SNDRV_PCM_INFO_JOINT_DUPLEX
 /** device can do a kind of synchronized start */
 #define SND_PCM_INFO_SYNC_START SNDRV_PCM_INFO_SYNC_START
+/** device can disable period interrupts */
+#define SND_PCM_INFO_NO_PERIOD_IRQ SNDRV_PCM_INFO_NO_PERIOD_IRQ
 
 #define SND_PCM_HW_PARAMS_NORESAMPLE SNDRV_PCM_HW_PARAMS_NORESAMPLE
 #define SND_PCM_HW_PARAMS_EXPORT_BUFFER SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER
+#define SND_PCM_HW_PARAMS_NO_PERIOD_IRQ SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ
 
 #define SND_PCM_INFO_MONOTONIC	0x80000000
 
-- 
1.7.2.3
