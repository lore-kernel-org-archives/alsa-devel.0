From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: adau1373: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 18:51:27 +0000
Message-ID: <1389207089-23741-3-git-send-email-broonie@kernel.org>
References: <1389207089-23741-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B7E265196
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 19:51:39 +0100 (CET)
In-Reply-To: <1389207089-23741-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/adau1373.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 59654b1e7f3f..eb836ed5271f 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1078,17 +1078,17 @@ static int adau1373_hw_params(struct snd_pcm_substream *substream,
 		ADAU1373_BCLKDIV_SR_MASK | ADAU1373_BCLKDIV_BCLK_MASK,
 		(div << 2) | ADAU1373_BCLKDIV_64);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		ctrl = ADAU1373_DAI_WLEN_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		ctrl = ADAU1373_DAI_WLEN_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		ctrl = ADAU1373_DAI_WLEN_24;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		ctrl = ADAU1373_DAI_WLEN_32;
 		break;
 	default:
-- 
1.8.5.2
