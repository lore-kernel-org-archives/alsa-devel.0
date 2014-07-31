From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/7] ASoC: tlv320aic26: Convert to
	params_width()
Date: Thu, 31 Jul 2014 13:16:13 +0100
Message-ID: <1406808978-16175-2-git-send-email-broonie@kernel.org>
References: <1406808978-16175-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76E972652AD
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:16:33 +0200 (CEST)
In-Reply-To: <1406808978-16175-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 43069de3d56a..620ab9ea1ef0 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -71,8 +71,8 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 
 	dev_dbg(&aic26->spi->dev, "aic26_hw_params(substream=%p, params=%p)\n",
 		substream, params);
-	dev_dbg(&aic26->spi->dev, "rate=%i format=%i\n", params_rate(params),
-		params_format(params));
+	dev_dbg(&aic26->spi->dev, "rate=%i width=%d\n", params_rate(params),
+		params_width(params));
 
 	switch (params_rate(params)) {
 	case 8000:  fsref = 48000; divisor = AIC26_DIV_6; break;
@@ -89,11 +89,11 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* select data word length */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:     wlen = AIC26_WLEN_16; break;
-	case SNDRV_PCM_FORMAT_S16_BE: wlen = AIC26_WLEN_16; break;
-	case SNDRV_PCM_FORMAT_S24_BE: wlen = AIC26_WLEN_24; break;
-	case SNDRV_PCM_FORMAT_S32_BE: wlen = AIC26_WLEN_32; break;
+	switch (params_width(params)) {
+	case 8:  wlen = AIC26_WLEN_16; break;
+	case 16: wlen = AIC26_WLEN_16; break;
+	case 24: wlen = AIC26_WLEN_24; break;
+	case 32: wlen = AIC26_WLEN_32; break;
 	default:
 		dev_dbg(&aic26->spi->dev, "bad format\n"); return -EINVAL;
 	}
-- 
2.0.1
