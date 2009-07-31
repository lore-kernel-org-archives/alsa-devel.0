From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH 1/4] pulse: get rid of a number of	assert()s
Date: Fri, 31 Jul 2009 17:10:18 +0200
Message-ID: <20090731151018.GA434@omega>
References: <20090731140133.GA31121@omega> <h4v080$v96$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 47E162457A
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 17:10:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <h4v080$v96$1@ger.gmane.org>
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, 31.07.09 15:48, Colin Guthrie (gmane@colin.guthr.ie) wrote:

> Couldn't find these commits in your alsa-plugins clone at 
> git://git.0pointer.de/alsa-plugins.git so couldn't create a followup 
> patch so here it is inline (against 1.2.20 so line numbers may be off):
> 
> --- alsa-plugins-1.0.20/pulse/ctl_pulse.c~	2009-07-31 15:39:22.000000000 
> +0100
> +++ alsa-plugins-1.0.20/pulse/ctl_pulse.c	2009-07-31 15:47:32.000000000 
> +0100
> @@ -542,6 +542,8 @@
>   	snd_ctl_pulse_t *ctl = ext->private_data;
>   	int err = 0;
> 
> +	assert(ctl);
> +
>   	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
>   		return -EBADFD;
> 

See attachment for a version that incorporates this mini fix.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-pulse-get-rid-of-a-number-of-assert-s.patch"

>From 5ba1cc327b329ae518c3413e65b44945d5d8f919 Mon Sep 17 00:00:00 2001
From: Lennart Poettering <lennart@poettering.net>
Date: Fri, 31 Jul 2009 15:25:44 +0200
Subject: [PATCH] pulse: get rid of a number of assert()s

Instead of hitting an assert when any of the plugin functions is called
in an invalid context we should return a clean error to make sure
programs are not unnecessarily aborted.

This should fix issues such as http://pulseaudio.org/ticket/595
---
 pulse/ctl_pulse.c |   35 ++++++++++++++++++-----
 pulse/pcm_pulse.c |   79 +++++++++++++++++++++++++++++++++++++++++------------
 pulse/pulse.c     |   34 ++++++++++++++++-------
 3 files changed, 112 insertions(+), 36 deletions(-)

diff --git a/pulse/ctl_pulse.c b/pulse/ctl_pulse.c
index c6cf9e2..2caa29b 100644
--- a/pulse/ctl_pulse.c
+++ b/pulse/ctl_pulse.c
@@ -125,8 +125,9 @@ static void event_cb(pa_context * c, pa_subscription_event_type_t t,
 	pa_operation *o;
 
 	assert(ctl);
-	assert(ctl->p);
-	assert(ctl->p->context);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return;
 
 	o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->sink,
 					     sink_info_cb, ctl);
@@ -148,8 +149,9 @@ static int pulse_update_volume(snd_ctl_pulse_t * ctl)
 	pa_operation *o;
 
 	assert(ctl);
-	assert(ctl->p);
-	assert(ctl->p->context);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
 
 	o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->sink,
 					     sink_info_cb, ctl);
@@ -203,6 +205,9 @@ static int pulse_elem_list(snd_ctl_ext_t * ext, unsigned int offset,
 
 	assert(ctl);
 
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
+
 	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
@@ -260,7 +265,9 @@ static int pulse_get_attribute(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 		return -EINVAL;
 
 	assert(ctl);
-	assert(ctl->p);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
@@ -311,7 +318,9 @@ static int pulse_read_integer(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 	pa_cvolume *vol = NULL;
 
 	assert(ctl);
-	assert(ctl->p);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
@@ -361,7 +370,9 @@ static int pulse_write_integer(snd_ctl_ext_t * ext, snd_ctl_ext_key_t key,
 	pa_cvolume *vol = NULL;
 
 	assert(ctl);
-	assert(ctl->p && ctl->p->context);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
@@ -465,6 +476,9 @@ static void pulse_subscribe_events(snd_ctl_ext_t * ext, int subscribe)
 
 	assert(ctl);
 
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return;
+
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
 	ctl->subscribed = !!(subscribe & SND_CTL_EVENT_MASK_VALUE);
@@ -481,6 +495,9 @@ static int pulse_read_event(snd_ctl_ext_t * ext, snd_ctl_elem_id_t * id,
 
 	assert(ctl);
 
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
+
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
 	if (!ctl->updated || !ctl->subscribed)
@@ -526,7 +543,9 @@ static int pulse_ctl_poll_revents(snd_ctl_ext_t * ext, struct pollfd *pfd,
 	int err = 0;
 
 	assert(ctl);
-	assert(ctl->p);
+
+	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(ctl->p->mainloop);
 
diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index c276839..24347f9 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -106,6 +106,9 @@ static int update_active(snd_pcm_pulse_t *pcm) {
 
 	assert(pcm);
 
+	if (!pcm->p)
+		return -EBADFD;
+
 	ret = check_active(pcm);
 	if (ret < 0)
 		return ret;
@@ -125,7 +128,9 @@ static int pulse_start(snd_pcm_ioplug_t * io)
 	int err = 0, err_o = 0, err_u = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -174,7 +179,9 @@ static int pulse_stop(snd_pcm_ioplug_t * io)
 	int err = 0, err_o = 0, err_u = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -224,7 +231,9 @@ static int pulse_drain(snd_pcm_ioplug_t * io)
 	int err = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -259,7 +268,9 @@ static snd_pcm_sframes_t pulse_pointer(snd_pcm_ioplug_t * io)
 	snd_pcm_sframes_t ret = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	if (io->state == SND_PCM_STATE_XRUN)
 		return -EPIPE;
@@ -269,7 +280,10 @@ static snd_pcm_sframes_t pulse_pointer(snd_pcm_ioplug_t * io)
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	assert(pcm->stream);
+	if (!pcm->stream) {
+		ret = -EBADFD;
+		goto finish;
+	}
 
 	ret = pulse_check_connection(pcm->p);
 	if (ret < 0)
@@ -305,11 +319,16 @@ static int pulse_delay(snd_pcm_ioplug_t * io, snd_pcm_sframes_t * delayp)
 	pa_usec_t lat = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	assert(pcm->stream);
+	if (!pcm->stream) {
+		err = -EBADFD;
+		goto finish;
+	}
 
 	for (;;) {
 		err = pulse_check_connection(pcm->p);
@@ -354,11 +373,16 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
 	snd_pcm_sframes_t ret = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	assert(pcm->stream);
+	if (!pcm->stream) {
+		ret = -EBADFD;
+		goto finish;
+	}
 
 	ret = pulse_check_connection(pcm->p);
 	if (ret < 0)
@@ -409,11 +433,16 @@ static snd_pcm_sframes_t pulse_read(snd_pcm_ioplug_t * io,
 	snd_pcm_sframes_t ret = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	assert(pcm->stream);
+	if (!pcm->stream) {
+		ret = -EBADFD;
+		goto finish;
+	}
 
 	ret = pulse_check_connection(pcm->p);
 	if (ret < 0)
@@ -480,7 +509,9 @@ static void stream_request_cb(pa_stream * p, size_t length, void *userdata)
 	snd_pcm_pulse_t *pcm = userdata;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return;
 
 	update_active(pcm);
 }
@@ -490,7 +521,9 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
 	snd_pcm_pulse_t *pcm = userdata;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return;
 
 	pcm->underrun = 1;
 }
@@ -499,7 +532,9 @@ static void stream_latency_cb(pa_stream *p, void *userdata) {
 	snd_pcm_pulse_t *pcm = userdata;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return;
 
 	pa_threaded_mainloop_signal(pcm->p->mainloop, 0);
 }
@@ -512,7 +547,9 @@ static int pulse_pcm_poll_revents(snd_pcm_ioplug_t * io,
 	snd_pcm_pulse_t *pcm = io->private_data;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -541,7 +578,9 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 	unsigned c, d;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -645,7 +684,9 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
 	int err = 0;
 
 	assert(pcm);
-	assert(pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
@@ -745,7 +786,9 @@ static int pulse_pause(snd_pcm_ioplug_t * io, int enable)
 	int err = 0;
 
 	assert (pcm);
-	assert (pcm->p);
+
+	if (!pcm->p)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(pcm->p->mainloop);
 
diff --git a/pulse/pulse.c b/pulse/pulse.c
index 3940238..95d8dde 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -32,8 +32,9 @@ int pulse_check_connection(snd_pulse_t * p)
 	pa_context_state_t state;
 
 	assert(p);
-	assert(p->context);
-	assert(p->mainloop);
+
+	if (!p->context || !p->mainloop)
+		return -EBADFD;
 
 	state = pa_context_get_state(p->context);
 
@@ -77,8 +78,12 @@ int pulse_wait_operation(snd_pulse_t * p, pa_operation * o)
 {
 	assert(p);
 	assert(o);
-	assert(p->state == PULSE_STATE_READY);
-	assert(p->mainloop);
+
+	if (p->state != PULSE_STATE_READY)
+		return -EBADFD;
+
+	if (!p->mainloop)
+		return -EBADFD;
 
 	for (;;) {
 		int err;
@@ -103,8 +108,12 @@ int pulse_wait_stream_state(snd_pulse_t * p, pa_stream * stream,
 
 	assert(p);
 	assert(stream);
-	assert(p->state == PULSE_STATE_READY);
-	assert(p->mainloop);
+
+	if (p->state != PULSE_STATE_READY)
+		return -EBADFD;
+
+	if (!p->mainloop)
+		return -EBADFD;
 
 	for (;;) {
 		int err;
@@ -197,7 +206,9 @@ snd_pulse_t *pulse_new(void)
 
 	p->context =
 	    pa_context_new(pa_threaded_mainloop_get_api(p->mainloop), buf);
-	assert(p->context);
+
+	if (!p->context)
+		goto fail;
 
 	pa_context_set_state_callback(p->context, context_state_cb, p);
 
@@ -246,9 +257,12 @@ int pulse_connect(snd_pulse_t * p, const char *server)
 	int err;
 
 	assert(p);
-	assert(p->context);
-	assert(p->mainloop);
-	assert(p->state == PULSE_STATE_INIT);
+
+	if (!p->context || !p->mainloop)
+		return -EBADFD;
+
+	if (p->state != PULSE_STATE_INIT)
+		return -EBADFD;
 
 	pa_threaded_mainloop_lock(p->mainloop);
 
-- 
1.6.3.3


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--ikeVEW9yuYc//A+q--
