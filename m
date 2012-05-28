From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ASoC: tlv320aic3x: Change Class-D amplifier
	gain control name
Date: Mon, 28 May 2012 22:09:02 +0300
Message-ID: <1338232142-2615-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id AB2E724530
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 21:11:00 +0200 (CEST)
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
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Randolph Chung <rchung42@gmail.com>
List-Id: alsa-devel@alsa-project.org

ALSA mixers cannot classify this "Class-D Amplifier Gain" speaker output
gain control as a playback control. Fix this by changing the name as
"Class-D Playback Volume".

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 64d2a4f..58ef59d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -368,7 +368,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 static DECLARE_TLV_DB_SCALE(classd_amp_tlv, 0, 600, 0);
 
 static const struct snd_kcontrol_new aic3x_classd_amp_gain_ctrl =
-	SOC_DOUBLE_TLV("Class-D Amplifier Gain", CLASSD_CTRL, 6, 4, 3, 0, classd_amp_tlv);
+	SOC_DOUBLE_TLV("Class-D Playback Volume", CLASSD_CTRL, 6, 4, 3, 0, classd_amp_tlv);
 
 /* Left DAC Mux */
 static const struct snd_kcontrol_new aic3x_left_dac_mux_controls =
-- 
1.7.10
