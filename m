From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/8] ASoC: da7213: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 19:52:00 +0000
Message-ID: <1389210723-16535-5-git-send-email-broonie@kernel.org>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 885292651AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 20:55:09 +0100 (CET)
In-Reply-To: <1389210723-16535-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/da7213.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 4a6f1daf911f..0c77e7ad7423 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1067,17 +1067,17 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 	u8 fs;
 
 	/* Set DAI format */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S16_LE;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S20_LE;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S24_LE;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S32_LE;
 		break;
 	default:
-- 
1.8.5.2
