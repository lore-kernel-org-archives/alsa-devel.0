From: <twischer@de.adit-jv.com>
Subject: [PATCH - ALSA JACK plugin 2/2] jack: Moving
	jack_deactivate() to snd_pcm_jack_hw_free() to speedup the
	XRUN Recovery
Date: Fri, 21 Dec 2018 10:29:43 +0100
Message-ID: <1545384583-29955-3-git-send-email-twischer@de.adit-jv.com>
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

Removed snd_pcm_jack_stop() from snd_pcm_jack_prepare(),as on XRUN we do
not need to reconnect or reconfigure anything.

Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 19d339d..af2136e 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -58,8 +58,6 @@ typedef struct {
 	bool xrun_detected;
 } snd_pcm_jack_t;
 
-static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
-
 /* snd_pcm_ioplug_avail() was introduced after alsa-lib 1.1.6 */
 #if SND_LIB_VERSION < 0x10107
 static snd_pcm_uframes_t snd_pcm_ioplug_avail(const snd_pcm_ioplug_t *io,
@@ -277,9 +275,6 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 		snd_pcm_sw_params_get_boundary(swparams, &jack->boundary);
 	}
 
-	/* deactivate jack connections if this is XRUN recovery */
-	snd_pcm_jack_stop(io);
-
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		pcm_poll_unblock_check(io); /* playback pcm initially accepts writes */
 	else
@@ -337,8 +332,14 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 {
+	(void)io;
+	return 0;
+}
+
+static int snd_pcm_jack_hw_free(snd_pcm_ioplug_t *io)
+{
 	snd_pcm_jack_t *jack = io->private_data;
-	
+
 	if (jack->activated) {
 		jack_deactivate(jack->client);
 		jack->activated = 0;
@@ -360,6 +361,7 @@ static snd_pcm_ioplug_callback_t jack_pcm_callback = {
 	.start = snd_pcm_jack_start,
 	.stop = snd_pcm_jack_stop,
 	.pointer = snd_pcm_jack_pointer,
+	.hw_free = snd_pcm_jack_hw_free,
 	.prepare = snd_pcm_jack_prepare,
 	.poll_revents = snd_pcm_jack_poll_revents,
 };
-- 
2.7.4
