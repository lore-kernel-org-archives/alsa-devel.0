From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix Blackfin I2S _pointer()
	implementation return in bounds values
Date: Thu, 23 Jun 2011 20:02:11 +0100
Message-ID: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C3F6246BE
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 21:02:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Blackfin DMA controller can report one frame beyond the end of the
buffer in the wraparound case but ALSA requires that the pointer always
be in the buffer. Do the wraparound to handle this. A similar bug is
likely to apply to the other Blackfin PCM drivers but the code is less
obvious to inspection and I don't have a user to test.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 4a805a8..819d3bd 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -138,11 +138,21 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 	pr_debug("%s enter\n", __func__);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		diff = sport_curr_offset_tx(sport);
-		frames = bytes_to_frames(substream->runtime, diff);
 	} else {
 		diff = sport_curr_offset_rx(sport);
-		frames = bytes_to_frames(substream->runtime, diff);
 	}
+
+	/*
+	 * TX at least can report one frame beyond the end of the
+	 * buffer if we hit the wraparound case - clamp to within the
+	 * buffer as the ALSA APIs require.
+	 */
+	if (diff == snd_pcm_lib_buffer_bytes(substream))
+		diff = 0;
+	}
+
+	frames = bytes_to_frames(substream->runtime, diff);
+
 	return frames;
 }
 
-- 
1.7.5.4
