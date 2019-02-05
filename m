From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/20] ASoC: stm: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:16 +0100
Message-ID: <20190205194221.25924-16-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B04926793F
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
 sound/soc/stm/stm32_adfsdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 706ff005234f..47901983a6ff 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -262,8 +262,9 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	unsigned int size = DFSDM_MAX_PERIODS * DFSDM_MAX_PERIOD_SIZE;
 
-	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     priv->dev, size, size);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      priv->dev, size, size);
+	return 0;
 }
 
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
-- 
2.16.4
