From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/7] ASoC: tas5086: Convert to params_width()
Date: Thu, 31 Jul 2014 13:16:12 +0100
Message-ID: <1406808978-16175-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6B82655E7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:16:33 +0200 (CEST)
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
 sound/soc/codecs/tas5086.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index be7194b43b7a..249ef5c4c762 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -425,14 +425,14 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* ... then add the offset for the sample bit depth. */
-	switch (params_format(params)) {
-        case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+        case 16:
 		val += 0;
                 break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val += 1;
 		break;
-	case SNDRV_PCM_FORMAT_S24_3LE:
+	case 24:
 		val += 2;
 		break;
 	default:
-- 
2.0.1
