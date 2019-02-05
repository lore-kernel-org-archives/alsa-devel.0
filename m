From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/20] ALSA: sh: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:06 +0100
Message-ID: <20190205194221.25924-6-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47B4726790B
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
 sound/sh/aica.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 2b26311405a4..e7fef3fce44a 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -464,14 +464,12 @@ static int __init snd_aicapcmchip(struct snd_card_aica
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			&snd_aicapcm_playback_ops);
 	/* Allocate the DMA buffers */
-	err =
-	    snd_pcm_lib_preallocate_pages_for_all(pcm,
-						  SNDRV_DMA_TYPE_CONTINUOUS,
-						  snd_dma_continuous_data
-						  (GFP_KERNEL),
-						  AICA_BUFFER_SIZE,
-						  AICA_BUFFER_SIZE);
-	return err;
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data(GFP_KERNEL),
+					      AICA_BUFFER_SIZE,
+					      AICA_BUFFER_SIZE);
+	return 0;
 }
 
 /* Mixer controls */
-- 
2.16.4
