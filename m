From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: pcm1792a: Convert to params_width()
Date: Fri, 24 Jan 2014 16:25:59 +0000
Message-ID: <1390580759-4320-2-git-send-email-broonie@kernel.org>
References: <1390580759-4320-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA425265450
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 17:26:14 +0100 (CET)
In-Reply-To: <1390580759-4320-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Marek Belisko <marek.belisko@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This will help support future enhancements in the way we negotiate
parameters in the core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm1792a.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 7146653a8e16..3a80ba4452df 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -107,24 +107,35 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
 	int val = 0, ret;
-	int pcm_format = params_format(params);
 
 	priv->rate = params_rate(params);
 
 	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
-		if (pcm_format == SNDRV_PCM_FORMAT_S24_LE ||
-		    pcm_format == SNDRV_PCM_FORMAT_S32_LE)
-			val = 0x02;
-		else if (pcm_format == SNDRV_PCM_FORMAT_S16_LE)
-			val = 0x00;
+		switch (params_width(params)) {
+		case 24:
+		case 32:
+			val = 2;
+			break;
+		case 16:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	case SND_SOC_DAIFMT_I2S:
-		if (pcm_format == SNDRV_PCM_FORMAT_S24_LE ||
-		    pcm_format == SNDRV_PCM_FORMAT_S32_LE)
-			val = 0x05;
-		else if (pcm_format == SNDRV_PCM_FORMAT_S16_LE)
-			val = 0x04;
+		switch (params_width(params)) {
+		case 24:
+		case 32:
+			val = 5;
+			break;
+		case 16:
+			val = 4;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		dev_err(codec->dev, "Invalid DAI format\n");
-- 
1.8.5.3
