From: Bo Shen <voice.shen@atmel.com>
Subject: [v2 3/5] ASoC: atmel-pcm-dma: move prepare for dma to dai prepare
Date: Wed,  3 Jul 2013 16:37:58 +0800
Message-ID: <1372840680-2253-4-git-send-email-voice.shen@atmel.com>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, lars@metafoo.de, richard.genoud@gmail.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

as prepare callback for dma is acctually access ssc register
which better done in dai driver, so move it to dai prepare
callback function

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change in v2:
  - split as a new patch
---
 sound/soc/atmel/atmel-pcm-dma.c |   14 --------------
 sound/soc/atmel/atmel_ssc_dai.c |    1 +
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 1d38fd0..5a57803 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -175,19 +175,6 @@ err:
 	return ret;
 }
 
-static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct atmel_pcm_dma_params *prtd;
-
-	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	ssc_writex(prtd->ssc->regs, SSC_IER, prtd->mask->ssc_error);
-	ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_enable);
-
-	return 0;
-}
-
 static int atmel_pcm_open(struct snd_pcm_substream *substream)
 {
 	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_dma_hardware);
@@ -200,7 +187,6 @@ static struct snd_pcm_ops atmel_pcm_ops = {
 	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_pcm_hw_params,
-	.prepare	= atmel_pcm_dma_prepare,
 	.trigger	= snd_dmaengine_pcm_trigger,
 	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
 	.mmap		= atmel_pcm_mmap,
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 1ab4763..0ecf356 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -649,6 +649,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 	dma_params = ssc_p->dma_params[dir];
 
 	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
+	ssc_writel(ssc_p->ssc->regs, IER, dma_params->mask->ssc_error);
 
 	pr_debug("%s enabled SSC_SR=0x%08x\n",
 			dir ? "receive" : "transmit",
-- 
1.7.9.5

