From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 2/6] pulse: move a couple of PCM related
	functions from	pulse.c to pcm_pulse.c
Date: Tue, 4 Aug 2009 23:54:24 +0200
Message-ID: <20090804215424.GA4814@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C9D1D103803
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:54:24 +0200 (CEST)
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

A number of functions in pulse.c are only relevant for the PCM handling,
so let's move them to pcm_pulse.c. This allows us to simplify their
argument lists a bit.
---
 pulse/pcm_pulse.c |  118 ++++++++++++++++++++++++++++++++++++++++++----------
 pulse/pulse.c     |   55 -------------------------
 pulse/pulse.h     |    4 --
 3 files changed, 95 insertions(+), 82 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 24347f9..a625f55 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -49,6 +49,32 @@ typedef struct snd_pcm_pulse {
 	pa_buffer_attr buffer_attr;
 } snd_pcm_pulse_t;
 
+static int check_stream(snd_pcm_pulse_t *pcm)
+{
+	int err;
+	pa_stream_state_t state;
+
+	assert(pcm);
+
+	if (!pcm->p)
+		return -EBADFD;
+
+	err = pulse_check_connection(pcm->p);
+	if (err < 0)
+		return err;
+
+	if (!pcm->stream)
+		return -EBADFD;
+
+	state = pa_stream_get_state(pcm->stream);
+	if (!PA_STREAM_IS_GOOD(state))
+		return -EIO;
+
+	err = 0;
+
+	return err;
+}
+
 static int update_ptr(snd_pcm_pulse_t *pcm)
 {
 	size_t size;
@@ -118,9 +144,53 @@ static int update_active(snd_pcm_pulse_t *pcm) {
 	else
 		pulse_poll_deactivate(pcm->p);
 
+	return ret;
+}
+
+static int wait_stream_state(snd_pcm_pulse_t *pcm, pa_stream_state_t target)
+{
+	pa_stream_state_t state;
+
+	assert(pcm);
+
+	if (!pcm->p)
+		return -EBADFD;
+
+	for (;;) {
+		int err;
+
+		err = pulse_check_connection(pcm->p);
+		if (err < 0)
+			return err;
+
+		if (!pcm->stream)
+			return -EBADFD;
+
+		state = pa_stream_get_state(pcm->stream);
+		if (state == target)
+			break;
+
+		if (!PA_STREAM_IS_GOOD(state))
+			return -EIO;
+
+		pa_threaded_mainloop_wait(pcm->p->mainloop);
+	}
+
 	return 0;
 }
 
+static void stream_success_cb(pa_stream * p, int success, void *userdata)
+{
+	snd_pcm_pulse_t *pcm = userdata;
+
+	assert(pcm);
+
+	if (!pcm->p)
+		return;
+
+	pa_threaded_mainloop_signal(pcm->p->mainloop, 0);
+}
+
 static int pulse_start(snd_pcm_ioplug_t * io)
 {
 	snd_pcm_pulse_t *pcm = io->private_data;
@@ -138,18 +208,13 @@ static int pulse_start(snd_pcm_ioplug_t * io)
 	if (err < 0)
 		goto finish;
 
-	if (pcm->stream == NULL)
-		goto finish;
-
-	o = pa_stream_cork(pcm->stream, 0, pulse_stream_success_cb,
-			   pcm->p);
+	o = pa_stream_cork(pcm->stream, 0, stream_success_cb, pcm);
 	if (!o) {
 		err = -EIO;
 		goto finish;
 	}
 
-	u = pa_stream_trigger(pcm->stream, pulse_stream_success_cb,
-			      pcm->p);
+	u = pa_stream_trigger(pcm->stream, stream_success_cb, pcm);
 
 	pcm->underrun = 0;
 	err_o = pulse_wait_operation(pcm->p, o);
@@ -165,7 +230,6 @@ static int pulse_start(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
-
 finish:
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
 
@@ -189,18 +253,13 @@ static int pulse_stop(snd_pcm_ioplug_t * io)
 	if (err < 0)
 		goto finish;
 
-	if (pcm->stream == NULL)
-		goto finish;
-
-	o = pa_stream_cork(pcm->stream, 1, pulse_stream_success_cb,
-			   pcm->p);
+	o = pa_stream_cork(pcm->stream, 1, stream_success_cb, pcm);
 	if (!o) {
 		err = -EIO;
 		goto finish;
 	}
 
-	u = pa_stream_flush(pcm->stream, pulse_stream_success_cb,
-			    pcm->p);
+	u = pa_stream_flush(pcm->stream, stream_success_cb, pcm);
 	if (!u) {
 		pa_operation_unref(o);
 		err = -EIO;
@@ -241,7 +300,7 @@ static int pulse_drain(snd_pcm_ioplug_t * io)
 	if (err < 0)
 		goto finish;
 
-	o = pa_stream_drain(pcm->stream, pulse_stream_success_cb, pcm->p);
+	o = pa_stream_drain(pcm->stream, stream_success_cb, pcm);
 	if (!o) {
 		err = -EIO;
 		goto finish;
@@ -504,6 +563,23 @@ finish:
 	return ret;
 }
 
+static void stream_state_cb(pa_stream * p, void *userdata)
+{
+	snd_pcm_pulse_t *pcm = userdata;
+	pa_stream_state_t state;
+
+	assert(pcm);
+
+	if (!pcm->p)
+		return;
+
+	state = pa_stream_get_state(p);
+	if (!PA_STREAM_IS_GOOD(state))
+		pulse_poll_activate(pcm->p);
+
+	pa_threaded_mainloop_signal(pcm->p->mainloop, 0);
+}
+
 static void stream_request_cb(pa_stream * p, size_t length, void *userdata)
 {
 	snd_pcm_pulse_t *pcm = userdata;
@@ -586,8 +662,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 
 	if (pcm->stream) {
 		pa_stream_disconnect(pcm->stream);
-		pulse_wait_stream_state(pcm->p, pcm->stream,
-					PA_STREAM_TERMINATED);
+		wait_stream_state(pcm, PA_STREAM_TERMINATED);
 		pa_stream_unref(pcm->stream);
 		pcm->stream = NULL;
 	}
@@ -620,9 +695,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
-	pa_stream_set_state_callback(pcm->stream, pulse_stream_state_cb,
-				     pcm->p);
-
+	pa_stream_set_state_callback(pcm->stream, stream_state_cb, pcm);
 	pa_stream_set_latency_update_callback(pcm->stream, stream_latency_cb, pcm);
 
 	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
@@ -659,8 +732,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
-	err =
-	    pulse_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_READY);
+	err = wait_stream_state(pcm, PA_STREAM_READY);
 	if (err < 0) {
 		SNDERR("PulseAudio: Unable to create stream: %s\n", pa_strerror(pa_context_errno(pcm->p->context)));
 		pa_stream_unref(pcm->stream);
diff --git a/pulse/pulse.c b/pulse/pulse.c
index 6f58a7e..c313182 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -44,26 +44,6 @@ int pulse_check_connection(snd_pulse_t * p)
 	return 0;
 }
 
-void pulse_stream_state_cb(pa_stream * s, void *userdata)
-{
-	snd_pulse_t *p = userdata;
-
-	assert(s);
-	assert(p);
-
-	pa_threaded_mainloop_signal(p->mainloop, 0);
-}
-
-void pulse_stream_success_cb(pa_stream * s, int success, void *userdata)
-{
-	snd_pulse_t *p = userdata;
-
-	assert(s);
-	assert(p);
-
-	pa_threaded_mainloop_signal(p->mainloop, 0);
-}
-
 void pulse_context_success_cb(pa_context * c, int success, void *userdata)
 {
 	snd_pulse_t *p = userdata;
@@ -101,41 +81,6 @@ int pulse_wait_operation(snd_pulse_t * p, pa_operation * o)
 	return 0;
 }
 
-int pulse_wait_stream_state(snd_pulse_t * p, pa_stream * stream,
-			    pa_stream_state_t target)
-{
-	pa_stream_state_t state;
-
-	assert(p);
-	assert(stream);
-
-	if (p->state != PULSE_STATE_READY)
-		return -EBADFD;
-
-	if (!p->mainloop)
-		return -EBADFD;
-
-	for (;;) {
-		int err;
-
-		err = pulse_check_connection(p);
-		if (err < 0)
-			return err;
-
-		state = pa_stream_get_state(stream);
-
-		if (state == target)
-			break;
-
-		if (!PA_STREAM_IS_GOOD(state))
-			return -EIO;
-
-		pa_threaded_mainloop_wait(p->mainloop);
-	}
-
-	return 0;
-}
-
 static void context_state_cb(pa_context * c, void *userdata)
 {
 	snd_pulse_t *p = userdata;
diff --git a/pulse/pulse.h b/pulse/pulse.h
index 7bf1a5b..51f9a11 100644
--- a/pulse/pulse.h
+++ b/pulse/pulse.h
@@ -41,13 +41,9 @@ typedef struct snd_pulse {
 
 int pulse_check_connection(snd_pulse_t * p);
 
-void pulse_stream_state_cb(pa_stream * s, void *userdata);
-void pulse_stream_success_cb(pa_stream * s, int success, void *userdata);
 void pulse_context_success_cb(pa_context * c, int success, void *userdata);
 
 int pulse_wait_operation(snd_pulse_t * p, pa_operation * o);
-int pulse_wait_stream_state(snd_pulse_t * p, pa_stream * stream,
-			    pa_stream_state_t target);
 
 snd_pulse_t *pulse_new(void);
 void pulse_free(snd_pulse_t * p);
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
