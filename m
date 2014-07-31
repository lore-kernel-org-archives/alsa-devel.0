From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 7/7] ASoC: twl4030: Convert to params_width()
Date: Thu, 31 Jul 2014 13:16:18 +0100
Message-ID: <1406808978-16175-7-git-send-email-broonie@kernel.org>
References: <1406808978-16175-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 713BB2655EA
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:16:36 +0200 (CEST)
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
 sound/soc/codecs/twl4030.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cf404505e7d1..b6b0cb399599 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1763,16 +1763,16 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	old_format = twl4030_read(codec, TWL4030_REG_AUDIO_IF);
 	format = old_format;
 	format &= ~TWL4030_DATA_WIDTH;
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		format |= TWL4030_DATA_WIDTH_16S_16W;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		format |= TWL4030_DATA_WIDTH_32S_24W;
 		break;
 	default:
-		dev_err(codec->dev, "%s: unknown format %d\n", __func__,
-			params_format(params));
+		dev_err(codec->dev, "%s: unsupported bits/sample %d\n",
+			__func__, params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
