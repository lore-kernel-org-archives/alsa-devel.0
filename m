From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/7] ASoC: tlv320aic31xx: Convert to
	params_width()
Date: Thu, 31 Jul 2014 13:16:14 +0100
Message-ID: <1406808978-16175-3-git-send-email-broonie@kernel.org>
References: <1406808978-16175-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E292E265602
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:16:35 +0200 (CEST)
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
 sound/soc/codecs/tlv320aic31xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 095f4556ab1b..0f64c7890eed 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -760,8 +760,8 @@ static int aic31xx_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	u8 data = 0;
 
-	dev_dbg(codec->dev, "## %s: format %d width %d rate %d\n",
-		__func__, params_format(params), params_width(params),
+	dev_dbg(codec->dev, "## %s: width %d rate %d\n",
+		__func__, params_width(params),
 		params_rate(params));
 
 	switch (params_width(params)) {
@@ -780,8 +780,8 @@ static int aic31xx_hw_params(struct snd_pcm_substream *substream,
 			AIC31XX_IFACE1_DATALEN_SHIFT);
 		break;
 	default:
-		dev_err(codec->dev, "%s: Unsupported format %d\n",
-			__func__, params_format(params));
+		dev_err(codec->dev, "%s: Unsupported width %d\n",
+			__func__, params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
