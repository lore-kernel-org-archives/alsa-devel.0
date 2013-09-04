From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] ASoC: atmel: disable error interrupt
Date: Wed,  4 Sep 2013 15:27:46 +0800
Message-ID: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A83E2654CA
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 09:29:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

As once the error interrupt is triggered, it can not be cleared.
So, disable it.

No side effect found while testing on sama5d3xek and at91sam9x5ek
boards.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0ecf356..bb53dea 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -649,7 +649,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 	dma_params = ssc_p->dma_params[dir];
 
 	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
-	ssc_writel(ssc_p->ssc->regs, IER, dma_params->mask->ssc_error);
+	ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
 
 	pr_debug("%s enabled SSC_SR=0x%08x\n",
 			dir ? "receive" : "transmit",
-- 
1.7.9.5
