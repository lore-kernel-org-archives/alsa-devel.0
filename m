From: Troy Moure <twmoure@szypr.net>
Subject: [PATCH] alsa-plugins/pulse: Implement 'pause'.
Date: Wed, 17 Jun 2009 21:55:20 +0100 (BST)
Message-ID: <alpine.LFD.2.00.0906172120550.20793@troy-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

Just cork or uncork the stream to pause or unpause it.

Signed-off-by: Troy Moure <twmoure@szypr.net>
---
I'm not very familiar with alsa or pulseaudio, so this might not be 
right.  If it is, feel free to apply it, though.

It *does* fix my problem, which was that pause and unpause didn't work in 
'cmus' after I upgraded to Fedora 11.  Since the pulse plug-in didn't 
support snd_pcm_pause, pausing in cmus would just cause cmus to stop 
writing to the buffer, leading to buffer underruns in pulseaudio.  With 
this patch, pausing in cmus works perfectly for me.

If this should be fixed another way, please let me know what it is!  
Thanks.

 pulse/pcm_pulse.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index db8d1e1..c322884 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -739,6 +739,25 @@ static int pulse_close(snd_pcm_ioplug_t * io)
 	return 0;
 }
 
+static int pulse_pause(snd_pcm_ioplug_t * io, int enable)
+{
+	snd_pcm_pulse_t *pcm = io->private_data;
+	int err = 0;
+
+	assert (pcm);
+	assert (pcm->p);
+
+	pa_threaded_mainloop_lock(pcm->p->mainloop);
+
+	if (pcm->stream)
+		if (!pa_stream_cork(pcm->stream, enable, NULL, NULL))
+			err = -EIO;
+
+	pa_threaded_mainloop_unlock(pcm->p->mainloop);
+
+	return err;
+}
+
 static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
 	.start = pulse_start,
 	.stop = pulse_stop,
@@ -750,6 +769,7 @@ static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
 	.prepare = pulse_prepare,
 	.hw_params = pulse_hw_params,
 	.close = pulse_close,
+	.pause = pulse_pause
 };
 
 
-- 
1.6.2.2
