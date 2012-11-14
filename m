From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 2/2] pcm_pulse: set prebuf parameter according
	to software parameters
Date: Wed, 14 Nov 2012 20:07:57 +0200
Message-ID: <1352916477-17552-2-git-send-email-remi@remlab.net>
References: <201211142007.19751@leon.remlab.net>
 <1352916477-17552-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E532625ED
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 19:08:03 +0100 (CET)
In-Reply-To: <1352916477-17552-1-git-send-email-remi@remlab.net>
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
 pulse/pcm_pulse.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 0165120..08b6cea 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -859,6 +859,30 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
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
@@ -925,6 +949,7 @@ static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
 	.poll_revents = pulse_pcm_poll_revents,
 	.prepare = pulse_prepare,
 	.hw_params = pulse_hw_params,
+	.sw_params = pulse_sw_params,
 	.close = pulse_close,
 	.pause = pulse_pause
 };
-- 
1.7.10.4
