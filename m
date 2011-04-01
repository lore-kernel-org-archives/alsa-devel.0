From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: PXA: Fix oops in __pxa2xx_pcm_prepare
Date: Fri,  1 Apr 2011 22:35:30 +0300
Message-ID: <1301686530-8560-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id AA5242447D
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 21:37:19 +0200 (CEST)
Received: by bwz10 with SMTP id 10so2847535bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2011 12:37:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

pxa2xx_pcm_hw_free frees dma channel and sets prtd->dma_ch to -1,
but does not set prtd->params to NULL, so if pxa2xx_pcm_hw_params will
be called immediately, it leaves prtd->dma_ch initialized with -1,
and it results in oops in __pxa2xx_pcm_prepare. This bug is triggered
via SDL.

This patch adds check for prtd->dma_ch to __pxa2xx_pcm_prepare and
cleans prtd->params, so now it works properly.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/arm/pxa2xx-pcm-lib.c |    3 +++
 sound/soc/pxa/pxa2xx-pcm.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 8808b82..52b1e17 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -140,6 +140,9 @@ int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 	if (!prtd || !prtd->params)
 		return 0;
 
+	if (prtd->dma_ch == -1)
+		return -EIO;
+
 	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
 	DCSR(prtd->dma_ch) = 0;
 	DCMD(prtd->dma_ch) = 0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 02fb664..2ce0b2d 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -65,6 +65,7 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (prtd->dma_ch >= 0) {
 		pxa_free_dma(prtd->dma_ch);
 		prtd->dma_ch = -1;
+		prtd->params = NULL;
 	}
 
 	return 0;
-- 
1.7.4.1
