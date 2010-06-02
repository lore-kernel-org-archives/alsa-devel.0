From: John Lindgren <john.lindgren@tds.net>
Subject: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Wed, 02 Jun 2010 17:29:36 -0400
Message-ID: <1275514176.8032.42.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D32C1039F8
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 23:29:43 +0200 (CEST)
Received: by wyg36 with SMTP id 36so1250233wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 14:29:41 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

In a multi-threaded application it is possible for snd_pcm_delay or an
equivalent function to be called by one thread while another is sitting
in snd_pcm_writei.  In this case, snd_pcm_delay does not take into
account that there may not be enough space for all the data passed to
snd_pcm_writei to be written to the ring buffer at once, and will return
incorrect values.

To illustrate:

Suppose a sound card has a maximum buffer size of 0.1 second.  Then,
suppose an application writes 0.5 second of audio.  snd_pcm_writei will
immediately write the first 0.1 second to the ring buffer, then will
incrementally write the remaining 0.4 second as the buffer drains.
During this time, snd_pcm_delay will return a constant fill level of 0.1
second.  On the application side, the playback time counter will be
calculated during this time as 0.5 seconds written to ALSA minus a delay
of 0.1 second, giving a constant stream position of 0.4 second.

(This problem showed up when a recent change in Audacious caused it to
call snd_pcm_writei with larger chunks of audio than formerly -- the
result was that the visualization, which is synchronized with the time
counter, began to jump, where it should be a smooth 30 FPS animation.)

The problem is a little tough to fix, since there must be some thread
semantics involved so that the thread calling snd_pcm_delay knows at
what instant snd_pcm_delay will begin taking into account the data
passed to snd_pcm_writei.  My solution is to create a variant of
snd_pcm_writei ("snd_pcm_writei_locked"), which is the passed the
additional argument of a pointer to a mutex locked in advance by the
caller.  snd_pcm_writei_locked will then unlock the mutex once the
application can safely assume that snd_pcm_delay will take into account
the new data.

I realize this is a substantial change, so please tell me whether this
patch is along the right track or if a different solution is called for.

Signed-off-by: John Lindgren <john.lindgren@tds.net>
---

 include/pcm.h       |    8 +++++
 src/pcm/pcm.c       |   76 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/pcm/pcm_hw.c    |   39 +++++++++++++++++++++++++-
 src/pcm/pcm_local.h |    3 ++
 4 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index f3618c3..2234279 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -33,6 +33,10 @@
 extern "C" {
 #endif
 
+#include <pthread.h>
+
+#define SND_PCM_HAVE_LOCKED_WRITE
+
 /**
  *  \defgroup PCM PCM Interface
  *  See the \ref pcm page for more details.
@@ -448,8 +452,12 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
 snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm);
 snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
 snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_writei_locked (snd_pcm_t * pcm, const void * buffer,
+ snd_pcm_uframes_t size, pthread_mutex_t * mutex);
 snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size);
 snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_writen_locked (snd_pcm_t * pcm, void * * bufs,
+ snd_pcm_uframes_t size, pthread_mutex_t * mutex);
 snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
 int snd_pcm_wait(snd_pcm_t *pcm, int timeout);
 
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index f910189..db03067 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -903,8 +903,12 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
  */
 int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
 {
-	assert(pcm && status);
-	return pcm->fast_ops->status(pcm->fast_op_arg, status);
+	int result;
+
+ 	assert(pcm && status);
+	result = pcm->fast_ops->status (pcm->fast_op_arg, status);
+	status->delay += pcm->fast_op_arg->write_delay;
+	return result;
 }
 
 /**
@@ -973,12 +977,17 @@ link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider
  */
 int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
+	int result;
+
 	assert(pcm);
 	if (CHECK_SANITY(! pcm->setup)) {
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	return pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
+
+	result = pcm->fast_ops->delay (pcm->fast_op_arg, delayp);
+	* delayp += pcm->fast_op_arg->write_delay;
+	return result;
 }
 
 /**
@@ -1248,6 +1257,34 @@ snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_ufr
 }
 
 /**
+ * \brief Variant of snd_pcm_writei for multithreaded applications
+ * \param mutex Mutex already locked by caller
+ *
+ * In a multithreaded application, there is uncertainty inherent in calling
+ * snd_pcm_delay while another thread is calling and_pcm_writei, since there is
+ * no way to know whether the data passed to snd_pcm_writei has yet been
+ * accounted for in the delay calculation.  This function provides a solution to
+ * that problem by unlocking the mutex when it is safe to call snd_pcm_delay.
+ * The mutex is locked again before the function returns.  An application using
+ * this function should be careful to avoid deadlocks.
+ *
+ * Programmers should check that the macro SND_PCM_HAVE_LOCKED_WRITE is defined
+ * before using this function.
+ */
+
+snd_pcm_sframes_t snd_pcm_writei_locked (snd_pcm_t * pcm, const void * buffer,
+ snd_pcm_uframes_t size, pthread_mutex_t * mutex)
+{
+	snd_pcm_sframes_t result;
+
+	assert (pcm && pcm->fast_op_arg && ! pcm->fast_op_arg->write_mutex);
+	pcm->fast_op_arg->write_mutex = mutex;
+	result = snd_pcm_writei (pcm, buffer, size);
+	pcm->fast_op_arg->write_mutex = NULL;
+	return result;
+}
+
+/**
  * \brief Write non interleaved frames to a PCM
  * \param pcm PCM handle
  * \param bufs frames containing buffers (one for each channel)
@@ -1280,6 +1317,25 @@ snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t
 }
 
 /**
+ * \brief Variant of snd_pcm_writen for multithreaded applications
+ * \param Mutex already locked by caller
+ *
+ * (See snd_pcm_writei_locked for a full description.)
+ */
+
+snd_pcm_sframes_t snd_pcm_writen_locked (snd_pcm_t * pcm, void * * bufs,
+ snd_pcm_uframes_t size, pthread_mutex_t * mutex)
+{
+	snd_pcm_sframes_t result;
+
+	assert (pcm && pcm->fast_op_arg && ! pcm->fast_op_arg->write_mutex);
+	pcm->fast_op_arg->write_mutex = mutex;
+	result = snd_pcm_writen (pcm, bufs, size);
+	pcm->fast_op_arg->write_mutex = NULL;
+	return result;
+}
+
+/**
  * \brief Read interleaved frames from a PCM
  * \param pcm PCM handle
  * \param buffer frames containing buffer
@@ -2480,6 +2536,7 @@ int snd_pcm_avail_delay(snd_pcm_t *pcm,
 	sf = pcm->fast_ops->delay(pcm->fast_op_arg, delayp);
 	if (sf < 0)
 		return (int)sf;
+	* delayp += pcm->fast_op_arg->write_delay;
 	sf = pcm->fast_ops->avail_update(pcm->fast_op_arg);
 	if (sf < 0)
 		return (int)sf;
@@ -6652,7 +6709,18 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 				goto _end;
 			}
 
-			err = snd_pcm_wait(pcm, -1);
+			if (pcm->write_mutex) {
+				pcm->write_delay = size;
+				assert (! pthread_mutex_unlock (pcm->write_mutex));
+			}
+
+ 			err = snd_pcm_wait(pcm, -1);
+
+			if (pcm->write_mutex) {
+				assert (! pthread_mutex_lock (pcm->write_mutex));
+				pcm->write_delay = 0;
+			}
+
 			if (err < 0)
 				break;
 			goto _again;			
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 9d243d5..6a428d8 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -753,7 +753,8 @@ static int snd_pcm_hw_unlink(snd_pcm_t *pcm)
 	return 0;
 }
 
-static snd_pcm_sframes_t snd_pcm_hw_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
+static snd_pcm_sframes_t writei_real (snd_pcm_t * pcm, const void * buffer,
+ snd_pcm_uframes_t size)
 {
 	int err;
 	snd_pcm_hw_t *hw = pcm->private_data;
@@ -772,6 +773,42 @@ static snd_pcm_sframes_t snd_pcm_hw_writei(snd_pcm_t *pcm, const void *buffer, s
 	return xferi.result;
 }
 
+static snd_pcm_sframes_t snd_pcm_hw_writei (snd_pcm_t * pcm, const void *
+ buffer, snd_pcm_uframes_t size)
+{
+	snd_pcm_sframes_t remain = size;
+	snd_pcm_sframes_t result;
+
+	while (1) {
+		if ((result = snd_pcm_hw_avail_update (pcm)) < 0)
+			return result;
+		if ((result = writei_real (pcm, buffer, result < remain ? result :
+		 remain)) < 0)
+			return result;
+
+		buffer = (const char *) buffer + snd_pcm_frames_to_bytes (pcm, result);
+		remain -= result;
+
+		if (! remain)
+			return size;
+
+		if (pcm->write_mutex) {
+			pcm->write_delay = remain;
+			assert (! pthread_mutex_unlock (pcm->write_mutex));
+		}
+
+		result = snd_pcm_wait (pcm, -1);
+
+		if (pcm->write_mutex) {
+			assert (! pthread_mutex_lock (pcm->write_mutex));
+			pcm->write_delay = 0;
+		}
+
+		if (result < 0)
+			return result;
+	}
+}
+
 static snd_pcm_sframes_t snd_pcm_hw_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	int err;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 9aa81e1..53eef78 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -229,6 +229,9 @@ struct _snd_pcm {
 	snd_pcm_t *fast_op_arg;
 	void *private_data;
 	struct list_head async_handlers;
+	snd_pcm_uframes_t write_delay;  /* size of data passed to snd_pcm_write*
+	                                 * but not yet outputted to ring buffer */
+	pthread_mutex_t * write_mutex;  /* mutex passed to snd_pcm_write*_locked */
 };
 
 /* make local functions really local */
