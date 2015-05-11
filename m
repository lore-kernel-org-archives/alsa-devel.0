From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 3/3] ASoC: fsl_sai: add 12kHz, 24kHz,
	176.4kHz and 192kHz sample rate support
Date: Mon, 11 May 2015 18:24:43 +0800
Message-ID: <1431339894-4248-3-git-send-email-zidan.wang@freescale.com>
References: <cover.1431337606.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0116.outbound.protection.outlook.com [157.56.111.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 42CDE2614EE
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:23:27 +0200 (CEST)
In-Reply-To: <cover.1431337606.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Normally we don't support 12kHz, 24kHz in audio driver, alsa didn't
have formal definition of 12kHz, 24kHz, but alsa supply a way to
support these sample rates. And add 176.4kHz and 192kHz support.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 88f5861..7efcac4 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -27,6 +27,17 @@
 #define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
 		       FSL_SAI_CSR_FEIE)
 
+static u32 fsl_sai_rates[] = {
+	8000, 11025, 12000, 16000, 22050,
+	24000, 32000, 44100, 48000, 64000,
+	88200, 96000, 176400, 192000
+};
+
+static struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
+	.count = ARRAY_SIZE(fsl_sai_rates),
+	.list = fsl_sai_rates,
+};
+
 static irqreturn_t fsl_sai_isr(int irq, void *devid)
 {
 	struct fsl_sai *sai = (struct fsl_sai *)devid;
@@ -531,7 +542,10 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
 			   FSL_SAI_CR3_TRCE);
 
-	return 0;
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
+
+	return ret;
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
@@ -586,14 +600,18 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
 	.ops = &fsl_sai_pcm_dai_ops,
-- 
1.9.1
