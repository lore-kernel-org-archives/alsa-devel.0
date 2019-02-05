From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/20] ASoC: mediatek: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:13 +0100
Message-ID: <20190205194221.25924-13-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 71634267925
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
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 697aa50aff9a..3ce527ce30ce 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -126,9 +126,9 @@ int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
-	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     afe->dev,
-						     size, size);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      afe->dev, size, size);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
-- 
2.16.4
