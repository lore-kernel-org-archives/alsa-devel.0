From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/20] ASoC: sh: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:15 +0100
Message-ID: <20190205194221.25924-15-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A12A2678FD
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:29 +0100 (CET)
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
 sound/soc/sh/fsi.c       |  3 ++-
 sound/soc/sh/rcar/core.c |  5 +----
 sound/soc/sh/siu_pcm.c   | 13 +------------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index aa7e902f0c02..285afbafa662 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1768,11 +1768,12 @@ static const struct snd_pcm_ops fsi_pcm_ops = {
 
 static int fsi_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_pcm_lib_preallocate_pages_for_all(
+	snd_pcm_lib_preallocate_pages_for_all(
 		rtd->pcm,
 		SNDRV_DMA_TYPE_DEV,
 		rtd->card->snd_card->dev,
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
 }
 
 /*
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 59e250cc2e9d..29213b90755f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1575,7 +1575,6 @@ static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_substream *substream;
-	int err;
 
 	/*
 	 * use Audio-DMAC dev if we can use IPMMU
@@ -1588,12 +1587,10 @@ static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
 	for (substream = rtd->pcm->streams[stream].substream;
 	     substream;
 	     substream = substream->next) {
-		err = snd_pcm_lib_preallocate_pages(substream,
+		snd_pcm_lib_preallocate_pages(substream,
 					SNDRV_DMA_TYPE_DEV,
 					dev,
 					PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
-		if (err < 0)
-			return err;
 	}
 
 	return 0;
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 23384c477740..78c3145b4109 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -541,15 +541,9 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (ret < 0)
 			return ret;
 
-		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
 				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
-		if (ret < 0) {
-			dev_err(card->dev,
-			       "snd_pcm_lib_preallocate_pages_for_all() err=%d",
-				ret);
-			goto fail;
-		}
 
 		(*port_info)->pcm = pcm;
 
@@ -562,11 +556,6 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 	dev_info(card->dev, "SuperH SIU driver initialized.\n");
 	return 0;
-
-fail:
-	siu_free_port(siu_ports[pdev->id]);
-	dev_err(card->dev, "SIU: failed to initialize.\n");
-	return ret;
 }
 
 static void siu_pcm_free(struct snd_pcm *pcm)
-- 
2.16.4
