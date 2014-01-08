From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 6/8] ASoC: da732x: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 19:52:01 +0000
Message-ID: <1389210723-16535-6-git-send-email-broonie@kernel.org>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74947265196
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
 sound/soc/codecs/da732x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index dc0284dc9e6f..f295b6569910 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -973,17 +973,17 @@ static int da732x_hw_params(struct snd_pcm_substream *substream,
 
 	reg_aif = dai->driver->base;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		aif |= DA732X_AIF_WORD_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		aif |= DA732X_AIF_WORD_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		aif |= DA732X_AIF_WORD_24;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		aif |= DA732X_AIF_WORD_32;
 		break;
 	default:
-- 
1.8.5.2
