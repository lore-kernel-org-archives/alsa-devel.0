From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: ssm2602: Convert to params_width()
Date: Thu, 31 Jul 2014 13:18:19 +0100
Message-ID: <1406809099-18597-2-git-send-email-broonie@kernel.org>
References: <1406809099-18597-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3DAC2654A6
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:18:28 +0200 (CEST)
In-Reply-To: <1406809099-18597-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ssm2602.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 97b0454eb346..484b3bbe8624 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -275,17 +275,17 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	regmap_write(ssm2602->regmap, SSM2602_SRATE, srate);
 
 	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		iface = 0x0;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface = 0x4;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface = 0x8;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface = 0xc;
 		break;
 	default:
-- 
2.0.1
