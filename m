From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] ASoC: Staticise nuc900_dma_getposition()
Date: Wed, 21 Sep 2011 14:42:49 +0800
Message-ID: <1316587369.2824.4.camel@phoenix>
References: <1316587205.2824.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316587205.2824.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wan ZongShun <mcuos.com@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is not used outside this driver so no need to make the symbol global.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index e46d551..4e3626b 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -227,7 +227,7 @@ static int nuc900_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
-int nuc900_dma_getposition(struct snd_pcm_substream *substream,
+static int nuc900_dma_getposition(struct snd_pcm_substream *substream,
 					dma_addr_t *src, dma_addr_t *dst)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-- 
1.7.4.1
