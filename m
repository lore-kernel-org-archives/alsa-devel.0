From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 32/35] ASoC: wm8994: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:15 +0100
Message-ID: <1406807898-5927-32-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B891E2654D3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:45 +0200 (CEST)
In-Reply-To: <1406807898-5927-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8994.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 39d8df040116..6cc0566dc29a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2815,19 +2815,19 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	bclk_rate = params_rate(params);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		bclk_rate *= 16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		bclk_rate *= 20;
 		aif1 |= 0x20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		bclk_rate *= 24;
 		aif1 |= 0x40;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		bclk_rate *= 32;
 		aif1 |= 0x60;
 		break;
@@ -2966,16 +2966,16 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		aif1 |= 0x20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		aif1 |= 0x40;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		aif1 |= 0x60;
 		break;
 	default:
-- 
2.0.1
