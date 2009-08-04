From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 4/6] pulse: unify stream/context state checks
Date: Tue, 4 Aug 2009 23:55:05 +0200
Message-ID: <20090804215505.GA4874@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 17681103810
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:55:06 +0200 (CEST)
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

Unify (and simplify) the paths that check for the validity of a
stream/context: always call into check_stream()/pulse_check_connection()
when applicable instead of rolling our own checks each time. Also check
for validity of mainloop before locking it.
---
 pulse/ctl_pulse.c |   72 ++++++++++++++++++++++++++++++++----------
 pulse/pcm_pulse.c |   90 +++++++++++++++++++++++-----------------------------
 2 files changed, 95 insertions(+), 67 deletions(-)

diff --git a/pulse/ctl_pulse.c b/pulse/ctl_pulse.c
index 2caa29b..879f260 100644
--- a/pulse/ctl_pulse.c
+++ b/pulse/ctl_pulse.c
@@ -150,9 +150,13 @@ static int pulse_update_volume(snd_ctl_pulse_t * ctl)
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p)
 		return -EBADFD;
 
+	err = pulse_check_connection(ctl->p);
+	if (err < 0)
+		return err;
+
 	o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->sink,
 					     sink_info_cb, ctl);
 	if (o) {
@@ -182,17 +186,27 @@ static int pulse_update_volume(snd_ctl_pulse_t * ctl)
 static int pulse_elem_count(snd_ctl_ext_t * ext)
 {
 	snd_ctl_pulse_t *ctl = ext->private_data;
-	int count = 0;
+	int count = 0, err;
 
 	assert(ctl);
 
+	if (!ctl->p || !ctl->p->mainloop)
+		return -EBADFD;
+
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
+	err = pulse_check_connection(ctl->p);
+	if (err < 0) {
+		count = err;
+		goto finish;
+	}
+
 	if (ctl->source)
 		count += 2;
 	if (ctl->sink)
 		count += 2;
 
+finish:
 	pa_threaded_mainloop_unlock(ctl->p->mainloop);
 
 	return count;
@@ -202,16 +216,21 @@ static int pulse_elem_list(snd_ctl_ext_t * ext, unsigned int offset,
 			   snd_ctl_elem_id_t * id)
 {
 	snd_ctl_pulse_t *ctl = ext->private_data;
+	int err;
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
+	err = pulse_check_connection(ctl->p);
+	if (err < 0)
+		goto finish;
+
 	if (ctl->source) {
 		if (offset == 0)
 			snd_ctl_elem_id_set_name(id, SOURCE_VOL_NAME);
@@ -220,14 +239,19 @@ static int pulse_elem_list(snd_ctl_ext_t * ext, unsigned int offset,
 	} else
 		offset += 2;
 
+	err = 0;
+
+finish:
 	pa_threaded_mainloop_unlock(ctl->p->mainloop);
 
-	if (offset == 2)
-		snd_ctl_elem_id_set_name(id, SINK_VOL_NAME);
-	else if (offset == 3)
-		snd_ctl_elem_id_set_name(id, SINK_MUTE_NAME);
+	if (err >= 0) {
+		if (offset == 2)
+			snd_ctl_elem_id_set_name(id, SINK_VOL_NAME);
+		else if (offset == 3)
+			snd_ctl_elem_id_set_name(id, SINK_MUTE_NAME);
+	}
 
-	return 0;
+	return err;
 }
 
 static snd_ctl_ext_key_t pulse_find_elem(snd_ctl_ext_t * ext,
@@ -266,7 +290,7 @@ static int pulse_get_attribute(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
@@ -319,7 +343,7 @@ static int pulse_read_integer(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
@@ -371,7 +395,7 @@ static int pulse_write_integer(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
@@ -476,7 +500,7 @@ static void pulse_subscribe_events(snd_ctl_ext_t * ext, int subscribe)
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
@@ -491,17 +515,23 @@ static int pulse_read_event(snd_ctl_ext_t * ext, snd_ctl_elem_id_t * id,
 {
 	snd_ctl_pulse_t *ctl = ext->private_data;
 	int offset;
-	int err = -EAGAIN;
+	int err;
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
-	if (!ctl->updated || !ctl->subscribed)
+	err = pulse_check_connection(ctl->p);
+	if (err < 0)
+		goto finish;
+
+	if (!ctl->updated || !ctl->subscribed) {
+		err = -EAGAIN;
 		goto finish;
+	}
 
 	if (ctl->source)
 		offset = 2;
@@ -540,20 +570,28 @@ static int pulse_ctl_poll_revents(snd_ctl_ext_t * ext, struct pollfd *pfd,
 				  unsigned short *revents)
 {
 	snd_ctl_pulse_t *ctl = ext->private_data;
-	int err = 0;
+	int err;
 
 	assert(ctl);
 
-	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+	if (!ctl->p || !ctl->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
+	err = pulse_check_connection(ctl->p);
+	if (err < 0)
+		goto finish;
+
 	if (ctl->updated)
 		*revents = POLLIN;
 	else
 		*revents = 0;
 
+	err = 0;
+
+finish:
+
 	pa_threaded_mainloop_unlock(ctl->p->mainloop);
 
 	return err;
diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index a625f55..98983f8 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -135,11 +135,15 @@ static int update_active(snd_pcm_pulse_t *pcm) {
 	if (!pcm->p)
 		return -EBADFD;
 
-	ret = check_active(pcm);
+	ret = check_stream(pcm);
 	if (ret < 0)
-		return ret;
+		goto finish;
+
+	ret = check_active(pcm);
 
-	if (ret > 0)
+finish:
+
+	if (ret != 0) /* On error signal the caller, too */
 		pulse_poll_activate(pcm->p);
 	else
 		pulse_poll_deactivate(pcm->p);
@@ -199,12 +203,12 @@ static int pulse_start(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	err = pulse_check_connection(pcm->p);
+	err = check_stream(pcm);
 	if (err < 0)
 		goto finish;
 
@@ -244,12 +248,12 @@ static int pulse_stop(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	err = pulse_check_connection(pcm->p);
+	err = check_stream(pcm);
 	if (err < 0)
 		goto finish;
 
@@ -291,12 +295,12 @@ static int pulse_drain(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	err = pulse_check_connection(pcm->p);
+	err = check_stream(pcm);
 	if (err < 0)
 		goto finish;
 
@@ -328,7 +332,7 @@ static snd_pcm_sframes_t pulse_pointer(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	if (io->state == SND_PCM_STATE_XRUN)
@@ -339,12 +343,7 @@ static snd_pcm_sframes_t pulse_pointer(snd_pcm_ioplug_t * io)
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	if (!pcm->stream) {
-		ret = -EBADFD;
-		goto finish;
-	}
-
-	ret = pulse_check_connection(pcm->p);
+	ret = check_stream(pcm);
 	if (ret < 0)
 		goto finish;
 
@@ -379,18 +378,13 @@ static int pulse_delay(snd_pcm_ioplug_t * io, snd_pcm_sframes_t * delayp)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	if (!pcm->stream) {
-		err = -EBADFD;
-		goto finish;
-	}
-
 	for (;;) {
-		err = pulse_check_connection(pcm->p);
+		err = check_stream(pcm);
 		if (err < 0)
 			goto finish;
 
@@ -433,17 +427,12 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	if (!pcm->stream) {
-		ret = -EBADFD;
-		goto finish;
-	}
-
-	ret = pulse_check_connection(pcm->p);
+	ret = check_stream(pcm);
 	if (ret < 0)
 		goto finish;
 
@@ -493,17 +482,12 @@ static snd_pcm_sframes_t pulse_read(snd_pcm_ioplug_t * io,
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	if (!pcm->stream) {
-		ret = -EBADFD;
-		goto finish;
-	}
-
-	ret = pulse_check_connection(pcm->p);
+	ret = check_stream(pcm);
 	if (ret < 0)
 		goto finish;
 
@@ -624,13 +608,16 @@ static int pulse_pcm_poll_revents(snd_pcm_ioplug_t * io,
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	err = check_active(pcm);
+	err = check_stream(pcm);
+	if (err < 0)
+		goto finish;
 
+	err = check_active(pcm);
 	if (err < 0)
 		goto finish;
 
@@ -655,7 +642,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
@@ -757,7 +744,7 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
 
 	assert(pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
@@ -856,23 +843,26 @@ static int pulse_pause(snd_pcm_ioplug_t * io, int enable)
 {
 	snd_pcm_pulse_t *pcm = io->private_data;
 	int err = 0;
+	pa_operation *o;
 
 	assert (pcm);
 
-	if (!pcm->p)
+	if (!pcm->p || !pcm->p->mainloop)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	if (pcm->stream) {
-		pa_operation *o;
-		o = pa_stream_cork(pcm->stream, enable, NULL, NULL);
-		if (o)
-			pa_operation_unref(o);
-		else
-			err = -EIO;
-	}
+	err = check_stream(pcm);
+	if (err < 0)
+		goto finish;
+
+	o = pa_stream_cork(pcm->stream, enable, NULL, NULL);
+	if (o)
+		pa_operation_unref(o);
+	else
+		err = -EIO;
 
+finish:
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
 
 	return err;
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
