From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 33/35] ASoC: wm8995: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:16 +0100
Message-ID: <1406807898-5927-33-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D93E265041
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:42 +0200 (CEST)
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
 sound/soc/codecs/wm8995.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 863a2c38bcb5..cae4ac5a5730 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -1597,21 +1597,21 @@ static int wm8995_hw_params(struct snd_pcm_substream *substream,
 		return bclk_rate;
 
 	aif1 = 0;
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		aif1 |= (0x1 << WM8995_AIF1_WL_SHIFT);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		aif1 |= (0x2 << WM8995_AIF1_WL_SHIFT);
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		aif1 |= (0x3 << WM8995_AIF1_WL_SHIFT);
 		break;
 	default:
 		dev_err(dai->dev, "Unsupported word length %u\n",
-			params_format(params));
+			params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
