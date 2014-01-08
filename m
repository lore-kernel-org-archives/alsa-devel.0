From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: max9850: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 20:40:44 +0000
Message-ID: <1389213644-11167-4-git-send-email-broonie@kernel.org>
References: <1389213644-11167-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C805265176
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 21:40:58 +0100 (CET)
In-Reply-To: <1389213644-11167-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwoog@dmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max9850.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index c5dd61785f8d..82757ebf0301 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -149,14 +149,14 @@ static int max9850_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_write(codec, MAX9850_LRCLK_MSB, (lrclk_div >> 8) & 0x7f);
 	snd_soc_write(codec, MAX9850_LRCLK_LSB, lrclk_div & 0xff);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		da = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		da = 0x2;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		da = 0x3;
 		break;
 	default:
-- 
1.8.5.2
