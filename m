From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Wed, 17 Dec 2014 17:27:47 +0000
Message-ID: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 874002612D7
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 18:31:28 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0064720F00
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 12:31:27 -0500 (EST)
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
Cc: tiwai@suse.de, nstoughton@aether.com, Tim Cussins <timcussins@eml.cc>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add notion of TSTAMP_CLASS (SYSTEM/AUDIO) as per Pierre's suggestion.
Add snd_pcm_start_at()

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/pcm.h b/include/pcm.h
index 0655e7f..c57edca 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -323,13 +323,25 @@ typedef enum _snd_pcm_tstamp {
 	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_ENABLE
 } snd_pcm_tstamp_t;
 
+typedef enum _snd_pcm_tstamp_class {
+	SND_PCM_TSTAMP_CLASS_SYSTEM = 0,
+	SND_PCM_TSTAMP_CLASS_AUDIO,
+	SND_PCM_TSTAMP_CLASS_LAST = SND_PCM_TSTAMP_CLASS_AUDIO,
+} snd_pcm_tstamp_class_t;
+
 typedef enum _snd_pcm_tstamp_type {
 	SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/** gettimeofday equivalent */
-	SND_PCM_TSTAMP_TYPE_MONOTONIC,	/** posix_clock_monotonic equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC,		/** posix_clock_monotonic equivalent */
 	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/** monotonic_raw (no NTP) */
 	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 } snd_pcm_tstamp_type_t;
 
+typedef enum _snd_pcm_audio_tstamp_type {
+	SND_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 0,
+	SND_PCM_AUDIO_TSTAMP_TYPE_LINK,
+	SND_PCM_AUDIO_TSTAMP_TYPE_LAST = SND_PCM_AUDIO_TSTAMP_TYPE_LINK,
+} snd_pcm_audio_tstamp_t;
+
 /** Unsigned frames quantity */
 typedef unsigned long snd_pcm_uframes_t;
 /** Signed frames quantity */
@@ -478,6 +490,7 @@ int snd_pcm_prepare(snd_pcm_t *pcm);
 int snd_pcm_reset(snd_pcm_t *pcm);
 int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status);
 int snd_pcm_start(snd_pcm_t *pcm);
+int snd_pcm_start_at(snd_pcm_t *pcm, snd_pcm_tstamp_class_t tstamp_class, int tstamp_type, const snd_htimestamp_t* start_time);
 int snd_pcm_drop(snd_pcm_t *pcm);
 int snd_pcm_drain(snd_pcm_t *pcm);
 int snd_pcm_pause(snd_pcm_t *pcm, int enable);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1f23cd6..1592160 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -466,12 +466,30 @@ struct snd_xfern {
 };
 
 enum {
+	SNDRV_PCM_TSTAMP_CLASS_SYSTEM = 0,
+	SNDRV_PCM_TSTAMP_CLASS_AUDIO,
+	SNDRV_PCM_TSTAMP_CLASS_LAST = SNDRV_PCM_TSTAMP_CLASS_AUDIO,
+};
+
+enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/* monotonic_raw (no NTP) */
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
+enum {
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 0,
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK,
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK,
+};
+
+struct snd_start_at {
+	int tstamp_class;
+	int tstamp_type;
+	struct timespec start_time;
+};
+
 /* channel positions */
 enum {
 	SNDRV_CHMAP_UNKNOWN = 0,
@@ -550,6 +568,8 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT	_IOW('A', 0x62, struct snd_start_at)
+
 
 /*****************************************************************************
  *                                                                           *
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index baa47c7..40a4689 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1085,6 +1085,37 @@ int snd_pcm_start(snd_pcm_t *pcm)
 }
 
 /**
+ * \brief Start a PCM at a specified point in the future
+ * \param pcm PCM handle
+ * \param tstamp_class specifies the class of tstamp_type
+ * \param tstamp_type specifies the clock with which to interpret \p start_time
+ * \param start_time Absolute time at which to start the stream
+ * \return 0 on success otherwise a negative error code
+ * \retval -ENOSYS operation not supported for the current timestamp type
+ * \retval -EINVAL timespec, tstamp_class or tstamp_type is invalid
+ * \retval -ETIME requested start_time cannot be satisfied
+ *
+ * This method is non-blocking: It establishes an appropriate timer in the kernel
+ * that will start the stream on expiry.
+ *
+ * The timer is unconditionally cancelled upon any \a attempt to change the stream
+ * state e.g. drop, drain, start, start_at.
+ */
+int snd_pcm_start_at(snd_pcm_t *pcm, snd_pcm_tstamp_class_t tstamp_class, int tstamp_type, const snd_htimestamp_t *start_time)
+{
+	assert(pcm);
+	assert(start_time);
+	if (CHECK_SANITY(! pcm->setup)) {
+		SNDMSG("PCM not set up");
+		return -EIO;
+	}
+	if (pcm->fast_ops->start_at) {
+		return pcm->fast_ops->start_at(pcm->fast_op_arg, tstamp_class, tstamp_type, start_time);
+	}
+	return -EINVAL;
+}
+
+/**
  * \brief Stop a PCM dropping pending frames
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c34b766..0190787 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -620,6 +620,26 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_hw_start_at(snd_pcm_t *pcm, snd_pcm_tstamp_class_t tstamp_class, int tstamp_type, const snd_htimestamp_t *start_time)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+	int err;
+
+	struct snd_start_at start_at = {
+		.tstamp_class = tstamp_class,
+		.tstamp_type = tstamp_type,
+		.start_time = *start_time
+	};
+
+	sync_ptr(hw, 0);
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, &start_at) < 0) {
+		err = -errno;
+		SYSMSG("SNDRV_PCM_IOCTL_START_AT failed (%i)", err);
+		return err;
+	}
+	return 0;
+}
+
 static int snd_pcm_hw_drop(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
@@ -1336,6 +1356,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
 	.prepare = snd_pcm_hw_prepare,
 	.reset = snd_pcm_hw_reset,
 	.start = snd_pcm_hw_start,
+	.start_at = snd_pcm_hw_start_at,
 	.drop = snd_pcm_hw_drop,
 	.drain = snd_pcm_hw_drain,
 	.pause = snd_pcm_hw_pause,
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 394505f..5cdfd3a 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -154,6 +154,7 @@ typedef struct {
 	int (*prepare)(snd_pcm_t *pcm);
 	int (*reset)(snd_pcm_t *pcm);
 	int (*start)(snd_pcm_t *pcm);
+	int (*start_at)(snd_pcm_t *pcm, snd_pcm_tstamp_class_t tstamp_class, int tstamp_type, const snd_htimestamp_t *start_time);
 	int (*drop)(snd_pcm_t *pcm);
 	int (*drain)(snd_pcm_t *pcm);
 	int (*pause)(snd_pcm_t *pcm, int enable);
-- 
1.7.10.4
