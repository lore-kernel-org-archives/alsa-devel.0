From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: codecs: da9055: Minor improvement in ALC
 calibration process
Date: Thu, 11 Oct 2012 14:04:37 +0530
Message-ID: <1349944477.24126.11.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id EC8492625D4
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 10:23:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch slightly improves ALC calibration process of da9055 codec
driver by muting Mic PGAs during calibration.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
---
 sound/soc/codecs/da9055.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 27c4454..abf3e43 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -179,6 +179,12 @@
 #define DA9055_AIF_WORD_S24_LE		(2 << 2)
 #define DA9055_AIF_WORD_S32_LE		(3 << 2)
 
+/* MIC_L_CTRL bit fields */
+#define DA9055_MIC_L_MUTE_EN		(1 << 6)
+
+/* MIC_R_CTRL bit fields */
+#define DA9055_MIC_R_MUTE_EN		(1 << 6)
+
 /* MIXIN_L_CTRL bit fields */
 #define DA9055_MIXIN_L_MIX_EN		(1 << 3)
 
@@ -477,7 +483,7 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	u8 reg_val, adc_left, adc_right;
+	u8 reg_val, adc_left, adc_right, mic_left, mic_right;
 	int avg_left_data, avg_right_data, offset_l, offset_r;
 
 	if (ucontrol->value.integer.value[0]) {
@@ -486,6 +492,16 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 		 * offsets must be done first
 		 */
 
+		/* Save current values from Mic control registers */
+		mic_left = snd_soc_read(codec, DA9055_MIC_L_CTRL);
+		mic_right = snd_soc_read(codec, DA9055_MIC_R_CTRL);
+
+		/* Mute Mic PGA Left and Right */
+		snd_soc_update_bits(codec, DA9055_MIC_L_CTRL,
+				    DA9055_MIC_L_MUTE_EN, DA9055_MIC_L_MUTE_EN);
+		snd_soc_update_bits(codec, DA9055_MIC_R_CTRL,
+				    DA9055_MIC_R_MUTE_EN, DA9055_MIC_R_MUTE_EN);
+
 		/* Save current values from ADC control registers */
 		adc_left = snd_soc_read(codec, DA9055_ADC_L_CTRL);
 		adc_right = snd_soc_read(codec, DA9055_ADC_R_CTRL);
@@ -521,6 +537,10 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 		/* Restore original values of ADC control registers */
 		snd_soc_write(codec, DA9055_ADC_L_CTRL, adc_left);
 		snd_soc_write(codec, DA9055_ADC_R_CTRL, adc_right);
+
+		/* Restore original values of Mic control registers */
+		snd_soc_write(codec, DA9055_MIC_L_CTRL, mic_left);
+		snd_soc_write(codec, DA9055_MIC_R_CTRL, mic_right);
 	}
 
 	return snd_soc_put_volsw(kcontrol, ucontrol);
-- 
1.7.1
