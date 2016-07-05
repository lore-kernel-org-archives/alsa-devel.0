From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] ASoC: atmel_ssc_dai: Fix DMA params for
	different SSC
Date: Tue,  5 Jul 2016 11:46:29 +0200
Message-ID: <20160705094629.5326-1-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDB62664FA
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 11:48:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, "Wu,
 Songjun" <songjun.wu@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

follow-up patch from c706f2e55f ASoC: atmel_ssc_dai: distinguish the
different SSC

cpu_dai id is always 0, use platform_device id to distinguish DMA
parameters of SSCs

Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Cc: "Wu, Songjun" <songjun.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..c7daea8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -320,7 +320,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	dma_params = &ssc_dma_params[dai->id][dir];
+	dma_params = &ssc_dma_params[pdev->id][dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
-- 
2.9.0
