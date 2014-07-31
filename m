From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] ASoC: sta32x: Convert to params_width()
Date: Thu, 31 Jul 2014 13:02:20 +0100
Message-ID: <1406808143-8985-2-git-send-email-broonie@kernel.org>
References: <1406808143-8985-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F1DD2655AF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:02:36 +0200 (CEST)
In-Reply-To: <1406808143-8985-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/sta32x.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 0579d187135b..48740855566d 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -678,15 +678,11 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
 
 	confb = snd_soc_read(codec, STA32X_CONFB);
 	confb &= ~(STA32X_CONFB_SAI_MASK | STA32X_CONFB_SAIFB);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S24_LE:
-	case SNDRV_PCM_FORMAT_S24_BE:
-	case SNDRV_PCM_FORMAT_S24_3LE:
-	case SNDRV_PCM_FORMAT_S24_3BE:
+	switch (params_width(params)) {
+	case 24:
 		pr_debug("24bit\n");
 		/* fall through */
-	case SNDRV_PCM_FORMAT_S32_LE:
-	case SNDRV_PCM_FORMAT_S32_BE:
+	case 32:
 		pr_debug("24bit or 32bit\n");
 		switch (sta32x->format) {
 		case SND_SOC_DAIFMT_I2S:
@@ -701,8 +697,7 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-	case SNDRV_PCM_FORMAT_S20_3BE:
+	case 20:
 		pr_debug("20bit\n");
 		switch (sta32x->format) {
 		case SND_SOC_DAIFMT_I2S:
@@ -717,8 +712,7 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		break;
-	case SNDRV_PCM_FORMAT_S18_3LE:
-	case SNDRV_PCM_FORMAT_S18_3BE:
+	case 18:
 		pr_debug("18bit\n");
 		switch (sta32x->format) {
 		case SND_SOC_DAIFMT_I2S:
@@ -733,8 +727,7 @@ static int sta32x_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-	case SNDRV_PCM_FORMAT_S16_BE:
+	case 16:
 		pr_debug("16bit\n");
 		switch (sta32x->format) {
 		case SND_SOC_DAIFMT_I2S:
-- 
2.0.1
