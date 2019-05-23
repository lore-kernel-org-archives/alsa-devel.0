From: Philippe Bekaert <Philippe.Bekaert@panokkel.be>
Subject: [PATCH] Fix single speed ADAT capture and playback
	with RME HDSPe AIO
Date: Thu, 23 May 2019 23:56:49 +0200
Message-ID: <20190523215649.GA17263@bladje>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from com-out001.mailprotect.be (com-out001.mailprotect.be
 [83.217.72.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3313BF80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 23:57:00 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

By taking into account the mapping from logical to DMA channels when
enabling or disabling audio channels, ADAT channels 3 to 8 on the RME
HDSPe AIO card are now correctly captured and played back in single speed
mode.

Since the mapping is an identity mapping for all cards except AIO and
RayDAT, only those cards should be affected by this patch. It was tested on
an AIO card. The patch needs testing on other cards, in particular RayDAT.

Note: this patch does not solve ADAT capture and playback issues in double
or triple speed mode. That seems to be another problem.

Signed-off-by: Philippe Bekaert <Philippe.Bekaert@panokkel.be>
---
 sound/pci/rme9652/hdspm.c | 61 +++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1209cf0b05e0..982b297b3d0a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -23,6 +23,9 @@
  *
  *	Modified 2011-01-25 variable period sizes on RayDAT/AIO by Adrian Knoth
  *
+ *      Modified 2019-05-23 fix AIO single speed ADAT capture and playback
+ *      by Philippe.Bekaert@uhasselt.be
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -1105,9 +1108,9 @@ static int hdspm_autosync_ref(struct hdspm *hdspm);
 static int hdspm_set_toggle_setting(struct hdspm *hdspm, u32 regmask, int out);
 static int snd_hdspm_set_defaults(struct hdspm *hdspm);
 static int hdspm_system_clock_mode(struct hdspm *hdspm);
-static void hdspm_set_sgbuf(struct hdspm *hdspm,
-			    struct snd_pcm_substream *substream,
-			     unsigned int reg, int channels);
+static void hdspm_set_channel_dma_addr(struct hdspm *hdspm,
+				       struct snd_pcm_substream *substream,
+				       unsigned int reg, int channels);
 
 static int hdspm_aes_sync_check(struct hdspm *hdspm, int idx);
 static int hdspm_wc_sync_check(struct hdspm *hdspm);
@@ -5588,11 +5591,16 @@ static int snd_hdspm_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 
-		hdspm_set_sgbuf(hdspm, substream, HDSPM_pageAddressBufferOut,
-				params_channels(params));
+		for (i = 0; i < params_channels(params); ++i) {
+			int c = hdspm->channel_map_out[i];
 
-		for (i = 0; i < params_channels(params); ++i)
-			snd_hdspm_enable_out(hdspm, i, 1);
+			if (c < 0)
+				continue;      /* just make sure */
+			hdspm_set_channel_dma_addr(hdspm, substream,
+						   HDSPM_pageAddressBufferOut,
+						   c);
+			snd_hdspm_enable_out(hdspm, c, 1);
+		}
 
 		hdspm->playback_buffer =
 			(unsigned char *) substream->runtime->dma_area;
@@ -5600,11 +5608,16 @@ static int snd_hdspm_hw_params(struct snd_pcm_substream *substream,
 			"Allocated sample buffer for playback at %p\n",
 				hdspm->playback_buffer);
 	} else {
-		hdspm_set_sgbuf(hdspm, substream, HDSPM_pageAddressBufferIn,
-				params_channels(params));
-
-		for (i = 0; i < params_channels(params); ++i)
-			snd_hdspm_enable_in(hdspm, i, 1);
+		for (i = 0; i < params_channels(params); ++i) {
+			int c = hdspm->channel_map_in[i];
+
+			if (c < 0)
+				continue;
+			hdspm_set_channel_dma_addr(hdspm, substream,
+						   HDSPM_pageAddressBufferIn,
+						   c);
+			snd_hdspm_enable_in(hdspm, c, 1);
+		}
 
 		hdspm->capture_buffer =
 			(unsigned char *) substream->runtime->dma_area;
@@ -5665,19 +5678,17 @@ static int snd_hdspm_hw_free(struct snd_pcm_substream *substream)
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-
-		/* params_channels(params) should be enough,
-		   but to get sure in case of error */
-		for (i = 0; i < hdspm->max_channels_out; ++i)
+		/* Just disable all channels. The saving when disabling a */
+		/* smaller set is not worth the trouble. */
+		for (i = 0; i < HDSPM_MAX_CHANNELS; ++i)
 			snd_hdspm_enable_out(hdspm, i, 0);
 
 		hdspm->playback_buffer = NULL;
 	} else {
-		for (i = 0; i < hdspm->max_channels_in; ++i)
+		for (i = 0; i < HDSPM_MAX_CHANNELS; ++i)
 			snd_hdspm_enable_in(hdspm, i, 0);
 
 		hdspm->capture_buffer = NULL;
-
 	}
 
 	snd_pcm_lib_free_pages(substream);
@@ -6416,17 +6427,17 @@ static int snd_hdspm_preallocate_memory(struct hdspm *hdspm)
 	return 0;
 }
 
-
-static void hdspm_set_sgbuf(struct hdspm *hdspm,
-			    struct snd_pcm_substream *substream,
-			     unsigned int reg, int channels)
+/* Inform the card what DMA addresses to use for the indicated channel. */
+/* Each channel got 16 4K pages allocated for DMA transfers. */
+static void hdspm_set_channel_dma_addr(struct hdspm *hdspm,
+				       struct snd_pcm_substream *substream,
+				       unsigned int reg, int channel)
 {
 	int i;
 
-	/* continuous memory segment */
-	for (i = 0; i < (channels * 16); i++)
+	for (i = channel * 16; i < channel * 16 + 16; i++)
 		hdspm_write(hdspm, reg + 4 * i,
-				snd_pcm_sgbuf_get_addr(substream, 4096 * i));
+			    snd_pcm_sgbuf_get_addr(substream, 4096 * i));
 }
 
 
-- 
2.19.1
