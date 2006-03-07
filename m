From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Properly terminate stream in polypaudio plugin
Date: Tue, 07 Mar 2006 17:43:52 +0100
Message-ID: <440DB848.5020200@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090109030204060001070207"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C6311C3
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 17:43:53 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090109030204060001070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some applications like to call prepare over and over again, recreating 
the stream each time. Previously we just cleaned up the local end each 
time, but this makes sure the server also releases its resources.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------090109030204060001070207
Content-Type: text/x-patch;
 name="alsa-plugins-polyp-kill-stream.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-plugins-polyp-kill-stream.patch"

Index: polyp/pcm_polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/pcm_polyp.c,v
retrieving revision 1.2
diff -u -r1.2 pcm_polyp.c
--- polyp/pcm_polyp.c	22 Feb 2006 15:38:52 -0000	1.2
+++ polyp/pcm_polyp.c	7 Mar 2006 16:41:39 -0000
@@ -335,6 +335,8 @@
         return err;
 
     if (pcm->stream) {
+        pa_stream_disconnect(pcm->stream);
+        polyp_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_TERMINATED);
         pa_stream_unref(pcm->stream);
         pcm->stream = NULL;
     }
@@ -356,18 +358,12 @@
     else
         pa_stream_connect_record(pcm->stream, pcm->device, &pcm->buffer_attr, 0);
 
-    while (1) {
-        state = pa_stream_get_state(pcm->stream);
-
-        if (state == PA_STREAM_FAILED)
-            goto error;
-
-        if (state == PA_STREAM_READY)
-            break;
-
-        err = pa_mainloop_iterate(pcm->p->mainloop, 1, NULL);
-        if (err < 0)
-            return -EIO;
+    err = polyp_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_READY);
+    if (err < 0) {
+        fprintf(stderr, "*** POLYPAUDIO: Unable to create stream.\n");
+        pa_stream_unref(pcm->stream);
+        pcm->stream = NULL;
+        return err;
     }
 
     pcm->last_size = 0;
@@ -375,12 +371,6 @@
     pcm->offset = 0;
 
     return 0;
-
-error:
-    fprintf(stderr, "*** POLYPAUDIO: Unable to create stream.\n");
-    pa_stream_unref(pcm->stream);
-    pcm->stream = NULL;
-    return -EIO;
 }
 
 static int polyp_hw_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
@@ -437,8 +427,11 @@
 
     assert(pcm);
 
-    if (pcm->stream)
+    if (pcm->stream) {
+        pa_stream_disconnect(pcm->stream);
+        polyp_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_TERMINATED);
         pa_stream_unref(pcm->stream);
+    }
 
     if (pcm->p)
         polyp_free(pcm->p);
Index: polyp/polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/polyp.c,v
retrieving revision 1.2
diff -u -r1.2 polyp.c
--- polyp/polyp.c	22 Feb 2006 15:38:52 -0000	1.2
+++ polyp/polyp.c	7 Mar 2006 16:41:39 -0000
@@ -182,6 +182,32 @@
     return 0;
 }
 
+int polyp_wait_stream_state(snd_polyp_t *p, pa_stream *stream, pa_stream_state_t target)
+{
+    int err;
+    pa_stream_state_t state;
+
+    assert(p && stream && (p->state == POLYP_STATE_READY));
+
+    while (1) {
+        state = pa_stream_get_state(stream);
+
+        if (state == PA_STREAM_FAILED)
+            return -EIO;
+
+        if (state == target)
+            break;
+
+        p->state = POLYP_STATE_POLLING;
+        err = pa_mainloop_iterate(p->mainloop, 1, NULL);
+        p->state = POLYP_STATE_READY;
+        if (err < 0)
+            return -EIO;
+    }
+
+    return 0;
+}
+
 snd_polyp_t *polyp_new()
 {
     snd_polyp_t *p;
Index: polyp/polyp.h
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/polyp.h,v
retrieving revision 1.1
diff -u -r1.1 polyp.h
--- polyp/polyp.h	21 Feb 2006 16:14:00 -0000	1.1
+++ polyp/polyp.h	7 Mar 2006 16:41:39 -0000
@@ -48,6 +48,7 @@
 int polyp_check_connection(snd_polyp_t *p);
 
 int polyp_wait_operation(snd_polyp_t *p, pa_operation *o);
+int polyp_wait_stream_state(snd_polyp_t *p, pa_stream *stream, pa_stream_state_t target);
 
 snd_polyp_t *polyp_new();
 void polyp_free(snd_polyp_t *p);

--------------090109030204060001070207--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
