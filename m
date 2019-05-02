From: Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3] ASoC: tlv320aic3x: Add support for high power analog output
Date: Thu,  2 May 2019 20:13:32 +0200
Message-ID: <20190502181332.5503-1-sravanhome@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support to output level control for the analog high power output
drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---

Notes:
    Changes in V3:
    -Fixed compilation error
    
    Changes in V2:
    - Removed power control as it is handled by DAPM
    - Added level control for left channel

 sound/soc/codecs/tlv320aic3x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..489a6d89d63d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
+static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -419,6 +422,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Pop reduction */
 	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
 	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
+
+	/* Analog HPOUT, HPCOM output level controls */
+	SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL,
+			4, 9, 0, hp_tlv),
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			4, 9, 0, hp_tlv),
 };
 
 /* For other than tlv320aic3104 */
-- 
2.17.1
