From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: max98095: Convert to params_width()
Date: Thu, 31 Jul 2014 13:25:07 +0100
Message-ID: <1406809509-21544-3-git-send-email-broonie@kernel.org>
References: <1406809509-21544-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E39426569E
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:25:24 +0200 (CEST)
In-Reply-To: <1406809509-21544-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/max98095.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 89ec00424880..0ee6797d5083 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1280,12 +1280,12 @@ static int max98095_dai2_hw_params(struct snd_pcm_substream *substream,
 
 	rate = params_rate(params);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		snd_soc_update_bits(codec, M98095_034_DAI2_FORMAT,
 			M98095_DAI_WS, 0);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		snd_soc_update_bits(codec, M98095_034_DAI2_FORMAT,
 			M98095_DAI_WS, M98095_DAI_WS);
 		break;
@@ -1341,12 +1341,12 @@ static int max98095_dai3_hw_params(struct snd_pcm_substream *substream,
 
 	rate = params_rate(params);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		snd_soc_update_bits(codec, M98095_03E_DAI3_FORMAT,
 			M98095_DAI_WS, 0);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		snd_soc_update_bits(codec, M98095_03E_DAI3_FORMAT,
 			M98095_DAI_WS, M98095_DAI_WS);
 		break;
-- 
2.0.1
