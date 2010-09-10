From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/4] ASoC: tlv320aic3x: Optimize PLL
	programming in aic3x_set_bias_level
Date: Fri, 10 Sep 2010 14:23:29 +0300
Message-ID: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D23A0103982
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:22:44 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1541723ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:22:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There is only need to enable/disable once the PLL when the bias is going
between on, prepare, standby and off states.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b317586..94dc707 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1069,7 +1069,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		if (aic3x->master) {
+		if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
+		    aic3x->master) {
 			/* enable pll */
 			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
 			aic3x_write(codec, AIC3X_PLL_PROGA_REG,
@@ -1077,15 +1078,16 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* fall through and disable pll */
-	case SND_SOC_BIAS_OFF:
-		if (aic3x->master) {
+		if (codec->bias_level == SND_SOC_BIAS_PREPARE &&
+		    aic3x->master) {
 			/* disable pll */
 			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
 			aic3x_write(codec, AIC3X_PLL_PROGA_REG,
 				    reg & ~PLL_ENABLE);
 		}
 		break;
+	case SND_SOC_BIAS_OFF:
+		break;
 	}
 	codec->bias_level = level;
 
-- 
1.7.1
