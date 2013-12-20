From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 2/6] ASoC: fsl_sai: Use snd_pcm_format_width()
Date: Fri, 20 Dec 2013 16:41:01 +0800
Message-ID: <b9f2ad8b7ef55d36ce451a1633dce240261d5e87.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 1482F265536
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:43 +0100 (CET)
In-Reply-To: <cover.1387528048.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Use common helper function snd_pcm_format_width() to make code neater.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index e3e8aa1..6f1e8aa 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -244,9 +244,10 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *cpu_dai)
 {
-	u32 val_cr4, val_cr5, val_mr, reg_cr4, reg_cr5, reg_mr, word_width;
+	u32 val_cr4, val_cr5, val_mr, reg_cr4, reg_cr5, reg_mr;
 	unsigned int channels = params_channels(params);
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 word_width = snd_pcm_format_width(params_format(params));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		reg_cr4 = FSL_SAI_TCR4;
@@ -267,20 +268,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 &= ~FSL_SAI_CR5_W0W_MASK;
 	val_cr5 &= ~FSL_SAI_CR5_FBT_MASK;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		word_width = 16;
-		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-		word_width = 20;
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		word_width = 24;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
 	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
-- 
1.8.4
