From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/14] ASoC: atmel-pcm-dma: Do not use
	snd_dmaengine_pcm_{set, get}_data()
Date: Fri, 22 Mar 2013 14:12:09 +0100
Message-ID: <1363957934-20059-10-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 56A72266549
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:03 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

We want to get rid of snd_dmaengine_pcm_{set,get}_data(). All instances of
snd_dmaengine_pcm_get_data() in the atmel pcm driver can easily be replaced with
snd_soc_dai_get_dma_data().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bo Shen <voice.shen@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel-pcm-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 396bf78..b8570e3 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -67,9 +67,10 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 static void atmel_pcm_dma_irq(u32 ssc_sr,
 	struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_pcm_dma_params *prtd;
 
-	prtd = snd_dmaengine_pcm_get_data(substream);
+	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if (ssc_sr & prtd->mask->ssc_error) {
 		if (snd_pcm_running(substream))
@@ -104,15 +105,13 @@ static bool filter(struct dma_chan *chan, void *slave)
 }
 
 static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+	struct snd_pcm_hw_params *params, struct atmel_pcm_dma_params *prtd)
 {
-	struct atmel_pcm_dma_params *prtd;
 	struct ssc_device *ssc;
 	struct dma_chan *dma_chan;
 	struct dma_slave_config slave_config;
 	int ret;
 
-	prtd = snd_dmaengine_pcm_get_data(substream);
 	ssc = prtd->ssc;
 
 	ret = snd_hwparams_to_dma_slave_config(substream, params,
@@ -164,9 +163,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_dmaengine_pcm_set_data(substream, prtd);
-
-	ret = atmel_pcm_configure_dma(substream, params);
+	ret = atmel_pcm_configure_dma(substream, params, prtd);
 	if (ret) {
 		pr_err("atmel-pcm: failed to configure dmai\n");
 		goto err;
@@ -182,9 +179,10 @@ err:
 
 static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_pcm_dma_params *prtd;
 
-	prtd = snd_dmaengine_pcm_get_data(substream);
+	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ssc_writex(prtd->ssc->regs, SSC_IER, prtd->mask->ssc_error);
 	ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_enable);
-- 
1.8.0
