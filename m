From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 11:14:17 +0200
Message-ID: <4BF108E9.5020705@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>		<4BDABDDD.4050502@ladisch.de>		<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>		<s5hsk5uq4u4.wl%tiwai@suse.de>		<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 57732245C7
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 11:14:21 +0200 (CEST)
In-Reply-To: <4BF1086F.9070900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


---
 alsa-kernel/include/sound/asound.h  |    4 +
 alsa-kernel/include/sound/pcm.h     |    1
 alsa-kernel/sound/core/pcm_lib.c    |    8 ++-
 alsa-kernel/sound/core/pcm_native.c |    2
 alsa-lib/include/pcm.h              |    4 +
 alsa-lib/include/sound/asound.h     |    3 +
 alsa-lib/src/pcm/pcm.c              |   61 ++++++++++++++++++++++++++++
 alsa-lib/src/pcm/pcm_direct.c       |    2
 alsa-lib/src/pcm/pcm_local.h        |    3 +
 alsa-lib/src/pcm/pcm_multi.c        |    2
 10 files changed, 86 insertions(+), 4 deletions(-)

--- a/alsa-kernel/include/sound/asound.h
+++ b/alsa-kernel/include/sound/asound.h
@@ -255,6 +255,7 @@ typedef int __bitwise snd_pcm_subformat_
 #define SNDRV_PCM_INFO_HALF_DUPLEX	0x00100000	/* only half duplex */
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
+#define SNDRV_PCM_INFO_NO_PERIOD_IRQ	0x00800000	/* period interrupt can be disabled */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
@@ -330,6 +331,9 @@ typedef int snd_pcm_hw_param_t;
 #define	SNDRV_PCM_HW_PARAM_LAST_INTERVAL	SNDRV_PCM_HW_PARAM_TICK_TIME
 
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
+#define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
+#define SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ	(1<<2)	/* disable period
+							   interrupts */
 
 struct snd_interval {
 	unsigned int min, max;
--- a/alsa-kernel/include/sound/pcm.h
+++ b/alsa-kernel/include/sound/pcm.h
@@ -291,6 +291,7 @@ struct snd_pcm_runtime {
 	unsigned int info;
 	unsigned int rate_num;
 	unsigned int rate_den;
+	bool no_period_irq;
 
 	/* -- SW params -- */
 	int tstamp_mode;		/* mmap timestamp is updated */
--- a/alsa-kernel/sound/core/pcm_native.c
+++ b/alsa-kernel/sound/core/pcm_native.c
@@ -453,6 +453,8 @@ static int snd_pcm_hw_params(struct snd_
 	runtime->info = params->info;
 	runtime->rate_num = params->rate_num;
 	runtime->rate_den = params->rate_den;
+	runtime->no_period_irq =
+			!!(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ);
 
 	bits = snd_pcm_format_physical_width(runtime->format);
 	runtime->sample_bits = bits;
--- a/alsa-kernel/sound/core/pcm_lib.c
+++ b/alsa-kernel/sound/core/pcm_lib.c
@@ -363,7 +363,8 @@ static int snd_pcm_update_hw_ptr0(struct
 			   (unsigned long)runtime->hw_ptr_base);
 	}
 	/* something must be really wrong */
-	if (delta >= runtime->buffer_size + runtime->period_size) {
+	if (delta >= runtime->buffer_size + runtime->period_size &&
+	    !runtime->no_period_irq) {
 		hw_ptr_error(substream,
 			       "Unexpected hw_pointer value %s"
 			       "(stream=%i, pos=%ld, new_hw_ptr=%ld, "
@@ -384,6 +385,8 @@ static int snd_pcm_update_hw_ptr0(struct
 	 */
 	if (runtime->hw.info & SNDRV_PCM_INFO_BATCH)
 		goto no_jiffies_check;
+	if (runtime->no_period_irq)
+		goto no_jiffies_check;
 	hdelta = delta;
 	if (hdelta < runtime->delay)
 		goto no_jiffies_check;
@@ -420,7 +423,8 @@ static int snd_pcm_update_hw_ptr0(struct
 		hw_base = new_hw_ptr - (new_hw_ptr % runtime->buffer_size);
 	}
  no_jiffies_check:
-	if (delta > runtime->period_size + runtime->period_size / 2) {
+	if (delta > runtime->period_size + runtime->period_size / 2 &&
+	    !runtime->no_period_irq) {
 		hw_ptr_error(substream,
 			     "Lost interrupts? %s"
 			     "(stream=%i, delta=%ld, new_hw_ptr=%ld, "
--- a/alsa-lib/include/sound/asound.h
+++ b/alsa-lib/include/sound/asound.h
@@ -278,6 +278,7 @@ enum sndrv_pcm_subformat {
 #define SNDRV_PCM_INFO_HALF_DUPLEX	0x00100000	/* only half duplex */
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
+#define SNDRV_PCM_INFO_NO_PERIOD_IRQ	0x00800000	/* period interrupt can be disabled */
 
 enum sndrv_pcm_state {
 	SNDRV_PCM_STATE_OPEN = 0,	/* stream is open */
@@ -346,6 +347,8 @@ enum sndrv_pcm_hw_param {
 
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)  /* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)  /* export buffer */
+#define SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ	(1<<2)	/* disable period
+							   interrupts */
 
 struct sndrv_interval {
 	unsigned int min, max;
--- a/alsa-lib/include/pcm.h
+++ b/alsa-lib/include/pcm.h
@@ -531,6 +531,7 @@ int snd_pcm_hw_params_can_resume(const s
 int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num,
 				      unsigned int *rate_den);
@@ -622,10 +623,13 @@ int snd_pcm_hw_params_set_rate_minmax(sn
 int snd_pcm_hw_params_set_rate_near(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
 int snd_pcm_hw_params_set_rate_first(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
 int snd_pcm_hw_params_set_rate_last(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
+
 int snd_pcm_hw_params_set_rate_resample(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
 int snd_pcm_hw_params_get_rate_resample(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 int snd_pcm_hw_params_set_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
 int snd_pcm_hw_params_get_export_buffer(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
+int snd_pcm_hw_params_set_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int val);
+int snd_pcm_hw_params_get_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val);
 
 int snd_pcm_hw_params_get_period_time(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
 int snd_pcm_hw_params_get_period_time_min(const snd_pcm_hw_params_t *params, unsigned int *val, int *dir);
--- a/alsa-lib/src/pcm/pcm.c
+++ b/alsa-lib/src/pcm/pcm.c
@@ -3085,6 +3085,27 @@ int snd_pcm_hw_params_can_sync_start(con
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
+	assert(params);
+	if (CHECK_SANITY(params->info == ~0U)) {
+		SNDMSG("invalid PCM info field");
+		return 0; /* FIXME: should be a negative error? */
+	}
+	return !!(params->info & SNDRV_PCM_INFO_NO_PERIOD_IRQ);
+}
+
+/**
  * \brief Get rate exact info from a configuration space
  * \param params Configuration space
  * \param rate_num Pointer to returned rate numerator
@@ -4203,6 +4224,46 @@ int snd_pcm_hw_params_get_export_buffer(
 	return 0;
 }
 
+/**
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
+	assert(pcm && params);
+	if (!val)
+		params->flags |= SND_PCM_HW_PARAMS_NO_PERIOD_IRQ;
+	else
+		params->flags &= ~SND_PCM_HW_PARAMS_NO_PERIOD_IRQ;
+	return snd_pcm_hw_refine(pcm, params);
+}
+
+/**
+ * \brief Extract period interrupt mask from a configuration space
+ * \param pcm PCM handle
+ * \param params Configuration space
+ * \param val 0 = disable, 1 = enable period interrupts
+ * \return Zero on success, otherwise a negative error code.
+ */
+int snd_pcm_hw_params_get_period_irq(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, unsigned int *val)
+{
+	assert(pcm && params && val);
+	*val = params->flags & SND_PCM_HW_PARAMS_NO_PERIOD_IRQ ? 0 : 1;
+	return 0;
+}
+
 /**
  * \brief Extract period time from a configuration space
  * \param params Configuration space
--- a/alsa-lib/src/pcm/pcm_local.h
+++ b/alsa-lib/src/pcm/pcm_local.h
@@ -91,9 +91,12 @@ typedef enum sndrv_pcm_hw_param snd_pcm_
 #define SND_PCM_INFO_JOINT_DUPLEX SNDRV_PCM_INFO_JOINT_DUPLEX
 /** device can do a kind of synchronized start */
 #define SND_PCM_INFO_SYNC_START SNDRV_PCM_INFO_SYNC_START
+/** device can disable period interrupts */
+#define SND_PCM_INFO_NO_PERIOD_IRQ SNDRV_PCM_INFO_NO_PERIOD_IRQ
 
 #define SND_PCM_HW_PARAMS_NORESAMPLE SNDRV_PCM_HW_PARAMS_NORESAMPLE
 #define SND_PCM_HW_PARAMS_EXPORT_BUFFER SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER
+#define SND_PCM_HW_PARAMS_NO_PERIOD_IRQ SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ
 
 #define SND_PCM_INFO_MONOTONIC	0x80000000
 
--- a/alsa-lib/src/pcm/pcm_direct.c
+++ b/alsa-lib/src/pcm/pcm_direct.c
@@ -741,7 +741,7 @@ int snd_pcm_direct_hw_refine(snd_pcm_t *
 			changed |= err;
 		} while (changed);
 	}
-	params->info = dshare->shmptr->s.info;
+	params->info = dshare->shmptr->s.info & ~SND_PCM_INFO_NO_PERIOD_IRQ;
 #ifdef REFINE_DEBUG
 	snd_output_puts(log, "DMIX REFINE (end):\n");
 	snd_pcm_hw_params_dump(params, log);
--- a/alsa-lib/src/pcm/pcm_multi.c
+++ b/alsa-lib/src/pcm/pcm_multi.c
@@ -157,7 +157,7 @@ static int snd_pcm_multi_hw_refine_cprep
 				    multi->channels_count, 0);
 	if (err < 0)
 		return err;
-	params->info = ~0U;
+	params->info = ~SND_PCM_INFO_NO_PERIOD_IRQ;
 	return 0;
 }
