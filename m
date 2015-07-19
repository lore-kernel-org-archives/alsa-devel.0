From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs4265: CS4265_INT_STATUS is readable
	register
Date: Sun, 19 Jul 2015 12:32:52 +0800
Message-ID: <1437280372.23834.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id BFDDC260547
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 06:32:58 +0200 (CEST)
Received: by padck2 with SMTP id ck2so82574638pad.0
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 21:32:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

CS4265_INT_STATUS was missed in cs4265_readable_register, fix it.
The register 0x01 ~ 0x12 are readable, use
CS4265_CHIP_ID ... CS4265_SPDIF_CTL2 syntax for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4265.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index e42a5038..55db19d 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -60,23 +60,7 @@ static const struct reg_default cs4265_reg_defaults[] = {
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4265_PWRCTL:
-	case CS4265_DAC_CTL:
-	case CS4265_ADC_CTL:
-	case CS4265_MCLK_FREQ:
-	case CS4265_SIG_SEL:
-	case CS4265_CHB_PGA_CTL:
-	case CS4265_CHA_PGA_CTL:
-	case CS4265_ADC_CTL2:
-	case CS4265_DAC_CHA_VOL:
-	case CS4265_DAC_CHB_VOL:
-	case CS4265_DAC_CTL2:
-	case CS4265_SPDIF_CTL1:
-	case CS4265_SPDIF_CTL2:
-	case CS4265_INT_MASK:
-	case CS4265_STATUS_MODE_MSB:
-	case CS4265_STATUS_MODE_LSB:
-	case CS4265_CHIP_ID:
+	case CS4265_CHIP_ID ... CS4265_SPDIF_CTL2:
 		return true;
 	default:
 		return false;
-- 
2.1.0
