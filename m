From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/8] ASoC: alc5623: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 19:51:56 +0000
Message-ID: <1389210723-16535-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7958526519A
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 20:55:09 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/alc5623.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 256c364193a5..d3036283482a 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -714,17 +714,17 @@ static int alc5623_pcm_hw_params(struct snd_pcm_substream *substream,
 	iface &= ~ALC5623_DAI_I2S_DL_MASK;
 
 	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		iface |= ALC5623_DAI_I2S_DL_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface |= ALC5623_DAI_I2S_DL_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface |= ALC5623_DAI_I2S_DL_24;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface |= ALC5623_DAI_I2S_DL_32;
 		break;
 	default:
-- 
1.8.5.2
