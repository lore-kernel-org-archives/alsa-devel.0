From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin] jack: Write only valid
	values to the internal hw_ptr
Date: Mon, 22 Jan 2018 09:37:20 +0100
Message-ID: <1516610240-7772-1-git-send-email-twischer@de.adit-jv.com>
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

Otherwise the ALSA thread could for example read a hw_ptr >
buffer_size

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 4468ede..3aed332 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -137,6 +137,7 @@ static int
 snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
+	snd_pcm_uframes_t hw_ptr;
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0;
 	unsigned int channel;
@@ -155,12 +156,13 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 			return 0;
 		}
 	}
-	
+
+	hw_ptr = jack->hw_ptr;
 	areas = snd_pcm_ioplug_mmap_areas(io);
 
 	while (xfer < nframes) {
 		snd_pcm_uframes_t frames = nframes - xfer;
-		snd_pcm_uframes_t offset = jack->hw_ptr;
+		snd_pcm_uframes_t offset = hw_ptr;
 		snd_pcm_uframes_t cont = io->buffer_size - offset;
 
 		if (cont < frames)
@@ -173,10 +175,11 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 				snd_pcm_area_copy(&areas[channel], offset, &jack->areas[channel], xfer, frames, io->format);
 		}
 		
-		jack->hw_ptr += frames;
-		jack->hw_ptr %= io->buffer_size;
+		hw_ptr += frames;
+		hw_ptr %= io->buffer_size;
 		xfer += frames;
 	}
+	jack->hw_ptr = hw_ptr;
 
 	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
 
-- 
2.7.4
