From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] soc - at91-pcm - Fix line wrapping
Date: Thu,  8 May 2008 11:27:54 +0100
Message-ID: <1210242475-24279-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F24E01037FC
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 12:27:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

There's more checkpatch stuff to fix in the driver, this just fixes the
minimum required for the following patch to be clean.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/at91/at91-pcm.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/at91/at91-pcm.c b/sound/soc/at91/at91-pcm.c
index 67c88e3..e36533d 100644
--- a/sound/soc/at91/at91-pcm.c
+++ b/sound/soc/at91/at91-pcm.c
@@ -103,7 +103,8 @@ static void at91_pcm_dma_irq(u32 ssc_sr,
 		if (prtd->period_ptr >= prtd->dma_buffer_end) {
 			prtd->period_ptr = prtd->dma_buffer;
 		}
-		at91_ssc_write(params->ssc_base + params->pdc->xnpr, prtd->period_ptr);
+		at91_ssc_write(params->ssc_base + params->pdc->xnpr,
+			       prtd->period_ptr);
 		at91_ssc_write(params->ssc_base + params->pdc->xncr,
 				prtd->period_size / params->pdc_xfer_size);
 	}
@@ -191,10 +192,12 @@ static int at91_pcm_trigger(struct snd_pcm_substream *substream,
 		at91_ssc_write(params->ssc_base + AT91_SSC_IER,
 			params->mask->ssc_endx | params->mask->ssc_endbuf);
 
-		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR,
+			params->mask->pdc_enable);
 
-		DBG("sr=%lx imr=%lx\n", at91_ssc_read(params->ssc_base + AT91_SSC_SR),
-					at91_ssc_read(params->ssc_base + AT91_SSC_IER));
+		DBG("sr=%lx imr=%lx\n",
+		    at91_ssc_read(params->ssc_base + AT91_SSC_SR),
+		    at91_ssc_read(params->ssc_base + AT91_SSC_IER));
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.5.5.1
