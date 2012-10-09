From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ALSA: ASoC: McASP: add support for 24 bit
	samples
Date: Tue,  9 Oct 2012 09:35:16 +0200
Message-ID: <1349768116-23883-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E8FA26526D
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:35:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Matt Porter <mporter@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Cc: Matt Porter <mporter@ti.com>
---
v2: also enable 24bit in the DAI

 sound/soc/davinci/davinci-mcasp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1252bad..76728be 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -839,6 +839,14 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		word_length = DAVINCI_AUDIO_WORD_16;
 		break;
 
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_U24_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dma_params->data_type = 3;
+		word_length = DAVINCI_AUDIO_WORD_24;
+		break;
+
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_params->data_type = 4;
@@ -917,6 +925,10 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 				SNDRV_PCM_FMTBIT_U8 | \
 				SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_U16_LE | \
+				SNDRV_PCM_FMTBIT_S24_LE | \
+				SNDRV_PCM_FMTBIT_U24_LE | \
+				SNDRV_PCM_FMTBIT_S24_3LE | \
+				SNDRV_PCM_FMTBIT_U24_3LE | \
 				SNDRV_PCM_FMTBIT_S32_LE | \
 				SNDRV_PCM_FMTBIT_U32_LE)
 
-- 
1.7.11.4
