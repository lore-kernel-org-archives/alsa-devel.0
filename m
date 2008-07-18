From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] send both an uncork and a trigger in _start()
Date: Fri, 18 Jul 2008 21:45:47 +0200
Message-ID: <20080718194547.GA1407@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E742456D
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:45:48 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

Here's a patch for alsa-plugins:

When playing very short streams, the pulse plugin needs call
pa_stream_trigger() in snd_pcm_start() to make sure the stream is
actually started, in addition to uncorking the stream.

Lennart

---
 pulse/pcm_pulse.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index efff509..7edd157 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -67,8 +67,8 @@ static void update_ptr(snd_pcm_pulse_t *pcm)
 static int pulse_start(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_pulse_t *pcm = io->private_data;
-	pa_operation *o;
-	int err = 0;
+	pa_operation *o, *u;
+	int err = 0, err_o = 0, err_u = 0;
 
     assert(pcm);
     assert(pcm->p);
@@ -88,11 +88,20 @@ static int pulse_start(snd_pcm_ioplug_t *io)
 	goto finish;
     }
 
-    err = pulse_wait_operation(pcm->p, o);
+    u = pa_stream_trigger(pcm->stream, pulse_stream_success_cb, pcm->p);
+    if (!u) {
+        pa_operation_unref(o);
+	err = -EIO;
+	goto finish;
+    }
+
+    err_o = pulse_wait_operation(pcm->p, o);
+    err_u = pulse_wait_operation(pcm->p, u);
 
     pa_operation_unref(o);
+    pa_operation_unref(u);
 
-    if (err < 0) {
+    if (err_o < 0 || err_u < 0) {
         err = -EIO;
         goto finish;
     } else
@@ -543,7 +552,7 @@ static int pulse_hw_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
 	    break;
 	}
     }
-    
+
     pa_threaded_mainloop_lock(pcm->p->mainloop);
 
     pcm->frame_size = (snd_pcm_format_physical_width(io->format) * io->channels) / 8;
@@ -761,7 +770,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	pcm->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
 		&pulse_playback_callback : &pulse_capture_callback;
 	pcm->io.private_data = pcm;
- 
+
 	err = snd_pcm_ioplug_create(&pcm->io, name, stream, mode);
 	if (err < 0)
 		goto error;
-- 
1.5.6



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
