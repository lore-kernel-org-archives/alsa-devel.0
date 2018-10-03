From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: pxa-ssp: enable and disable extclk if
	given
Date: Wed,  3 Oct 2018 21:36:27 +0200
Message-ID: <20181003193627.5423-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2092677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 21:36:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

If a "extclk" clock is given, enable and disable it when appropriate.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/pxa-ssp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 69033e1a84e6..adcf8ba9d287 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -103,6 +103,9 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		pxa_ssp_disable(ssp);
 	}
 
+	if (priv->extclk)
+		clk_prepare_enable(priv->extclk);
+
 	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
 		return -ENOMEM;
@@ -125,6 +128,9 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		clk_disable_unprepare(ssp->clk);
 	}
 
+	if (priv->extclk)
+		clk_disable_unprepare(priv->extclk);
+
 	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
 	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
 }
-- 
2.17.1
