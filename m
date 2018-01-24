From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin 5/7] jack: Use internal
	snd_pcm_state to reduce amount of additional variables
Date: Wed, 24 Jan 2018 13:00:40 +0100
Message-ID: <1516795241-10219-3-git-send-email-twischer@de.adit-jv.com>
References: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

This variable will be used to exchange the status of the stream between
the ALSA and JACK thread.
In future commits it will also be used
to signal DRAINING state from the ALSA to JACK thread and
to signal XRUN state form the JACK to ALSA thread

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 53192dc..a42c8b5 100644
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
@@ -122,8 +126,8 @@ static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 	snd_pcm_sframes_t avail;
 	snd_pcm_jack_t *jack = io->private_data;
 
-	if (io->state == SND_PCM_STATE_RUNNING ||
-	    (io->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
+	if (jack->state == SND_PCM_STATE_RUNNING ||
+	    (jack->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
 		avail = snd_pcm_avail_update(io->pcm);
 		if (avail >= 0 && avail < jack->min_avail) {
 			while (read(io->poll_fd, &buf, sizeof(buf)) == sizeof(buf))
@@ -227,7 +231,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 	}
 
 	hw_ptr = jack->hw_ptr;
-	if (io->state == SND_PCM_STATE_RUNNING) {
+	if (jack->state == SND_PCM_STATE_RUNNING) {
 		const snd_pcm_channel_area_t *areas = snd_pcm_ioplug_mmap_areas(io);
 
 		while (xfer < nframes) {
@@ -307,29 +311,31 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	else
 		pcm_poll_block_check(io); /* block capture pcm if that's XRUN recovery */
 
-	if (jack->ports)
-		return 0;
+	if (!jack->ports) {
+		jack->ports = calloc(io->channels, sizeof(jack_port_t*));
 
-	jack->ports = calloc(io->channels, sizeof(jack_port_t*));
-
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
 
@@ -337,12 +343,11 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
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
@@ -355,21 +360,27 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
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
@@ -380,6 +391,9 @@ static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 		}
 	}
 #endif
+
+	jack->state = SND_PCM_STATE_SETUP;
+
 	return 0;
 }
 
@@ -491,6 +505,7 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 
 	jack->fd = -1;
 	jack->io.poll_fd = -1;
+	jack->state = SND_PCM_STATE_OPEN;
 
 	err = parse_ports(jack, stream == SND_PCM_STREAM_PLAYBACK ?
 			  playback_conf : capture_conf);
-- 
2.7.4
