From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] ASoC: Staticise bf5xx_pcm_i2s_new()
Date: Wed, 21 Sep 2011 14:40:58 +0800
Message-ID: <1316587258.2824.2.camel@phoenix>
References: <1316587205.2824.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316587205.2824.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Cliff Cai <Cliff.Cai@analog.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is not used outside this driver so no need to make the symbol global.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 61ddf94..7565e15 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -257,7 +257,7 @@ static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
 
-int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
+static int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
-- 
1.7.4.1
