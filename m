From: Tim Cussins <timcussins@eml.cc>
Subject: [RFC] alsa-lib: Add snd_pcm_start_at
Date: Wed,  3 Dec 2014 16:27:29 +0000
Message-ID: <1417624049-9043-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 92BBB260477
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 17:27:45 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id E7CEF20F7D
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 11:27:44 -0500 (EST)
Received: from PC816.linn.co.uk (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id 60B126801B0
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 11:27:44 -0500 (EST)
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
List-Id: alsa-devel@alsa-project.org

snd_pcm_start_at() - alsa-lib

The headlines:

- Provide userspace snd_pcm_start_at, leverage new ioctl
- Provide some decent doxygen guff

diff --git a/include/pcm.h b/include/pcm.h
index 0655e7f..bbe6e79 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -325,9 +325,10 @@ typedef enum _snd_pcm_tstamp {
 
 typedef enum _snd_pcm_tstamp_type {
 	SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/** gettimeofday equivalent */
-	SND_PCM_TSTAMP_TYPE_MONOTONIC,	/** posix_clock_monotonic equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC,		/** posix_clock_monotonic equivalent */
 	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/** monotonic_raw (no NTP) */
-	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
+	SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,	/** audio hw clock */
+	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,
 } snd_pcm_tstamp_type_t;
 
 /** Unsigned frames quantity */
@@ -478,6 +479,7 @@ int snd_pcm_prepare(snd_pcm_t *pcm);
 int snd_pcm_reset(snd_pcm_t *pcm);
 int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status);
 int snd_pcm_start(snd_pcm_t *pcm);
+int snd_pcm_start_at(snd_pcm_t *pcm, const snd_htimestamp_t* start_time);
 int snd_pcm_drop(snd_pcm_t *pcm);
 int snd_pcm_drain(snd_pcm_t *pcm);
 int snd_pcm_pause(snd_pcm_t *pcm, int enable);
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 941d32f..bcc49dc 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -467,8 +467,9 @@ struct snd_xfern {
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
-	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,	/* audio hw clock */
+	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,
 };
 
 /* channel positions */
@@ -549,6 +550,8 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT	_IOW('A', 0x62, snd_htimestamp_t)
+
 
 /*****************************************************************************
  *                                                                           *
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index baa47c7..61158cb 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1085,6 +1085,38 @@ int snd_pcm_start(snd_pcm_t *pcm)
 }
 
 /**
+ * \brief Start a PCM at a specified point in the future
+ * \param pcm PCM handle
+ * \param start_time Absolute time at which to start the stream
+ * \return 0 on success otherwise a negative error code
+ * \retval -ENOSYS operation not supported for the current timestamp type
+ * \retval -EINVAL timespec invalid
+ * \retval -ETIME requested start_time cannot be satisfied
+ *
+ * This method is non-blocking: It establishes an appropriate timer in the kernel
+ * that will start the stream on expiry.
+ *
+ * The timer is unconditionally cancelled upon any \a attempt to change the stream
+ * state e.g. drop, drain, start, start_at.
+ *
+ * \p start_time is interpreted in the context of the stream snd_pcm_tstamp_type,
+ * set using \link ::snd_pcm_sw_params_set_tstamp_type() \endlink.
+ */
+int snd_pcm_start_at(snd_pcm_t *pcm, const snd_htimestamp_t *start_time)
+{
+	assert(pcm);
+	assert(start_time);
+	if (CHECK_SANITY(! pcm->setup)) {
+		SNDMSG("PCM not set up");
+		return -EIO;
+	}
+	if (pcm->fast_ops->start_at) {
+		return pcm->fast_ops->start_at(pcm->fast_op_arg, start_time);
+	}
+	return -EINVAL;
+}
+
+/**
  * \brief Stop a PCM dropping pending frames
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
@@ -1693,6 +1725,7 @@ static const char *const snd_pcm_tstamp_type_names[] = {
 	TSTAMP_TYPE(GETTIMEOFDAY),
 	TSTAMP_TYPE(MONOTONIC),
 	TSTAMP_TYPE(MONOTONIC_RAW),
+	TSTAMP_TYPE(AUDIO_WALLCLOCK),
 };
 #endif
 
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c34b766..aa0c7ba 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -447,6 +447,11 @@ static int snd_pcm_hw_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
 		hw->mmap_control->avail_min = params->avail_min;
 		return sync_ptr(hw, 0);
 	}
+	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK &&
+	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
+		SYSMSG("Kernel doesn't support SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK");
+		return -EINVAL;
+	}
 	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW &&
 	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
 		SYSMSG("Kernel doesn't support SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW");
@@ -620,6 +625,20 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_hw_start_at(snd_pcm_t *pcm, const snd_htimestamp_t *start_time)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+	int err;
+
+	sync_ptr(hw, 0);
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, start_time) < 0) {
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
@@ -1336,6 +1355,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
 	.prepare = snd_pcm_hw_prepare,
 	.reset = snd_pcm_hw_reset,
 	.start = snd_pcm_hw_start,
+	.start_at = snd_pcm_hw_start_at,
 	.drop = snd_pcm_hw_drop,
 	.drain = snd_pcm_hw_drain,
 	.pause = snd_pcm_hw_pause,
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 394505f..6829750 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -154,6 +154,7 @@ typedef struct {
 	int (*prepare)(snd_pcm_t *pcm);
 	int (*reset)(snd_pcm_t *pcm);
 	int (*start)(snd_pcm_t *pcm);
+	int (*start_at)(snd_pcm_t *pcm, const snd_htimestamp_t *start_time);
 	int (*drop)(snd_pcm_t *pcm);
 	int (*drain)(snd_pcm_t *pcm);
 	int (*pause)(snd_pcm_t *pcm, int enable);
-- 
1.7.10.4
