From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/2] alsa: pcm: return -ENOSYS when ops or
	fast_ops callback is NULL
Date: Wed, 24 Jul 2019 12:12:59 +0200
Message-ID: <1563963180-416-2-git-send-email-amiartus@de.adit-jv.com>
References: <1563963180-416-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1563963180-416-1-git-send-email-amiartus@de.adit-jv.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

function is allowed to continue until it checks for error variable, as to
not conflict with original implementation flow

for simple functions involving only one line, return error immediately in
case callback is NULL

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
---
 src/pcm/pcm.c        | 134 +++++++++++++++++++++++++++++++++++++++++----------
 src/pcm/pcm_local.h  |  20 ++++++++
 src/pcm/pcm_mmap.c   |  15 ++++--
 src/pcm/pcm_params.c |  10 +++-
 4 files changed, 148 insertions(+), 31 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index e0ceccc..178d438 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -761,7 +761,10 @@ int snd_pcm_close(snd_pcm_t *pcm)
 		snd_async_handler_t *h = list_entry(pcm->async_handlers.next, snd_async_handler_t, hlist);
 		snd_async_del_handler(h);
 	}
-	err = pcm->ops->close(pcm->op_arg);
+	if (pcm->ops->close)
+		err = pcm->ops->close(pcm->op_arg);
+	else
+		err = -ENOSYS;
 	if (err < 0)
 		res = err;
 	err = snd_pcm_free(pcm);
@@ -787,7 +790,11 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
 	 * the possible deadlock in signal handler calling snd_pcm_abort()
 	 */
 	/* __snd_pcm_lock(pcm); */ /* forced lock due to pcm field change */
-	if ((err = pcm->ops->nonblock(pcm->op_arg, nonblock)) < 0)
+	if (pcm->ops->nonblock)
+		err = pcm->ops->nonblock(pcm->op_arg, nonblock);
+	else
+		err = -ENOSYS;
+	if (err < 0)
 		goto unlock;
 	if (nonblock == 2) {
 		pcm->mode |= SND_PCM_ABORT;
@@ -818,6 +825,8 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
  */
 int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
 {
+	int err = 0;
+
 	assert(pcm);
 	if (sig == 0)
 		sig = SIGIO;
@@ -828,7 +837,11 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
 	/* async handler may lead to a deadlock; suppose no multi thread */
 	pcm->lock_enabled = 0;
 #endif
-	return pcm->ops->async(pcm->op_arg, sig, pid);
+	if (pcm->ops->async)
+		err = pcm->ops->async(pcm->op_arg, sig, pid);
+	else
+		err = -ENOSYS;
+	return err;
 }
 #endif
 
@@ -840,8 +853,14 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
  */
 int snd_pcm_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
 {
+	int err = 0;
+
 	assert(pcm && info);
-	return pcm->ops->info(pcm->op_arg, info);
+	if (pcm->ops->info)
+		err = pcm->ops->info(pcm->op_arg, info);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /** \brief Retreive current PCM hardware configuration chosen with #snd_pcm_hw_params
@@ -927,7 +946,10 @@ int snd_pcm_hw_free(snd_pcm_t *pcm)
 	}
 	// assert(snd_pcm_state(pcm) == SND_PCM_STATE_SETUP ||
 	//        snd_pcm_state(pcm) == SND_PCM_STATE_PREPARED);
-	err = pcm->ops->hw_free(pcm->op_arg);
+	if (pcm->ops->hw_free)
+		err = pcm->ops->hw_free(pcm->op_arg);
+	else
+		err = -ENOSYS;
 	pcm->setup = 0;
 	if (err < 0)
 		return err;
@@ -968,7 +990,10 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	}
 #endif
 	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
-	err = pcm->ops->sw_params(pcm->op_arg, params);
+	if (pcm->ops->sw_params)
+		err = pcm->ops->sw_params(pcm->op_arg, params);
+	else
+		err = -ENOSYS;
 	if (err < 0) {
 		__snd_pcm_unlock(pcm);
 		return err;
@@ -1001,7 +1026,10 @@ int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
 
 	assert(pcm && status);
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->status(pcm->fast_op_arg, status);
+	if (pcm->fast_ops->status)
+		err = pcm->fast_ops->status(pcm->fast_op_arg, status);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 
 	return err;
@@ -1117,13 +1145,19 @@ int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  */
 int snd_pcm_resume(snd_pcm_t *pcm)
 {
+	int err = 0;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
 	/* lock handled in the callback */
-	return pcm->fast_ops->resume(pcm->fast_op_arg);
+	if (pcm->fast_ops->resume)
+		err = pcm->fast_ops->resume(pcm->fast_op_arg);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /**
@@ -1148,7 +1182,10 @@ int snd_pcm_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_
 		return -EIO;
 	}
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->htimestamp(pcm->fast_op_arg, avail, tstamp);
+	if (pcm->fast_ops->htimestamp)
+		err = pcm->fast_ops->htimestamp(pcm->fast_op_arg, avail, tstamp);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return err;
 }
@@ -1173,7 +1210,10 @@ int snd_pcm_prepare(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->prepare(pcm->fast_op_arg);
+	if (pcm->fast_ops->prepare)
+		err = pcm->fast_ops->prepare(pcm->fast_op_arg);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return err;
 }
@@ -1197,7 +1237,10 @@ int snd_pcm_reset(snd_pcm_t *pcm)
 		return -EIO;
 	}
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->reset(pcm->fast_op_arg);
+	if (pcm->fast_ops->reset)
+		err = pcm->fast_ops->reset(pcm->fast_op_arg);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return err;
 }
@@ -1254,7 +1297,10 @@ int snd_pcm_drop(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->drop(pcm->fast_op_arg);
+	if (pcm->fast_ops->drop)
+		err = pcm->fast_ops->drop(pcm->fast_op_arg);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return err;
 }
@@ -1287,7 +1333,11 @@ int snd_pcm_drain(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 	/* lock handled in the callback */
-	return pcm->fast_ops->drain(pcm->fast_op_arg);
+	if (pcm->fast_ops->drain)
+		err = pcm->fast_ops->drain(pcm->fast_op_arg);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /**
@@ -1315,7 +1365,10 @@ int snd_pcm_pause(snd_pcm_t *pcm, int enable)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	err = pcm->fast_ops->pause(pcm->fast_op_arg, enable);
+	if (pcm->fast_ops->pause)
+		err = pcm->fast_ops->pause(pcm->fast_op_arg, enable);
+	else
+		err = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return err;
 }
@@ -1345,7 +1398,10 @@ snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	result = pcm->fast_ops->rewindable(pcm->fast_op_arg);
+	if (pcm->fast_ops->rewindable)
+		result = pcm->fast_ops->rewindable(pcm->fast_op_arg);
+	else
+		result = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return result;
 }
@@ -1375,7 +1431,10 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	result = pcm->fast_ops->rewind(pcm->fast_op_arg, frames);
+	if (pcm->fast_ops->rewind)
+		result = pcm->fast_ops->rewind(pcm->fast_op_arg, frames);
+	else
+		result = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return result;
 }
@@ -1405,7 +1464,10 @@ snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	result = pcm->fast_ops->forwardable(pcm->fast_op_arg);
+	if (pcm->fast_ops->forwardable)
+		result = pcm->fast_ops->forwardable(pcm->fast_op_arg);
+	else
+		result = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return result;
 }
@@ -1439,7 +1501,10 @@ snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 	if (err < 0)
 		return err;
 	snd_pcm_lock(pcm);
-	result = pcm->fast_ops->forward(pcm->fast_op_arg, frames);
+	if (pcm->fast_ops->forward)
+		result = pcm->fast_ops->forward(pcm->fast_op_arg, frames);
+	else
+		result = -ENOSYS;
 	snd_pcm_unlock(pcm);
 	return result;
 }
@@ -1611,11 +1676,15 @@ snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t s
  */ 
 int snd_pcm_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2)
 {
+	int err = 0;
+
 	assert(pcm1);
 	assert(pcm2);
 	if (pcm1->fast_ops->link)
-		return pcm1->fast_ops->link(pcm1, pcm2);
-	return -ENOSYS;
+		err = pcm1->fast_ops->link(pcm1, pcm2);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /**
@@ -1625,10 +1694,14 @@ int snd_pcm_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2)
  */
 int snd_pcm_unlink(snd_pcm_t *pcm)
 {
+	int err = 0;
+
 	assert(pcm);
 	if (pcm->fast_ops->unlink)
-		return pcm->fast_ops->unlink(pcm);
-	return -ENOSYS;
+		err = pcm->fast_ops->unlink(pcm);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /* locked version */
@@ -2275,10 +2348,15 @@ int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t *out)
  */
 int snd_pcm_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
+	int err = 0;
+
 	assert(pcm);
 	assert(out);
-	pcm->ops->dump(pcm->op_arg, out);
-	return 0;
+	if (pcm->ops->dump)
+		pcm->ops->dump(pcm->op_arg, out);
+	else
+		err = -ENOSYS;
+	return err;
 }
 
 /**
@@ -7242,7 +7320,10 @@ snd_pcm_sframes_t __snd_pcm_mmap_commit(snd_pcm_t *pcm,
 		       snd_pcm_mmap_avail(pcm));
 		return -EPIPE;
 	}
-	return pcm->fast_ops->mmap_commit(pcm->fast_op_arg, offset, frames);
+	if (pcm->fast_ops->mmap_commit)
+		return pcm->fast_ops->mmap_commit(pcm->fast_op_arg, offset, frames);
+	else
+		return -ENOSYS;
 }
 
 int _snd_pcm_poll_descriptor(snd_pcm_t *pcm)
@@ -7969,7 +8050,8 @@ static int chmap_equal(const snd_pcm_chmap_t *a, const snd_pcm_chmap_t *b)
  * \return the NULL-terminated array of integer pointers, each of
  * which contains the channel map. A channel map is represented by an
  * integer array, beginning with the channel map type, followed by the
- * number of channels, and the position of each channel.
+ * number of channels, and the position of each channel. Return NULL
+ * in case of an error.
  *
  * Note: the caller is requested to release the returned value via
  * snd_pcm_free_chmaps().
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index d5726eb..05ed935 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -410,6 +410,8 @@ snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 				     snd_pcm_uframes_t size);
 static inline int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
 {
+	if (!pcm->ops->channel_info)
+		return -ENOSYS;
 	return pcm->ops->channel_info(pcm, info);
 }
 int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int shmid);
@@ -427,26 +429,36 @@ int __snd_pcm_wait_in_lock(snd_pcm_t *pcm, int timeout);
 
 static inline snd_pcm_sframes_t __snd_pcm_avail_update(snd_pcm_t *pcm)
 {
+	if (!pcm->fast_ops->avail_update)
+		return -ENOSYS;
 	return pcm->fast_ops->avail_update(pcm->fast_op_arg);
 }
 
 static inline int __snd_pcm_start(snd_pcm_t *pcm)
 {
+	if (!pcm->fast_ops->start)
+		return -ENOSYS;
 	return pcm->fast_ops->start(pcm->fast_op_arg);
 }
 
 static inline snd_pcm_state_t __snd_pcm_state(snd_pcm_t *pcm)
 {
+	if (!pcm->fast_ops->state)
+		return -ENOSYS;
 	return pcm->fast_ops->state(pcm->fast_op_arg);
 }
 
 static inline int __snd_pcm_hwsync(snd_pcm_t *pcm)
 {
+	if (!pcm->fast_ops->hwsync)
+		return -ENOSYS;
 	return pcm->fast_ops->hwsync(pcm->fast_op_arg);
 }
 
 static inline int __snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
+	if (!pcm->fast_ops->delay)
+		return -ENOSYS;
 	return pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
 }
 
@@ -604,24 +616,32 @@ static inline unsigned int snd_pcm_channel_area_step(const snd_pcm_channel_area_
 static inline snd_pcm_sframes_t _snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
 {
 	/* lock handled in the callback */
+	if (!pcm->fast_ops->writei)
+		return -ENOSYS;
 	return pcm->fast_ops->writei(pcm->fast_op_arg, buffer, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	/* lock handled in the callback */
+	if (!pcm->fast_ops->writen)
+		return -ENOSYS;
 	return pcm->fast_ops->writen(pcm->fast_op_arg, bufs, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	/* lock handled in the callback */
+	if (!pcm->fast_ops->readi)
+		return -ENOSYS;
 	return pcm->fast_ops->readi(pcm->fast_op_arg, buffer, size);
 }
 
 static inline snd_pcm_sframes_t _snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	/* lock handled in the callback */
+	if (!pcm->fast_ops->readn)
+		return -ENOSYS;
 	return pcm->fast_ops->readn(pcm->fast_op_arg, bufs, size);
 }
 
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 0d00f26..024ae65 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -269,7 +269,10 @@ int snd_pcm_mmap(snd_pcm_t *pcm)
 		SNDMSG("Already mmapped");
 		return -EBUSY;
 	}
-	err = pcm->ops->mmap(pcm);
+	if (pcm->ops->mmap)
+		err = pcm->ops->mmap(pcm);
+	else
+		err = -ENOSYS;
 	if (err < 0)
 		return err;
 	if (pcm->mmap_shadow)
@@ -445,7 +448,10 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 		return -ENXIO;
 	}
 	if (pcm->mmap_shadow)
-		return pcm->ops->munmap(pcm);
+		if (pcm->ops->munmap)
+			return pcm->ops->munmap(pcm);
+		else
+			return -ENOSYS;
 	for (c = 0; c < pcm->channels; ++c) {
 		snd_pcm_channel_info_t *i = &pcm->mmap_channels[c];
 		unsigned int c1;
@@ -503,7 +509,10 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 		}
 		i->addr = NULL;
 	}
-	err = pcm->ops->munmap(pcm);
+	if (pcm->ops->munmap)
+		err = pcm->ops->munmap(pcm);
+	else
+		err = -ENOSYS;
 	if (err < 0)
 		return err;
 	free(pcm->mmap_channels);
diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 8826bc3..ceb3b1a 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -2356,7 +2356,10 @@ int snd_pcm_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	snd_output_printf(log, "REFINE called:\n");
 	snd_pcm_hw_params_dump(params, log);
 #endif
-	res = pcm->ops->hw_refine(pcm->op_arg, params);
+	if (pcm->ops->hw_refine)
+		res = pcm->ops->hw_refine(pcm->op_arg, params);
+	else
+		res = -ENOSYS;
 #ifdef REFINE_DEBUG
 	snd_output_printf(log, "refine done - result = %i\n", res);
 	snd_pcm_hw_params_dump(params, log);
@@ -2391,7 +2394,10 @@ int _snd_pcm_hw_params_internal(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 		if (err < 0)
 			return err;
 	}
-	err = pcm->ops->hw_params(pcm->op_arg, params);
+	if (pcm->ops->hw_params)
+		err = pcm->ops->hw_params(pcm->op_arg, params);
+	else
+		err = -ENOSYS;
 	if (err < 0)
 		return err;
 
-- 
2.7.4
