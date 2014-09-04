Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BA62926532C
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 09:59:47 +0200 (CEST)
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 4 Sep 2014 10:59:41 +0300
Message-ID: <1409817581-29496-1-git-send-email-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH] ASoC: tlv320aic31xx: Enable support for S24_LE
	format
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-ID: <alsa-devel@alsa-project.org>

S24_LE is the same on the bus as S24_3LE, which means the codec can support
it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 52ed57c69dfa..fe16c34607bb 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -18,7 +18,8 @@
 #define AIC31XX_RATES	SNDRV_PCM_RATE_8000_192000
 
 #define AIC31XX_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
-			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE \
+			 | SNDRV_PCM_FMTBIT_S32_LE)
 
 
 #define AIC31XX_STEREO_CLASS_D_BIT	0x1
-- 
2.1.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
