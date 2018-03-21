From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM 1/1] jack: Use correct parameter
	order for snd_pcm_areas_silence()
Date: Wed, 21 Mar 2018 12:42:32 +0100
Message-ID: <1521632552-24858-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Without this fix it will sometimes fail with a segmentation fault.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index a655668..e3df4d2 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -200,7 +200,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
 			const snd_pcm_uframes_t frames = nframes - xfer;
 
-			snd_pcm_areas_silence(jack->areas, io->channels, xfer,
+			snd_pcm_areas_silence(jack->areas, xfer, io->channels,
 					      frames, io->format);
 		}
 
-- 
2.7.4
