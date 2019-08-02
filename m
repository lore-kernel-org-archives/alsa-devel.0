From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/2] ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver
Date: Fri, 2 Aug 2019 19:21:23 +0530
Message-ID: <1564753899-17124-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Alexander.Deucher@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, YueHaibing <yuehaibing@huawei.com>, Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, Colin Ian King <colin.king@canonical.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

AMD platform device acp3x_rv_i2s created by parent PCI device
driver. Pass struct device of the parent to
snd_pcm_lib_preallocate_pages() so dma_alloc_coherent() can use
correct dma_ops. Otherwise, it will use default dma_ops which
is nommu_dma_ops on x86_64 even when IOMMU is enabled and
set to non passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a4ade6b..905ed2f 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -385,9 +385,11 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	struct device *parent = component->dev->parent;
 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      rtd->pcm->card->dev,
-					      MIN_BUFFER, MAX_BUFFER);
+					      parent, MIN_BUFFER, MAX_BUFFER);
 	return 0;
 }
 
-- 
2.7.4
