From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/3] ALSA: snd-usb-caiaq: set up internal
	sample pointer positions in trigger callback
Date: Fri, 10 Sep 2010 11:55:00 +0800
Message-ID: <1284090901-4533-2-git-send-email-daniel@caiaq.de>
References: <1284090901-4533-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 39D711038F5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 05:55:49 +0200 (CEST)
In-Reply-To: <1284090901-4533-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Calling prepare() on a stream which is already active shouldn't touch the
sample pointer positions. This code belongs into the trigger callback, so
move it there.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/audio.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 4328cad..db85320 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -194,21 +194,11 @@ static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
 static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	int bytes_per_sample, bpp, ret, i;
-	int index = substream->number;
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	debug("%s(%p)\n", __func__, substream);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
-		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
-	} else {
-		int in_pos = (dev->spec.data_alignment == 2) ? 0 : 2;
-		dev->period_in_count[index] = BYTES_PER_SAMPLE + in_pos;
-		dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE + in_pos;
-	}
-
 	if (dev->streaming)
 		return 0;
 
@@ -251,10 +241,21 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 
 static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *sub, int cmd)
 {
+	int index = sub->number;
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(sub);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
+			dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
+		} else {
+			int in_pos = (dev->spec.data_alignment == 2) ? 0 : 2;
+			dev->period_in_count[index] = BYTES_PER_SAMPLE + in_pos;
+			dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE + in_pos;
+		}
+
+		/* fall thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		activate_substream(dev, sub);
 		break;
-- 
1.7.0.4
