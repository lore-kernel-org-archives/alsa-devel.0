From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 1/5] Permit simultaneous compilation of both
	PXA AC97 drivers
Date: Mon,  8 Sep 2008 13:06:09 +0400
Message-ID: <1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 3280C2452D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:08:51 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so590031eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 02:08:50 -0700 (PDT)
In-Reply-To: <20080908085339.GA31573@doriath.ww600.siemens.net>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 4345f38..771c592 100644
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
1.5.6.5
