From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: pcm1681: Convert to params_width()
Date: Fri, 24 Jan 2014 16:25:58 +0000
Message-ID: <1390580759-4320-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 681EA265372
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 17:26:14 +0100 (CET)
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
 sound/soc/codecs/pcm1681.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 73f9c3630e2c..e427544183d7 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -172,16 +172,21 @@ static int pcm1681_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 	int val = 0, ret;
-	int pcm_format = params_format(params);
 
 	priv->rate = params_rate(params);
 
 	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
-		if (pcm_format == SNDRV_PCM_FORMAT_S24_LE)
-			val = 0x00;
-		else if (pcm_format == SNDRV_PCM_FORMAT_S16_LE)
-			val = 0x03;
+		switch (params_width(params)) {
+		case 24:
+			val = 0;
+			break;
+		case 16:
+			val = 3;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	case SND_SOC_DAIFMT_I2S:
 		val = 0x04;
-- 
1.8.5.3
