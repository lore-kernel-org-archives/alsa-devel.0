From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/20] ALSA: usb: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:09 +0100
Message-ID: <20190205194221.25924-9-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 484F0267910
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:28 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usbusx2yaudio.c | 21 ++++++++++-----------
 sound/usb/usx2y/usx2yhwdeppcm.c | 19 ++++++++-----------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 2b833054e3b0..58974d094b27 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -981,18 +981,17 @@ static int usX2Y_audio_stream_new(struct snd_card *card, int playback_endpoint,
 
 	sprintf(pcm->name, NAME_ALLCAPS" Audio #%d", usX2Y(card)->pcm_devs);
 
-	if ((playback_endpoint &&
-	     0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
-						     SNDRV_DMA_TYPE_CONTINUOUS,
-						     snd_dma_continuous_data(GFP_KERNEL),
-						     64*1024, 128*1024))) ||
-	    0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
-	    					     SNDRV_DMA_TYPE_CONTINUOUS,
-	    					     snd_dma_continuous_data(GFP_KERNEL),
-						     64*1024, 128*1024))) {
-		snd_usX2Y_pcm_private_free(pcm);
-		return err;
+	if (playback_endpoint) {
+		snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data(GFP_KERNEL),
+					      64*1024, 128*1024);
 	}
+
+	snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+				      SNDRV_DMA_TYPE_CONTINUOUS,
+				      snd_dma_continuous_data(GFP_KERNEL),
+				      64*1024, 128*1024);
 	usX2Y(card)->pcm_devs++;
 
 	return 0;
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 4fd9276b8e50..714cf50d4a4c 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -736,17 +736,14 @@ int usX2Y_hwdep_pcm_new(struct snd_card *card)
 	pcm->info_flags = 0;
 
 	sprintf(pcm->name, NAME_ALLCAPS" hwdep Audio");
-	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
-						     SNDRV_DMA_TYPE_CONTINUOUS,
-						     snd_dma_continuous_data(GFP_KERNEL),
-						     64*1024, 128*1024)) ||
-	    0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
-	    					     SNDRV_DMA_TYPE_CONTINUOUS,
-	    					     snd_dma_continuous_data(GFP_KERNEL),
-						     64*1024, 128*1024))) {
-		return err;
-	}
-
+	snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
+				      SNDRV_DMA_TYPE_CONTINUOUS,
+				      snd_dma_continuous_data(GFP_KERNEL),
+				      64*1024, 128*1024);
+	snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+				      SNDRV_DMA_TYPE_CONTINUOUS,
+				      snd_dma_continuous_data(GFP_KERNEL),
+				      64*1024, 128*1024);
 
 	return 0;
 }
-- 
2.16.4
