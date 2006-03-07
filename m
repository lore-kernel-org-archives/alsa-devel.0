From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Make polypaudio plugin thread safe
Date: Tue, 07 Mar 2006 18:44:11 +0100
Message-ID: <440DC66B.9080109@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040704070402090700030402"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C07C51B8
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 18:44:13 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040704070402090700030402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add a mutex to make sure that the Polypaudio plugin is thread safe.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------040704070402090700030402
Content-Type: text/x-patch;
 name="alsa-plugins-polyp-thread-safe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-plugins-polyp-thread-safe.patch"

diff -up polyp.orig/ctl_polyp.c polyp/ctl_polyp.c
--- polyp.orig/ctl_polyp.c	2006-02-27 20:25:38.000000000 +0100
+++ polyp/ctl_polyp.c	2006-03-07 18:35:50.000000000 +0100
@@ -20,6 +20,8 @@
 
 #include <sys/poll.h>
 
+#include <pthread.h>
+
 #include <alsa/asoundlib.h>
 #include <alsa/control_external.h>
 
@@ -41,6 +43,8 @@ typedef struct snd_ctl_polyp {
 
     int subscribed;
     int updated;
+
+    pthread_mutex_t mutex;
 } snd_ctl_polyp_t;
 
 #define SOURCE_VOL_NAME "Capture Volume"
@@ -159,11 +163,15 @@ static int polyp_elem_count(snd_ctl_ext_
 
     assert(ctl);
 
+    pthread_mutex_lock(&ctl->mutex);
+
     if (ctl->source)
         count += 2;
     if (ctl->sink)
         count += 2;
 
+    pthread_mutex_unlock(&ctl->mutex);
+
     return count;
 }
 
@@ -176,6 +184,8 @@ static int polyp_elem_list(snd_ctl_ext_t
 
     snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
 
+    pthread_mutex_lock(&ctl->mutex);
+
     if (ctl->source) {
         if (offset == 0)
             snd_ctl_elem_id_set_name(id, SOURCE_VOL_NAME);
@@ -184,6 +194,8 @@ static int polyp_elem_list(snd_ctl_ext_t
     } else
         offset += 2;
 
+    pthread_mutex_unlock(&ctl->mutex);
+
     if (offset == 2)
         snd_ctl_elem_id_set_name(id, SINK_VOL_NAME);
     else if (offset == 3)
@@ -215,24 +227,28 @@ static int polyp_get_attribute(snd_ctl_e
     int *type, unsigned int *acc, unsigned int *count)
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
-    int err;
+    int err = 0;
 
-    assert(ctl && ctl->p);
+    assert(ctl);
 
     if (key > 3)
         return -EINVAL;
 
+    pthread_mutex_lock(&ctl->mutex);
+
+    assert(ctl->p);
+
     err = polyp_finish_poll(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_update_volume(ctl);
     if (err < 0)
-        return err;
+        goto finish;
 
     if (key & 1)
         *type = SND_CTL_ELEM_TYPE_BOOLEAN;
@@ -248,7 +264,10 @@ static int polyp_get_attribute(snd_ctl_e
     else
         *count = 1;
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
+    return err;
 }
 
 static int polyp_get_integer_info(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
@@ -265,22 +284,26 @@ static int polyp_read_integer(snd_ctl_ex
     long *value)
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
-    int err, i;
+    int err = 0, i;
     pa_cvolume *vol = NULL;
 
-    assert(ctl && ctl->p);
+    assert(ctl);
+
+    pthread_mutex_lock(&ctl->mutex);
+
+    assert(ctl->p);
 
     err = polyp_finish_poll(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_update_volume(ctl);
     if (err < 0)
-        return err;
+        goto finish;
 
     switch (key) {
     case 0:
@@ -296,7 +319,8 @@ static int polyp_read_integer(snd_ctl_ex
         *value = !ctl->sink_muted;
         break;
     default:
-        return -EINVAL;
+        err = -EINVAL;
+        goto finish;
     }
 
     if (vol) {
@@ -304,30 +328,37 @@ static int polyp_read_integer(snd_ctl_ex
             value[i] = vol->values[i];
     }
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
+    return err;
 }
 
 static int polyp_write_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
     long *value)
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
-    int err, i;
+    int err = 0, i;
     pa_operation *o;
     pa_cvolume *vol = NULL;
 
-    assert(ctl && ctl->p && ctl->p->context);
+    assert(ctl);
+
+    pthread_mutex_lock(&ctl->mutex);
+
+    assert(ctl->p && ctl->p->context);
 
     err = polyp_finish_poll(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(ctl->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_update_volume(ctl);
     if (err < 0)
-        return err;
+        goto finish;
 
     switch (key) {
     case 0:
@@ -335,7 +366,7 @@ static int polyp_write_integer(snd_ctl_e
         break;
     case 1:
         if (!!ctl->source_muted == !*value)
-            return 0;
+            goto finish;
         ctl->source_muted = !*value;
         break;
     case 2:
@@ -343,11 +374,12 @@ static int polyp_write_integer(snd_ctl_e
         break;
     case 3:
         if (!!ctl->sink_muted == !*value)
-            return 0;
+            goto finish;
         ctl->sink_muted = !*value;
         break;
     default:
-        return -EINVAL;
+        err = -EINVAL;
+        goto finish;
     }
 
     if (vol) {
@@ -356,7 +388,7 @@ static int polyp_write_integer(snd_ctl_e
                 break;
 
         if (i == vol->channels)
-            return 0;
+            goto finish;
 
         for (i = 0;i < vol->channels;i++)
             vol->values[i] = value[i];
@@ -379,9 +411,14 @@ static int polyp_write_integer(snd_ctl_e
     err = polyp_wait_operation(ctl->p, o);
     pa_operation_unref(o);
     if (err < 0)
-        return err;
+        goto finish;
+
+    err = 1;
 
-    return 1;
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
+    return err;
 }
 
 static void polyp_subscribe_events(snd_ctl_ext_t *ext, int subscribe)
@@ -390,7 +427,11 @@ static void polyp_subscribe_events(snd_c
 
     assert(ctl);
 
+    pthread_mutex_lock(&ctl->mutex);
+
     ctl->subscribed = !!(subscribe & SND_CTL_EVENT_MASK_VALUE);
+
+    pthread_mutex_unlock(&ctl->mutex);
 }
 
 static int polyp_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id,
@@ -398,11 +439,14 @@ static int polyp_read_event(snd_ctl_ext_
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
     int offset;
+    int err = -EAGAIN;
 
     assert(ctl);
 
+    pthread_mutex_lock(&ctl->mutex);
+
     if (!ctl->updated || !ctl->subscribed)
-        return -EAGAIN;
+        goto finish;
 
     if (ctl->source)
         offset = 2;
@@ -425,16 +469,30 @@ static int polyp_read_event(snd_ctl_ext_
 
     *event_mask = SND_CTL_EVENT_MASK_VALUE;
 
-    return 1;
+    err = 0;
+
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
+    return err;
 }
 
 static int polyp_ctl_poll_descriptors_count(snd_ctl_ext_t *ext)
 {
 	snd_ctl_polyp_t *ctl = ext->private_data;
+	int count;
+
+    assert(ctl);
+
+    pthread_mutex_lock(&ctl->mutex);
+
+    assert(ctl->p);
+
+    count = polyp_poll_descriptors_count(ctl->p);
 
-    assert(ctl && ctl->p);
+    pthread_mutex_unlock(&ctl->mutex);
 
-    return polyp_poll_descriptors_count(ctl->p);
+    return count;
 }
 
 static int polyp_ctl_poll_descriptors(snd_ctl_ext_t *ext, struct pollfd *pfd, unsigned int space)
@@ -443,35 +501,49 @@ static int polyp_ctl_poll_descriptors(sn
 
 	snd_ctl_polyp_t *ctl = ext->private_data;
 
-    assert(ctl && ctl->p);
+    assert(ctl);
+
+    pthread_mutex_lock(&ctl->mutex);
+
+    assert(ctl->p);
 
     num = polyp_poll_descriptors(ctl->p, pfd, space);
     if (num < 0)
-        return num;
+        goto finish;
 
     if (ctl->updated)
         pa_mainloop_wakeup(ctl->p->mainloop);
 
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
     return num;
 }
 
 static int polyp_ctl_poll_revents(snd_ctl_ext_t *ext, struct pollfd *pfd, unsigned int nfds, unsigned short *revents)
 {
 	snd_ctl_polyp_t *ctl = ext->private_data;
-	int err;
+	int err = 0;
+
+    assert(ctl);
+
+    pthread_mutex_lock(&ctl->mutex);
 
-    assert(ctl && ctl->p);
+    assert(ctl->p);
 
     err = polyp_poll_revents(ctl->p, pfd, nfds, revents);
     if (err < 0)
-        return err;
+        goto finish;
 
     *revents = 0;
 
     if (ctl->updated)
         *revents |= POLLIN;
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&ctl->mutex);
+
+    return err;
 }
 
 static void polyp_close(snd_ctl_ext_t *ext)
@@ -488,6 +560,8 @@ static void polyp_close(snd_ctl_ext_t *e
     if (ctl->sink)
         free(ctl->sink);
 
+    pthread_mutex_destroy(&ctl->mutex);
+
 	free(ctl);
 }
 
@@ -529,6 +603,7 @@ SND_CTL_PLUGIN_DEFINE_FUNC(polyp)
 	int err;
 	snd_ctl_polyp_t *ctl;
     pa_operation *o;
+    pthread_mutexattr_t mutexattr;
 
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -582,6 +657,11 @@ SND_CTL_PLUGIN_DEFINE_FUNC(polyp)
     if (err < 0)
         goto error;
 
+    pthread_mutexattr_init(&mutexattr);
+    pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
+    pthread_mutex_init(&ctl->mutex, &mutexattr);
+    pthread_mutexattr_destroy(&mutexattr);
+
     if (source)
         ctl->source = strdup(source);
     else if (device)
Common subdirectories: polyp.orig/CVS and polyp/CVS
Only in polyp: .deps
Only in polyp: Makefile
Only in polyp: Makefile.in
diff -up polyp.orig/pcm_polyp.c polyp/pcm_polyp.c
--- polyp.orig/pcm_polyp.c	2006-03-07 18:39:00.000000000 +0100
+++ polyp/pcm_polyp.c	2006-03-07 18:42:13.000000000 +0100
@@ -21,6 +21,8 @@
 #include <stdio.h>
 #include <sys/poll.h>
 
+#include <pthread.h>
+
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
@@ -44,6 +46,8 @@ typedef struct snd_pcm_polyp {
     pa_sample_spec ss;
     unsigned int frame_size;
     pa_buffer_attr buffer_attr;
+
+    pthread_mutex_t mutex;
 } snd_pcm_polyp_t;
 
 static void update_ptr(snd_pcm_polyp_t *pcm)
@@ -67,17 +71,21 @@ static int polyp_start(snd_pcm_ioplug_t 
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
 	pa_operation *o;
-	int err;
+	int err = 0;
 
-    assert(pcm && pcm->p && pcm->stream);
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     o = pa_stream_cork(pcm->stream, 0, NULL, NULL);
     assert(o);
@@ -86,27 +94,36 @@ static int polyp_start(snd_pcm_ioplug_t 
 
     pa_operation_unref(o);
 
-    if (err < 0)
-        return -EIO;
+    if (err < 0) {
+        err = -EIO;
+        goto finish;
+    }
 
-	return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_stop(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
 	pa_operation *o;
-	int err;
+	int err = 0;
+
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
 
-    assert(pcm && pcm->p && pcm->stream);
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     o = pa_stream_flush(pcm->stream, NULL, NULL);
     assert(o);
@@ -115,8 +132,10 @@ static int polyp_stop(snd_pcm_ioplug_t *
 
     pa_operation_unref(o);
 
-    if (err < 0)
-        return -EIO;
+    if (err < 0) {
+        err = -EIO;
+        goto finish;
+    }
 
     o = pa_stream_cork(pcm->stream, 1, NULL, NULL);
     assert(o);
@@ -125,27 +144,36 @@ static int polyp_stop(snd_pcm_ioplug_t *
 
     pa_operation_unref(o);
 
-    if (err < 0)
-        return -EIO;
+    if (err < 0) {
+        err = -EIO;
+        goto finish;
+    }
 
-	return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 int polyp_drain(snd_pcm_ioplug_t *io)
 {
     snd_pcm_polyp_t *pcm = io->private_data;
 	pa_operation *o;
-	int err;
+	int err = 0;
+
+    assert(pcm);
 
-    assert(pcm && pcm->p && pcm->stream);
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     o = pa_stream_drain(pcm->stream, NULL, NULL);
     assert(o);
@@ -154,34 +182,48 @@ int polyp_drain(snd_pcm_ioplug_t *io)
 
     pa_operation_unref(o);
 
-    if (err < 0)
-        return -EIO;
+    if (err < 0) {
+        err = -EIO;
+        goto finish;
+    }
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static snd_pcm_sframes_t polyp_pointer(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
-	int err;
+	int err = 0;
 
-    assert(pcm && pcm->p && pcm->stream);
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     update_ptr(pcm);
 
     err = polyp_start_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
+
+	err = snd_pcm_bytes_to_frames(io->pcm, pcm->ptr);
 
-	return snd_pcm_bytes_to_frames(io->pcm, pcm->ptr);
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static snd_pcm_sframes_t polyp_write(snd_pcm_ioplug_t *io,
@@ -191,17 +233,21 @@ static snd_pcm_sframes_t polyp_write(snd
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
 	const char *buf;
-	int err;
+	int err = 0;
 
-    assert(pcm && pcm->p && pcm->stream);
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
@@ -215,7 +261,12 @@ static snd_pcm_sframes_t polyp_write(snd
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
 
-    return size;
+    err = size;
+
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static snd_pcm_sframes_t polyp_read(snd_pcm_ioplug_t *io,
@@ -226,17 +277,21 @@ static snd_pcm_sframes_t polyp_read(snd_
 	snd_pcm_polyp_t *pcm = io->private_data;
 	void *dst_buf, *src_buf;
 	size_t remain_size, frag_length;
-	int err;
+	int err = 0;
+
+    assert(pcm);
 
-    assert(pcm && pcm->p && pcm->stream);
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && pcm->stream);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
@@ -270,37 +325,64 @@ static snd_pcm_sframes_t polyp_read(snd_
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
 
-    return size - (remain_size / pcm->frame_size);
+    err = size - (remain_size / pcm->frame_size);
+
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_pcm_poll_descriptors_count(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
+	int count;
+
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p);
 
-    assert(pcm && pcm->p);
+    count = polyp_poll_descriptors_count(pcm->p);
 
-    return polyp_poll_descriptors_count(pcm->p);
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return count;
 }
 
 static int polyp_pcm_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd, unsigned int space)
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
+	int err;
+
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p);
 
-    assert(pcm && pcm->p);
+    err = polyp_poll_descriptors(pcm->p, pfd, space);
 
-    return polyp_poll_descriptors(pcm->p, pfd, space);
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_pcm_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd, unsigned int nfds, unsigned short *revents)
 {
 	snd_pcm_polyp_t *pcm = io->private_data;
-	int err;
+	int err = 0;
 
-    assert(pcm && pcm->p);
+    assert(pcm);
+
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p);
 
     err = polyp_poll_revents(pcm->p, pfd, nfds, revents);
     if (err < 0)
-        return err;
+        goto finish;
 
     *revents = 0;
 
@@ -319,20 +401,26 @@ static int polyp_pcm_poll_revents(snd_pc
             *revents |= POLLIN;
     }
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_prepare(snd_pcm_ioplug_t *io)
 {
     snd_pcm_polyp_t *pcm = io->private_data;
-    int err;
-    pa_stream_state_t state;
+    int err = 0;
+
+    assert(pcm);
 
-    assert(pcm && pcm->p);
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p);
 
     err = polyp_finish_poll(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     if (pcm->stream) {
         pa_stream_disconnect(pcm->stream);
@@ -343,7 +431,7 @@ static int polyp_prepare(snd_pcm_ioplug_
 
     err = polyp_check_connection(pcm->p);
     if (err < 0)
-        return err;
+        goto finish;
 
     assert(pcm->stream == NULL);
 
@@ -363,21 +451,29 @@ static int polyp_prepare(snd_pcm_ioplug_
         fprintf(stderr, "*** POLYPAUDIO: Unable to create stream.\n");
         pa_stream_unref(pcm->stream);
         pcm->stream = NULL;
-        return err;
+        goto finish;
     }
 
     pcm->last_size = 0;
     pcm->ptr = 0;
     pcm->offset = 0;
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_hw_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
 {
     snd_pcm_polyp_t *pcm = io->private_data;
+	int err = 0;
+
+    assert(pcm);
 
-    assert(pcm && pcm->p && !pcm->stream);
+    pthread_mutex_lock(&pcm->mutex);
+
+    assert(pcm->p && !pcm->stream);
 
     pcm->frame_size = (snd_pcm_format_physical_width(io->format) * io->channels) / 8;
 
@@ -406,7 +502,8 @@ static int polyp_hw_params(snd_pcm_ioplu
     default:
         fprintf(stderr, "*** POLYPAUDIO: unsupported format %s\n",
             snd_pcm_format_name(io->format));
-        return -EINVAL;
+        err = -EINVAL;
+        goto finish;
     }
 
     pcm->ss.rate = io->rate;
@@ -418,7 +515,10 @@ static int polyp_hw_params(snd_pcm_ioplu
     pcm->buffer_attr.minreq = io->period_size * pcm->frame_size;
     pcm->buffer_attr.fragsize = io->period_size * pcm->frame_size;
 
-    return 0;
+finish:
+    pthread_mutex_unlock(&pcm->mutex);
+
+	return err;
 }
 
 static int polyp_close(snd_pcm_ioplug_t *io)
@@ -439,6 +539,8 @@ static int polyp_close(snd_pcm_ioplug_t 
     if (pcm->device)
         free(pcm->device);
 
+    pthread_mutex_destroy(&pcm->mutex);
+
 	free(pcm);
 
 	return 0;
@@ -543,6 +645,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(polyp)
 	const char *device = NULL;
 	int err;
 	snd_pcm_polyp_t *pcm;
+    pthread_mutexattr_t mutexattr;
 
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -585,6 +688,11 @@ SND_PCM_PLUGIN_DEFINE_FUNC(polyp)
     if (err < 0)
         goto error;
 
+    pthread_mutexattr_init(&mutexattr);
+    pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
+    pthread_mutex_init(&pcm->mutex, &mutexattr);
+    pthread_mutexattr_destroy(&mutexattr);
+
 	pcm->io.version = SND_PCM_IOPLUG_VERSION;
 	pcm->io.name = "ALSA <-> Polypaudio PCM I/O Plugin";
 	pcm->io.poll_fd = -1;
diff -up polyp.orig/polyp.c polyp/polyp.c
--- polyp.orig/polyp.c	2006-03-07 18:39:00.000000000 +0100
+++ polyp/polyp.c	2006-03-07 17:28:02.000000000 +0100
@@ -174,7 +174,9 @@ int polyp_wait_operation(snd_polyp_t *p,
     assert(p && o && (p->state == POLYP_STATE_READY));
 
     while (pa_operation_get_state(o) == PA_OPERATION_RUNNING) {
+        p->state = POLYP_STATE_POLLING;
         err = pa_mainloop_iterate(p->mainloop, 1, NULL);
+        p->state = POLYP_STATE_READY;
         if (err < 0)
             return err;
     }

--------------040704070402090700030402--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
