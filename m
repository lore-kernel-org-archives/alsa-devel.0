From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Thu, 16 Feb 2012 10:48:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 036C32457E
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 16:48:16 +0100 (CET)
Received: from lpc8.fields.utoronto.ca (lpc8.fields.utoronto.ca
	[128.100.216.128])
	by fileserver.fields.utoronto.ca (8.14.4/8.14.4/Fields_8.1M) with ESMTP
	id q1GFmEXr002226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 10:48:14 -0500
Received: from lpc8.fields.utoronto.ca (localhost [127.0.0.1])
	by lpc8.fields.utoronto.ca (8.14.4/8.14.4/Fields_8.1W) with ESMTP id
	q1GFmEO7024688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 10:48:14 -0500
Received: from localhost (pspencer@localhost)
	by lpc8.fields.utoronto.ca (8.14.4/8.14.4/Submit) with ESMTP id
	q1GFmCem024684
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 10:48:14 -0500
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

When Adobe Flash player is playing a live stream in "live" (no internal 
latency) mode[1], through alsa's pulseaudio plugin, the audio is a 
half-second out of sync with the video. This is with alsa-plugins version 
1.0.25.[2]

I see the problem is one already reported on the bug tracker several years 
ago (issue #3944). The plugin sets pulseaudio's target buffer length to
match the IO buffer length, and sets the prebuffering attribute to match
the IO buffer length less one period.

In our case, the IO buffer is 500ms long, the IO period length is 20ms 
(for 16KHz Speex soud packets), and the application requests that playback 
start immediately (by setting the start_threshold software parameter very 
low).

However, the plugin ignores start_threshold and sets the pulseaudio target 
buffer length to 500ms, meaning pulseaudio plays the sound with a 
half-second delay.

The fix initially suggested in the bug report was to implement the 
start_threshold parameter and use it to lower the prebuffering attribute 
but this does not work: playback STARTS sooner, but when dropouts and 
underruns occur pulseaudio increases the latency to match the target 
buffer length. It is necessary to lower the target buffer length too.

Below is a proposed patch (my apologies if I've missed some 
subtleties as I've never looked at the alsa source code before). The patch
changes the plugin to do the following:

   -- decouple the length of the fake ring buffer seen by ALSA (which needs
      to match the IO buffer length) from the "target length" parameter
      sent to pulseaudio (which needs to reflect the desired latency),
      adding a new variable to the structure to store the former value.
      Currently they are forced to be the same value.

   -- when the start_threshold software parameter is seen, lower both
      the target length and prebuffering attributes to match it, except
      don't set them less than one IO period or longer than the IO buffer
      length

   -- when hardware parameters are seen, don't mess with the target length
      or prebuffering attributes if already set by software.

It doesn't currently tell pulseaudio to change its parameters if the
start_threshold is enountered after the stream is already started, but
that could be added too if necessary with
          if (pcm->stream) pa_stream_set_buffer_attr( ... )

I hope this patch (or something like it) can get put into an alsa release
since otherwise the Flash Player 2-way interaction app we're developing 
won't be usable by Linux users unless it runs in about 750ms time-delayed 
mode!

Thank you,

Philip

[1] Normally Flash Player plays prerecorded streams with a slight internal 
buffering delay, and in this mode it requests the audio be buffered for 
500ms in addition to its own internal delay, and it automatically delays 
video frames for 500ms beyond its own internal delay to compensate, so 
there are no out-of-sync problems with prerecorded streams or live streams 
played in regular buffered mode.

[2] In 1.0.23 with low-sample-rate streams there was no sync problem but
each sound sample was truncated, resulting in distorted and crackly sound; 
this problem has been fixed in 1.0.25 -- thanks!

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences

Signed-Of-By: Philip Spencer <pspencer@fields.utoronto.ca>

--- alsa-plugins-1.0.25.orig/pulse/pcm_pulse.c	2012-01-25 02:57:07.000000000 -0500
+++ alsa-plugins-1.0.25/pulse/pcm_pulse.c	2012-02-15 16:23:08.000000000 -0500
@@ -49,6 +49,9 @@
  	pa_sample_spec ss;
  	size_t frame_size;
  	pa_buffer_attr buffer_attr;
+	uint32_t ring_buffer_length;
+	int tlength_set_by_sw;
+
  } snd_pcm_pulse_t;

  static int check_stream(snd_pcm_pulse_t *pcm)
@@ -93,12 +96,12 @@
  		size -= pcm->offset;

  	/* Prevent accidental overrun of the fake ringbuffer */
-	if (size > pcm->buffer_attr.tlength - pcm->frame_size)
-		size = pcm->buffer_attr.tlength - pcm->frame_size;
+	if (size > pcm->ring_buffer_length - pcm->frame_size)
+		size = pcm->ring_buffer_length - pcm->frame_size;

  	if (size > pcm->last_size) {
  		pcm->ptr += size - pcm->last_size;
-		pcm->ptr %= pcm->buffer_attr.tlength;
+		pcm->ptr %= pcm->ring_buffer_length;
  	}

  	pcm->last_size = size;
@@ -830,12 +833,16 @@
  	pcm->ss.rate = io->rate;
  	pcm->ss.channels = io->channels;

+	pcm->ring_buffer_length =
+		io->buffer_size * pcm->frame_size;
  	pcm->buffer_attr.maxlength =
  		4 * 1024 * 1024;
-	pcm->buffer_attr.tlength =
-		io->buffer_size * pcm->frame_size;
-	pcm->buffer_attr.prebuf =
-	    (io->buffer_size - io->period_size) * pcm->frame_size;
+	if (! pcm->tlength_set_by_sw) {
+		pcm->buffer_attr.tlength =
+			io->buffer_size * pcm->frame_size;
+		pcm->buffer_attr.prebuf =
+			(io->buffer_size - io->period_size) * pcm->frame_size;
+	}
  	pcm->buffer_attr.minreq = io->period_size * pcm->frame_size;
  	pcm->buffer_attr.fragsize = io->period_size * pcm->frame_size;

@@ -845,6 +852,36 @@
  	return err;
  }

+static int pulse_sw_params(snd_pcm_ioplug_t * io,
+			   snd_pcm_sw_params_t * params)
+{
+	snd_pcm_pulse_t *pcm = io->private_data;
+	int err = 0;
+
+	assert(pcm);
+
+	if (!pcm->p || !pcm->p->mainloop)
+		return -EBADFD;
+
+	pa_threaded_mainloop_lock(pcm->p->mainloop);
+	snd_pcm_uframes_t start_thresh;
+	err = snd_pcm_sw_params_get_start_threshold(params, &start_thresh);
+ 	if (! err) {
+		if (start_thresh <  io->period_size)
+			start_thresh = io->period_size;
+		if (start_thresh > io->buffer_size)
+			start_thresh = io->buffer_size;
+
+		pcm->buffer_attr.tlength = start_thresh * pcm->frame_size;
+		pcm->buffer_attr.prebuf = start_thresh * pcm->frame_size;
+		pcm->tlength_set_by_sw = 1;
+	}
+
+	pa_threaded_mainloop_unlock(pcm->p->mainloop);
+	return err;
+
+}
+
  static int pulse_close(snd_pcm_ioplug_t * io)
  {
  	snd_pcm_pulse_t *pcm = io->private_data;
@@ -911,6 +948,7 @@
  	.poll_revents = pulse_pcm_poll_revents,
  	.prepare = pulse_prepare,
  	.hw_params = pulse_hw_params,
+	.sw_params = pulse_sw_params,
  	.close = pulse_close,
  	.pause = pulse_pause
  };
@@ -1080,6 +1118,7 @@
  	pcm->io.mmap_rw = 0;
  	pcm->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
  	    &pulse_playback_callback : &pulse_capture_callback;
+	pcm->tlength_set_by_sw = 0;
  	pcm->io.private_data = pcm;

  	err = snd_pcm_ioplug_create(&pcm->io, name, stream, mode);
