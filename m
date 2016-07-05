From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC alsa-lib 1/5] pcm: Add thread-safety to PCM
	API
Date: Tue,  5 Jul 2016 17:20:20 +0200
Message-ID: <20160705152024.20152-2-tiwai@suse.de>
References: <20160705152024.20152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A91A2666D0
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 17:20:29 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91949ACDC
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 15:20:27 +0000 (UTC)
In-Reply-To: <20160705152024.20152-1-tiwai@suse.de>
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
functions in a simplistic way: namely, just wrap the exported
functions with the pthread mutex of each PCM object.  Some functions
are split to both unlocked and locked versions for avoiding
deadlocks.

Two new fields are added snd_pcm_t when the option is enabled:
thread_safe and lock.  The former indicates that the plugin is
thread-safe that doesn't need this workaround and the latter is the
pthread mutex.  Currently only hw plugin has thread_safe=1.  So, the
most of real-time sensitive apps won't be influenced by this change at
all.

Although the patch covers most of PCM ops, a few snd_pcm_fast_ops are
left without the extra mutex locking: namely, the ones that may have
blocking behavior, i.e. resume, drain, readi, writei, readn and
writen.  These are supposed to handle own locking in the callbacks.

If anyone wants to disable this new thread-safe API feature, it can be
still turned off via --disable-thread-safety configure option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac          |  15 ++
 src/pcm/pcm.c         | 468 +++++++++++++++++++++++++++++++++++++++++++-------
 src/pcm/pcm_direct.c  |   4 +-
 src/pcm/pcm_dmix.c    |  13 +-
 src/pcm/pcm_dshare.c  |  13 +-
 src/pcm/pcm_dsnoop.c  |  15 +-
 src/pcm/pcm_file.c    |  21 ++-
 src/pcm/pcm_generic.c |  10 +-
 src/pcm/pcm_hw.c      |   3 +
 src/pcm/pcm_ioplug.c  |  11 +-
 src/pcm/pcm_local.h   |  62 ++++++-
 src/pcm/pcm_mmap.c    |  16 +-
 src/pcm/pcm_params.c  |   2 +-
 src/pcm/pcm_rate.c    |   7 +-
 src/pcm/pcm_route.c   |   2 +-
 15 files changed, 565 insertions(+), 97 deletions(-)

diff --git a/configure.ac b/configure.ac
index 53fca33e201a..ce324411fd61 100644
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
+  AC_DEFINE([THREAD_SAFE_API], "1", [Build thread-safe API functions])
+else
+  AC_MSG_RESULT(no)
+fi
+fi
+
 dnl Make a symlink for inclusion of alsa/xxx.h
 if test ! -L "$srcdir"/include/alsa ; then
   echo "Making a symlink include/alsa"
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 0d0d093deb49..413cc94b8f2e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -686,6 +686,8 @@ snd_pcm_stream_t snd_pcm_stream(snd_pcm_t *pcm)
  *
  * Closes the specified PCM handle and frees all associated
  * resources.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_close(snd_pcm_t *pcm)
 {
@@ -697,6 +699,7 @@ int snd_pcm_close(snd_pcm_t *pcm)
 		if (err < 0)
 			res = err;
 	}
+	snd_pcm_lock(pcm);
 	if (pcm->mmap_channels)
 		snd_pcm_munmap(pcm);
 	while (!list_empty(&pcm->async_handlers)) {
@@ -704,6 +707,7 @@ int snd_pcm_close(snd_pcm_t *pcm)
 		snd_async_del_handler(h);
 	}
 	err = pcm->ops->close(pcm->op_arg);
+	snd_pcm_unlock(pcm);
 	if (err < 0)
 		res = err;
 	err = snd_pcm_free(pcm);
@@ -712,16 +716,32 @@ int snd_pcm_close(snd_pcm_t *pcm)
 	return res;
 }	
 
+static int __snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock);
+
 /**
  * \brief set nonblock mode
  * \param pcm PCM handle
  * \param nonblock 0 = block, 1 = nonblock mode, 2 = abort
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 {
 	int err;
+
 	assert(pcm);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_nonblock(pcm, nonblock);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOXYGEN
+static int __snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
+{
+	int err;
+
 	if ((err = pcm->ops->nonblock(pcm->op_arg, nonblock)) < 0)
 		return err;
 	if (nonblock == 2) {
@@ -738,7 +758,6 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 	return 0;
 }
 
-#ifndef DOC_HIDDEN
 /**
  * \brief set async mode
  * \param pcm PCM handle
@@ -764,17 +783,26 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
  * \param pcm PCM handle
  * \param info Information container
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
 {
+	int err;
+
 	assert(pcm && info);
-	return pcm->ops->info(pcm->op_arg, info);
+	snd_pcm_lock(pcm);
+	err = pcm->ops->info(pcm->op_arg, info);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /** \brief Retreive current PCM hardware configuration chosen with #snd_pcm_hw_params
  * \param pcm PCM handle
  * \param params Configuration space definition container
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
@@ -783,6 +811,7 @@ int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	assert(pcm && params);
 	if (!pcm->setup)
 		return -EBADFD;
+	snd_pcm_lock(pcm);
 	memset(params, 0, snd_pcm_hw_params_sizeof());
 	params->flags = pcm->hw_flags;
 	snd_mask_set(&params->masks[SND_PCM_HW_PARAM_ACCESS - SND_PCM_HW_PARAM_FIRST_MASK], pcm->access);
@@ -803,6 +832,7 @@ int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	params->rate_num = pcm->rate_num;
 	params->rate_den = pcm->rate_den;
 	params->fifo_size = pcm->fifo_size;
+	snd_pcm_unlock(pcm);
 	return 0;
 } 
 
@@ -826,12 +856,16 @@ int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
  *
  * The configuration space will be updated to reflect the chosen
  * parameters.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
 	int err;
 	assert(pcm && params);
+	snd_pcm_lock(pcm);
 	err = _snd_pcm_hw_params_internal(pcm, params);
+	snd_pcm_unlock(pcm);
 	if (err < 0)
 		return err;
 	err = snd_pcm_prepare(pcm);
@@ -841,21 +875,27 @@ int snd_pcm_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 /** \brief Remove PCM hardware configuration and free associated resources
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_hw_free(snd_pcm_t *pcm)
 {
-	int err;
+	int err = 0;
+
+	snd_pcm_lock(pcm);
 	if (! pcm->setup)
-		return 0;
+		goto unlock;
 	if (pcm->mmap_channels) {
 		err = snd_pcm_munmap(pcm);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
-	// assert(snd_pcm_state(pcm) == SND_PCM_STATE_SETUP ||
-	//        snd_pcm_state(pcm) == SND_PCM_STATE_PREPARED);
+	// assert(__snd_pcm_state(pcm) == SND_PCM_STATE_SETUP ||
+	//        __snd_pcm_state(pcm) == SND_PCM_STATE_PREPARED);
 	err = pcm->ops->hw_free(pcm->op_arg);
 	pcm->setup = 0;
+ unlock:
+	snd_pcm_unlock(pcm);
 	if (err < 0)
 		return err;
 	return 0;
@@ -869,6 +909,8 @@ int snd_pcm_hw_free(snd_pcm_t *pcm)
  * The software parameters can be changed at any time.
  * The hardware parameters cannot be changed when the stream is
  * running (active).
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 {
@@ -892,6 +934,18 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		return -EINVAL;
 	}
 #endif
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_sw_params(pcm, params);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOC_HIDDEN
+/* locked version */
+int __snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
+{
+	int err;
+
 	err = pcm->ops->sw_params(pcm->op_arg, params);
 	if (err < 0)
 		return err;
@@ -907,17 +961,24 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	pcm->boundary = params->boundary;
 	return 0;
 }
+#endif
 
 /**
  * \brief Obtain status (runtime) information for PCM handle
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
@@ -927,13 +988,33 @@ int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
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
+	snd_pcm_lock(pcm);
+	state = __snd_pcm_state(pcm);
+	snd_pcm_unlock(pcm);
+	return state;
+}
+
+#ifndef DOC_HIDDEN
+/* locked version */
+snd_pcm_state_t __snd_pcm_state(snd_pcm_t *pcm)
+{
 	return pcm->fast_ops->state(pcm->fast_op_arg);
 }
 
+static inline int pcm_hwsync(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->hwsync(pcm->fast_op_arg);
+}
+#endif
+
 /**
  * \brief (DEPRECATED) Synchronize stream position with hardware
  * \param pcm PCM handle
@@ -942,15 +1023,22 @@ snd_pcm_state_t snd_pcm_state(snd_pcm_t *pcm)
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
+	err = pcm_hwsync(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 #ifndef DOC_HIDDEN
 link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()");
@@ -983,15 +1071,22 @@ link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider
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
+	err = pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1005,6 +1100,8 @@ int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  * to do the fine resume from this state. Not all hardware supports
  * this feature, when an -ENOSYS error is returned, use the \link ::snd_pcm_prepare() \endlink
  * function to recovery.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_resume(snd_pcm_t *pcm)
 {
@@ -1013,6 +1110,7 @@ int snd_pcm_resume(snd_pcm_t *pcm)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	/* lock handled in the callback */
 	return pcm->fast_ops->resume(pcm->fast_op_arg);
 }
 
@@ -1025,30 +1123,44 @@ int snd_pcm_resume(snd_pcm_t *pcm)
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
@@ -1057,30 +1169,51 @@ int snd_pcm_prepare(snd_pcm_t *pcm)
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
+}
+
+#ifndef DOXYGEN
+static int pcm_start(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->start(pcm->fast_op_arg);
 }
+#endif
 
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
+	err = pcm_start(pcm);
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1093,15 +1226,22 @@ int snd_pcm_start(snd_pcm_t *pcm)
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
@@ -1116,6 +1256,8 @@ int snd_pcm_drop(snd_pcm_t *pcm)
  *
  * For stopping the PCM stream immediately, use \link ::snd_pcm_drop() \endlink
  * instead.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_drain(snd_pcm_t *pcm)
 {
@@ -1124,6 +1266,7 @@ int snd_pcm_drain(snd_pcm_t *pcm)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	/* lock handled in the callback */
 	return pcm->fast_ops->drain(pcm->fast_op_arg);
 }
 
@@ -1136,15 +1279,22 @@ int snd_pcm_drain(snd_pcm_t *pcm)
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
@@ -1155,15 +1305,22 @@ int snd_pcm_pause(snd_pcm_t *pcm, int enable)
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
@@ -1172,9 +1329,13 @@ snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t *pcm)
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
@@ -1182,7 +1343,10 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
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
@@ -1193,15 +1357,22 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
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
@@ -1210,6 +1381,8 @@ snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm)
  * \param frames wanted skip in frames
  * \return a positive number for actual skip otherwise a negative error code
  * \retval 0 means no action
+ *
+ * The function is thread-safe when built with the proper option.
  */
 #ifndef DOXYGEN
 snd_pcm_sframes_t INTERNAL(snd_pcm_forward)(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -1217,6 +1390,8 @@ snd_pcm_sframes_t INTERNAL(snd_pcm_forward)(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 #endif
 {
+	snd_pcm_sframes_t result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
@@ -1224,7 +1399,10 @@ snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
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
 
@@ -1244,6 +1422,8 @@ use_default_symbol_version(__snd_pcm_forward, snd_pcm_forward, ALSA_0.9.0rc8);
  * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
@@ -1276,6 +1456,8 @@ snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_ufr
  * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
@@ -1308,6 +1490,8 @@ snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
@@ -1340,6 +1524,8 @@ snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
@@ -1363,27 +1549,43 @@ snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t s
  * \return 0 on success otherwise a negative error code
  *
  * The two PCMs will start/stop/prepare in sync.
+ *
+ * The function is thread-safe when built with the proper option.
  */ 
 int snd_pcm_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2)
 {
+	int err;
+
 	assert(pcm1);
 	assert(pcm2);
+	snd_pcm_lock(pcm1);
 	if (pcm1->fast_ops->link)
-		return pcm1->fast_ops->link(pcm1, pcm2);
-	return -ENOSYS;
+		err = pcm1->fast_ops->link(pcm1, pcm2);
+	else
+		err = -ENOSYS;
+	snd_pcm_unlock(pcm1);
+	return err;
 }
 
 /**
  * \brief Remove a PCM from a linked group
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_unlink(snd_pcm_t *pcm)
 {
+	int err;
+
 	assert(pcm);
+	snd_pcm_lock(pcm);
 	if (pcm->fast_ops->unlink)
-		return pcm->fast_ops->unlink(pcm);
-	return -ENOSYS;
+		err = pcm->fast_ops->unlink(pcm);
+	else
+		err = -ENOSYS;
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -1393,12 +1595,24 @@ int snd_pcm_unlink(snd_pcm_t *pcm)
  */
 int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
 {
+	int count;
+
 	assert(pcm);
+	snd_pcm_lock(pcm);
+	count = __snd_pcm_poll_descriptors_count(pcm);
+	snd_pcm_unlock(pcm);
+	return count;
+}
+
+#ifndef DOXYGEN
+/* locked version */
+int __snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
+{
 	if (pcm->fast_ops->poll_descriptors_count)
 		return pcm->fast_ops->poll_descriptors_count(pcm->fast_op_arg);
 	return pcm->poll_fd_count;
 }
-
+#endif
 
 /**
  * \brief get poll descriptors
@@ -1428,7 +1642,20 @@ int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
  */
 int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
 {
+	int err;
+
 	assert(pcm && pfds);
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_poll_descriptors(pcm, pfds, space);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOXYGEN
+/* locked version */
+int __snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
+			       unsigned int space)
+{
 	if (pcm->fast_ops->poll_descriptors)
 		return pcm->fast_ops->poll_descriptors(pcm->fast_op_arg, pfds, space);
 	if (pcm->poll_fd < 0) {
@@ -1443,6 +1670,10 @@ int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int s
 	}
 	return 1;
 }
+#endif
+
+static int pcm_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds,
+			    unsigned int nfds, unsigned short *revents);
 
 /**
  * \brief get returned events from poll descriptors
@@ -1462,20 +1693,33 @@ int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int s
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
+	err = pcm_poll_revents(pcm, pfds, nfds, revents);
+	snd_pcm_unlock(pcm);
+	return err;
+}
+
+#ifndef DOC_HIDDEN
+static int pcm_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds,
+			    unsigned int nfds, unsigned short *revents)
+{
 	if (pcm->fast_ops->poll_revents)
 		return pcm->fast_ops->poll_revents(pcm->fast_op_arg, pfds, nfds, revents);
-	if (nfds == 1) {
+	if (nfds == 1)
 		*revents = pfds->revents;
-		return 0;
-	}
-	return -EINVAL;
+	else
+		return -EINVAL;
+	return 0;
 }
 
-#ifndef DOC_HIDDEN
 #define PCMTYPE(v) [SND_PCM_TYPE_##v] = #v
 #define STATE(v) [SND_PCM_STATE_##v] = #v
 #define STREAM(v) [SND_PCM_STREAM_##v] = #v
@@ -1974,12 +2218,16 @@ int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t *out)
  * \param pcm PCM handle
  * \param out Output handle
  * \return 0 on success otherwise a negative error code
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	assert(pcm);
 	assert(out);
+	snd_pcm_lock(pcm);
 	pcm->ops->dump(pcm->op_arg, out);
+	snd_pcm_unlock(pcm);
 	return 0;
 }
 
@@ -2056,6 +2304,8 @@ ssize_t snd_pcm_samples_to_bytes(snd_pcm_t *pcm, long samples)
  * \return 0 otherwise a negative error code on failure
  *
  * The asynchronous callback is called when period boundary elapses.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm, 
 			      snd_async_callback_t callback, void *private_data)
@@ -2063,10 +2313,11 @@ int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm,
 	int err;
 	int was_empty;
 	snd_async_handler_t *h;
+	snd_pcm_lock(pcm);
 	err = snd_async_add_handler(&h, _snd_pcm_async_descriptor(pcm),
 				    callback, private_data);
 	if (err < 0)
-		return err;
+		goto unlock;
 	h->type = SND_ASYNC_HANDLER_PCM;
 	h->u.pcm = pcm;
 	was_empty = list_empty(&pcm->async_handlers);
@@ -2075,11 +2326,13 @@ int snd_async_add_pcm_handler(snd_async_handler_t **handler, snd_pcm_t *pcm,
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
+	snd_pcm_unlock(pcm);
+	return err;
 }
 
 /**
@@ -2359,6 +2612,9 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
 	pcm->op_arg = pcm;
 	pcm->fast_op_arg = pcm;
 	INIT_LIST_HEAD(&pcm->async_handlers);
+#ifdef THREAD_SAFE_API
+	pthread_mutex_init(&pcm->lock, NULL);
+#endif
 	*pcmp = pcm;
 	return 0;
 }
@@ -2370,6 +2626,9 @@ int snd_pcm_free(snd_pcm_t *pcm)
 	free(pcm->hw.link_dst);
 	free(pcm->appl.link_dst);
 	snd_dlobj_cache_put(pcm->open_func);
+#ifdef THREAD_SAFE_API
+	pthread_mutex_destroy(&pcm->lock);
+#endif
 	free(pcm);
 	return 0;
 }
@@ -2401,12 +2660,26 @@ int snd_pcm_open_named_slave(snd_pcm_t **pcmp, const char *name,
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
+	snd_pcm_lock(pcm);
+	err = __snd_pcm_wait_in_lock(pcm, timeout);
+	snd_pcm_unlock(pcm);
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
@@ -2420,11 +2693,12 @@ int snd_pcm_wait(snd_pcm_t *pcm, int timeout)
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
@@ -2432,13 +2706,13 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
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
@@ -2446,7 +2720,9 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 		return -EIO;
 	}
 	do {
+		snd_pcm_unlock(pcm);
 		err_poll = poll(pfd, npfds, timeout);
+		snd_pcm_lock(pcm);
 		if (err_poll < 0) {
 		        if (errno == EINTR && !PCMINABORT(pcm))
 		                continue;
@@ -2454,12 +2730,12 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
                 }
 		if (! err_poll)
 			break;
-		err = snd_pcm_poll_descriptors_revents(pcm, pfd, npfds, &revents);
+		err = pcm_poll_revents(pcm, pfd, npfds, &revents);
 		if (err < 0)
 			return err;
 		if (revents & (POLLERR | POLLNVAL)) {
 			/* check more precisely */
-			switch (snd_pcm_state(pcm)) {
+			switch (__snd_pcm_state(pcm)) {
 			case SND_PCM_STATE_XRUN:
 				return -EPIPE;
 			case SND_PCM_STATE_SUSPENDED:
@@ -2474,8 +2750,8 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
 #if 0 /* very useful code to test poll related problems */
 	{
 		snd_pcm_sframes_t avail_update;
-		snd_pcm_hwsync(pcm);
-		avail_update = snd_pcm_avail_update(pcm);
+		pcm_hwsync(pcm);
+		avail_update = pcm_avail_update(pcm);
 		if (avail_update < (snd_pcm_sframes_t)pcm->avail_min) {
 			printf("*** snd_pcm_wait() FATAL ERROR!!!\n");
 			printf("avail_min = %li, avail_update = %li\n", pcm->avail_min, avail_update);
@@ -2506,10 +2782,17 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
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
@@ -2523,20 +2806,27 @@ snd_pcm_sframes_t snd_pcm_avail_update(snd_pcm_t *pcm)
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
+	err = pcm_hwsync(pcm);
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
@@ -2547,6 +2837,8 @@ snd_pcm_sframes_t snd_pcm_avail(snd_pcm_t *pcm)
  * \return zero on success otherwise a negative error code
  *
  * The avail and delay values retuned are in sync.
+ *
+ * The function is thread-safe when built with the proper option.
  */
 int snd_pcm_avail_delay(snd_pcm_t *pcm,
 			snd_pcm_sframes_t *availp,
@@ -2560,17 +2852,23 @@ int snd_pcm_avail_delay(snd_pcm_t *pcm,
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	snd_pcm_lock(pcm);
 	err = pcm->fast_ops->hwsync(pcm->fast_op_arg);
 	if (err < 0)
-		return err;
+		goto unlock;
 	sf = pcm->fast_ops->avail_update(pcm->fast_op_arg);
-	if (sf < 0)
-		return (int)sf;
+	if (sf < 0) {
+		err = (int)sf;
+		goto unlock;
+	}
 	err = pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
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
@@ -6680,12 +6978,27 @@ void snd_pcm_info_set_stream(snd_pcm_info_t *obj, snd_pcm_stream_t val)
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
+#ifndef DOXYGEN
+/* locked version */
+int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
+		       snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames)
+{
 	snd_pcm_uframes_t cont;
 	snd_pcm_uframes_t f;
 	snd_pcm_uframes_t avail;
@@ -6708,6 +7021,7 @@ int snd_pcm_mmap_begin(snd_pcm_t *pcm,
 	*frames = f;
 	return 0;
 }
+#endif
 
 /**
  * \brief Application has completed the access to area requested with #snd_pcm_mmap_begin
@@ -6760,11 +7074,27 @@ int snd_pcm_mmap_begin(snd_pcm_t *pcm,
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
+#ifndef DOXYGEN
+/* locked version*/
+snd_pcm_sframes_t __snd_pcm_mmap_commit(snd_pcm_t *pcm,
+					snd_pcm_uframes_t offset,
+					snd_pcm_uframes_t frames)
+{
 	assert(pcm);
 	if (CHECK_SANITY(offset != *pcm->appl.ptr % pcm->buffer_size)) {
 		SNDMSG("commit offset (%ld) doesn't match with appl_ptr (%ld) %% buf_size (%ld)",
@@ -6779,8 +7109,6 @@ snd_pcm_sframes_t snd_pcm_mmap_commit(snd_pcm_t *pcm,
 	return pcm->fast_ops->mmap_commit(pcm->fast_op_arg, offset, frames);
 }
 
-#ifndef DOC_HIDDEN
-
 int _snd_pcm_poll_descriptor(snd_pcm_t *pcm)
 {
 	assert(pcm);
@@ -6791,24 +7119,32 @@ void snd_pcm_areas_from_buf(snd_pcm_t *pcm, snd_pcm_channel_area_t *areas,
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
@@ -6822,19 +7158,20 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 	if (size == 0)
 		return 0;
 
+	snd_pcm_lock(pcm);
 	while (size > 0) {
 		snd_pcm_uframes_t frames;
 		snd_pcm_sframes_t avail;
 	_again:
-		state = snd_pcm_state(pcm);
+		state = __snd_pcm_state(pcm);
 		switch (state) {
 		case SND_PCM_STATE_PREPARED:
-			err = snd_pcm_start(pcm);
+			err = pcm_start(pcm);
 			if (err < 0)
 				goto _end;
 			break;
 		case SND_PCM_STATE_RUNNING:
-			err = snd_pcm_hwsync(pcm);
+			err = pcm_hwsync(pcm);
 			if (err < 0)
 				goto _end;
 			break;
@@ -6854,7 +7191,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 			err = -EBADFD;
 			goto _end;
 		}
-		avail = snd_pcm_avail_update(pcm);
+		avail = __snd_pcm_avail_update(pcm);
 		if (avail < 0) {
 			err = avail;
 			goto _end;
@@ -6867,7 +7204,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 				goto _end;
 			}
 
-			err = snd_pcm_wait(pcm, -1);
+			err = __snd_pcm_wait_in_lock(pcm, -1);
 			if (err < 0)
 				break;
 			goto _again;
@@ -6887,6 +7224,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 		xfer += frames;
 	}
  _end:
+	snd_pcm_unlock(pcm);
 	return xfer > 0 ? (snd_pcm_sframes_t) xfer : snd_pcm_check_error(pcm, err);
 }
 
@@ -6901,17 +7239,18 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 	if (size == 0)
 		return 0;
 
+	snd_pcm_lock(pcm);
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
+			err = pcm_hwsync(pcm);
 			if (err < 0)
 				goto _end;
 			break;
@@ -6928,7 +7267,7 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 			err = -EBADFD;
 			goto _end;
 		}
-		avail = snd_pcm_avail_update(pcm);
+		avail = __snd_pcm_avail_update(pcm);
 		if (avail < 0) {
 			err = avail;
 			goto _end;
@@ -6959,10 +7298,10 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 			snd_pcm_sframes_t hw_avail = pcm->buffer_size - avail;
 			hw_avail += frames;
 			/* some plugins might automatically start the stream */
-			state = snd_pcm_state(pcm);
+			state = __snd_pcm_state(pcm);
 			if (state == SND_PCM_STATE_PREPARED &&
 			    hw_avail >= (snd_pcm_sframes_t) pcm->start_threshold) {
-				err = snd_pcm_start(pcm);
+				err = pcm_start(pcm);
 				if (err < 0)
 					goto _end;
 			}
@@ -6972,6 +7311,7 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 		xfer += frames;
 	}
  _end:
+	snd_pcm_unlock(pcm);
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
index 92eb0724c0e2..b1821f944240 100644
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
+		snd_pcm_lock(pcm);
 		snd_pcm_file_write_bytes(pcm, file->wbuf_used_bytes);
 		assert(file->wbuf_used_bytes == 0);
+		snd_pcm_unlock(pcm);
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
+		snd_pcm_lock(pcm);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		snd_pcm_unlock(pcm);
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
+		snd_pcm_lock(pcm);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		snd_pcm_unlock(pcm);
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
+		snd_pcm_lock(pcm);
 		n = read(file->ifd, buffer, n * pcm->frame_bits / 8);
+		snd_pcm_unlock(pcm);
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
index 43550c03875b..98daa8dea70d 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -469,15 +469,20 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* need locking */
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
@@ -609,7 +614,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_mmap_commit(snd_pcm_t *pcm,
 		const snd_pcm_channel_area_t *areas;
 		snd_pcm_uframes_t ofs, frames = size;
 
-		snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
+		__snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
 		if (ofs != offset)
 			return -EIO;
 		return ioplug_priv_transfer_areas(pcm, areas, offset, frames);
@@ -635,7 +640,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_avail_update(snd_pcm_t *pcm)
 			snd_pcm_uframes_t offset, size = UINT_MAX;
 			snd_pcm_sframes_t result;
 
-			snd_pcm_mmap_begin(pcm, &areas, &offset, &size);
+			__snd_pcm_mmap_begin(pcm, &areas, &offset, &size);
 			result = io->data->callback->transfer(io->data, areas, offset, size);
 			if (result < 0)
 				return result;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 326618ecd0c0..126e2b6ece8f 100644
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
 
@@ -155,12 +159,12 @@ typedef struct {
 	int (*reset)(snd_pcm_t *pcm);
 	int (*start)(snd_pcm_t *pcm);
 	int (*drop)(snd_pcm_t *pcm);
-	int (*drain)(snd_pcm_t *pcm);
+	int (*drain)(snd_pcm_t *pcm); /* need own locking */
 	int (*pause)(snd_pcm_t *pcm, int enable);
 	snd_pcm_state_t (*state)(snd_pcm_t *pcm);
 	int (*hwsync)(snd_pcm_t *pcm);
 	int (*delay)(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp);
-	int (*resume)(snd_pcm_t *pcm);
+	int (*resume)(snd_pcm_t *pcm); /* need own locking */
 	int (*link)(snd_pcm_t *pcm1, snd_pcm_t *pcm2);
 	int (*link_slaves)(snd_pcm_t *pcm, snd_pcm_t *master);
 	int (*unlink)(snd_pcm_t *pcm);
@@ -168,10 +172,10 @@ typedef struct {
 	snd_pcm_sframes_t (*rewind)(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
 	snd_pcm_sframes_t (*forwardable)(snd_pcm_t *pcm);
 	snd_pcm_sframes_t (*forward)(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
-	snd_pcm_sframes_t (*writei)(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*writen)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*readi)(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size);
-	snd_pcm_sframes_t (*readn)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
+	snd_pcm_sframes_t (*writei)(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*writen)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*readi)(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size); /* need own locking */
+	snd_pcm_sframes_t (*readn)(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size); /* need own locking */
 	snd_pcm_sframes_t (*avail_update)(snd_pcm_t *pcm);
 	snd_pcm_sframes_t (*mmap_commit)(snd_pcm_t *pcm, snd_pcm_uframes_t offset, snd_pcm_uframes_t size);
 	int (*htimestamp)(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_t *tstamp);
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
@@ -401,11 +409,24 @@ int _snd_pcm_poll_descriptor(snd_pcm_t *pcm);
 #define _snd_pcm_link_descriptor _snd_pcm_poll_descriptor /* FIXME */
 #define _snd_pcm_async_descriptor _snd_pcm_poll_descriptor /* FIXME */
 
+/* locked versions */
+snd_pcm_state_t __snd_pcm_state(snd_pcm_t *pcm);
+int __snd_pcm_poll_descriptors_count(snd_pcm_t *pcm);
+int __snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
+			       unsigned int space);
+int __snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params);
+int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
+			 snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames);
+snd_pcm_sframes_t __snd_pcm_mmap_commit(snd_pcm_t *pcm,
+					snd_pcm_uframes_t offset,
+					snd_pcm_uframes_t frames);
+int __snd_pcm_wait_in_lock(snd_pcm_t *pcm, int timeout);
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
@@ -483,7 +504,7 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_hw_rewindable(snd_pcm_t *pcm)
 static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
 {
 	if (pcm->stopped_areas &&
-	    snd_pcm_state(pcm) != SND_PCM_STATE_RUNNING) 
+	    __snd_pcm_state(pcm) != SND_PCM_STATE_RUNNING)
 		return pcm->stopped_areas;
 	return pcm->running_areas;
 }
@@ -533,21 +554,25 @@ static inline unsigned int snd_pcm_channel_area_step(const snd_pcm_channel_area_
 
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
 
@@ -1016,6 +1041,11 @@ _snd_pcm_parse_config_chmaps(snd_config_t *conf);
 snd_pcm_chmap_t *
 _snd_pcm_choose_fixed_chmap(snd_pcm_t *pcm, snd_pcm_chmap_query_t * const *maps);
 
+static inline snd_pcm_sframes_t __snd_pcm_avail_update(snd_pcm_t *pcm)
+{
+	return pcm->fast_ops->avail_update(pcm->fast_op_arg);
+}
+
 /* return true if the PCM stream may wait to get avail_min space */
 static inline int snd_pcm_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
 {
@@ -1038,3 +1068,19 @@ static inline void sw_set_period_event(snd_pcm_sw_params_t *params, int val)
 }
 
 #define PCMINABORT(pcm) (((pcm)->mode & SND_PCM_ABORT) != 0)
+
+#ifdef THREAD_SAFE_API
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
+#define snd_pcm_lock(pcm)		do {} while (0)
+#define snd_pcm_unlock(pcm)		do {} while (0)
+#endif /* THREAD_SAFE_API */
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 5c4fbe1705eb..6c230a144559 100644
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
@@ -256,6 +256,7 @@ int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int s
 	return 0;
 }	
 
+/* called in pcm lock */
 int snd_pcm_mmap(snd_pcm_t *pcm)
 {
 	int err;
@@ -435,6 +436,7 @@ int snd_pcm_mmap(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* called in pcm lock */
 int snd_pcm_munmap(snd_pcm_t *pcm)
 {
 	int err;
@@ -513,6 +515,7 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 	return 0;
 }
 
+/* called in pcm lock */
 snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				     snd_pcm_uframes_t size)
 {
@@ -545,7 +548,9 @@ snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				const snd_pcm_channel_area_t *a = &areas[c];
 				bufs[c] = snd_pcm_channel_area_addr(a, offset);
 			}
+			snd_pcm_unlock(pcm);
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
@@ -596,7 +602,9 @@ snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				const snd_pcm_channel_area_t *a = &areas[c];
 				bufs[c] = snd_pcm_channel_area_addr(a, offset);
 			}
+			snd_pcm_unlock(pcm);
 			err = _snd_pcm_readn(pcm->fast_op_arg, bufs, frames);
+			snd_pcm_lock(pcm);
 			if (err >= 0)
 				frames = err;
 			break;
diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 60d99ad96167..33e04e38cb7f 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -2360,7 +2360,7 @@ int _snd_pcm_hw_params_internal(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	/* Default sw params */
 	memset(&sw, 0, sizeof(sw));
 	snd_pcm_sw_params_default(pcm, &sw);
-	err = snd_pcm_sw_params(pcm, &sw);
+	err = __snd_pcm_sw_params(pcm, &sw);
 	if (err < 0)
 		return err;
 
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 41bddac1a83f..0fe466647a55 100644
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
 
+		snd_pcm_lock(pcm);
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
+		snd_pcm_unlock(pcm);
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
