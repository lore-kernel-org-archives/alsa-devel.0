From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Update Polypaudio plug-in to the 0.9.0 API
Date: Mon, 29 May 2006 09:37:40 +0200
Message-ID: <447AA4C4.2010704@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0781491810=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81019163
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 09:37:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0781491810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3EE4A346F8B0B4117E224D9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3EE4A346F8B0B4117E224D9
Content-Type: multipart/mixed; boundary="------------090703090209000609040805"

This is a multi-part message in MIME format.
--------------090703090209000609040805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The new version of Polypaudio includes a threading abstraction that
allows application of a more synchronous nature to use the API more
easily. Using this, the complexity of the Polypaudio plug-in is greatly
reduced and also removes the risk of stalling the communications layer.

Signed-off-by: Pierre Ossman <ossman@cendio.se>

--------------090703090209000609040805
Content-Type: text/x-patch;
 name="polyp-09.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="polyp-09.patch"

? polyp-09.patch
? polyp-update.patch
? mix/pcm_upmix.loT
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-plugins/configure.in,v
retrieving revision 1.21
diff -u -r1.21 configure.in
--- configure.in	19 Apr 2006 07:41:49 -0000	1.21
+++ configure.in	28 May 2006 14:41:32 -0000
@@ -16,7 +16,7 @@
 PKG_CHECK_MODULES(JACK, jack >=3D 0.98, [HAVE_JACK=3Dyes], [HAVE_JACK=3D=
no])
 AM_CONDITIONAL(HAVE_JACK, test x$HAVE_JACK =3D xyes)
=20
-PKG_CHECK_MODULES(polypaudio, [polyplib], [HAVE_POLYP=3Dyes], [HAVE_POLY=
P=3Dno])
+PKG_CHECK_MODULES(polypaudio, [polyplib >=3D 0.9.0], [HAVE_POLYP=3Dyes],=
 [HAVE_POLYP=3Dno])
 AM_CONDITIONAL(HAVE_POLYP, test x$HAVE_POLYP =3D xyes)
=20
 PKG_CHECK_MODULES(samplerate, [samplerate], [HAVE_SAMPLERATE=3Dyes], [HA=
VE_SAMPLERATE=3Dno])
Index: polyp/ctl_polyp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-plugins/polyp/ctl_polyp.c,v
retrieving revision 1.4
diff -u -r1.4 ctl_polyp.c
--- polyp/ctl_polyp.c	8 Mar 2006 12:23:13 -0000	1.4
+++ polyp/ctl_polyp.c	28 May 2006 14:41:32 -0000
@@ -20,8 +20,6 @@
=20
 #include <sys/poll.h>
=20
-#include <pthread.h>
-
 #include <alsa/asoundlib.h>
 #include <alsa/control_external.h>
=20
@@ -43,8 +41,6 @@
=20
     int subscribed;
     int updated;
-
-    pthread_mutex_t mutex;
 } snd_ctl_polyp_t;
=20
 #define SOURCE_VOL_NAME "Capture Volume"
@@ -62,14 +58,19 @@
     snd_ctl_polyp_t *ctl =3D (snd_ctl_polyp_t*)userdata;
     int chan;
=20
-    if (is_last)
+    assert(ctl);
+
+    if (is_last) {
+        pa_threaded_mainloop_signal(ctl->p->mainloop, 0);
         return;
+    }
=20
-    assert(ctl && i);
+    assert(i);
=20
     if (!!ctl->sink_muted !=3D !!i->mute) {
         ctl->sink_muted =3D i->mute;
         ctl->updated |=3D UPDATE_SINK_MUTE;
+        polyp_poll_activate(ctl->p);
     }
=20
     if (ctl->sink_volume.channels =3D=3D i->volume.channels) {
@@ -81,6 +82,7 @@
             return;
=20
         ctl->updated |=3D UPDATE_SINK_VOL;
+        polyp_poll_activate(ctl->p);
     }
=20
     memcpy(&ctl->sink_volume, &i->volume, sizeof(pa_cvolume));
@@ -91,14 +93,19 @@
     snd_ctl_polyp_t *ctl =3D (snd_ctl_polyp_t*)userdata;
     int chan;
=20
-    if (is_last)
+    assert(ctl);
+
+    if (is_last) {
+        pa_threaded_mainloop_signal(ctl->p->mainloop, 0);
         return;
+    }
=20
-    assert(ctl && i);
+    assert(i);
=20
     if (!!ctl->source_muted !=3D !!i->mute) {
         ctl->source_muted =3D i->mute;
         ctl->updated |=3D UPDATE_SOURCE_MUTE;
+        polyp_poll_activate(ctl->p);
     }
=20
     if (ctl->source_volume.channels =3D=3D i->volume.channels) {
@@ -110,6 +117,7 @@
             return;
=20
         ctl->updated |=3D UPDATE_SOURCE_VOL;
+        polyp_poll_activate(ctl->p);
     }
=20
     memcpy(&ctl->source_volume, &i->volume, sizeof(pa_cvolume));
@@ -163,14 +171,14 @@
=20
     assert(ctl);
=20
-    pthread_mutex_lock(&ctl->mutex);
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     if (ctl->source)
         count +=3D 2;
     if (ctl->sink)
         count +=3D 2;
=20
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return count;
 }
@@ -184,7 +192,7 @@
=20
     snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
=20
-    pthread_mutex_lock(&ctl->mutex);
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     if (ctl->source) {
         if (offset =3D=3D 0)
@@ -194,7 +202,7 @@
     } else
         offset +=3D 2;
=20
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     if (offset =3D=3D 2)
         snd_ctl_elem_id_set_name(id, SINK_VOL_NAME);
@@ -229,18 +237,13 @@
     snd_ctl_polyp_t *ctl =3D ext->private_data;
     int err =3D 0;
=20
-    assert(ctl);
-
     if (key > 3)
         return -EINVAL;
=20
-    pthread_mutex_lock(&ctl->mutex);
-
+    assert(ctl);
     assert(ctl->p);
=20
-    err =3D polyp_finish_poll(ctl->p);
-    if (err < 0)
-        goto finish;
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     err =3D polyp_check_connection(ctl->p);
     if (err < 0)
@@ -265,7 +268,7 @@
         *count =3D 1;
=20
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return err;
 }
@@ -288,14 +291,9 @@
     pa_cvolume *vol =3D NULL;
=20
     assert(ctl);
-
-    pthread_mutex_lock(&ctl->mutex);
-
     assert(ctl->p);
=20
-    err =3D polyp_finish_poll(ctl->p);
-    if (err < 0)
-        goto finish;
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     err =3D polyp_check_connection(ctl->p);
     if (err < 0)
@@ -329,7 +327,7 @@
     }
=20
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return err;
 }
@@ -343,14 +341,9 @@
     pa_cvolume *vol =3D NULL;
=20
     assert(ctl);
-
-    pthread_mutex_lock(&ctl->mutex);
-
     assert(ctl->p && ctl->p->context);
=20
-    err =3D polyp_finish_poll(ctl->p);
-    if (err < 0)
-        goto finish;
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     err =3D polyp_check_connection(ctl->p);
     if (err < 0)
@@ -395,17 +388,17 @@
=20
         if (key =3D=3D 0)
             o =3D pa_context_set_source_volume_by_name(ctl->p->context,
-                ctl->source, vol, NULL, NULL);
+                ctl->source, vol, polyp_context_success_cb, ctl->p);
         else
             o =3D pa_context_set_sink_volume_by_name(ctl->p->context,
-                ctl->sink, vol, NULL, NULL);
+                ctl->sink, vol, polyp_context_success_cb, ctl->p);
     } else {
         if (key =3D=3D 1)
             o =3D pa_context_set_source_mute_by_name(ctl->p->context,
-                ctl->source, ctl->source_muted, NULL, NULL);
+                ctl->source, ctl->source_muted, polyp_context_success_cb=
, ctl->p);
         else
             o =3D pa_context_set_sink_mute_by_name(ctl->p->context,
-                ctl->sink, ctl->sink_muted, NULL, NULL);
+                ctl->sink, ctl->sink_muted, polyp_context_success_cb, ct=
l->p);
     }
=20
     err =3D polyp_wait_operation(ctl->p, o);
@@ -416,7 +409,7 @@
     err =3D 1;
=20
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return err;
 }
@@ -427,11 +420,11 @@
=20
     assert(ctl);
=20
-    pthread_mutex_lock(&ctl->mutex);
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     ctl->subscribed =3D !!(subscribe & SND_CTL_EVENT_MASK_VALUE);
=20
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
 }
=20
 static int polyp_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id,
@@ -443,7 +436,7 @@
=20
     assert(ctl);
=20
-    pthread_mutex_lock(&ctl->mutex);
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
=20
     if (!ctl->updated || !ctl->subscribed)
         goto finish;
@@ -469,10 +462,13 @@
=20
     *event_mask =3D SND_CTL_EVENT_MASK_VALUE;
=20
-    err =3D 0;
+    if (!ctl->updated)
+        polyp_poll_deactivate(ctl->p);
+
+    err =3D 1;
=20
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return err;
 }
@@ -483,14 +479,13 @@
 	int count;
=20
     assert(ctl);
-
-    pthread_mutex_lock(&ctl->mutex);
-
     assert(ctl->p);
=20
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
+
     count =3D polyp_poll_descriptors_count(ctl->p);
=20
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return count;
 }
@@ -502,20 +497,16 @@
 	snd_ctl_polyp_t *ctl =3D ext->private_data;
=20
     assert(ctl);
-
-    pthread_mutex_lock(&ctl->mutex);
-
     assert(ctl->p);
=20
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
+
     num =3D polyp_poll_descriptors(ctl->p, pfd, space);
     if (num < 0)
         goto finish;
=20
-    if (ctl->updated)
-        pa_mainloop_wakeup(ctl->p->mainloop);
-
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return num;
 }
@@ -526,11 +517,10 @@
 	int err =3D 0;
=20
     assert(ctl);
-
-    pthread_mutex_lock(&ctl->mutex);
-
     assert(ctl->p);
=20
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
+
     err =3D polyp_poll_revents(ctl->p, pfd, nfds, revents);
     if (err < 0)
         goto finish;
@@ -541,7 +531,7 @@
         *revents |=3D POLLIN;
=20
 finish:
-    pthread_mutex_unlock(&ctl->mutex);
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
=20
     return err;
 }
@@ -560,8 +550,6 @@
     if (ctl->sink)
         free(ctl->sink);
=20
-    pthread_mutex_destroy(&ctl->mutex);
-
 	free(ctl);
 }
=20
@@ -591,6 +579,8 @@
         ctl->source =3D strdup(i->default_source_name);
     if (i->default_sink_name && !ctl->sink)
         ctl->sink =3D strdup(i->default_sink_name);
+
+    pa_threaded_mainloop_signal(ctl->p->mainloop, 0);
 }
=20
 SND_CTL_PLUGIN_DEFINE_FUNC(polyp)
@@ -603,7 +593,6 @@
 	int err;
 	snd_ctl_polyp_t *ctl;
     pa_operation *o;
-    pthread_mutexattr_t mutexattr;
=20
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n =3D snd_config_iterator_entry(i);
@@ -647,21 +636,15 @@
 	ctl =3D calloc(1, sizeof(*ctl));
=20
     ctl->p =3D polyp_new();
-    assert(ctl->p);
-
-    err =3D polyp_connect(ctl->p, server);
-    if (err < 0)
+    if (!ctl->p) {
+        err =3D -EIO;
         goto error;
+    }
=20
-    err =3D polyp_start_thread(ctl->p);
+    err =3D polyp_connect(ctl->p, server);
     if (err < 0)
         goto error;
=20
-    pthread_mutexattr_init(&mutexattr);
-    pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
-    pthread_mutex_init(&ctl->mutex, &mutexattr);
-    pthread_mutexattr_destroy(&mutexattr);
-
     if (source)
         ctl->source =3D strdup(source);
     else if (device)
@@ -673,19 +656,33 @@
         ctl->sink =3D strdup(device);
=20
     if (!ctl->source || !ctl->sink) {
+        pa_threaded_mainloop_lock(ctl->p->mainloop);
+
         o =3D pa_context_get_server_info(ctl->p->context, server_info_cb=
, ctl);
         err =3D polyp_wait_operation(ctl->p, o);
+
         pa_operation_unref(o);
+
+        pa_threaded_mainloop_unlock(ctl->p->mainloop);
+
         if (err < 0)
             goto error;
     }
=20
+    pa_threaded_mainloop_lock(ctl->p->mainloop);
+
     pa_context_set_subscribe_callback(ctl->p->context, event_cb, ctl);
=20
     o =3D pa_context_subscribe(ctl->p->context,
-        PA_SUBSCRIPTION_MASK_SINK | PA_SUBSCRIPTION_MASK_SOURCE, NULL, N=
ULL);
+        PA_SUBSCRIPTION_MASK_SINK | PA_SUBSCRIPTION_MASK_SOURCE,
+        polyp_context_success_cb, ctl->p);
+
     err =3D polyp_wait_operation(ctl->p, o);
+
     pa_operation_unref(o);
+
+    pa_threaded_mainloop_unlock(ctl->p->mainloop);
+
     if (err < 0)
         goto error;
=20
Index: polyp/pcm_polyp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-plugins/polyp/pcm_polyp.c,v
retrieving revision 1.5
diff -u -r1.5 pcm_polyp.c
--- polyp/pcm_polyp.c	8 Mar 2006 12:23:13 -0000	1.5
+++ polyp/pcm_polyp.c	28 May 2006 14:41:33 -0000
@@ -21,8 +21,6 @@
 #include <stdio.h>
 #include <sys/poll.h>
=20
-#include <pthread.h>
-
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
=20
@@ -46,8 +44,6 @@
     pa_sample_spec ss;
     unsigned int frame_size;
     pa_buffer_attr buffer_attr;
-
-    pthread_mutex_t mutex;
 } snd_pcm_polyp_t;
=20
 static void update_ptr(snd_pcm_polyp_t *pcm)
@@ -74,20 +70,17 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
         goto finish;
=20
-    o =3D pa_stream_cork(pcm->stream, 0, NULL, NULL);
+    o =3D pa_stream_cork(pcm->stream, 0, polyp_stream_success_cb, pcm->p=
);
     assert(o);
=20
     err =3D polyp_wait_operation(pcm->p, o);
@@ -100,7 +93,7 @@
     }
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -112,20 +105,17 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
         goto finish;
=20
-    o =3D pa_stream_flush(pcm->stream, NULL, NULL);
+    o =3D pa_stream_flush(pcm->stream, polyp_stream_success_cb, pcm->p);=

     assert(o);
=20
     err =3D polyp_wait_operation(pcm->p, o);
@@ -137,7 +127,7 @@
         goto finish;
     }
=20
-    o =3D pa_stream_cork(pcm->stream, 1, NULL, NULL);
+    o =3D pa_stream_cork(pcm->stream, 1, polyp_stream_success_cb, pcm->p=
);
     assert(o);
=20
     err =3D polyp_wait_operation(pcm->p, o);
@@ -150,7 +140,7 @@
     }
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -162,20 +152,17 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
         goto finish;
=20
-    o =3D pa_stream_drain(pcm->stream, NULL, NULL);
+    o =3D pa_stream_drain(pcm->stream, polyp_stream_success_cb, pcm->p);=

     assert(o);
=20
     err =3D polyp_wait_operation(pcm->p, o);
@@ -188,7 +175,7 @@
     }
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -199,14 +186,11 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
@@ -214,14 +198,41 @@
=20
     update_ptr(pcm);
=20
-    err =3D polyp_start_poll(pcm->p);
+	err =3D snd_pcm_bytes_to_frames(io->pcm, pcm->ptr);
+
+finish:
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
+
+	return err;
+}
+
+static int polyp_delay(snd_pcm_ioplug_t *io,
+                       snd_pcm_sframes_t *delayp)
+{
+	snd_pcm_polyp_t *pcm =3D io->private_data;
+	int err =3D 0;
+	pa_usec_t lat;
+
+    assert(pcm);
+    assert(pcm->p);
+
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
+
+    assert(pcm->stream);
+
+    err =3D polyp_check_connection(pcm->p);
     if (err < 0)
         goto finish;
=20
-	err =3D snd_pcm_bytes_to_frames(io->pcm, pcm->ptr);
+	if (pa_stream_get_latency(pcm->stream, &lat, NULL)) {
+		err =3D -EIO;
+		goto finish;
+	}
+
+	*delayp =3D snd_pcm_bytes_to_frames(io->pcm, pa_usec_to_bytes(lat, &pcm=
->ss));
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -236,14 +247,11 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
@@ -261,10 +269,13 @@
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
=20
+    if (pcm->last_size < pcm->buffer_attr.minreq)
+        polyp_poll_deactivate(pcm->p);
+
     err =3D size;
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -280,14 +291,11 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
-
-    assert(pcm->p && pcm->stream);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    assert(pcm->stream);
=20
     err =3D polyp_check_connection(pcm->p);
     if (err < 0)
@@ -325,28 +333,40 @@
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
=20
+    if (pcm->last_size < pcm->buffer_attr.minreq)
+        polyp_poll_deactivate(pcm->p);
+
     err =3D size - (remain_size / pcm->frame_size);
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
=20
+static void stream_request_cb(pa_stream *p, size_t length, void *userdat=
a)
+{
+    snd_pcm_polyp_t *pcm =3D userdata;
+
+    assert(pcm);
+    assert(pcm->p);
+
+    polyp_poll_activate(pcm->p);
+}
+
 static int polyp_pcm_poll_descriptors_count(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_polyp_t *pcm =3D io->private_data;
 	int count;
=20
     assert(pcm);
-
-    pthread_mutex_lock(&pcm->mutex);
-
     assert(pcm->p);
=20
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
+
     count =3D polyp_poll_descriptors_count(pcm->p);
=20
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return count;
 }
@@ -357,14 +377,13 @@
 	int err;
=20
     assert(pcm);
-
-    pthread_mutex_lock(&pcm->mutex);
-
     assert(pcm->p);
=20
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
+
     err =3D polyp_poll_descriptors(pcm->p, pfd, space);
=20
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -375,11 +394,10 @@
 	int err =3D 0;
=20
     assert(pcm);
-
-    pthread_mutex_lock(&pcm->mutex);
-
     assert(pcm->p);
=20
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
+
     err =3D polyp_poll_revents(pcm->p, pfd, nfds, revents);
     if (err < 0)
         goto finish;
@@ -402,25 +420,21 @@
     }
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
=20
 static int polyp_prepare(snd_pcm_ioplug_t *io)
 {
+    pa_channel_map map;
     snd_pcm_polyp_t *pcm =3D io->private_data;
     int err =3D 0;
=20
     assert(pcm);
-
-    pthread_mutex_lock(&pcm->mutex);
-
     assert(pcm->p);
=20
-    err =3D polyp_finish_poll(pcm->p);
-    if (err < 0)
-        goto finish;
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
     if (pcm->stream) {
         pa_stream_disconnect(pcm->stream);
@@ -436,15 +450,24 @@
     assert(pcm->stream =3D=3D NULL);
=20
     if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK)
-        pcm->stream =3D pa_stream_new(pcm->p->context, "ALSA Playback", =
&pcm->ss, NULL);
+        pcm->stream =3D pa_stream_new(pcm->p->context, "ALSA Playback", =
&pcm->ss,
+            pa_channel_map_init_auto(&map, pcm->ss.channels, PA_CHANNEL_=
MAP_ALSA));
     else
-        pcm->stream =3D pa_stream_new(pcm->p->context, "ALSA Capture", &=
pcm->ss, NULL);
+        pcm->stream =3D pa_stream_new(pcm->p->context, "ALSA Capture", &=
pcm->ss,
+            pa_channel_map_init_auto(&map, pcm->ss.channels, PA_CHANNEL_=
MAP_ALSA));
     assert(pcm->stream);
=20
-    if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK)
-        pa_stream_connect_playback(pcm->stream, pcm->device, &pcm->buffe=
r_attr, 0, NULL, NULL);
-    else
-        pa_stream_connect_record(pcm->stream, pcm->device, &pcm->buffer_=
attr, 0);
+    pa_stream_set_state_callback(pcm->stream, polyp_stream_state_cb, pcm=
->p);
+
+    if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK) {
+        pa_stream_set_write_callback(pcm->stream, stream_request_cb, pcm=
);
+        pa_stream_connect_playback(pcm->stream, pcm->device, &pcm->buffe=
r_attr,
+        	PA_STREAM_AUTO_TIMING_UPDATE | PA_STREAM_INTERPOLATE_TIMING, NU=
LL, NULL);
+    } else {
+        pa_stream_set_read_callback(pcm->stream, stream_request_cb, pcm)=
;
+        pa_stream_connect_record(pcm->stream, pcm->device, &pcm->buffer_=
attr,
+	        PA_STREAM_AUTO_TIMING_UPDATE | PA_STREAM_INTERPOLATE_TIMING);
+    }
=20
     err =3D polyp_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_READY=
);
     if (err < 0) {
@@ -459,7 +482,7 @@
     pcm->offset =3D 0;
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -470,10 +493,11 @@
 	int err =3D 0;
=20
     assert(pcm);
+    assert(pcm->p);
=20
-    pthread_mutex_lock(&pcm->mutex);
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
=20
-    assert(pcm->p && !pcm->stream);
+    assert(!pcm->stream);
=20
     pcm->frame_size =3D (snd_pcm_format_physical_width(io->format) * io-=
>channels) / 8;
=20
@@ -516,7 +540,7 @@
     pcm->buffer_attr.fragsize =3D io->period_size * pcm->frame_size;
=20
 finish:
-    pthread_mutex_unlock(&pcm->mutex);
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
=20
 	return err;
 }
@@ -527,51 +551,55 @@
=20
     assert(pcm);
=20
+    pa_threaded_mainloop_lock(pcm->p->mainloop);
+
     if (pcm->stream) {
         pa_stream_disconnect(pcm->stream);
         polyp_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_TERMINATE=
D);
         pa_stream_unref(pcm->stream);
     }
=20
+    pa_threaded_mainloop_unlock(pcm->p->mainloop);
+
     if (pcm->p)
         polyp_free(pcm->p);
=20
     if (pcm->device)
         free(pcm->device);
=20
-    pthread_mutex_destroy(&pcm->mutex);
-
 	free(pcm);
=20
 	return 0;
 }
=20
 static snd_pcm_ioplug_callback_t polyp_playback_callback =3D {
-	.start =3D polyp_start,
-	.stop =3D polyp_stop,
+    .start =3D polyp_start,
+    .stop =3D polyp_stop,
     .drain =3D polyp_drain,
-	.pointer =3D polyp_pointer,
-	.transfer =3D polyp_write,
+    .pointer =3D polyp_pointer,
+    .transfer =3D polyp_write,
+    .delay =3D polyp_delay,
     .poll_descriptors_count =3D polyp_pcm_poll_descriptors_count,
     .poll_descriptors =3D polyp_pcm_poll_descriptors,
     .poll_revents =3D polyp_pcm_poll_revents,
-	.prepare =3D polyp_prepare,
-	.hw_params =3D polyp_hw_params,
-	.close =3D polyp_close,
+    .prepare =3D polyp_prepare,
+    .hw_params =3D polyp_hw_params,
+    .close =3D polyp_close,
 };
=20
=20
 static snd_pcm_ioplug_callback_t polyp_capture_callback =3D {
-	.start =3D polyp_start,
-	.stop =3D polyp_stop,
-	.pointer =3D polyp_pointer,
-	.transfer =3D polyp_read,
+    .start =3D polyp_start,
+    .stop =3D polyp_stop,
+    .pointer =3D polyp_pointer,
+    .transfer =3D polyp_read,
+    .delay =3D polyp_delay,
     .poll_descriptors_count =3D polyp_pcm_poll_descriptors_count,
     .poll_descriptors =3D polyp_pcm_poll_descriptors,
     .poll_revents =3D polyp_pcm_poll_revents,
-	.prepare =3D polyp_prepare,
-	.hw_params =3D polyp_hw_params,
-	.close =3D polyp_close,
+    .prepare =3D polyp_prepare,
+    .hw_params =3D polyp_hw_params,
+    .close =3D polyp_close,
 };
=20
=20
@@ -645,7 +673,6 @@
 	const char *device =3D NULL;
 	int err;
 	snd_pcm_polyp_t *pcm;
-    pthread_mutexattr_t mutexattr;
=20
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n =3D snd_config_iterator_entry(i);
@@ -678,21 +705,15 @@
         pcm->device =3D strdup(device);
=20
     pcm->p =3D polyp_new();
-    assert(pcm->p);
-
-    err =3D polyp_connect(pcm->p, server);
-    if (err < 0)
+    if (!pcm->p) {
+        err =3D -EIO;
         goto error;
+    }
=20
-    err =3D polyp_start_thread(pcm->p);
+    err =3D polyp_connect(pcm->p, server);
     if (err < 0)
         goto error;
=20
-    pthread_mutexattr_init(&mutexattr);
-    pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
-    pthread_mutex_init(&pcm->mutex, &mutexattr);
-    pthread_mutexattr_destroy(&mutexattr);
-
 	pcm->io.version =3D SND_PCM_IOPLUG_VERSION;
 	pcm->io.name =3D "ALSA <-> Polypaudio PCM I/O Plugin";
 	pcm->io.poll_fd =3D -1;
Index: polyp/polyp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-plugins/polyp/polyp.c,v
retrieving revision 1.4
diff -u -r1.4 polyp.c
--- polyp/polyp.c	8 Mar 2006 12:23:13 -0000	1.4
+++ polyp/polyp.c	28 May 2006 14:41:33 -0000
@@ -19,177 +19,71 @@
  */
=20
 #include <stdio.h>
+#include <unistd.h>
 #include <signal.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-
-#include <pthread.h>
+#include <sys/poll.h>
=20
 #include "polyp.h"
=20
-enum {
-    COMMAND_POLL =3D 'p',
-    COMMAND_QUIT =3D 'q',
-    COMMAND_POLL_DONE =3D 'P',
-    COMMAND_POLL_FAILED =3D 'F',
-};
-
-static int write_command(snd_polyp_t *p, char command)
-{
-    if (write(p->main_fd, &command, 1) !=3D 1)
-        return -errno;
-    return 0;
-}
-
-static int write_reply(snd_polyp_t *p, char reply)
-{
-    if (write(p->thread_fd, &reply, 1) !=3D 1)
-        return -errno;
-    return 0;
-}
-
-static int read_command(snd_polyp_t *p)
-{
-    char command;
-
-    if (read(p->thread_fd, &command, 1) !=3D 1)
-        return -errno;
-
-    return command;
-}
-
-static int read_reply(snd_polyp_t *p)
-{
-    char reply;
-
-    if (read(p->main_fd, &reply, 1) !=3D 1)
-        return -errno;
-
-    return reply;
-}
-
-static void* thread_func(void *data)
+int polyp_check_connection(snd_polyp_t *p)
 {
-    snd_polyp_t *p =3D (snd_polyp_t*)data;
-    sigset_t mask;
-    char command;
-    int ret;
+    pa_context_state_t state;
=20
-    sigfillset(&mask);
-    pthread_sigmask(SIG_BLOCK, &mask, NULL);
+    assert(p && p->context && p->mainloop);
=20
-    do {
-        command =3D read_command(p);
-        if (command < 0)
-            break;
-
-        switch (command) {
-        case COMMAND_POLL:
-            do {
-                ret =3D pa_mainloop_poll(p->mainloop);
-            } while ((ret < 0) && (errno =3D=3D EINTR));
-
-            ret =3D write_reply(p, (ret < 0) ? COMMAND_POLL_FAILED : COM=
MAND_POLL_DONE);
-            if (ret < 0)
-                return NULL;
+    state =3D pa_context_get_state(p->context);
=20
-            break;
-        }
-    } while (command !=3D COMMAND_QUIT);
+    if (state !=3D PA_CONTEXT_READY)
+        return -EIO;
=20
-    return NULL;
+    return 0;
 }
=20
-int polyp_start_poll(snd_polyp_t *p)
+void polyp_stream_state_cb(pa_stream *s, void * userdata)
 {
-    int err;
+    snd_polyp_t *p =3D userdata;
=20
+    assert(s);
     assert(p);
=20
-    if (p->state =3D=3D POLYP_STATE_POLLING)
-        return 0;
-
-    assert(p->state =3D=3D POLYP_STATE_READY);
-
-    err =3D pa_mainloop_prepare(p->mainloop, -1);
-    if (err < 0)
-        return err;
-
-    err =3D write_command(p, COMMAND_POLL);
-    if (err < 0)
-        return err;
-
-    p->state =3D POLYP_STATE_POLLING;
-
-    return 0;
+    pa_threaded_mainloop_signal(p->mainloop, 0);
 }
=20
-int polyp_finish_poll(snd_polyp_t *p)
+void polyp_stream_success_cb(pa_stream *s, int success, void *userdata)
 {
-	char reply;
-	int err;
+    snd_polyp_t *p =3D userdata;
=20
+    assert(s);
     assert(p);
=20
-    if (p->state =3D=3D POLYP_STATE_READY)
-        return 0;
-
-    assert(p->state =3D=3D POLYP_STATE_POLLING);
-
-    p->state =3D POLYP_STATE_READY;
-
-    pa_mainloop_wakeup(p->mainloop);
-
-    reply =3D read_reply(p);
-
-    if (reply =3D=3D COMMAND_POLL_DONE) {
-        err =3D pa_mainloop_dispatch(p->mainloop);
-        if (err < 0)
-            return err;
-    } else
-        return -EIO;
-
-    return 0;
+    pa_threaded_mainloop_signal(p->mainloop, 0);
 }
=20
-int polyp_check_connection(snd_polyp_t *p)
+void polyp_context_success_cb(pa_context *c, int success, void *userdata=
)
 {
-    pa_context_state_t state;
+    snd_polyp_t *p =3D userdata;
=20
-    assert(p && p->context);
-
-    state =3D pa_context_get_state(p->context);
-
-    if (state !=3D PA_CONTEXT_READY)
-        return -EIO;
+    assert(c);
+    assert(p);
=20
-    return 0;
+    pa_threaded_mainloop_signal(p->mainloop, 0);
 }
=20
 int polyp_wait_operation(snd_polyp_t *p, pa_operation *o)
 {
-    int err;
+    assert(p && o && (p->state =3D=3D POLYP_STATE_READY) && p->mainloop)=
;
=20
-    assert(p && o && (p->state =3D=3D POLYP_STATE_READY));
-
-    while (pa_operation_get_state(o) =3D=3D PA_OPERATION_RUNNING) {
-        p->state =3D POLYP_STATE_POLLING;
-        err =3D pa_mainloop_iterate(p->mainloop, 1, NULL);
-        p->state =3D POLYP_STATE_READY;
-        if (err < 0)
-            return err;
-    }
+    while (pa_operation_get_state(o) =3D=3D PA_OPERATION_RUNNING)
+        pa_threaded_mainloop_wait(p->mainloop);
=20
     return 0;
 }
=20
 int polyp_wait_stream_state(snd_polyp_t *p, pa_stream *stream, pa_stream=
_state_t target)
 {
-    int err;
     pa_stream_state_t state;
=20
-    assert(p && stream && (p->state =3D=3D POLYP_STATE_READY));
+    assert(p && stream && (p->state =3D=3D POLYP_STATE_READY) && p->main=
loop);
=20
     while (1) {
         state =3D pa_stream_get_state(stream);
@@ -200,34 +94,72 @@
         if (state =3D=3D target)
             break;
=20
-        p->state =3D POLYP_STATE_POLLING;
-        err =3D pa_mainloop_iterate(p->mainloop, 1, NULL);
-        p->state =3D POLYP_STATE_READY;
-        if (err < 0)
-            return -EIO;
+        pa_threaded_mainloop_wait(p->mainloop);
     }
=20
     return 0;
 }
=20
+static void context_state_cb(pa_context *c, void *userdata) {
+    snd_polyp_t *p =3D userdata;
+    assert(c);
+
+    switch (pa_context_get_state(c)) {
+        case PA_CONTEXT_READY:
+        case PA_CONTEXT_TERMINATED:
+        case PA_CONTEXT_FAILED:
+            pa_threaded_mainloop_signal(p->mainloop, 0);
+            break;
+
+        case PA_CONTEXT_UNCONNECTED:
+        case PA_CONTEXT_CONNECTING:
+        case PA_CONTEXT_AUTHORIZING:
+        case PA_CONTEXT_SETTING_NAME:
+            break;
+    }
+}
+
 snd_polyp_t *polyp_new()
 {
     snd_polyp_t *p;
+	int fd[2] =3D { -1, -1 };
+	char proc[PATH_MAX], buf[PATH_MAX + 20];
=20
     p =3D calloc(1, sizeof(snd_polyp_t));
     assert(p);
=20
     p->state =3D POLYP_STATE_INIT;
=20
-    p->main_fd =3D -1;
-    p->thread_fd =3D -1;
-    p->thread_running =3D 0;
+    if (pipe(fd)) {
+        free(p);
+        return NULL;
+    }
+
+    p->main_fd =3D fd[0];
+    p->thread_fd =3D fd[1];
+
+    fcntl(fd[0], F_SETFL, O_NONBLOCK);
+    fcntl(fd[1], F_SETFL, O_NONBLOCK);
+
+    signal(SIGPIPE, SIG_IGN); /* Yes, ugly as hell */
=20
-    p->mainloop =3D pa_mainloop_new();
+    p->mainloop =3D pa_threaded_mainloop_new();
     assert(p->mainloop);
=20
-    p->context =3D pa_context_new(pa_mainloop_get_api(p->mainloop),
-        "ALSA Plugin");
+    if (pa_threaded_mainloop_start(p->mainloop) < 0) {
+        pa_threaded_mainloop_free(p->mainloop);
+        close(fd[0]);
+        close(fd[1]);
+        free(p);
+        return NULL;
+    }
+
+    if (pa_get_binary_name(proc, sizeof(proc)))
+        snprintf(buf, sizeof(buf), "ALSA plug-in [%s]", pa_path_get_file=
name(proc));
+    else
+        snprintf(buf, sizeof(buf), "ALSA plug-in");
+
+    p->context =3D pa_context_new(pa_threaded_mainloop_get_api(p->mainlo=
op), buf);
     assert(p->context);
=20
     return p;
@@ -235,22 +167,13 @@
=20
 void polyp_free(snd_polyp_t *p)
 {
-    if (p->thread_running) {
-        assert(p->mainloop && p->thread);
-        write_command(p, COMMAND_QUIT);
-        pa_mainloop_wakeup(p->mainloop);
-        pthread_join(p->thread, NULL);
-    }
+    pa_threaded_mainloop_stop(p->mainloop);
=20
-    if (p->context)
-        pa_context_unref(p->context);
-    if (p->mainloop)
-        pa_mainloop_free(p->mainloop);
+    pa_context_unref(p->context);
+    pa_threaded_mainloop_free(p->mainloop);
=20
-    if (p->thread_fd >=3D 0)
-        close(p->thread_fd);
-    if (p->main_fd >=3D 0)
-        close(p->main_fd);
+    close(p->thread_fd);
+    close(p->main_fd);
=20
     free(p);
 }
@@ -258,70 +181,52 @@
 int polyp_connect(snd_polyp_t *p, const char *server)
 {
     int err;
-    pa_context_state_t state;
=20
     assert(p && p->context && p->mainloop && (p->state =3D=3D POLYP_STAT=
E_INIT));
=20
+    pa_threaded_mainloop_lock(p->mainloop);
+
     err =3D pa_context_connect(p->context, server, 0, NULL);
     if (err < 0)
         goto error;
=20
-    while (1) {
-        state =3D pa_context_get_state(p->context);
+    pa_context_set_state_callback(p->context, context_state_cb, p);
=20
-        if (state =3D=3D PA_CONTEXT_FAILED)
-            goto error;
+    pa_threaded_mainloop_wait(p->mainloop);
=20
-        if (state =3D=3D PA_CONTEXT_READY)
-            break;
+    if (pa_context_get_state(p->context) !=3D PA_CONTEXT_READY)
+        goto error;
=20
-        err =3D pa_mainloop_iterate(p->mainloop, 1, NULL);
-        if (err < 0)
-            return -EIO;
-    }
+    pa_threaded_mainloop_unlock(p->mainloop);
=20
-    p->state =3D POLYP_STATE_CONNECTED;
+    p->state =3D POLYP_STATE_READY;
=20
     return 0;
=20
 error:
     fprintf(stderr, "*** POLYPAUDIO: Unable to connect: %s\n",
         pa_strerror(pa_context_errno(p->context)));
+
+    pa_threaded_mainloop_unlock(p->mainloop);
+
     return -ECONNREFUSED;
 }
=20
-int polyp_start_thread(snd_polyp_t *p)
+void polyp_poll_activate(snd_polyp_t *p)
 {
-    int err;
-	int fd[2] =3D { -1, -1 };
-
-    assert(p && (p->state =3D=3D POLYP_STATE_CONNECTED));
-
-    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) < 0) {
-        perror("socketpair()");
-        return -errno;
-    }
-
-    p->thread_fd =3D fd[0];
-    p->main_fd =3D fd[1];
-
-    p->thread_running =3D 0;
+    assert(p);
=20
-    err =3D pthread_create(&p->thread, NULL, thread_func, p);
-    if (err) {
-        SNDERR("pthread_create(): %s", strerror(err));
-        close(fd[0]);
-        close(fd[1]);
-        p->main_fd =3D -1;
-        p->thread_fd =3D -1;
-        return -err;
-    }
+    write(p->thread_fd, "a", 1);
+}
=20
-    p->thread_running =3D 1;
+void polyp_poll_deactivate(snd_polyp_t *p)
+{
+	char buf[10];
=20
-    p->state =3D POLYP_STATE_READY;
+	assert(p);
=20
-    return 0;
+    /* Drain the pipe */
+    while (read(p->main_fd, buf, sizeof(buf)) > 0);
 }
=20
 int polyp_poll_descriptors_count(snd_polyp_t *p)
@@ -336,22 +241,12 @@
=20
 int polyp_poll_descriptors(snd_polyp_t *p, struct pollfd *pfd, unsigned =
int space)
 {
-	int err;
-
     assert(p);
=20
-    err =3D polyp_finish_poll(p);
-    if (err < 0)
-        return err;
-
-    err =3D polyp_start_poll(p);
-    if (err < 0)
-        return err;
-
     assert(space >=3D 1);
=20
     pfd[0].fd =3D p->main_fd;
-    pfd[0].events =3D POLL_IN;
+    pfd[0].events =3D POLLIN;
     pfd[0].revents =3D 0;
=20
     return 1;
@@ -359,20 +254,7 @@
=20
 int polyp_poll_revents(snd_polyp_t *p, struct pollfd *pfd, unsigned int =
nfds, unsigned short *revents)
 {
-	int err;
-
     assert(p);
=20
-    err =3D polyp_finish_poll(p);
-    if (err < 0)
-        return err;
-
-    err =3D polyp_check_connection(p);
-    if (err < 0)
-        return err;
-
-    /*
-     * The application might redo the poll immediatly.
-     */
-    return polyp_poll_descriptors(p, pfd, nfds);
+    return 1;
 }
Index: polyp/polyp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-plugins/polyp/polyp.h,v
retrieving revision 1.2
diff -u -r1.2 polyp.h
--- polyp/polyp.h	8 Mar 2006 12:16:51 -0000	1.2
+++ polyp/polyp.h	28 May 2006 14:41:33 -0000
@@ -21,32 +21,27 @@
 #include <alsa/asoundlib.h>
=20
 #include <polyp/polypaudio.h>
-#include <polyp/mainloop.h>
=20
 #define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))
=20
 typedef struct snd_polyp {
-    pa_mainloop *mainloop;
+    pa_threaded_mainloop *mainloop;
     pa_context *context;
=20
     int thread_fd, main_fd;
=20
-    pthread_t thread;
-    int thread_running;
-
     enum {
         POLYP_STATE_INIT,
-        POLYP_STATE_CONNECTED,
         POLYP_STATE_READY,
-        POLYP_STATE_POLLING,
     } state;
 } snd_polyp_t;
=20
-int polyp_start_poll(snd_polyp_t *p);
-int polyp_finish_poll(snd_polyp_t *p);
-
 int polyp_check_connection(snd_polyp_t *p);
=20
+void polyp_stream_state_cb(pa_stream *s, void * userdata);
+void polyp_stream_success_cb(pa_stream *s, int success, void *userdata);=

+void polyp_context_success_cb(pa_context *c, int success, void *userdata=
);
+
 int polyp_wait_operation(snd_polyp_t *p, pa_operation *o);
 int polyp_wait_stream_state(snd_polyp_t *p, pa_stream *stream, pa_stream=
_state_t target);
=20
@@ -54,8 +49,9 @@
 void polyp_free(snd_polyp_t *p);
=20
 int polyp_connect(snd_polyp_t *p, const char *server);
-int polyp_start_thread(snd_polyp_t *p);
=20
+void polyp_poll_activate(snd_polyp_t *p);
+void polyp_poll_deactivate(snd_polyp_t *p);
 int polyp_poll_descriptors_count(snd_polyp_t *p);
 int polyp_poll_descriptors(snd_polyp_t *p, struct pollfd *pfd, unsigned =
int space);
 int polyp_poll_revents(snd_polyp_t *p, struct pollfd *pfd, unsigned int =
nfds, unsigned short *revents);

--------------090703090209000609040805--

--------------enigD3EE4A346F8B0B4117E224D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeqTI7b8eESbyJLgRAkgiAKDAPQTkTcxSeSzWPhRPvUqGzGC3yACfcfHN
jKD2UlLtLFH26oCQ3rJHu/c=
=7J0l
-----END PGP SIGNATURE-----

--------------enigD3EE4A346F8B0B4117E224D9--


--===============0781491810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0781491810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0781491810==--
