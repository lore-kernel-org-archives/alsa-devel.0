From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2] ASoC: PXA: Fix oops in __pxa2xx_pcm_prepare
Date: Sat,  2 Apr 2011 10:54:47 +0300
Message-ID: <1301730887-7755-1-git-send-email-anarsoul@gmail.com>
References: <1301686530-8560-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E373103856
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:56:58 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3372554fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Apr 2011 00:56:58 -0700 (PDT)
In-Reply-To: <1301686530-8560-1-git-send-email-anarsoul@gmail.com>
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
v2: use -EINVAL as error in __pxa2xx_pcm_prepare if dma_ch is invalid.

 sound/arm/pxa2xx-pcm-lib.c |    3 +++
 sound/soc/pxa/pxa2xx-pcm.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 8808b82..76e0d56 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -140,6 +140,9 @@ int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 	if (!prtd || !prtd->params)
 		return 0;
 
+	if (prtd->dma_ch == -1)
+		return -EINVAL;
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
