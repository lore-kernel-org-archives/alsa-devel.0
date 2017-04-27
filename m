From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8824: leave Class D gain at chip
	default
Date: Thu, 27 Apr 2017 11:22:50 +0800
Message-ID: <1493263370-23040-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5338B2668B2
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 05:23:08 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id c198so5268181pfc.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 20:23:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, John Hsu <supercraig0719@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove initial configuration of Class D gain for 1R and 2L.
Leave them at the chip default.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 sound/soc/codecs/nau8824.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index cd358be0..cca974d 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1626,12 +1626,6 @@ static void nau8824_init_regs(struct nau8824 *nau8824)
 	regmap_update_bits(regmap, NAU8824_REG_DAC_FILTER_CTRL_1,
 		NAU8824_DAC_CICCLP_OFF | NAU8824_DAC_OVERSAMPLE_MASK,
 		NAU8824_DAC_CICCLP_OFF | NAU8824_DAC_OVERSAMPLE_64);
-	/* Class D gain 9db for 1R and 2L */
-	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_1,
-		NAU8824_CLASSD_GAIN_1R_MASK,
-		(0xa << NAU8824_CLASSD_GAIN_1R_SFT));
-	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_2,
-		NAU8824_CLASSD_GAIN_2L_MASK, 0xa);
 	/* DAC clock delay 2ns, VREF */
 	regmap_update_bits(regmap, NAU8824_REG_RDAC,
 		NAU8824_RDAC_CLK_DELAY_MASK | NAU8824_RDAC_VREF_MASK,
-- 
2.6.4
