From: Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Add support for high power analog output
Date: Sat, 27 Apr 2019 21:40:05 +0200
Message-ID: <20190427194005.7308-1-sravanhome@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support to power and output level control for the analog high power
output drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..d4bafac802eb 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -419,6 +419,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Pop reduction */
 	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
 	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
+
+	/* Analog HPOUT, HPCOM power and output level controls */
+	SOC_DOUBLE_R("Analog output power control", HPROUT_CTRL,
+			HPRCOM_CTRL, 0, 1, 0),
+	SOC_DOUBLE_R("Analog output level control", HPROUT_CTRL,
+			HPRCOM_CTRL, 4, 9, 0),
 };
 
 /* For other than tlv320aic3104 */
-- 
2.17.1
