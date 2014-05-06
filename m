From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: atmel-pcm-pdc: Remove broken
	suspend/resume code
Date: Tue,  6 May 2014 09:39:40 +0200
Message-ID: <1399361981-18518-5-git-send-email-lars@metafoo.de>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id C9CC82615B6
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:53 +0200 (CEST)
In-Reply-To: <1399361981-18518-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Suspend/resume support for the atmel-pcm-pdc driver was broken in commit
f0fba2ad1 ("ASoC: multi-component - ASoC Multi-Component Support"). It
essentially reverted the modifications done in commit 10cab262 ("ASoC: Change
how suspend and resume obtain the PCM runtime"). The suspend and resume handlers
at the beginning check if dai->runtime is not NULL, but dai->runtime is always
NULL, hence the code never runs. Considering that nobody noticed any problems in
the last 4 years since the code was broken and that the driver does not set
SNDRV_PCM_INFO_RESUME, which means applications are expected to stop and restart
the audio stream during suspend/resume, it is probably safe to assume that his
code is not needed and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Even before this was fully broken, the code was already partially broken since
it did only save/restore the playback registers, but not the capture registers,
so fixing this basically requires a rewrite. And since SNDRV_PCM_INFO_RESUME was
never set it's not clear if even playback suspend/resume ever worked correctly.
Given this I think it's better just remove the code rather than trying to fix
and risking breaking things even more.
---
 sound/soc/atmel/atmel-pcm-pdc.c | 63 -----------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 33ec592..a366b35 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -76,12 +76,6 @@ struct atmel_runtime_data {
 	size_t period_size;
 
 	dma_addr_t period_ptr;		/* physical address of next period */
-
-	/* PDC register save */
-	u32 pdc_xpr_save;
-	u32 pdc_xcr_save;
-	u32 pdc_xnpr_save;
-	u32 pdc_xncr_save;
 };
 
 /*--------------------------------------------------------------------------*\
@@ -320,67 +314,10 @@ static struct snd_pcm_ops atmel_pcm_ops = {
 	.mmap		= atmel_pcm_mmap,
 };
 
-
-/*--------------------------------------------------------------------------*\
- * ASoC platform driver
-\*--------------------------------------------------------------------------*/
-#ifdef CONFIG_PM
-static int atmel_pcm_suspend(struct snd_soc_dai *dai)
-{
-	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct atmel_runtime_data *prtd;
-	struct atmel_pcm_dma_params *params;
-
-	if (!runtime)
-		return 0;
-
-	prtd = runtime->private_data;
-	params = prtd->params;
-
-	/* disable the PDC and save the PDC registers */
-
-	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
-
-	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
-	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
-	prtd->pdc_xnpr_save = ssc_readx(params->ssc->regs, params->pdc->xnpr);
-	prtd->pdc_xncr_save = ssc_readx(params->ssc->regs, params->pdc->xncr);
-
-	return 0;
-}
-
-static int atmel_pcm_resume(struct snd_soc_dai *dai)
-{
-	struct snd_pcm_runtime *runtime = dai->runtime;
-	struct atmel_runtime_data *prtd;
-	struct atmel_pcm_dma_params *params;
-
-	if (!runtime)
-		return 0;
-
-	prtd = runtime->private_data;
-	params = prtd->params;
-
-	/* restore the PDC registers and enable the PDC */
-	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
-
-	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
-	return 0;
-}
-#else
-#define atmel_pcm_suspend	NULL
-#define atmel_pcm_resume	NULL
-#endif
-
 static struct snd_soc_platform_driver atmel_soc_platform = {
 	.ops		= &atmel_pcm_ops,
 	.pcm_new	= atmel_pcm_new,
 	.pcm_free	= atmel_pcm_free,
-	.suspend	= atmel_pcm_suspend,
-	.resume		= atmel_pcm_resume,
 };
 
 int atmel_pcm_pdc_platform_register(struct device *dev)
-- 
1.8.0
