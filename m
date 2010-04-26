From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/4] ASoC: tlv320aic3x: Change bias management
	semantics
Date: Mon, 26 Apr 2010 15:49:13 +0300
Message-ID: <1272286154-28392-3-git-send-email-jhnikula@gmail.com>
References: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EFEA103830
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 14:48:43 +0200 (CEST)
Received: by mail-ew0-f219.google.com with SMTP id 19so3573402ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 05:48:43 -0700 (PDT)
In-Reply-To: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Move PLL enable from BIAS_ON state to BIAS_PREPARE to be pair with
BIAS_STANDBY where PLL is disabled. Remove also old comments about power
control.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7548c9d..d8f1b86 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -998,7 +998,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* all power is driven by DAPM system */
+		break;
+	case SND_SOC_BIAS_PREPARE:
 		if (aic3x->master) {
 			/* enable pll */
 			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
@@ -1006,13 +1007,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 				    reg | PLL_ENABLE);
 		}
 		break;
-	case SND_SOC_BIAS_PREPARE:
-		break;
 	case SND_SOC_BIAS_STANDBY:
-		/*
-		 * all power is driven by DAPM system,
-		 * so output power is safe if bypass was set
-		 */
+		/* fall through and disable pll */
 	case SND_SOC_BIAS_OFF:
 		if (aic3x->master) {
 			/* disable pll */
-- 
1.7.0
