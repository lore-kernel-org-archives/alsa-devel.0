From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tlv320aic23: Convert to params_width()
Date: Tue, 29 Jul 2014 20:16:10 +0100
Message-ID: <1406661370-17822-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04F62265344
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:16:17 +0200 (CEST)
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
 sound/soc/codecs/tlv320aic23.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 686b8b85b956..d67167920c2f 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -364,16 +364,16 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 
 	iface_reg = snd_soc_read(codec, TLV320AIC23_DIGT_FMT) & ~(0x03 << 2);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface_reg |= (0x01 << 2);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface_reg |= (0x02 << 2);
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface_reg |= (0x03 << 2);
 		break;
 	}
-- 
2.0.1
