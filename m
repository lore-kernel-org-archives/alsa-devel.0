From: linux@audioscience.com
Subject: [PATCH 21/21] Fix format validity check.
Date: Thu, 22 Dec 2011 13:38:51 +1300
Message-ID: <1324514331-22570-22-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 78962103C4A
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:22 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:34 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Sharing and not reinitialising static pcm_hardware struct resulted in
stream format validity flags being incorrectly shared between cards.
Fix and clarify by declaring locally and initialising in the open functions.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   69 +++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 4aa8336..f462a58 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -938,15 +938,15 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	return ptr;
 }
 
-static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
-						u32 h_stream,
-						struct snd_pcm_hardware *pcmhw)
+static u64 snd_card_asihpi_playback_formats(struct snd_card_asihpi *asihpi,
+						u32 h_stream)
 {
 	struct hpi_format hpi_format;
 	u16 format;
 	u16 err;
 	u32 h_control;
 	u32 sample_rate = 48000;
+	u64 formats = 0;
 
 	/* on cards without SRC, must query at valid rate,
 	* maybe set by external sync
@@ -966,32 +966,24 @@ static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 		if (!err)
 			err = hpi_outstream_query_format(h_stream, &hpi_format);
 		if (!err && (hpi_to_alsa_formats[format] != -1))
-			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[format]);
+			formats |= (1ULL << hpi_to_alsa_formats[format]);
 	}
+	return formats;
 }
 
-static struct snd_pcm_hardware snd_card_asihpi_playback = {
-	.buffer_bytes_max = BUFFER_BYTES_MAX,
-	.period_bytes_min = PERIOD_BYTES_MIN,
-	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
-	.periods_min = PERIODS_MIN,
-	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
-	.fifo_size = 0,
-};
-
 static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm;
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
+	struct snd_pcm_hardware snd_card_asihpi_playback;
 	int err;
 
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 
-	err =
-	    hpi_outstream_open(card->hpi->adapter->index,
+	err = hpi_outstream_open(card->hpi->adapter->index,
 			      substream->number, &dpcm->h_stream);
 	hpi_handle_error(err);
 	if (err)
@@ -1013,13 +1005,19 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
-	snd_card_asihpi_playback.channels_max = card->out_max_chans;
-	snd_card_asihpi_playback.channels_min = card->out_min_chans;
+	memset(&snd_card_asihpi_playback, 0, sizeof(snd_card_asihpi_playback));
+	snd_card_asihpi_playback.buffer_bytes_max = BUFFER_BYTES_MAX;
+	snd_card_asihpi_playback.period_bytes_min = PERIOD_BYTES_MIN;
 	/*?snd_card_asihpi_playback.period_bytes_min =
 	card->out_max_chans * 4096; */
-
-	snd_card_asihpi_playback_format(card, dpcm->h_stream,
-					&snd_card_asihpi_playback);
+	snd_card_asihpi_playback.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+	snd_card_asihpi_playback.periods_min = PERIODS_MIN;
+	snd_card_asihpi_playback.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	/* snd_card_asihpi_playback.fifo_size = 0; */
+	snd_card_asihpi_playback.channels_max = card->out_max_chans;
+	snd_card_asihpi_playback.channels_min = card->out_min_chans;
+	snd_card_asihpi_playback.formats =
+			snd_card_asihpi_playback_formats(card, dpcm->h_stream);
 
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_playback);
 
@@ -1116,15 +1114,15 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 
 
 
-static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
-					u32 h_stream,
-					 struct snd_pcm_hardware *pcmhw)
+static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
+					u32 h_stream)
 {
   struct hpi_format hpi_format;
 	u16 format;
 	u16 err;
 	u32 h_control;
 	u32 sample_rate = 48000;
+	u64 formats = 0;
 
 	/* on cards without SRC, must query at valid rate,
 		maybe set by external sync */
@@ -1144,25 +1142,17 @@ static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 		if (!err)
 			err = hpi_instream_query_format(h_stream, &hpi_format);
 		if (!err)
-			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[format]);
+			formats |= (1ULL << hpi_to_alsa_formats[format]);
 	}
+	return formats;
 }
 
-
-static struct snd_pcm_hardware snd_card_asihpi_capture = {
-	.buffer_bytes_max = BUFFER_BYTES_MAX,
-	.period_bytes_min = PERIOD_BYTES_MIN,
-	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
-	.periods_min = PERIODS_MIN,
-	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
-	.fifo_size = 0,
-};
-
 static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
 	struct snd_card_asihpi_pcm *dpcm;
+	struct snd_pcm_hardware snd_card_asihpi_capture;
 	int err;
 
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
@@ -1189,10 +1179,17 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
+	memset(&snd_card_asihpi_capture, 0, sizeof(snd_card_asihpi_capture));
+	snd_card_asihpi_capture.buffer_bytes_max = BUFFER_BYTES_MAX;
+	snd_card_asihpi_capture.period_bytes_min = PERIOD_BYTES_MIN;
+	snd_card_asihpi_capture.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+	snd_card_asihpi_capture.periods_min = PERIODS_MIN;
+	snd_card_asihpi_capture.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	/* snd_card_asihpi_capture.fifo_size = 0; */
 	snd_card_asihpi_capture.channels_max = card->in_max_chans;
 	snd_card_asihpi_capture.channels_min = card->in_min_chans;
-	snd_card_asihpi_capture_format(card, dpcm->h_stream,
-				       &snd_card_asihpi_capture);
+	snd_card_asihpi_capture.formats =
+		snd_card_asihpi_capture_formats(card, dpcm->h_stream);
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_capture);
 	snd_card_asihpi_capture.info = SNDRV_PCM_INFO_INTERLEAVED |
 					SNDRV_PCM_INFO_MMAP |
-- 
1.7.0.4
