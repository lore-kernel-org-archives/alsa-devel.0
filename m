From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/4] ASoC: tlv320aic3x: Remove needless power
	off from aic3x_set_bias_level
Date: Mon, 26 Apr 2010 15:49:12 +0300
Message-ID: <1272286154-28392-2-git-send-email-jhnikula@gmail.com>
References: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id A223910382C
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 14:48:42 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 5so117408eyb.16
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 05:48:41 -0700 (PDT)
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

These ADC, DAC and output pin power off commands are needless in
aic3x_set_bias_level since they are not enabled in aic3x_init and they are
defined in aic3x_dapm_widgets so the ASoC DAPM will take care of them
anyway.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index af463d8..7548c9d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1013,41 +1013,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		 * all power is driven by DAPM system,
 		 * so output power is safe if bypass was set
 		 */
-		if (aic3x->master) {
-			/* disable pll */
-			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-			aic3x_write(codec, AIC3X_PLL_PROGA_REG,
-				    reg & ~PLL_ENABLE);
-		}
-		break;
 	case SND_SOC_BIAS_OFF:
-		/* force all power off */
-		reg = aic3x_read_reg_cache(codec, LINE1L_2_LADC_CTRL);
-		aic3x_write(codec, LINE1L_2_LADC_CTRL, reg & ~LADC_PWR_ON);
-		reg = aic3x_read_reg_cache(codec, LINE1R_2_RADC_CTRL);
-		aic3x_write(codec, LINE1R_2_RADC_CTRL, reg & ~RADC_PWR_ON);
-
-		reg = aic3x_read_reg_cache(codec, DAC_PWR);
-		aic3x_write(codec, DAC_PWR, reg & ~(LDAC_PWR_ON | RDAC_PWR_ON));
-
-		reg = aic3x_read_reg_cache(codec, HPLOUT_CTRL);
-		aic3x_write(codec, HPLOUT_CTRL, reg & ~HPLOUT_PWR_ON);
-		reg = aic3x_read_reg_cache(codec, HPROUT_CTRL);
-		aic3x_write(codec, HPROUT_CTRL, reg & ~HPROUT_PWR_ON);
-
-		reg = aic3x_read_reg_cache(codec, HPLCOM_CTRL);
-		aic3x_write(codec, HPLCOM_CTRL, reg & ~HPLCOM_PWR_ON);
-		reg = aic3x_read_reg_cache(codec, HPRCOM_CTRL);
-		aic3x_write(codec, HPRCOM_CTRL, reg & ~HPRCOM_PWR_ON);
-
-		reg = aic3x_read_reg_cache(codec, MONOLOPM_CTRL);
-		aic3x_write(codec, MONOLOPM_CTRL, reg & ~MONOLOPM_PWR_ON);
-
-		reg = aic3x_read_reg_cache(codec, LLOPM_CTRL);
-		aic3x_write(codec, LLOPM_CTRL, reg & ~LLOPM_PWR_ON);
-		reg = aic3x_read_reg_cache(codec, RLOPM_CTRL);
-		aic3x_write(codec, RLOPM_CTRL, reg & ~RLOPM_PWR_ON);
-
 		if (aic3x->master) {
 			/* disable pll */
 			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-- 
1.7.0
