From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/19] ASoC: samsung: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:20 +0100
Message-ID: <1387545625-19240-14-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 785A8265636
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:45 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/dma.c  | 6 ------
 sound/soc/samsung/idma.c | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index ee23194..dc09b71 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -35,12 +35,6 @@ static const struct snd_pcm_hardware dma_hardware = {
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
 				    SNDRV_PCM_INFO_MMAP_VALID,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-				    SNDRV_PCM_FMTBIT_U16_LE |
-				    SNDRV_PCM_FMTBIT_U8 |
-				    SNDRV_PCM_FMTBIT_S8,
-	.channels_min		= 2,
-	.channels_max		= 2,
 	.buffer_bytes_max	= 128*1024,
 	.period_bytes_min	= PAGE_SIZE,
 	.period_bytes_max	= PAGE_SIZE*2,
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index e4f318f..3d5cf15 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -35,14 +35,6 @@ static const struct snd_pcm_hardware idma_hardware = {
 		    SNDRV_PCM_INFO_MMAP_VALID |
 		    SNDRV_PCM_INFO_PAUSE |
 		    SNDRV_PCM_INFO_RESUME,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE |
-		    SNDRV_PCM_FMTBIT_U16_LE |
-		    SNDRV_PCM_FMTBIT_S24_LE |
-		    SNDRV_PCM_FMTBIT_U24_LE |
-		    SNDRV_PCM_FMTBIT_U8 |
-		    SNDRV_PCM_FMTBIT_S8,
-	.channels_min = 2,
-	.channels_max = 2,
 	.buffer_bytes_max = MAX_IDMA_BUFFER,
 	.period_bytes_min = 128,
 	.period_bytes_max = MAX_IDMA_PERIOD,
-- 
1.8.0
