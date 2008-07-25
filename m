From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] Permit simultaneous compilation of both PXA
	AC97 drivers
Date: Sat, 26 Jul 2008 01:51:51 +0400
Message-ID: <1217022714-2521-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 7417C2445C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 23:52:03 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1235413nfd.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 14:52:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, broonie@opensource.wolfsonmicro.com, eric.miao@marvell.com, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
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
1.5.6.2
