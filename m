From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Wed, 23 Jun 2010 21:57:01 +0200
Message-ID: <4C22670D.8010104@epost.diwic.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040006090607070407080605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213]) by alsa0.perex.cz (Postfix) with ESMTP id D803A24350
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 21:57:30 +0200 (CEST)
Received: from c83-254-137-216.bredband.comhem.se ([83.254.137.216]:47641
	helo=[192.168.8.103])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1ORW4D-0001OD-6z
	for alsa-devel@alsa-project.org; Wed, 23 Jun 2010 21:57:04 +0200
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

This is a multi-part message in MIME format.
--------------040006090607070407080605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

These two patches are being used in Ubuntu Lucid (released this April)
and are working well enough to have people asking us to backport them to
Karmic. Today I got an email, asking for the upstream status of one of
these patches, since he wanted them in Fedora. If posting them here
isn't the correct way to upstream them, please tell me so.

The first one (Fix invalid buffer pointer return value) fixes broken logic:

This patch improves recovering from underruns, and prevents hangs inside
snd_pcm_write* and snd_pcm_read* due to snd_pcm_avail* returning too
low values. It especially helps low latency situations.

The second one (Do not report underruns to the ALSA layer) is more a
change of behavior, which could be questioned. The arguments for
removing that code are these:

 * If pulseaudio gets an underrun, the normal way to end that underrun
is to feed it with more buffers. This is different from the ALSA way of
dealing with underruns, which requires hardware buffer pointers to be reset.
 * In addition, underrun signals are delivered asynchronously from
pulseaudio. This means that there might be more buffers on the way to
pulseaudio when the underrun is reported, making the underrun obsolete.
Unfortunately, there is currently no known way to determine whether this
is the case or not.

// David

--------------040006090607070407080605
Content-Type: text/x-patch;
 name="lp464008lp503174.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lp464008lp503174.patch"

Description: Do not report underruns to the ALSA layer.
 Reporting underruns to ALSA seems to do more bad than good, for these reasons:
 * If pulseaudio gets an underrun, the normal way to end that underrun is to 
   feed it with more buffers. This is different from the ALSA way of dealing
   with underruns, which requires hardware buffer pointers to be reset.
 * In addition, underrun signals are delivered asynchronously from pulseaudio.
   This means that there might be more buffers on the way to pulseaudio when
   the underrun is reported, making the underrun obsolete. Unfortunately, 
   there is currently no known way to determine whether this is the case or 
   not.
Forwarded: yes
Bug-ubuntu: https://bugs.launchpad.net/bugs/464008
Author: David Henningsson <diwic@ubuntu.com>

Index: alsa-plugins-1.0.22/pulse/pcm_pulse.c
===================================================================
--- alsa-plugins-1.0.22.orig/pulse/pcm_pulse.c	2010-02-28 17:11:29.000000000 -0500
+++ alsa-plugins-1.0.22/pulse/pcm_pulse.c	2010-02-28 17:11:56.000000000 -0500
@@ -38,7 +38,7 @@
 	/* Since ALSA expects a ring buffer we must do some voodoo. */
 	size_t last_size;
 	size_t ptr;
-	int underrun;
+	/* int underrun; */
 
 	size_t offset;
 
@@ -220,7 +220,7 @@
 
 	u = pa_stream_trigger(pcm->stream, stream_success_cb, pcm);
 
-	pcm->underrun = 0;
+	/* pcm->underrun = 0; */
 	err_o = pulse_wait_operation(pcm->p, o);
 	if (u)
 		err_u = pulse_wait_operation(pcm->p, u);
@@ -347,10 +347,10 @@
 	if (ret < 0)
 		goto finish;
 
-	if (pcm->underrun) {
+	/*if (pcm->underrun) {
 		ret = -EPIPE;
 		goto finish;
-	}
+	}*/
 
 	ret = update_ptr(pcm);
 	if (ret < 0) {
@@ -358,9 +358,9 @@
 		goto finish;
 	}
 
-	if (pcm->underrun)
+	/*if (pcm->underrun)
 		ret = -EPIPE;
-	else
+	else*/
 		ret = snd_pcm_bytes_to_frames(io->pcm, pcm->ptr);
 
 finish:
@@ -408,8 +408,8 @@
 
 finish:
 
-	if (pcm->underrun && pcm->io.state == SND_PCM_STATE_RUNNING)
-		snd_pcm_ioplug_set_state(io, SND_PCM_STATE_XRUN);
+	/*if (pcm->underrun && pcm->io.state == SND_PCM_STATE_RUNNING)
+		snd_pcm_ioplug_set_state(io, SND_PCM_STATE_XRUN);*/
 
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
 
@@ -462,7 +462,7 @@
 		goto finish;
 
 	ret = size;
-	pcm->underrun = 0;
+	/*pcm->underrun = 0;*/
 
 finish:
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
@@ -575,7 +575,7 @@
 
 	update_active(pcm);
 }
-
+/*
 static void stream_underrun_cb(pa_stream * p, void *userdata)
 {
 	snd_pcm_pulse_t *pcm = userdata;
@@ -587,7 +587,7 @@
 
 	pcm->underrun = 1;
 }
-
+*/
 static void stream_latency_cb(pa_stream *p, void *userdata) {
 	snd_pcm_pulse_t *pcm = userdata;
 
@@ -688,8 +688,8 @@
 	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
 		pa_stream_set_write_callback(pcm->stream,
 					     stream_request_cb, pcm);
-		pa_stream_set_underflow_callback(pcm->stream,
-						 stream_underrun_cb, pcm);
+		/*pa_stream_set_underflow_callback(pcm->stream,
+						 stream_underrun_cb, pcm);*/
 		r = pa_stream_connect_playback(pcm->stream, pcm->device,
 					       &pcm->buffer_attr,
 					       PA_STREAM_AUTO_TIMING_UPDATE |
@@ -728,7 +728,7 @@
 	}
 
 	pcm->offset = 0;
-	pcm->underrun = 0;
+	/*pcm->underrun = 0;*/
 
       finish:
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);

--------------040006090607070407080605
Content-Type: text/x-patch;
 name="lp485488.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lp485488.patch"

>From 2e9f8fa4d6f7a0cabe5aea1cbfa98980cdfb6d84 Mon Sep 17 00:00:00 2001
From: David Henningsson <diwic@ubuntu.com>
Date: Sat, 9 Jan 2010 09:09:14 +0100
Subject: [PATCH] pulse: Fix invalid buffer pointer return value

This patch improves recovering from underruns, and prevents hangs inside
snd_pcm_write* and snd_pcm_read* due to snd_pcm_avail* returning too
low values. It especially helps low latency situations.

Signed-off-by: David Henningsson <diwic@ubuntu.com>
---
 pulse/pcm_pulse.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

Index: alsa-plugins-1.0.22/pulse/pcm_pulse.c
===================================================================
--- alsa-plugins-1.0.22.orig/pulse/pcm_pulse.c	2010-02-28 17:12:02.000000000 -0500
+++ alsa-plugins-1.0.22/pulse/pcm_pulse.c	2010-02-28 17:12:25.000000000 -0500
@@ -90,6 +90,10 @@
 	if (pcm->io.stream == SND_PCM_STREAM_CAPTURE)
 		size -= pcm->offset;
 
+	/* Prevent accidental overrun of the fake ringbuffer */
+	if (size >= pcm->buffer_attr.tlength)
+		size = pcm->buffer_attr.tlength-1;
+
 	if (size > pcm->last_size) {
 		pcm->ptr += size - pcm->last_size;
 		pcm->ptr %= pcm->buffer_attr.tlength;
@@ -424,6 +428,7 @@
 	snd_pcm_pulse_t *pcm = io->private_data;
 	const char *buf;
 	snd_pcm_sframes_t ret = 0;
+	size_t writebytes;
 
 	assert(pcm);
 
@@ -445,13 +450,15 @@
 	    (char *) areas->addr + (areas->first +
 				    areas->step * offset) / 8;
 
-	ret = pa_stream_write(pcm->stream, buf, size * pcm->frame_size, NULL, 0, 0);
+	writebytes = size * pcm->frame_size;
+	ret = pa_stream_write(pcm->stream, buf, writebytes, NULL, 0, 0);
 	if (ret < 0) {
 		ret = -EIO;
 		goto finish;
 	}
 
 	/* Make sure the buffer pointer is in sync */
+	pcm->last_size -= writebytes;
 	ret = update_ptr(pcm);
 	if (ret < 0)
 		goto finish;
@@ -528,6 +535,7 @@
 
 		dst_buf = (char *) dst_buf + frag_length;
 		remain_size -= frag_length;
+		pcm->last_size -= frag_length;
 	}
 
 	/* Make sure the buffer pointer is in sync */
@@ -730,6 +738,11 @@
 	pcm->offset = 0;
 	/*pcm->underrun = 0;*/
 
+	/* Reset fake ringbuffer */
+	pcm->last_size = 0;
+	pcm->ptr = 0;
+	update_ptr(pcm);
+
       finish:
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
 

--------------040006090607070407080605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040006090607070407080605--
