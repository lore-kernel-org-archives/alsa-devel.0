From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: pxa-ssp: drop SNDRV_PCM_FMTBIT_S24_LE
Date: Wed, 13 Aug 2014 21:51:06 +0200
Message-ID: <1407959466-3690-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 343232655FF
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 21:51:16 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id l4so195112lbv.1
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 12:51:15 -0700 (PDT)
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
Cc: broonie@kernel.org, Eric Miao <eric.y.miao@gmail.com>, haojian.zhuang@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This mode is unsupported, as the DMA controller can't do zero-padding
of samples.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Johannes Stezenbach <js@sig21.net>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 199a8b3..2db467f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -764,9 +764,7 @@ static int pxa_ssp_remove(struct snd_soc_dai *dai)
 			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 |	\
 			  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
-#define PXA_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-			    SNDRV_PCM_FMTBIT_S24_LE |	\
-			    SNDRV_PCM_FMTBIT_S32_LE)
+#define PXA_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops pxa_ssp_dai_ops = {
 	.startup	= pxa_ssp_startup,
-- 
2.0.4
