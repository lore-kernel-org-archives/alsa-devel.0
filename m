From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH] ASoC: soc-pcm: always cancel any pending
	delayed stream shutdown
Date: Wed, 22 Oct 2014 16:14:53 +0200
Message-ID: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.11])
 by alsa0.perex.cz (Postfix) with ESMTP id E28112651AF
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 16:15:52 +0200 (CEST)
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
Cc: hector.palacios@digi.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

After playback a shutdown is scheduled to happen within 5 seconds.
If another playback takes place before the scheduled work times out,
the work is cancelled, but if a recording takes place, the work will
shutdown in the middle of the recording, causing problems.

To reproduce the issue chain the following commands:
	arecord -M --duration 5 -c 2 /tmp/test.wav;
	aplay /tmp/test.wav;
	sleep 2;
	arecord -M --duration 5 -c 2 /tmp/test.wav;
	aplay /tmp/test.wav;

The fist command records 5 seconds of audio.
The second command plays the recorded audio. At the end of the playback
a work will be scheduled to shutdown in 5 seconds, but only 2 seconds after
the first playback, we run another recording.
When we have recorded 3 seconds, the shutdown will occur which can cause
incorrect behavior and bad recorded data. As a consequence, the last
playback reproduces correct audio for the first 3 seconds and incorrect audio
after that.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 sound/soc/soc-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 642c86240752..d19a926872e8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -760,8 +760,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	/* cancel any delayed stream shutdown that is pending */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    rtd->pop_wait) {
+	if (rtd->pop_wait) {
 		rtd->pop_wait = 0;
 		cancel_delayed_work(&rtd->delayed_work);
 	}
