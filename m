From: Mads Kiilerich <mads@kiilerich.com>
Subject: [PATCH] Update pcm doc strings
Date: Thu, 12 Nov 2009 13:09:04 -0000
Message-ID: <b17ca10ac8915e27c5bd.1258031344@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 055C4103803
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 14:09:24 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so581415eyh.16
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 05:09:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

# HG changeset patch
# User Mads Kiilerich <mads@kiilerich.com>
# Date 1258031300 -3600
# Node ID b17ca10ac8915e27c5bd11a448b3b2e25d31278f
# Parent  b8245aff2e583f9efe80bb5aa8f4c53917b76c9a
Update pcm doc strings

This is information I needed and is based on my understanding of information
from Takashi Iwai.

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -168,17 +168,17 @@
 the operation.
 
 \par SND_PCM_STATE_RUNNING
-The PCM device is running. It processes the samples. The stream can
+The PCM device has been started and is running. It processes the samples. The stream can
 be stopped using the #snd_pcm_drop() or
-#snd_pcm_drain calls.
+#snd_pcm_drain() calls.
 
 \par SND_PCM_STATE_XRUN
 The PCM device reached overrun (capture) or underrun (playback).
 You can use the -EPIPE return code from I/O functions
 (#snd_pcm_writei(), #snd_pcm_writen(), #snd_pcm_readi(), #snd_pcm_readn())
 to determine this state without checking
-the actual state via #snd_pcm_state() call. You can recover from
-this state with #snd_pcm_prepare(),
+the actual state via #snd_pcm_state() call. It is recommended to use
+the helper function #snd_pcm_recover() to recover from this state, but you can also use #snd_pcm_prepare(),
 #snd_pcm_drop() or #snd_pcm_drain() calls.
 
 \par SND_PCM_STATE_DRAINING
@@ -1226,9 +1226,9 @@
  * \retval -EPIPE an underrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
  *
- * If the blocking behaviour is selected, then routine waits until
- * all requested bytes are played or put to the playback ring buffer.
- * The count of bytes can be less only if a signal or underrun occurred.
+ * If the blocking behaviour is selected and it is running, then routine waits until
+ * all requested frames are played or put to the playback ring buffer.
+ * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
  */ 
@@ -1258,9 +1258,9 @@
  * \retval -EPIPE an underrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
  *
- * If the blocking behaviour is selected, then routine waits until
- * all requested bytes are played or put to the playback ring buffer.
- * The count of bytes can be less only if a signal or underrun occurred.
+ * If the blocking behaviour is selected and it is running, then routine waits until
+ * all requested frames are played or put to the playback ring buffer.
+ * The returned number of frames can be less only if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
  */ 
@@ -1290,8 +1290,8 @@
  * \retval -EPIPE an overrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
  *
- * If the blocking behaviour was selected, then routine waits until
- * all requested bytes are filled. The count of bytes can be less only
+ * If the blocking behaviour was selected and it is running, then routine waits until
+ * all requested frames are filled. The returned number of frames can be less only
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
@@ -1322,8 +1322,8 @@
  * \retval -EPIPE an overrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
  *
- * If the blocking behaviour was selected, then routine waits until
- * all requested bytes are filled. The count of bytes can be less only
+ * If the blocking behaviour was selected and it is running, then routine waits until
+ * all requested frames are filled. The returned number of frames can be less only
  * if a signal or underrun occurred.
  *
  * If the non-blocking behaviour is selected, then routine doesn't wait at all.
@@ -7211,6 +7211,8 @@
  * \param silent do not print error reason
  * \return 0 when error code was handled successfuly, otherwise a negative error code
  *
+ * This a high-level helper function building on other functions.
+ *
  * This functions handles -EINTR (interrupted system call),
  * -EPIPE (overrun or underrun) and -ESTRPIPE (stream is suspended)
  * error codes trying to prepare given stream for next I/O.
