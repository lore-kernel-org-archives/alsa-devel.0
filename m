From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib v2 1/3] pcm: Add thread-safety to PCM
	API
Date: Thu,  7 Jul 2016 16:40:11 +0200
Message-ID: <20160707144013.23953-2-tiwai@suse.de>
References: <20160707144013.23953-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9131E26584A
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:40:16 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 49D9DAC35
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:40:16 +0000 (UTC)
In-Reply-To: <20160707144013.23953-1-tiwai@suse.de>
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

Traditionally, many of ALSA library functions are supposed to be
thread-unsafe, and applications are required to take care of thread
safety by themselves.  However, people never be careful enough, and
almost all applications fail in this regard.

This patch is an attempt to harden the thread safety in exported PCM
functions in a simplistic way: just wrap some of exported functions
with the pthread mutex of each PCM object.  Not all API functions are
wrapped by the mutex since it doesn't make sense.  Instead, the
patchset covers only the functions that may be likely called
concurrently.  The supposedly thread-safe API functions are marked in
the document.

For achieving the feature, two new fields are added snd_pcm_t when the
option is enabled: thread_safe and lock.  The former indicates that
the plugin is thread-safe that doesn't need this workaround and the
latter is the pthread mutex.  Currently only hw plugin have
thread_safe=1.  So, the most of real-time sensitive apps won't be
influenced by this patchset.

Although the patch covers most of PCM ops, a few snd_pcm_fast_ops are
left without the extra mutex locking: namely, the ones that may have
blocking behavior, i.e. resume, drain, readi, writei, readn and
writen.  These are supposed to handle own locking in the callbacks.

Also, if anyone wants to disable this new thread-safe API feature, it
can be still turned off via --disable-thread-safety configure option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 INSTALL               |   9 ++
 configure.ac          |  15 ++
 include/pcm_ioplug.h  |  10 +-
 src/pcm/pcm.c         | 417 +++++++++++++++++++++++++++++++++++++++++---------
 src/pcm/pcm_direct.c  |   4 +-
 src/pcm/pcm_dmix.c    |  13 +-
 src/pcm/pcm_dshare.c  |  13 +-
 src/pcm/pcm_dsnoop.c  |  15 +-
 src/pcm/pcm_file.c    |  21 ++-
 src/pcm/pcm_generic.c |  10 +-
 src/pcm/pcm_hw.c      |   3 +
 src/pcm/pcm_ioplug.c  |  70 ++++++---
 src/pcm/pcm_local.h   | 129 ++++++++++++----
 src/pcm/pcm_mmap.c    |  18 ++-
 src/pcm/pcm_rate.c    |   7 +-
 src/pcm/pcm_route.c   |   2 +-
 16 files changed, 610 insertions(+), 146 deletions(-)

diff --git a/INSTALL b/INSTALL
index 64f3d0945d01..a2427e072bca 100644
--- a/INSTALL
+++ b/INSTALL
@@ -104,6 +104,15 @@ option. This option disables usage of float numbers in PCM route plugin.
 ALSA could then leave much more CPU cycles for your applications, but you 
 could still need some floating point emulator.
 
+Thread-safety option
+--------------------
+
+As default, major PCM functions of alsa-lib are built to be
+thread-safe with pthread mutex (while this wasn't present in the
+versions earlier than 1.1.2).  If you want to build without this
+thread-safety support but reduce the overhead, pass
+--disable-thread-safety configure option.
+
 Jack plugin
 -----------
 
diff --git a/configure.ac b/configure.ac
index 53fca33e201a..8c888fac1635 100644
--- a/configure.ac
+++ b/configure.ac
@@ -632,6 +632,21 @@ elif test "$max_cards" -gt 256; then
 fi
 AC_DEFINE_UNQUOTED(SND_MAX_CARDS, $max_cards, [Max number of cards])
 
+dnl Check for thread-safe API functions
+if test "$HAVE_LIBPTHREAD" = "yes"; then
+AC_MSG_CHECKING(for thread-safe API functions)
+AC_ARG_ENABLE(thread-safety,
+  AS_HELP_STRING([--disable-thread-safety],
+    [disable thread-safe API functions]),
+  threadsafe="$enableval", threadsafe="yes")
+if test "$threadsafe" = "yes"; then
+  AC_MSG_RESULT(yes)
+  AC_DEFINE([THREAD_SAFE_API], "1", [Disable thread-safe API functions])
+else
+  AC_MSG_RESULT(no)
+fi
+fi
+
 dnl Make a symlink for inclusion of alsa/xxx.h
 if test ! -L "$srcdir"/include/alsa ; then
   echo "Making a symlink include/alsa"
diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index e529e6a60ae5..8c25e5e19850 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -124,19 +124,19 @@ struct snd_pcm_ioplug {
 /** Callback table of ioplug */
 struct snd_pcm_ioplug_callback {
 	/**
-	 * start the PCM; required
+	 * start the PCM; required, called inside mutex lock
 	 */
 	int (*start)(snd_pcm_ioplug_t *io);
 	/**
-	 * stop the PCM; required
+	 * stop the PCM; required, called inside mutex lock
 	 */
 	int (*stop)(snd_pcm_ioplug_t *io);
 	/**
-	 * get the current DMA position; required
+	 * get the current DMA position; required, called inside mutex lock
 	 */
 	snd_pcm_sframes_t (*pointer)(snd_pcm_ioplug_t *io);
 	/**
-	 * transfer the data; optional
+	 * transfer the data; optional, called inside mutex lock
 	 */
 	snd_pcm_sframes_t (*transfer)(snd_pcm_ioplug_t *io,
 				      const snd_pcm_channel_area_t *areas,
@@ -167,7 +167,7 @@ struct snd_pcm_ioplug_callback {
 	 */
 	int (*drain)(snd_pcm_ioplug_t *io);
 	/**
-	 * toggle pause; optional
+	 * toggle pause; optional, called inside mutex lock
 	 */
 	int (*pause)(snd_pcm_ioplug_t *io, int enable);
 	/**
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 0d0d093deb49..1567a46146ad 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -485,6 +485,15 @@ for hardware synchronized streams. When the #snd_pcm_link()
 function is called, all operations managing the stream state for these two
 streams are joined. The opposite function is #snd_pcm_unlink().
 
+\section pcm_thread_safety Thread-safety
+
+When the library is configured with the proper option, some PCM functions
+(e.g. #snd_pcm_avail_update()) are thread-safe and can be called concurrently
+from multiple threads.  Meanwhile, some functions (e.g. #snd_pcm_hw_params())
+aren't thread-safe, and application needs to call them carefully when they
+are called from multiple threads.  In general, all the functions that are
+often called during streaming are covered as thread-safe.
+
 \section pcm_dev_names PCM naming conventions
 
 The ALSA library uses a generic string representation for names of devices.
@@ -717,25 +726,32 @@ int snd_pcm_close(snd_pcm_t *pcm)
  * \param pcm PCM handle
  * \param nonblock 0 = block, 1 = nonblock mode, 2 = abort
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 {
-	int err;
+	int err = 0;
+
 	assert(pcm);
+	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
 	if ((err = pcm->ops->nonblock(pcm->op_arg, nonblock)) < 0)
-		return err;
+		goto unlock;
 	if (nonblock == 2) {
 		pcm->mode |= SND_PCM_ABORT;
-		return 0;
+		goto unlock;
 	}
 	if (nonblock)
 		pcm->mode |= SND_PCM_NONBLOCK;
 	else {
 		if (pcm->hw_flags & SND_PCM_HW_PARAMS_NO_PERIOD_WAKEUP)
-			return -EINVAL;
-		pcm->mode &= ~SND_PCM_NONBLOCK;
+			err = -EINVAL;
+		else
+			pcm->mode &= ~SND_PCM_NONBLOCK;
 	}
-	return 0;
+ unlock:
+	__snd_pcm_unlock(pcm);
+	return err;
 }
 
 #ifndef DOC_HIDDEN
@@ -869,6 +885,8 @@ int snd_pcm_hw_free(snd_pcm_t *pcm)
  * The software parameters can be changed at any time.
  * The hardware parameters cannot be changed when the stream is
  * running (active).
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 {
@@ -892,9 +910,12 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		return -EINVAL;
 	}
 #endif
+	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
 	err = pcm->ops->sw_params(pcm->op_arg, params);
-	if (err < 0)
+	if (err < 0) {
+		__snd_pcm_unlock(pcm);
 		return err;
+	}
 	pcm->tstamp_mode = params->tstamp_mode;
 	pcm->tstamp_type = params->tstamp_type;
 	pcm->period_step = params->period_step;
@@ -905,6 +926,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	pcm->silence_threshold = params->silence_threshold;
 	pcm->silence_size = params->silence_size;
 	pcm->boundary = params->boundary;
+	__snd_pcm_unlock(pcm);
 	return 0;
 }
 
@@ -913,11 +935,17 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
  * \param pcm PCM handle
  * \param status Status container
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
 {
+	int err;
+
 	assert(pcm && status);
-	return pcm->fast_ops->status(pcm->fast_op_arg, status);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->status(pcm->fast_op_arg, status);
+	snd_pcm_unlock(pcm);
 }
 
 /**
@@ -927,11 +955,18 @@ int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
  *
  * This is a faster way to obtain only the PCM state without calling
  * \link ::snd_pcm_status() \endlink.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_state_t snd_pcm_state(snd_pcm_t *pcm)
 {
+	snd_pcm_state_t state;
+
 	assert(pcm);
-	return pcm->fast_ops->state(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	state = __snd_pcm_state(pcm);
+	snd_pcm_unlock(pcm);
+	return state;
 }
 
 /**
@@ -942,15 +977,22 @@ snd_pcm_state_t snd_pcm_state(snd_pcm_t *pcm)
  * Note this function does not update the actual r/w pointer
  * for applications. The function #snd_pcm_avail_update()
  * have to be called before any mmap begin+commit operation.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_hwsync(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->hwsync(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_hwsync(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 #ifndef DOC_HIDDEN
 link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()");
@@ -983,15 +1025,22 @@ link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider
  * Note this function does not update the actual r/w pointer
  * for applications. The function #snd_pcm_avail_update()
  * have to be called before any begin+commit operation.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_delay(pcm, delayp);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1005,6 +1054,8 @@ int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  * to do the fine resume from this state. Not all hardware supports
  * this feature, when an -ENOSYS error is returned, use the \link ::snd_pcm_prepare() \endlink
  * function to recovery.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_resume(snd_pcm_t *pcm)
 {
@@ -1013,6 +1064,7 @@ int snd_pcm_resume(snd_pcm_t *pcm)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	/* lock handled in the callback */
 	return pcm->fast_ops->resume(pcm->fast_op_arg);
 }
 
@@ -1025,30 +1077,44 @@ int snd_pcm_resume(snd_pcm_t *pcm)
  *
  * Note this function does not update the actual r/w pointer
  * for applications.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_t *tstamp)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->htimestamp(pcm->fast_op_arg, avail, tstamp);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->htimestamp(pcm->fast_op_arg, avail, tstamp);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
  * \brief Prepare PCM for use
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_prepare(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->prepare(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->prepare(pcm->fast_op_arg);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1057,30 +1123,44 @@ int snd_pcm_prepare(snd_pcm_t *pcm)
  * \return 0 on success otherwise a negative error code
  *
  * Reduce PCM delay to 0.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_reset(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->reset(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->reset(pcm->fast_op_arg);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
  * \brief Start a PCM
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_start(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->start(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_start(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1093,15 +1173,22 @@ int snd_pcm_start(snd_pcm_t *pcm)
  *
  * For processing all pending samples, use \link ::snd_pcm_drain() \endlink
  * instead.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_drop(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->drop(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->drop(pcm->fast_op_arg);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1116,6 +1203,8 @@ int snd_pcm_drop(snd_pcm_t *pcm)
  *
  * For stopping the PCM stream immediately, use \link ::snd_pcm_drop() \endlink
  * instead.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_drain(snd_pcm_t *pcm)
 {
@@ -1124,6 +1213,7 @@ int snd_pcm_drain(snd_pcm_t *pcm)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	/* lock handled in the callback */
 	return pcm->fast_ops->drain(pcm->fast_op_arg);
 }
 
@@ -1136,15 +1226,22 @@ int snd_pcm_drain(snd_pcm_t *pcm)
  * Note that this function works only on the hardware which supports
  * pause feature.  You can check it via \link ::snd_pcm_hw_params_can_pause() \endlink
  * function.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_pause(snd_pcm_t *pcm, int enable)
 {
+	int err;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->pause(pcm->fast_op_arg, enable);
+	snd_pcm_lock(pcm);
+	err = pcm->fast_ops->pause(pcm->fast_op_arg, enable);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1155,15 +1252,22 @@ int snd_pcm_pause(snd_pcm_t *pcm, int enable)
  * Note: The snd_pcm_rewind() can accept bigger value than returned
  * by this function. But it is not guaranteed that output stream
  * will be consistent with bigger value.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t *pcm)
 {
+	snd_pcm_sframes_t result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->rewindable(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	result = pcm->fast_ops->rewindable(pcm->fast_op_arg);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 
 /**
@@ -1172,9 +1276,13 @@ snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t *pcm)
  * \param frames wanted displacement in frames
  * \return a positive number for actual displacement otherwise a
  * negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
+	snd_pcm_sframes_t result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
@@ -1182,7 +1290,10 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 	}
 	if (frames == 0)
 		return 0;
-	return pcm->fast_ops->rewind(pcm->fast_op_arg, frames);
+	snd_pcm_lock(pcm);
+	result = pcm->fast_ops->rewind(pcm->fast_op_arg, frames);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 
 /**
@@ -1193,15 +1304,22 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
  * Note: The snd_pcm_forward() can accept bigger value than returned
  * by this function. But it is not guaranteed that output stream
  * will be consistent with bigger value.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm)
 {
+	snd_pcm_sframes_t result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->forwardable(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	result = pcm->fast_ops->forwardable(pcm->fast_op_arg);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 
 /**
@@ -1210,6 +1328,8 @@ snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm)
  * \param frames wanted skip in frames
  * \return a positive number for actual skip otherwise a negative error code
  * \retval 0 means no action
+ *
+ * The function is thread-safe when built with the proper option.
  */
 #ifndef DOXYGEN
 snd_pcm_sframes_t INTERNAL(snd_pcm_forward)(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -1217,6 +1337,8 @@ snd_pcm_sframes_t INTERNAL(snd_pcm_forward)(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 #endif
 {
+	snd_pcm_sframes_t result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
@@ -1224,7 +1346,10 @@ snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 	}
 	if (frames == 0)
 		return 0;
-	return pcm->fast_ops->forward(pcm->fast_op_arg, frames);
+	snd_pcm_lock(pcm);
+	result = pcm->fast_ops->forward(pcm->fast_op_arg, frames);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 use_default_symbol_version(__snd_pcm_forward, snd_pcm_forward, ALSA_0.9.0rc8);
 
@@ -1244,6 +1369,8 @@ use_default_symbol_version(__snd_pcm_forward, snd_pcm_forward, ALSA_0.9.0rc8);
  * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
@@ -1276,6 +1403,8 @@ snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_ufr
  * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
@@ -1308,6 +1437,8 @@ snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
@@ -1340,6 +1471,8 @@ snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
@@ -1386,19 +1519,50 @@ int snd_pcm_unlink(snd_pcm_t *pcm)
 	return -ENOSYS;
 }
 
+/* locked version */
+static int __snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
+{
+	if (pcm->fast_ops->poll_descriptors_count)
+		return pcm->fast_ops->poll_descriptors_count(pcm->fast_op_arg);
+	return pcm->poll_fd_count;
+}
+
 /**
  * \brief get count of poll descriptors for PCM handle
  * \param pcm PCM handle
  * \return count of poll descriptors
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
 {
+	int count;
+
 	assert(pcm);
-	if (pcm->fast_ops->poll_descriptors_count)
-		return pcm->fast_ops->poll_descriptors_count(pcm->fast_op_arg);
-	return pcm->poll_fd_count;
+	snd_pcm_lock(pcm);
+	count = __snd_pcm_poll_descriptors_count(pcm);
+	snd_pcm_unlock(pcm);
+	return count;
 }
 
+/* locked version */
+static int __snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
+				      unsigned int space)
+{
+	if (pcm->fast_ops->poll_descriptors)
+		return pcm->fast_ops->poll_descriptors(pcm->fast_op_arg, pfds, space);
+	if (pcm->poll_fd < 0) {
+		SNDMSG("poll_fd < 0");
+		return -EIO;
+	}
+	if (space >= 1 && pfds) {
+		pfds->fd = pcm->poll_fd;
+		pfds->events = pcm->poll_events | POLLERR | POLLNVAL;
+	} else {
+		return 0;
+	}
+	return 1;
+}
 
 /**
  * \brief get poll descriptors
@@ -1425,25 +1589,23 @@ int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
  * syscall, too. Do not forget to translate POLLIN and POLLOUT events to
  * corresponding FD_SET arrays and demangle events using
  * \link ::snd_pcm_poll_descriptors_revents() \endlink .
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
 {
+	int err;
+
 	assert(pcm && pfds);
-	if (pcm->fast_ops->poll_descriptors)
-		return pcm->fast_ops->poll_descriptors(pcm->fast_op_arg, pfds, space);
-	if (pcm->poll_fd < 0) {
-		SNDMSG("poll_fd < 0");
-		return -EIO;
-	}
-	if (space >= 1 && pfds) {
-		pfds->fd = pcm->poll_fd;
-		pfds->events = pcm->poll_events | POLLERR | POLLNVAL;
-	} else {
-		return 0;
-	}
-	return 1;
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_poll_descriptors(pcm, pfds, space);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
+static int __snd_pcm_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds,
+				  unsigned int nfds, unsigned short *revents);
+
 /**
  * \brief get returned events from poll descriptors
  * \param pcm PCM handle
@@ -1462,10 +1624,23 @@ int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int s
  *
  * Note: Even if multiple poll descriptors are used (i.e. pfds > 1),
  * this function returns only a single event.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_poll_descriptors_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
 {
+	int err;
+
 	assert(pcm && pfds && revents);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_poll_revents(pcm, pfds, nfds, revents);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+static int __snd_pcm_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds,
+				  unsigned int nfds, unsigned short *revents)
+{
 	if (pcm->fast_ops->poll_revents)
 		return pcm->fast_ops->poll_revents(pcm->fast_op_arg, pfds, nfds, revents);
 	if (nfds == 1) {
@@ -2056,6 +2231,8 @@ ssize_t snd_pcm_samples_to_bytes(snd_pcm_t *pcm, long samples)
  * \return 0 otherwise a negative error code on failure
  *
  * The asynchronous callback is called when period boundary elapses.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm, 
 			      snd_async_callback_t callback, void *private_data)
@@ -2067,6 +2244,7 @@ int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm,
 				    callback, private_data);
 	if (err < 0)
 		return err;
+	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
 	h->type = SND_ASYNC_HANDLER_PCM;
 	h->u.pcm = pcm;
 	was_empty = list_empty(&pcm->async_handlers);
@@ -2075,11 +2253,13 @@ int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm,
 		err = snd_pcm_async(pcm, snd_async_handler_get_signo(h), getpid());
 		if (err < 0) {
 			snd_async_del_handler(h);
-			return err;
+			goto unlock;
 		}
 	}
 	*handler = h;
-	return 0;
+ unlock:
+	__snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -2359,6 +2539,9 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
 	pcm->op_arg = pcm;
 	pcm->fast_op_arg = pcm;
 	INIT_LIST_HEAD(&pcm->async_handlers);
+#ifdef THREAD_SAFE_API
+	pthread_mutex_init(&pcm->lock, NULL);
+#endif
 	*pcmp = pcm;
 	return 0;
 }
@@ -2370,6 +2553,9 @@ int snd_pcm_free(snd_pcm_t *pcm)
 	free(pcm->hw.link_dst);
 	free(pcm->appl.link_dst);
 	snd_dlobj_cache_put(pcm->open_func);
+#ifdef THREAD_SAFE_API
+	pthread_mutex_destroy(&pcm->lock);
+#endif
 	free(pcm);
 	return 0;
 }
@@ -2401,12 +2587,26 @@ int snd_pcm_open_named_slave(snd_pcm_t **pcmp, const char *name,
  *          others for general errors) 
  * \retval 0 timeout occurred
  * \retval 1 PCM stream is ready for I/O
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_wait(snd_pcm_t *pcm, int timeout)
 {
+	int err;
+
+	__snd_pcm_lock(pcm); /* forced lock */
+	err = __snd_pcm_wait_in_lock(pcm, timeout);
+	__snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOC_HIDDEN
+/* locked version */
+int __snd_pcm_wait_in_lock(snd_pcm_t *pcm, int timeout)
+{
 	if (!snd_pcm_may_wait_for_avail_min(pcm, snd_pcm_mmap_avail(pcm))) {
 		/* check more precisely */
-		switch (snd_pcm_state(pcm)) {
+		switch (__snd_pcm_state(pcm)) {
 		case SND_PCM_STATE_XRUN:
 			return -EPIPE;
 		case SND_PCM_STATE_SUSPENDED:
@@ -2420,11 +2620,12 @@ int snd_pcm_wait(snd_pcm_t *pcm, int timeout)
 	return snd_pcm_wait_nocheck(pcm, timeout);
 }
 
-#ifndef DOC_HIDDEN
 /* 
  * like snd_pcm_wait() but doesn't check mmap_avail before calling poll()
  *
  * used in drain code in some plugins
+ *
+ * This function is called inside pcm lock.
  */
 int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 {
@@ -2432,13 +2633,13 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 	unsigned short revents = 0;
 	int npfds, err, err_poll;
 	
-	npfds = snd_pcm_poll_descriptors_count(pcm);
+	npfds = __snd_pcm_poll_descriptors_count(pcm);
 	if (npfds <= 0 || npfds >= 16) {
 		SNDERR("Invalid poll_fds %d\n", npfds);
 		return -EIO;
 	}
 	pfd = alloca(sizeof(*pfd) * npfds);
-	err = snd_pcm_poll_descriptors(pcm, pfd, npfds);
+	err = __snd_pcm_poll_descriptors(pcm, pfd, npfds);
 	if (err < 0)
 		return err;
 	if (err != npfds) {
@@ -2446,7 +2647,9 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 		return -EIO;
 	}
 	do {
+		__snd_pcm_unlock(pcm);
 		err_poll = poll(pfd, npfds, timeout);
+		__snd_pcm_lock(pcm);
 		if (err_poll < 0) {
 		        if (errno == EINTR && !PCMINABORT(pcm))
 		                continue;
@@ -2454,12 +2657,12 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
                 }
 		if (! err_poll)
 			break;
-		err = snd_pcm_poll_descriptors_revents(pcm, pfd, npfds, &revents);
+		err = __snd_pcm_poll_revents(pcm, pfd, npfds, &revents);
 		if (err < 0)
 			return err;
 		if (revents & (POLLERR | POLLNVAL)) {
 			/* check more precisely */
-			switch (snd_pcm_state(pcm)) {
+			switch (__snd_pcm_state(pcm)) {
 			case SND_PCM_STATE_XRUN:
 				return -EPIPE;
 			case SND_PCM_STATE_SUSPENDED:
@@ -2474,8 +2677,8 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 #if 0 /* very useful code to test poll related problems */
 	{
 		snd_pcm_sframes_t avail_update;
-		snd_pcm_hwsync(pcm);
-		avail_update = snd_pcm_avail_update(pcm);
+		__snd_pcm_hwsync(pcm);
+		avail_update = __snd_pcm_avail_update(pcm);
 		if (avail_update < (snd_pcm_sframes_t)pcm->avail_min) {
 			printf("*** snd_pcm_wait() FATAL ERROR!!!\n");
 			printf("avail_min = %li, avail_update = %li\n", pcm->avail_min, avail_update);
@@ -2506,10 +2709,17 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
  * Also this function might be called after #snd_pcm_delay() or
  * #snd_pcm_hwsync() functions to move private ring buffer pointers
  * in alsa-lib (the internal plugin chain).
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_avail_update(snd_pcm_t *pcm)
 {
-	return pcm->fast_ops->avail_update(pcm->fast_op_arg);
+	snd_pcm_sframes_t result;
+
+	snd_pcm_lock(pcm);
+	result = __snd_pcm_avail_update(pcm);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 
 /**
@@ -2523,20 +2733,27 @@ snd_pcm_sframes_t snd_pcm_avail_update(snd_pcm_t *pcm)
  *
  * The position is synced with hardware (driver) position in the sound
  * ring buffer in this functions.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_avail(snd_pcm_t *pcm)
 {
 	int err;
+	snd_pcm_sframes_t result;
 
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	err = pcm->fast_ops->hwsync(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_hwsync(pcm);
 	if (err < 0)
-		return err;
-	return pcm->fast_ops->avail_update(pcm->fast_op_arg);
+		result = err;
+	else
+		result = __snd_pcm_avail_update(pcm);
+	snd_pcm_unlock(pcm);
+	return result;
 }
 
 /**
@@ -2547,6 +2764,8 @@ snd_pcm_sframes_t snd_pcm_avail(snd_pcm_t *pcm)
  * \return zero on success otherwise a negative error code
  *
  * The avail and delay values retuned are in sync.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_avail_delay(snd_pcm_t *pcm,
 			snd_pcm_sframes_t *availp,
@@ -2560,17 +2779,23 @@ int snd_pcm_avail_delay(snd_pcm_t *pcm,
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	err = pcm->fast_ops->hwsync(pcm->fast_op_arg);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_hwsync(pcm);
 	if (err < 0)
-		return err;
-	sf = pcm->fast_ops->avail_update(pcm->fast_op_arg);
-	if (sf < 0)
-		return (int)sf;
-	err = pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
+		goto unlock;
+	sf = __snd_pcm_avail_update(pcm);
+	if (sf < 0) {
+		err = (int)sf;
+		goto unlock;
+	}
+	err = __snd_pcm_delay(pcm, delayp);
 	if (err < 0)
-		return err;
+		goto unlock;
 	*availp = sf;
-	return 0;
+	err = 0;
+ unlock:
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -5646,6 +5871,8 @@ int snd_pcm_hw_params_get_min_align(const snd_pcm_hw_params_t *params, snd_pcm_u
  * \param pcm PCM handle
  * \param params Software configuration container
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 {
@@ -5654,6 +5881,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	__snd_pcm_lock(pcm); /* forced lock due to pcm field changes */
 	params->proto = SNDRV_PCM_VERSION;
 	params->tstamp_mode = pcm->tstamp_mode;
 	params->tstamp_type = pcm->tstamp_type;
@@ -5667,6 +5895,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	params->silence_threshold = pcm->silence_threshold;
 	params->silence_size = pcm->silence_size;
 	params->boundary = pcm->boundary;
+	__snd_pcm_unlock(pcm);
 	return 0;
 }
 
@@ -6680,12 +6909,27 @@ void snd_pcm_info_set_stream(snd_pcm_info_t *obj, snd_pcm_stream_t val)
  *
  * See the snd_pcm_mmap_commit() function to finish the frame processing in
  * the direct areas.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_mmap_begin(snd_pcm_t *pcm,
 		       const snd_pcm_channel_area_t **areas,
 		       snd_pcm_uframes_t *offset,
 		       snd_pcm_uframes_t *frames)
 {
+	int err;
+
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_mmap_begin(pcm, areas, offset, frames);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOC_HIDDEN
+/* locked version */
+int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
+		       snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames)
+{
 	snd_pcm_uframes_t cont;
 	snd_pcm_uframes_t f;
 	snd_pcm_uframes_t avail;
@@ -6708,6 +6952,7 @@ int snd_pcm_mmap_begin(snd_pcm_t *pcm,
 	*frames = f;
 	return 0;
 }
+#endif
 
 /**
  * \brief Application has completed the access to area requested with #snd_pcm_mmap_begin
@@ -6760,11 +7005,27 @@ int snd_pcm_mmap_begin(snd_pcm_t *pcm,
  *
  * Look to the \ref example_test_pcm "Sine-wave generator" example
  * for more details about the generate_sine function.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 snd_pcm_sframes_t snd_pcm_mmap_commit(snd_pcm_t *pcm,
 				      snd_pcm_uframes_t offset,
 				      snd_pcm_uframes_t frames)
 {
+	snd_pcm_sframes_t result;
+
+	snd_pcm_lock(pcm);
+	result = __snd_pcm_mmap_commit(pcm, offset, frames);
+	snd_pcm_unlock(pcm);
+	return result;
+}
+
+#ifndef DOC_HIDDEN
+/* locked version*/
+snd_pcm_sframes_t __snd_pcm_mmap_commit(snd_pcm_t *pcm,
+					snd_pcm_uframes_t offset,
+					snd_pcm_uframes_t frames)
+{
 	assert(pcm);
 	if (CHECK_SANITY(offset != *pcm->appl.ptr % pcm->buffer_size)) {
 		SNDMSG("commit offset (%ld) doesn't match with appl_ptr (%ld) %% buf_size (%ld)",
@@ -6779,8 +7040,6 @@ snd_pcm_sframes_t snd_pcm_mmap_commit(snd_pcm_t *pcm,
 	return pcm->fast_ops->mmap_commit(pcm->fast_op_arg, offset, frames);
 }
 
-#ifndef DOC_HIDDEN
-
 int _snd_pcm_poll_descriptor(snd_pcm_t *pcm)
 {
 	assert(pcm);
@@ -6791,24 +7050,32 @@ void snd_pcm_areas_from_buf(snd_pcm_t *pcm, snd_pcm_channel_area_t *areas,
 			    void *buf)
 {
 	unsigned int channel;
-	unsigned int channels = pcm->channels;
+	unsigned int channels;
+
+	snd_pcm_lock(pcm);
+	channels = pcm->channels;
 	for (channel = 0; channel < channels; ++channel, ++areas) {
 		areas->addr = buf;
 		areas->first = channel * pcm->sample_bits;
 		areas->step = pcm->frame_bits;
 	}
+	snd_pcm_unlock(pcm);
 }
 
 void snd_pcm_areas_from_bufs(snd_pcm_t *pcm, snd_pcm_channel_area_t *areas, 
 			     void **bufs)
 {
 	unsigned int channel;
-	unsigned int channels = pcm->channels;
+	unsigned int channels;
+
+	snd_pcm_lock(pcm);
+	channels = pcm->channels;
 	for (channel = 0; channel < channels; ++channel, ++areas, ++bufs) {
 		areas->addr = *bufs;
 		areas->first = 0;
 		areas->step = pcm->sample_bits;
 	}
+	snd_pcm_unlock(pcm);
 }
 
 snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_t *areas,
@@ -6822,19 +7089,20 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 	if (size == 0)
 		return 0;
 
+	__snd_pcm_lock(pcm); /* forced lock */
 	while (size > 0) {
 		snd_pcm_uframes_t frames;
 		snd_pcm_sframes_t avail;
 	_again:
-		state = snd_pcm_state(pcm);
+		state = __snd_pcm_state(pcm);
 		switch (state) {
 		case SND_PCM_STATE_PREPARED:
-			err = snd_pcm_start(pcm);
+			err = __snd_pcm_start(pcm);
 			if (err < 0)
 				goto _end;
 			break;
 		case SND_PCM_STATE_RUNNING:
-			err = snd_pcm_hwsync(pcm);
+			err = __snd_pcm_hwsync(pcm);
 			if (err < 0)
 				goto _end;
 			break;
@@ -6854,7 +7122,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 			err = -EBADFD;
 			goto _end;
 		}
-		avail = snd_pcm_avail_update(pcm);
+		avail = __snd_pcm_avail_update(pcm);
 		if (avail < 0) {
 			err = avail;
 			goto _end;
@@ -6867,7 +7135,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 				goto _end;
 			}
 
-			err = snd_pcm_wait(pcm, -1);
+			err = __snd_pcm_wait_in_lock(pcm, -1);
 			if (err < 0)
 				break;
 			goto _again;
@@ -6887,6 +7155,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 		xfer += frames;
 	}
  _end:
+	__snd_pcm_unlock(pcm);
 	return xfer > 0 ? (snd_pcm_sframes_t) xfer : snd_pcm_check_error(pcm, err);
 }
 
@@ -6901,17 +7170,18 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 	if (size == 0)
 		return 0;
 
+	__snd_pcm_lock(pcm); /* forced lock */
 	while (size > 0) {
 		snd_pcm_uframes_t frames;
 		snd_pcm_sframes_t avail;
 	_again:
-		state = snd_pcm_state(pcm);
+		state = __snd_pcm_state(pcm);
 		switch (state) {
 		case SND_PCM_STATE_PREPARED:
 		case SND_PCM_STATE_PAUSED:
 			break;
 		case SND_PCM_STATE_RUNNING:
-			err = snd_pcm_hwsync(pcm);
+			err = __snd_pcm_hwsync(pcm);
 			if (err < 0)
 				goto _end;
 			break;
@@ -6928,7 +7198,7 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 			err = -EBADFD;
 			goto _end;
 		}
-		avail = snd_pcm_avail_update(pcm);
+		avail = __snd_pcm_avail_update(pcm);
 		if (avail < 0) {
 			err = avail;
 			goto _end;
@@ -6959,10 +7229,10 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 			snd_pcm_sframes_t hw_avail = pcm->buffer_size - avail;
 			hw_avail += frames;
 			/* some plugins might automatically start the stream */
-			state = snd_pcm_state(pcm);
+			state = __snd_pcm_state(pcm);
 			if (state == SND_PCM_STATE_PREPARED &&
 			    hw_avail >= (snd_pcm_sframes_t) pcm->start_threshold) {
-				err = snd_pcm_start(pcm);
+				err = __snd_pcm_start(pcm);
 				if (err < 0)
 					goto _end;
 			}
@@ -6972,6 +7242,7 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 		xfer += frames;
 	}
  _end:
+	__snd_pcm_unlock(pcm);
 	return xfer > 0 ? (snd_pcm_sframes_t) xfer : snd_pcm_check_error(pcm, err);
 }
 
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 21f98e7a1779..ecc86db4831a 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -559,7 +559,7 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned in
 	events = pfds[0].revents;
 	if (events & POLLIN) {
 		snd_pcm_uframes_t avail;
-		snd_pcm_avail_update(pcm);
+		__snd_pcm_avail_update(pcm);
 		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
 			events |= POLLOUT;
 			events &= ~POLLIN;
@@ -580,7 +580,7 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned in
 			snd_pcm_direct_clear_timer_queue(dmix);
 			events &= ~(POLLOUT|POLLIN);
 			/* additional check */
-			switch (snd_pcm_state(pcm)) {
+			switch (__snd_pcm_state(pcm)) {
 			case SND_PCM_STATE_XRUN:
 			case SND_PCM_STATE_SUSPENDED:
 			case SND_PCM_STATE_SETUP:
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 007d35664ce7..2714fb93c758 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -601,7 +601,8 @@ static int snd_pcm_dmix_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
+/* locked version */
+static int __snd_pcm_dmix_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	snd_pcm_uframes_t stop_threshold;
@@ -659,6 +660,16 @@ static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
+{
+	int err;
+
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_dmix_drain(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
 static int snd_pcm_dmix_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTRIBUTE_UNUSED)
 {
 	return -EIO;
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 05854dedf259..c5b3178a4990 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -354,7 +354,8 @@ static int snd_pcm_dshare_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_dshare_drain(snd_pcm_t *pcm)
+/* locked version */
+static int __snd_pcm_dshare_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
 	snd_pcm_uframes_t stop_threshold;
@@ -412,6 +413,16 @@ static int snd_pcm_dshare_drain(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_dshare_drain(snd_pcm_t *pcm)
+{
+	int err;
+
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_dshare_drain(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
 static int snd_pcm_dshare_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTRIBUTE_UNUSED)
 {
 	return -EIO;
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 2d45171dda01..4efbc53d177e 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -297,7 +297,8 @@ static int snd_pcm_dsnoop_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_dsnoop_drain(snd_pcm_t *pcm)
+/* locked version */
+static int __snd_pcm_dsnoop_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
 	snd_pcm_uframes_t stop_threshold;
@@ -314,12 +315,22 @@ static int snd_pcm_dsnoop_drain(snd_pcm_t *pcm)
 			break;
 		if (pcm->mode & SND_PCM_NONBLOCK)
 			return -EAGAIN;
-		snd_pcm_wait(pcm, -1);
+		__snd_pcm_wait_in_lock(pcm, -1);
 	}
 	pcm->stop_threshold = stop_threshold;
 	return snd_pcm_dsnoop_drop(pcm);
 }
 
+static int snd_pcm_dsnoop_drain(snd_pcm_t *pcm)
+{
+	int err;
+
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_dsnoop_drain(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
 static int snd_pcm_dsnoop_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTRIBUTE_UNUSED)
 {
 	return -EIO;
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 92eb0724c0e2..ae58c531360e 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -440,13 +440,16 @@ static int snd_pcm_file_drop(snd_pcm_t *pcm)
 	return err;
 }
 
+/* locking */
 static int snd_pcm_file_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	int err = snd_pcm_drain(file->gen.slave);
 	if (err >= 0) {
+		__snd_pcm_lock(pcm);
 		snd_pcm_file_write_bytes(pcm, file->wbuf_used_bytes);
 		assert(file->wbuf_used_bytes == 0);
+		__snd_pcm_unlock(pcm);
 	}
 	return err;
 }
@@ -507,40 +510,49 @@ static snd_pcm_sframes_t snd_pcm_file_forward(snd_pcm_t *pcm, snd_pcm_uframes_t
 	return err;
 }
 
+/* locking */
 static snd_pcm_sframes_t snd_pcm_file_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_channel_area_t areas[pcm->channels];
-	snd_pcm_sframes_t n = snd_pcm_writei(file->gen.slave, buffer, size);
+	snd_pcm_sframes_t n = _snd_pcm_writei(file->gen.slave, buffer, size);
 	if (n > 0) {
 		snd_pcm_areas_from_buf(pcm, areas, (void*) buffer);
+		__snd_pcm_lock(pcm);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		__snd_pcm_unlock(pcm);
 	}
 	return n;
 }
 
+/* locking */
 static snd_pcm_sframes_t snd_pcm_file_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_channel_area_t areas[pcm->channels];
-	snd_pcm_sframes_t n = snd_pcm_writen(file->gen.slave, bufs, size);
+	snd_pcm_sframes_t n = _snd_pcm_writen(file->gen.slave, bufs, size);
 	if (n > 0) {
 		snd_pcm_areas_from_bufs(pcm, areas, bufs);
+		__snd_pcm_lock(pcm);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		__snd_pcm_unlock(pcm);
 	}
 	return n;
 }
 
+/* locking */
 static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_sframes_t n;
 
-	n = snd_pcm_readi(file->gen.slave, buffer, size);
+	n = _snd_pcm_readi(file->gen.slave, buffer, size);
 	if (n <= 0)
 		return n;
 	if (file->ifd >= 0) {
+		__snd_pcm_lock(pcm);
 		n = read(file->ifd, buffer, n * pcm->frame_bits / 8);
+		__snd_pcm_unlock(pcm);
 		if (n < 0)
 			return n;
 		return n * 8 / pcm->frame_bits;
@@ -548,6 +560,7 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 	return n;
 }
 
+/* locking */
 static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -558,7 +571,7 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 		return 0;	/* TODO: Noninterleaved read */
 	}
 
-	n = snd_pcm_readn(file->gen.slave, bufs, size);
+	n = _snd_pcm_readn(file->gen.slave, bufs, size);
 	return n;
 }
 
diff --git a/src/pcm/pcm_generic.c b/src/pcm/pcm_generic.c
index 4dbef08cc2c7..12102c40a372 100644
--- a/src/pcm/pcm_generic.c
+++ b/src/pcm/pcm_generic.c
@@ -235,25 +235,25 @@ int snd_pcm_generic_unlink(snd_pcm_t *pcm)
 snd_pcm_sframes_t snd_pcm_generic_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_writei(generic->slave, buffer, size);
+	return _snd_pcm_writei(generic->slave, buffer, size);
 }
 
 snd_pcm_sframes_t snd_pcm_generic_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_writen(generic->slave, bufs, size);
+	return _snd_pcm_writen(generic->slave, bufs, size);
 }
 
 snd_pcm_sframes_t snd_pcm_generic_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_readi(generic->slave, buffer, size);
+	return _snd_pcm_readi(generic->slave, buffer, size);
 }
 
 snd_pcm_sframes_t snd_pcm_generic_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_readn(generic->slave, bufs, size);
+	return _snd_pcm_readn(generic->slave, bufs, size);
 }
 
 snd_pcm_sframes_t snd_pcm_generic_mmap_commit(snd_pcm_t *pcm, 
@@ -287,7 +287,7 @@ int snd_pcm_generic_real_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
 	int ok = 0;
 
 	while (1) {
-		avail1 = snd_pcm_avail_update(pcm);
+		avail1 = __snd_pcm_avail_update(pcm);
 		if (avail1 < 0)
 			return avail1;
 		if (ok && (snd_pcm_uframes_t)avail1 == *avail)
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 4f4b84b2d2bc..d4045f8efc4f 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1505,6 +1505,9 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 	pcm->poll_fd = fd;
 	pcm->poll_events = info.stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
 	pcm->tstamp_type = tstamp_type;
+#ifdef THREAD_SAFE_API
+	pcm->thread_safe = 1;
+#endif
 
 	ret = snd_pcm_hw_mmap_status(pcm);
 	if (ret < 0) {
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 43550c03875b..115d89bc3c02 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -48,6 +48,7 @@ typedef struct snd_pcm_ioplug_priv {
 } ioplug_priv_t;
 
 /* update the hw pointer */
+/* called in lock */
 static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
@@ -138,12 +139,16 @@ static int snd_pcm_ioplug_reset(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_prepare(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err = 0;
 
 	io->data->state = SND_PCM_STATE_PREPARED;
 	snd_pcm_ioplug_reset(pcm);
-	if (io->data->callback->prepare)
-		return io->data->callback->prepare(io->data);
-	return 0;
+	if (io->data->callback->prepare) {
+		snd_pcm_unlock(pcm); /* to avoid deadlock */
+		err = io->data->callback->prepare(io->data);
+		snd_pcm_lock(pcm);
+	}
+	return err;
 }
 
 static const int hw_params_type[SND_PCM_IOPLUG_HW_PARAMS] = {
@@ -429,9 +434,13 @@ static int snd_pcm_ioplug_hw_free(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err = 0;
 
-	if (io->data->callback->sw_params)
-		return io->data->callback->sw_params(io->data, params);
+	if (io->data->callback->sw_params) {
+		snd_pcm_unlock(pcm); /* to avoid deadlock */
+		err = io->data->callback->sw_params(io->data, params);
+		snd_pcm_lock(pcm);
+	}
 	return 0;
 }
 
@@ -469,15 +478,20 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* need own locking */
 static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err;
 
 	if (io->data->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (io->data->callback->drain)
 		io->data->callback->drain(io->data);
-	return snd_pcm_ioplug_drop(pcm);
+	snd_pcm_lock(pcm);
+	err = snd_pcm_ioplug_drop(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 static int snd_pcm_ioplug_pause(snd_pcm_t *pcm, int enable)
@@ -523,6 +537,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 	return frames;
 }
 
+/* need own locking */
 static int snd_pcm_ioplug_resume(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
@@ -532,6 +547,7 @@ static int snd_pcm_ioplug_resume(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* called in lock */
 static snd_pcm_sframes_t ioplug_priv_transfer_areas(snd_pcm_t *pcm,
 						       const snd_pcm_channel_area_t *areas,
 						       snd_pcm_uframes_t offset,
@@ -609,7 +625,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_mmap_commit(snd_pcm_t *pcm,
 		const snd_pcm_channel_area_t *areas;
 		snd_pcm_uframes_t ofs, frames = size;
 
-		snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
+		__snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
 		if (ofs != offset)
 			return -EIO;
 		return ioplug_priv_transfer_areas(pcm, areas, offset, frames);
@@ -635,7 +651,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_avail_update(snd_pcm_t *pcm)
 			snd_pcm_uframes_t offset, size = UINT_MAX;
 			snd_pcm_sframes_t result;
 
-			snd_pcm_mmap_begin(pcm, &areas, &offset, &size);
+			__snd_pcm_mmap_begin(pcm, &areas, &offset, &size);
 			result = io->data->callback->transfer(io->data, areas, offset, size);
 			if (result < 0)
 				return result;
@@ -658,19 +674,27 @@ static int snd_pcm_ioplug_nonblock(snd_pcm_t *pcm, int nonblock)
 static int snd_pcm_ioplug_poll_descriptors_count(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err = 1;
 
-	if (io->data->callback->poll_descriptors_count)
-		return io->data->callback->poll_descriptors_count(io->data);
-	else
-		return 1;
+	if (io->data->callback->poll_descriptors_count) {
+		snd_pcm_unlock(pcm); /* to avoid deadlock */
+		err = io->data->callback->poll_descriptors_count(io->data);
+		snd_pcm_lock(pcm);
+	}
+	return err;
 }
 
 static int snd_pcm_ioplug_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err;
 
-	if (io->data->callback->poll_descriptors)
-		return io->data->callback->poll_descriptors(io->data, pfds, space);
+	if (io->data->callback->poll_descriptors) {
+		snd_pcm_unlock(pcm); /* to avoid deadlock */
+		err = io->data->callback->poll_descriptors(io->data, pfds, space);
+		snd_pcm_lock(pcm);
+		return err;
+	}
 	if (pcm->poll_fd < 0)
 		return -EIO;
 	if (space >= 1 && pfds) {
@@ -685,12 +709,17 @@ static int snd_pcm_ioplug_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
 static int snd_pcm_ioplug_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err;
 
-	if (io->data->callback->poll_revents)
-		return io->data->callback->poll_revents(io->data, pfds, nfds, revents);
-	else
+	if (io->data->callback->poll_revents) {
+		snd_pcm_unlock(pcm); /* to avoid deadlock */
+		err = io->data->callback->poll_revents(io->data, pfds, nfds, revents);
+		snd_pcm_lock(pcm);
+	} else {
 		*revents = pfds->revents;
-	return 0;
+		err = 0;
+	}
+	return err;
 }
 
 static int snd_pcm_ioplug_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
@@ -909,6 +938,11 @@ callback.
 
 Finally, the dump callback is used to print the status of the plugin.
 
+Note that some callbacks (start, stop, pointer, transfer and pause)
+may be called inside the internal pthread mutex, and they shouldn't
+call the PCM functions again unnecessarily from the callback itself;
+otherwise it may lead to a deadlock.
+
 The hw_params constraints can be defined via either
 #snd_pcm_ioplug_set_param_minmax() and #snd_pcm_ioplug_set_param_list()
 functions after calling #snd_pcm_ioplug_create().
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 326618ecd0c0..5c7eeb4ee07d 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -34,6 +34,10 @@
 
 #include "local.h"
 
+#ifdef THREAD_SAFE_API
+#include <pthread.h>
+#endif
+
 #define SND_INTERVAL_INLINE
 #include "interval.h"
 
@@ -133,13 +137,13 @@ typedef struct _snd_pcm_channel_info {
 
 typedef struct {
 	int (*close)(snd_pcm_t *pcm);
-	int (*nonblock)(snd_pcm_t *pcm, int nonblock);
+	int (*nonblock)(snd_pcm_t *pcm, int nonblock); /* always locked */
 	int (*async)(snd_pcm_t *pcm, int sig, pid_t pid);
 	int (*info)(snd_pcm_t *pcm, snd_pcm_info_t *info);
 	int (*hw_refine)(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 	int (*hw_params)(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 	int (*hw_free)(snd_pcm_t *pcm);
-	int (*sw_params)(snd_pcm_t *pcm, snd_pcm_sw_params_t *params);
+	int (*sw_params)(snd_pcm_t *pcm, snd_pcm_sw_params_t *params); /* always locked */
 	int (*channel_info)(snd_pcm_t *pcm, snd_pcm_channel_info_t *info);
 	void (*dump)(snd_pcm_t *pcm, snd_output_t *out);
 	int (*mmap)(snd_pcm_t *pcm);
@@ -150,34 +154,34 @@ typedef struct {
 } snd_pcm_ops_t;
 
 typedef struct {
-	int (*status)(snd_pcm_t *pcm, snd_pcm_status_t *status);
-	int (*prepare)(snd_pcm_t *pcm);
-	int (*reset)(snd_pcm_t *pcm);
-	int (*start)(snd_pcm_t *pcm);
-	int (*drop)(snd_pcm_t *pcm);
-	int (*drain)(snd_pcm_t *pcm);
-	int (*pause)(snd_pcm_t *pcm, int enable);
-	snd_pcm_state_t (*state)(snd_pcm_t *pcm);
-	int (*hwsync)(snd_pcm_t *pcm);
-	int (*delay)(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp);
-	int (*resume)(snd_pcm_t *pcm);
+	int (*status)(snd_pcm_t *pcm, snd_pcm_status_t *status); /* locked */
+	int (*prepare)(snd_pcm_t *pcm); /* locked */
+	int (*reset)(snd_pcm_t *pcm); /* locked */
+	int (*start)(snd_pcm_t *pcm); /* locked */
+	int (*drop)(snd_pcm_t *pcm); /* locked */
+	int (*drain)(snd_pcm_t *pcm); /* need own locking */
+	int (*pause)(snd_pcm_t *pcm, int enable); /* locked */
+	snd_pcm_state_t (*state)(snd_pcm_t *pcm); /* locked */
+	int (*hwsync)(snd_pcm_t *pcm); /* locked */
+	int (*delay)(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp); /* locked */
+	int (*resume)(snd_pcm_t *pcm); /* need own locking */
 	int (*link)(snd_pcm_t *pcm1, snd_pcm_t *pcm2);
 	int (*link_slaves)(snd_pcm_t *pcm, snd_pcm_t *master);
 	int (*unlink)(snd_pcm_t *pcm);
-	snd_pcm_sframes_t (*rewindable)(snd_pcm_t *pcm);
-	snd_pcm_sframes_t (*rewind)(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
-	snd_pcm_sframes_t (*forwardable)(snd_pcm_t *pcm);
-	snd_pcm_sframes_t (*forward)(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
-	snd_pcm_sframes_t (*writei)(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*writen)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*readi)(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*readn)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*avail_update)(snd_pcm_t *pcm);
-	snd_pcm_sframes_t (*mmap_commit)(snd_pcm_t *pcm, snd_pcm_uframes_t offset, snd_pcm_uframes_t size);
-	int (*htimestamp)(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_t *tstamp);
-	int (*poll_descriptors_count)(snd_pcm_t *pcm);
-	int (*poll_descriptors)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space);
-	int (*poll_revents)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
+	snd_pcm_sframes_t (*rewindable)(snd_pcm_t *pcm); /* locked */
+	snd_pcm_sframes_t (*rewind)(snd_pcm_t *pcm, snd_pcm_uframes_t frames); /* locked */
+	snd_pcm_sframes_t (*forwardable)(snd_pcm_t *pcm); /* locked */
+	snd_pcm_sframes_t (*forward)(snd_pcm_t *pcm, snd_pcm_uframes_t frames); /* locked */
+	snd_pcm_sframes_t (*writei)(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*writen)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*readi)(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*readn)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*avail_update)(snd_pcm_t *pcm); /* locked */
+	snd_pcm_sframes_t (*mmap_commit)(snd_pcm_t *pcm, snd_pcm_uframes_t offset, snd_pcm_uframes_t size); /* locked */
+	int (*htimestamp)(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_t *tstamp); /* locked */
+	int (*poll_descriptors_count)(snd_pcm_t *pcm); /* locked */
+	int (*poll_descriptors)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space); /* locked */
+	int (*poll_revents)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents); /* locked */
 	int (*may_wait_for_avail_min)(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
 } snd_pcm_fast_ops_t;
 
@@ -239,6 +243,10 @@ struct _snd_pcm {
 	snd_pcm_t *fast_op_arg;
 	void *private_data;
 	struct list_head async_handlers;
+#ifdef THREAD_SAFE_API
+	int thread_safe;
+	pthread_mutex_t lock;
+#endif
 };
 
 /* make local functions really local */
@@ -401,11 +409,44 @@ int _snd_pcm_poll_descriptor(snd_pcm_t *pcm);
 #define _snd_pcm_link_descriptor _snd_pcm_poll_descriptor /* FIXME */
 #define _snd_pcm_async_descriptor _snd_pcm_poll_descriptor /* FIXME */
 
+/* locked versions */
+int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
+			 snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames);
+snd_pcm_sframes_t __snd_pcm_mmap_commit(snd_pcm_t *pcm,
+					snd_pcm_uframes_t offset,
+					snd_pcm_uframes_t frames);
+int __snd_pcm_wait_in_lock(snd_pcm_t *pcm, int timeout);
+
+static inline snd_pcm_sframes_t __snd_pcm_avail_update(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->avail_update(pcm->fast_op_arg);
+}
+
+static inline int __snd_pcm_start(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->start(pcm->fast_op_arg);
+}
+
+static inline snd_pcm_state_t __snd_pcm_state(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->state(pcm->fast_op_arg);
+}
+
+static inline int __snd_pcm_hwsync(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->hwsync(pcm->fast_op_arg);
+}
+
+static inline int __snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
+{
+	return pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
+}
+
 /* handle special error cases */
 static inline int snd_pcm_check_error(snd_pcm_t *pcm, int err)
 {
 	if (err == -EINTR) {
-		switch (snd_pcm_state(pcm)) {
+		switch (__snd_pcm_state(pcm)) {
 		case SND_PCM_STATE_XRUN:
 			return -EPIPE;
 		case SND_PCM_STATE_SUSPENDED:
@@ -483,7 +524,7 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_hw_rewindable(snd_pcm_t *pcm)
 static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
 {
 	if (pcm->stopped_areas &&
-	    snd_pcm_state(pcm) != SND_PCM_STATE_RUNNING) 
+	    __snd_pcm_state(pcm) != SND_PCM_STATE_RUNNING)
 		return pcm->stopped_areas;
 	return pcm->running_areas;
 }
@@ -533,21 +574,25 @@ static inline unsigned int snd_pcm_channel_area_step(const snd_pcm_channel_area_
 
 static inline snd_pcm_sframes_t _snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
+	/* lock handled in the callback */
 	return pcm->fast_ops->writei(pcm->fast_op_arg, buffer, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
+	/* lock handled in the callback */
 	return pcm->fast_ops->writen(pcm->fast_op_arg, bufs, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
+	/* lock handled in the callback */
 	return pcm->fast_ops->readi(pcm->fast_op_arg, buffer, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
+	/* lock handled in the callback */
 	return pcm->fast_ops->readn(pcm->fast_op_arg, bufs, size);
 }
 
@@ -1038,3 +1083,29 @@ static inline void sw_set_period_event(snd_pcm_sw_params_t *params, int val)
 }
 
 #define PCMINABORT(pcm) (((pcm)->mode & SND_PCM_ABORT) != 0)
+
+#ifdef THREAD_SAFE_API
+static inline void __snd_pcm_lock(snd_pcm_t *pcm)
+{
+	pthread_mutex_lock(&pcm->lock);
+}
+static inline void __snd_pcm_unlock(snd_pcm_t *pcm)
+{
+	pthread_mutex_unlock(&pcm->lock);
+}
+static inline void snd_pcm_lock(snd_pcm_t *pcm)
+{
+	if (!pcm->thread_safe)
+		pthread_mutex_lock(&pcm->lock);
+}
+static inline void snd_pcm_unlock(snd_pcm_t *pcm)
+{
+	if (!pcm->thread_safe)
+		pthread_mutex_unlock(&pcm->lock);
+}
+#else /* THREAD_SAFE_API */
+#define __snd_pcm_lock(pcm)		do {} while (0)
+#define __snd_pcm_unlock(pcm)		do {} while (0)
+#define snd_pcm_lock(pcm)		do {} while (0)
+#define snd_pcm_unlock(pcm)		do {} while (0)
+#endif /* THREAD_SAFE_API */
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 5c4fbe1705eb..1948289cdc44 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -82,12 +82,12 @@ static snd_pcm_sframes_t snd_pcm_mmap_write_areas(snd_pcm_t *pcm,
 		snd_pcm_uframes_t frames = size;
 		snd_pcm_sframes_t result;
 
-		snd_pcm_mmap_begin(pcm, &pcm_areas, &pcm_offset, &frames);
+		__snd_pcm_mmap_begin(pcm, &pcm_areas, &pcm_offset, &frames);
 		snd_pcm_areas_copy(pcm_areas, pcm_offset,
 				   areas, offset, 
 				   pcm->channels, 
 				   frames, pcm->format);
-		result = snd_pcm_mmap_commit(pcm, pcm_offset, frames);
+		result = __snd_pcm_mmap_commit(pcm, pcm_offset, frames);
 		if (result < 0)
 			return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
 		offset += result;
@@ -114,12 +114,12 @@ static snd_pcm_sframes_t snd_pcm_mmap_read_areas(snd_pcm_t *pcm,
 		snd_pcm_uframes_t frames = size;
 		snd_pcm_sframes_t result;
 		
-		snd_pcm_mmap_begin(pcm, &pcm_areas, &pcm_offset, &frames);
+		__snd_pcm_mmap_begin(pcm, &pcm_areas, &pcm_offset, &frames);
 		snd_pcm_areas_copy(areas, offset,
 				   pcm_areas, pcm_offset,
 				   pcm->channels, 
 				   frames, pcm->format);
-		result = snd_pcm_mmap_commit(pcm, pcm_offset, frames);
+		result = __snd_pcm_mmap_commit(pcm, pcm_offset, frames);
 		if (result < 0)
 			return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
 		offset += result;
@@ -513,6 +513,7 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* called in pcm lock */
 snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				     snd_pcm_uframes_t size)
 {
@@ -530,7 +531,9 @@ snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 		{
 			const snd_pcm_channel_area_t *a = snd_pcm_mmap_areas(pcm);
 			const char *buf = snd_pcm_channel_area_addr(a, offset);
+			snd_pcm_unlock(pcm); /* to avoid deadlock */
 			err = _snd_pcm_writei(pcm, buf, frames);
+			snd_pcm_lock(pcm);
 			if (err >= 0)
 				frames = err;
 			break;
@@ -545,7 +548,9 @@ snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				const snd_pcm_channel_area_t *a = &areas[c];
 				bufs[c] = snd_pcm_channel_area_addr(a, offset);
 			}
+			snd_pcm_unlock(pcm); /* to avoid deadlock */
 			err = _snd_pcm_writen(pcm, bufs, frames);
+			snd_pcm_lock(pcm);
 			if (err >= 0)
 				frames = err;
 			break;
@@ -564,6 +569,7 @@ snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 	return err;
 }
 
+/* called in pcm lock */
 snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				    snd_pcm_uframes_t size)
 {
@@ -581,7 +587,9 @@ snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 		{
 			const snd_pcm_channel_area_t *a = snd_pcm_mmap_areas(pcm);
 			char *buf = snd_pcm_channel_area_addr(a, offset);
+			snd_pcm_unlock(pcm); /* to avoid deadlock */
 			err = _snd_pcm_readi(pcm, buf, frames);
+			snd_pcm_lock(pcm);
 			if (err >= 0)
 				frames = err;
 			break;
@@ -596,7 +604,9 @@ snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				const snd_pcm_channel_area_t *a = &areas[c];
 				bufs[c] = snd_pcm_channel_area_addr(a, offset);
 			}
+			snd_pcm_unlock(pcm); /* to avoid deadlock */
 			err = _snd_pcm_readn(pcm->fast_op_arg, bufs, frames);
+			snd_pcm_lock(pcm);
 			if (err >= 0)
 				frames = err;
 			break;
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 41bddac1a83f..06854fdee7f9 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1004,6 +1004,7 @@ static int snd_pcm_rate_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsign
 	return snd_pcm_poll_descriptors_revents(rate->gen.slave, pfds, nfds, revents);
 }
 
+/* locking */
 static int snd_pcm_rate_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
@@ -1013,6 +1014,7 @@ static int snd_pcm_rate_drain(snd_pcm_t *pcm)
 		snd_pcm_uframes_t size, ofs, saved_avail_min;
 		snd_pcm_sw_params_t sw_params;
 
+		__snd_pcm_lock(pcm);
 		/* temporarily set avail_min to one */
 		sw_params = rate->sw_params;
 		saved_avail_min = sw_params.avail_min;
@@ -1023,8 +1025,10 @@ static int snd_pcm_rate_drain(snd_pcm_t *pcm)
 		ofs = rate->last_commit_ptr % pcm->buffer_size;
 		while (size > 0) {
 			snd_pcm_uframes_t psize, spsize;
+			int err;
 
-			if (snd_pcm_wait(rate->gen.slave, -1) < 0)
+			err = __snd_pcm_wait_in_lock(rate->gen.slave, -1);
+			if (err < 0)
 				break;
 			if (size > pcm->period_size) {
 				psize = pcm->period_size;
@@ -1042,6 +1046,7 @@ static int snd_pcm_rate_drain(snd_pcm_t *pcm)
 		}
 		sw_params.avail_min = saved_avail_min;
 		snd_pcm_sw_params(rate->gen.slave, &sw_params);
+		__snd_pcm_unlock(pcm);
 	}
 	return snd_pcm_drain(rate->gen.slave);
 }
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 361160302be8..508d5b0fc3d2 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -877,7 +877,7 @@ static int route_chmap_init(snd_pcm_t *pcm)
 	snd_pcm_route_t *route = pcm->private_data;
 	if (!route->chmap)
 		return 0;
-	if (snd_pcm_state(pcm) != SND_PCM_STATE_PREPARED)
+	if (__snd_pcm_state(pcm) != SND_PCM_STATE_PREPARED)
 		return 0;
 
 	/* Check if we really need to set the chmap or not.
-- 
2.9.0
