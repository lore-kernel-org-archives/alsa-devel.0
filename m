From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH] Fix register address to set SPDIF data type.
Date: Thu, 11 Sep 2014 09:52:46 -0500
Message-ID: <1410447166-2336-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 72CB72656DB
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:53:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

ASoC: cs4265: Fix register address to set the proper data type.

The SPDIF control register must be written to set the data type in hw_params
not the ADC control register.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs4265.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index e299948..4fdd47d 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -459,12 +459,12 @@ static int cs4265_pcm_hw_params(struct snd_pcm_substream *substream,
 		if (params_width(params) == 16) {
 			snd_soc_update_bits(codec, CS4265_DAC_CTL,
 				CS4265_DAC_CTL_DIF, (1 << 5));
-			snd_soc_update_bits(codec, CS4265_ADC_CTL,
+			snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
 				CS4265_SPDIF_CTL2_DIF, (1 << 7));
 		} else {
 			snd_soc_update_bits(codec, CS4265_DAC_CTL,
 				CS4265_DAC_CTL_DIF, (3 << 5));
-			snd_soc_update_bits(codec, CS4265_ADC_CTL,
+			snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
 				CS4265_SPDIF_CTL2_DIF, (1 << 7));
 		}
 		break;
@@ -473,7 +473,7 @@ static int cs4265_pcm_hw_params(struct snd_pcm_substream *substream,
 			CS4265_DAC_CTL_DIF, 0);
 		snd_soc_update_bits(codec, CS4265_ADC_CTL,
 			CS4265_ADC_DIF, 0);
-		snd_soc_update_bits(codec, CS4265_ADC_CTL,
+		snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
 			CS4265_SPDIF_CTL2_DIF, (1 << 6));
 
 		break;
-- 
1.9.1
