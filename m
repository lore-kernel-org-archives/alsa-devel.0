From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/14] ASoC: Permit simultaneous compilation of
	both PXA AC97 drivers
Date: Tue, 29 Jul 2008 11:42:24 +0100
Message-ID: <1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E19D2483B
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:40 +0200 (CEST)
In-Reply-To: <1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 2df03ee..45ac468 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -330,7 +330,7 @@ static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static u64 pxa2xx_pcm_dmamask = DMA_32BIT_MASK;
 
-int pxa2xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+static int pxa2xx_soc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
 	int ret = 0;
@@ -360,7 +360,7 @@ int pxa2xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 struct snd_soc_platform pxa2xx_soc_platform = {
 	.name		= "pxa2xx-audio",
 	.pcm_ops 	= &pxa2xx_pcm_ops,
-	.pcm_new	= pxa2xx_pcm_new,
+	.pcm_new	= pxa2xx_soc_pcm_new,
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(pxa2xx_soc_platform);
-- 
1.5.6.3
