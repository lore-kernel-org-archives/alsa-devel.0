From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v3 alsa-lib 1/3] snd_pcm_start_at and friends.
Date: Fri,  6 Feb 2015 16:15:59 +0000
Message-ID: <1423239361-17655-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 741212605E8
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:16:13 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 01B8620AD6
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:16:12 -0500 (EST)
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
Cc: Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

Upcoming audio hardware has the ability to begin playback when the value
of a high-precision free-running counter matches some programmable value.

This patch exposes such capability in a general way, allowing for several
clock sources, including both system clocks and audio hardware clocks.

We define 3 new methods that operate on a snd_pcm_t, and 1 that
operates on a snd_pcm_status_t.

- snd_pcm_start_at()
allows client code to delegate the starting of the stream to the kernel.

- snd_pcm_start_at_abort()
allows client code to cancel a previous call to snd_pcm_start_at().

- snd_pcm_start_at_gettime()
allows client code to query the current time for a given clock.

- snd_pcm_status_get_startat_state()
allows client code to extract information about any pending start_at timer
from a snd_pcm_status_t object.

We define a new enum: snd_pcm_startat_clock_type_t, which reinforces a clean
boundary between the capabilities of the timestamping system and the start_at
system. The clock and audio hw sources are grouped together because the
difference is irrelevant to the use of snd_pcm_start_at().

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/pcm.h b/include/pcm.h
index 0655e7f..4f4834b 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -330,6 +330,17 @@ typedef enum _snd_pcm_tstamp_type {
 	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 } snd_pcm_tstamp_type_t;
 
+/** PCM start_at clock types */
+typedef enum _snd_pcm_startat_clock_type {
+	/** POSIX CLOCK_REALTIME equivalent */
+	SND_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY = 0,
+	/** POSIX CLOCK_MONOTONIC equivalent */
+	SND_PCM_STARTAT_CLOCK_TYPE_MONOTONIC,
+	/** Default link clock */
+	SND_PCM_STARTAT_CLOCK_TYPE_LINK,
+	SND_PCM_STARTAT_CLOCK_TYPE_LAST = SND_PCM_STARTAT_CLOCK_TYPE_LINK,
+} snd_pcm_startat_clock_type_t;
+
 /** Unsigned frames quantity */
 typedef unsigned long snd_pcm_uframes_t;
 /** Signed frames quantity */
@@ -478,6 +489,9 @@ int snd_pcm_prepare(snd_pcm_t *pcm);
 int snd_pcm_reset(snd_pcm_t *pcm);
 int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status);
 int snd_pcm_start(snd_pcm_t *pcm);
+int snd_pcm_start_at(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, const snd_htimestamp_t* start_time);
+int snd_pcm_start_at_abort(snd_pcm_t *pcm);
+int snd_pcm_start_at_gettime(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, snd_htimestamp_t* current_time);
 int snd_pcm_drop(snd_pcm_t *pcm);
 int snd_pcm_drain(snd_pcm_t *pcm);
 int snd_pcm_pause(snd_pcm_t *pcm, int enable);
@@ -984,6 +998,7 @@ snd_pcm_sframes_t snd_pcm_status_get_delay(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail_max(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_overrange(const snd_pcm_status_t *obj);
+void snd_pcm_status_get_startat_state(const snd_pcm_status_t *obj, int *pending, snd_pcm_startat_clock_type_t *clock_type, snd_htimestamp_t *start_time);
 
 /** \} */
 
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index e74e02f..f2cbd8e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1085,6 +1085,74 @@ int snd_pcm_start(snd_pcm_t *pcm)
 }
 
 /**
+ * \brief Start a PCM at a specified point in the future
+ * \param pcm PCM handle
+ * \param clock_type Specifies the start_at clock with which to interpret \p start_time
+ * \param start_time Absolute time at which to start the stream
+ * \return 0 on success otherwise a negative error code
+ * \retval -ENOSYS operation not supported for the current timestamp type
+ * \retval -EINVAL timespec, tstamp_class or tstamp_type is invalid
+ * \retval -ETIME requested start_time cannot be satisfied
+ *
+ * This method is non-blocking: It establishes an appropriate timer in the kernel
+ * that will start the stream on expiry.
+ *
+ * Any pending timer is unconditionally cancelled.
+ */
+int snd_pcm_start_at(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, const snd_htimestamp_t *start_time)
+{
+	assert(pcm);
+	assert(start_time);
+	if (CHECK_SANITY(! pcm->setup)) {
+		SNDMSG("PCM not set up");
+		return -EIO;
+	}
+	if (pcm->fast_ops->start_at) {
+		return pcm->fast_ops->start_at(pcm->fast_op_arg, clock_type, start_time);
+	}
+	return -EINVAL;
+}
+
+/**
+ * \brief Abort the pending PCM start_at timer
+ * \param pcm PCM handle
+ * \return 0 on success otherwise a negative error code
+ *
+ * If a start_at timer is pending, it is cancelled.
+ */
+int snd_pcm_start_at_abort(snd_pcm_t *pcm)
+{
+	assert(pcm);
+	if (CHECK_SANITY(! pcm->setup)) {
+		SNDMSG("PCM not set up");
+		return -EIO;
+	}
+	if (pcm->fast_ops->start_at_abort) {
+		return pcm->fast_ops->start_at_abort(pcm->fast_op_arg);
+	}
+	return -EINVAL;
+}
+
+/**
+ * \brief Get current time for a given start_at clock
+ * \param pcm PCM handle
+ * \param clock_type Start_at clock type e.g. SND_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY
+ * \return 0 on success otherwise a negative error code
+ */
+int snd_pcm_start_at_gettime(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, snd_htimestamp_t *current_time)
+{
+	assert(pcm);
+	if (CHECK_SANITY(! pcm->setup)) {
+		SNDMSG("PCM not set up");
+		return -EIO;
+	}
+	if (pcm->fast_ops->start_at_gettime) {
+		return pcm->fast_ops->start_at_gettime(pcm->fast_op_arg, clock_type, current_time);
+	}
+	return -EINVAL;
+}
+
+/**
  * \brief Stop a PCM dropping pending frames
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
@@ -6380,6 +6448,20 @@ snd_pcm_uframes_t snd_pcm_status_get_overrange(const snd_pcm_status_t *obj)
 }
 
 /**
+ * \brief Get status of a pending start_at timer, if any.
+ * \param pending output param: 1 if start_at timer pending, 0 otherwise
+ * \param clock_type output param: if pending == 1, is updated with current start_at timer clock_type
+ * \param start_time output param: if pending == 1, is updated with current start_at timer start_time
+ */
+void snd_pcm_status_get_startat_state(const snd_pcm_status_t *obj, int *pending, snd_pcm_startat_clock_type_t *clock_type, snd_htimestamp_t *start_time)
+{
+	assert(obj);
+	*pending = obj->start_at_pending;
+	*clock_type = obj->start_at_clock_type;
+	*start_time = obj->start_at_start_time;
+}
+
+/**
  * \brief get size of #snd_pcm_info_t
  * \return size in bytes
  */
-- 
1.9.1
