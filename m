From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: pxa2xx-pcm: remove unused variable 'dai'
Date: Wed, 06 Jul 2011 21:20:42 +0800
Message-ID: <1309958442.4613.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove unused variable 'dai' to eliminate below warning.

  CC      sound/soc/pxa/pxa2xx-pcm.o
sound/soc/pxa/pxa2xx-pcm.c: In function 'pxa2xx_soc_pcm_new':
sound/soc/pxa/pxa2xx-pcm.c:91: warning: unused variable 'dai'

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index da28394..c430600 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -88,7 +88,6 @@ static u64 pxa2xx_pcm_dmamask = DMA_BIT_MASK(32);
 static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
-- 
1.7.4.1
