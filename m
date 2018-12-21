From: <twischer@de.adit-jv.com>
Subject: [PATCH - ALSA JACK plugin 1/2] jack: Move
	jack_activate() and jack_connect() to snd_pcm_jack_prepare()
Date: Fri, 21 Dec 2018 10:29:42 +0100
Message-ID: <1545384583-29955-2-git-send-email-twischer@de.adit-jv.com>
References: <1545384583-29955-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1545384583-29955-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: Laxmi Devi <Laxmi.Devi@in.bosch.com>, alsa-devel@alsa-project.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <Laxmi.Devi@in.bosch.com>

Since the processing of jack_activate() and jack_connect() take a while
longer, snd_pcm_jack_start() was blocked.
Consider a usecase of reading the data from capture device and
writing to a playback device, since the capture device is
already started and the starting of playback device is blocked,
it leads to XRUNs for capture device.
Therefore these calls are moved to snd_pcm_jack_prepare(),
So that the capture and playback devices can be prepared in advance so
that starting of the device doesn't take too long.

Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index b39835e..19d339d 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -222,16 +222,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 					      frames, io->format);
 		}
 
-		if (io->state == SND_PCM_STATE_PREPARED) {
-			/* After activating this JACK client with
-			 * jack_activate() this process callback will be called.
-			 * But the processing of snd_pcm_jack_start() would take
-			 * a while longer due to the jack_connect() calls.
-			 * Therefore the device was already started
-			 * but it is not yet in RUNNING state.
-			 * Due to this expected behaviour it is not an Xrun.
-			 */
-		} else {
+		if (io->state == SND_PCM_STATE_RUNNING ||
+		    io->state == SND_PCM_STATE_DRAINING) {
 			/* report Xrun to user application */
 			jack->xrun_detected = true;
 		}
@@ -242,6 +234,30 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 	return 0;
 }
 
+static void jack_allocate_and_register_ports(snd_pcm_ioplug_t *io)
+{
+	snd_pcm_jack_t *jack = io->private_data;
+	unsigned int i;
+
+	jack->ports = calloc(io->channels, sizeof(jack_port_t *));
+
+	for (i = 0; i < io->channels; i++) {
+		char port_name[32];
+
+		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+			sprintf(port_name, "out_%03d", i);
+			jack->ports[i] = jack_port_register(jack->client, port_name,
+							    JACK_DEFAULT_AUDIO_TYPE,
+							    JackPortIsOutput, 0);
+		} else {
+			sprintf(port_name, "in_%03d", i);
+			jack->ports[i] = jack_port_register(jack->client, port_name,
+							    JACK_DEFAULT_AUDIO_TYPE,
+							    JackPortIsInput, 0);
+		}
+	}
+}
+
 static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
@@ -269,38 +285,16 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	else
 		pcm_poll_block_check(io); /* block capture pcm if that's XRUN recovery */
 
-	if (jack->ports)
-		return 0;
-
-	jack->ports = calloc(io->channels, sizeof(jack_port_t*));
-
-	for (i = 0; i < io->channels; i++) {
-		char port_name[32];
-		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
-
-			sprintf(port_name, "out_%03d", i);
-			jack->ports[i] = jack_port_register(jack->client, port_name,
-							    JACK_DEFAULT_AUDIO_TYPE,
-							    JackPortIsOutput, 0);
-		} else {
-			sprintf(port_name, "in_%03d", i);
-			jack->ports[i] = jack_port_register(jack->client, port_name,
-							    JACK_DEFAULT_AUDIO_TYPE,
-							    JackPortIsInput, 0);
-		}
+	if (!jack->ports) {
+		jack_allocate_and_register_ports(io);
+		jack_set_process_callback(jack->client,
+					  (JackProcessCallback)snd_pcm_jack_process_cb, io);
 	}
 
-	jack_set_process_callback(jack->client,
-				  (JackProcessCallback)snd_pcm_jack_process_cb, io);
-	return 0;
-}
+	if (jack->activated)
+		return 0;
 
-static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_jack_t *jack = io->private_data;
-	unsigned int i;
-	
-	if (jack_activate (jack->client))
+	if (jack_activate(jack->client))
 		return -EIO;
 
 	jack->activated = 1;
@@ -321,7 +315,23 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 			}
 		}
 	}
-	
+	return 0;
+}
+
+static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
+{
+	(void)io;
+	/*
+	 * Since the processing of jack_activate() and jack_connect() take a
+	 * while longer, snd_pcm_jack_start() was blocked.
+	 * Consider a usecase of reading the data from capture device and
+	 * writing to a playback device, since the capture device is
+	 * already started and the starting of playback device is blocked,
+	 * it leads to XRUNs for capture device.
+	 * Therefore these calls are moved to snd_pcm_jack_prepare(),
+	 * So that the capture and playback devices can be prepared in advance
+	 * and starting of the device doesn't take too long.
+	 */
 	return 0;
 }
 
-- 
2.7.4
