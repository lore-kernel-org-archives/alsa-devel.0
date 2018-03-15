From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK 1/1] jack: Use internal snd_pcm_state to
	reduce amount of additional variables
Date: Thu, 15 Mar 2018 13:56:27 +0100
Message-ID: <1521118587-6319-2-git-send-email-twischer@de.adit-jv.com>
References: <s5hefl3izpf.wl-tiwai@suse.de>
 <1521118587-6319-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A787F267277
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 13:56:56 +0100 (CET)
In-Reply-To: <1521118587-6319-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

This variable will be used to exchange the status of the stream between
the ALSA and JACK thread. In future commits it will also be used to signal
DRAINING state from the ALSA to JACK thread and to signal XRUN state form
the JACK to ALSA thread.

Therefore this internal state variable is not always in sync with
io->state. In addition the internal state variable will be updated after
the corresponding callback function was processed and not before the
callback function was called (e.g. PREPARE and RUNNING).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 7c7c230..5932ca2 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -36,7 +36,11 @@ typedef struct {
 	snd_pcm_ioplug_t io;
 
 	int fd;
-	int activated;		/* jack is activated? */
+
+	/* This variable is not always in sync with io->state
+	 * because it will be accessed by multiple threads.
+	 */
+	snd_pcm_state_t state;
 
 	char **port_names;
 	unsigned int num_ports;
@@ -61,8 +65,8 @@ static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 	snd_pcm_sframes_t avail;
 	snd_pcm_jack_t *jack = io->private_data;
 
-	if (io->state == SND_PCM_STATE_RUNNING ||
-	    (io->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
+	if (jack->state == SND_PCM_STATE_RUNNING ||
+	    (jack->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
 		avail = snd_pcm_avail_update(io->pcm);
 		if (avail >= 0 && avail < jack->min_avail) {
 			while (read(io->poll_fd, &buf, sizeof(buf)) == sizeof(buf))
@@ -154,7 +158,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		jack->areas[channel].step = jack->sample_bits;
 	}
 
-	if (io->state == SND_PCM_STATE_RUNNING) {
+	if (jack->state == SND_PCM_STATE_RUNNING) {
 		snd_pcm_uframes_t hw_ptr = jack->hw_ptr;
 		const snd_pcm_uframes_t hw_avail = snd_pcm_ioplug_hw_avail(io, hw_ptr,
 									   io->appl_ptr);
@@ -229,29 +233,31 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	else
 		pcm_poll_block_check(io); /* block capture pcm if that's XRUN recovery */
 
-	if (jack->ports)
-		return 0;
-
-	jack->ports = calloc(io->channels, sizeof(jack_port_t*));
+	if (!jack->ports) {
+		jack->ports = calloc(io->channels, sizeof(jack_port_t*));
 
-	for (i = 0; i < io->channels; i++) {
-		char port_name[32];
-		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < io->channels; i++) {
+			char port_name[32];
+			if (io->stream == SND_PCM_STREAM_PLAYBACK) {
 
-			sprintf(port_name, "out_%03d", i);
-			jack->ports[i] = jack_port_register(jack->client, port_name,
-							    JACK_DEFAULT_AUDIO_TYPE,
-							    JackPortIsOutput, 0);
-		} else {
-			sprintf(port_name, "in_%03d", i);
-			jack->ports[i] = jack_port_register(jack->client, port_name,
-							    JACK_DEFAULT_AUDIO_TYPE,
-							    JackPortIsInput, 0);
+				sprintf(port_name, "out_%03d", i);
+				jack->ports[i] = jack_port_register(jack->client, port_name,
+								    JACK_DEFAULT_AUDIO_TYPE,
+								    JackPortIsOutput, 0);
+			} else {
+				sprintf(port_name, "in_%03d", i);
+				jack->ports[i] = jack_port_register(jack->client, port_name,
+								    JACK_DEFAULT_AUDIO_TYPE,
+								    JackPortIsInput, 0);
+			}
 		}
+
+		jack_set_process_callback(jack->client,
+					  (JackProcessCallback)snd_pcm_jack_process_cb, io);
 	}
 
-	jack_set_process_callback(jack->client,
-				  (JackProcessCallback)snd_pcm_jack_process_cb, io);
+	jack->state = SND_PCM_STATE_PREPARED;
+
 	return 0;
 }
 
@@ -259,12 +265,11 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
 	unsigned int i;
+	int err = 0;
 	
 	if (jack_activate (jack->client))
 		return -EIO;
 
-	jack->activated = 1;
-
 	for (i = 0; i < io->channels && i < jack->num_ports; i++) {
 		if (jack->port_names[i]) {
 			const char *src, *dst;
@@ -277,21 +282,27 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 			}
 			if (jack_connect(jack->client, src, dst)) {
 				fprintf(stderr, "cannot connect %s to %s\n", src, dst);
-				return -EIO;
+				err = -EIO;
+				break;
 			}
 		}
 	}
+
+	/* do not start forwarding audio samples before the ports are connected */
+	jack->state = SND_PCM_STATE_RUNNING;
 	
-	return 0;
+	return err;
 }
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
-	
-	if (jack->activated) {
+	const snd_pcm_state_t state = jack->state;
+
+	if (state == SND_PCM_STATE_RUNNING ||
+	    state == SND_PCM_STATE_DRAINING ||
+	    state == SND_PCM_STATE_XRUN) {
 		jack_deactivate(jack->client);
-		jack->activated = 0;
 	}
 #if 0
 	unsigned i;
@@ -302,6 +313,9 @@ static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 		}
 	}
 #endif
+
+	jack->state = SND_PCM_STATE_SETUP;
+
 	return 0;
 }
 
@@ -413,6 +427,7 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 
 	jack->fd = -1;
 	jack->io.poll_fd = -1;
+	jack->state = SND_PCM_STATE_OPEN;
 
 	err = parse_ports(jack, stream == SND_PCM_STREAM_PLAYBACK ?
 			  playback_conf : capture_conf);
-- 
2.7.4
