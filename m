From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 6/7] ASoC: tlv320dac33: Convert to
	params_width()
Date: Thu, 31 Jul 2014 13:16:17 +0100
Message-ID: <1406808978-16175-6-git-send-email-broonie@kernel.org>
References: <1406808978-16175-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF2D4265615
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
 sound/soc/codecs/tlv320dac33.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ff006cc95520..e21ed934bdbf 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -832,18 +832,18 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		dac33->fifo_size = DAC33_FIFO_SIZE_16BIT;
 		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 32);
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		dac33->fifo_size = DAC33_FIFO_SIZE_24BIT;
 		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 64);
 		break;
 	default:
-		dev_err(codec->dev, "unsupported format %d\n",
-			params_format(params));
+		dev_err(codec->dev, "unsupported width %d\n",
+			params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
