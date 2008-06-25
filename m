From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 2/2] ASoC: TLV320AIC3X: Use
	register modifier widget for mic bias
Date: Wed, 25 Jun 2008 14:42:08 +0300
Message-ID: <1214394128-7062-3-git-send-email-jarkko.nikula@nokia.com>
References: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5996E24359
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 13:42:49 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBgSDF009270
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 14:42:45 +0300
In-Reply-To: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 528c26a..0c7452f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -456,10 +456,12 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 			 &aic3x_right_line2_mux_controls),
 
 	/* Mic Bias */
-	SND_SOC_DAPM_MICBIAS("Mic Bias 2V", MICBIAS_CTRL, 6, 0),
-	SND_SOC_DAPM_MICBIAS("Mic Bias 2.5V", MICBIAS_CTRL, 7, 0),
-	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 6, 0),
-	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 7, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
+			 MICBIAS_CTRL, 6, 3, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2.5V",
+			 MICBIAS_CTRL, 6, 3, 2, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
+			 MICBIAS_CTRL, 6, 3, 3, 0),
 
 	/* Left PGA to Left Output bypass */
 	SND_SOC_DAPM_MIXER("Left PGA Bypass Mixer", SND_SOC_NOPM, 0, 0,
-- 
1.5.5.4
