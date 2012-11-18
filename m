From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCHv2 1/1] pcm_pulse: set prebuf parameter
	according to software parameters
Date: Sun, 18 Nov 2012 12:01:49 +0200
Message-ID: <1353232909-6207-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A6B2615AA
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 11:01:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
List-Id: alsa-devel@alsa-project.org

The current default value for prebuf is very high, almost the full
virtual ALSA buffer. This breaks some application especially where
low latency is involved.

This patch makes pcm_pulse implement the sw_params callback and get
the prebuf value from the ALSA software parameters. Thus the
trigger latency is much more like what an ALSA application should
expect from an ALSA PCM device.
---
 pulse/pcm_pulse.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 24fd4da..4226d30 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -854,8 +854,9 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
 		4 * 1024 * 1024;
 	pcm->buffer_attr.tlength =
 		io->buffer_size * pcm->frame_size;
-	pcm->buffer_attr.prebuf =
-	    (io->buffer_size - io->period_size) * pcm->frame_size;
+	if (pcm->buffer_attr.prebuf == (uint32_t)-1)
+		pcm->buffer_attr.prebuf =
+			(io->buffer_size - io->period_size) * pcm->frame_size;
 	pcm->buffer_attr.minreq = io->period_size * pcm->frame_size;
 	pcm->buffer_attr.fragsize = io->period_size * pcm->frame_size;
 
@@ -865,6 +866,31 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
 	return err;
 }
 
+static int pulse_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t *params)
+{
+	snd_pcm_pulse_t *pcm = io->private_data;
+	snd_pcm_uframes_t start_threshold;
+
+	assert(pcm);
+
+	if (!pcm->p || !pcm->p->mainloop)
+		return -EBADFD;
+
+	pa_threaded_mainloop_lock(pcm->p->mainloop);
+
+	snd_pcm_sw_params_get_start_threshold(params, &start_threshold);
+
+	/* At least one period to keep PulseAudio happy */
+	if (start_threshold < io->period_size)
+		start_threshold = io->period_size;
+
+	pcm->buffer_attr.prebuf = start_threshold * pcm->frame_size;
+
+	pa_threaded_mainloop_unlock(pcm->p->mainloop);
+
+	return 0;
+}
+
 static int pulse_close(snd_pcm_ioplug_t * io)
 {
 	snd_pcm_pulse_t *pcm = io->private_data;
@@ -931,6 +957,7 @@ static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
 	.poll_revents = pulse_pcm_poll_revents,
 	.prepare = pulse_prepare,
 	.hw_params = pulse_hw_params,
+	.sw_params = pulse_sw_params,
 	.close = pulse_close,
 	.pause = pulse_pause
 };
@@ -1088,6 +1115,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	}
 
 	pcm->handle_underrun = handle_underrun;
+	pcm->buffer_attr.prebuf = -1;
 
 	err = pulse_connect(pcm->p, server, fallback_name != NULL);
 	if (err < 0)
-- 
1.7.10.4
