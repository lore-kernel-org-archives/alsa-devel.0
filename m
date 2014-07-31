From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 22/35] ASoC: wm8962: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:05 +0100
Message-ID: <1406807898-5927-22-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C25662654D4
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
 sound/soc/codecs/wm8962.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ca2fda9d72be..4be6f2afdbc4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2586,16 +2586,16 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	if (wm8962->lrclk % 8000 == 0)
 		adctl3 |= WM8962_SAMPLE_RATE_INT_MODE;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		aif0 |= 0x4;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		aif0 |= 0x8;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		aif0 |= 0xc;
 		break;
 	default:
-- 
2.0.1
