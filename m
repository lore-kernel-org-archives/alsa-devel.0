From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Split input PGA controls
Date: Fri, 14 Dec 2012 14:48:27 +0900
Message-ID: <1355464107-26545-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FE66261602
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 12:57:35 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
 by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id BF276110487
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 11:50:19 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Though the controls are named as stereo controls in the part the main use
case for the analogue inputs to the WM5102 is mono. Reflect this in the
controls exposed to userspace, providing a series of mono controls rather
than stereo ones.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index b20feb2..3831645 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -611,32 +611,44 @@ SOC_SINGLE("IN2 High Performance Switch", ARIZONA_IN2L_CONTROL,
 SOC_SINGLE("IN3 High Performance Switch", ARIZONA_IN3L_CONTROL,
 	   ARIZONA_IN3_OSR_SHIFT, 1, 0),
 
-SOC_DOUBLE_R_RANGE_TLV("IN1 Volume", ARIZONA_IN1L_CONTROL,
-		       ARIZONA_IN1R_CONTROL,
-		       ARIZONA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("IN2 Volume", ARIZONA_IN2L_CONTROL,
-		       ARIZONA_IN2R_CONTROL,
-		       ARIZONA_IN2L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("IN3 Volume", ARIZONA_IN3L_CONTROL,
-		       ARIZONA_IN3R_CONTROL,
-		       ARIZONA_IN3L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-
-SOC_DOUBLE_R("IN1 Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_1L,
-	     ARIZONA_ADC_DIGITAL_VOLUME_1R, ARIZONA_IN1L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("IN2 Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_2L,
-	     ARIZONA_ADC_DIGITAL_VOLUME_2R, ARIZONA_IN2L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("IN3 Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_3L,
-	     ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_MUTE_SHIFT, 1, 1),
-
-SOC_DOUBLE_R_TLV("IN1 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_1L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_1R, ARIZONA_IN1L_DIG_VOL_SHIFT,
-		 0xbf, 0, digital_tlv),
-SOC_DOUBLE_R_TLV("IN2 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_2L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_2R, ARIZONA_IN2L_DIG_VOL_SHIFT,
-		 0xbf, 0, digital_tlv),
-SOC_DOUBLE_R_TLV("IN3 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_3L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_DIG_VOL_SHIFT,
-		 0xbf, 0, digital_tlv),
+SOC_SINGLE_RANGE_TLV("IN1L Volume", ARIZONA_IN1L_CONTROL,
+		     ARIZONA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN1R Volume", ARIZONA_IN1R_CONTROL,
+		     ARIZONA_IN1R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN2L Volume", ARIZONA_IN2L_CONTROL,
+		     ARIZONA_IN2L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN2R Volume", ARIZONA_IN2R_CONTROL,
+		     ARIZONA_IN2R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN3L Volume", ARIZONA_IN3L_CONTROL,
+		     ARIZONA_IN3L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN3R Volume", ARIZONA_IN3R_CONTROL,
+		     ARIZONA_IN3R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+
+SOC_SINGLE("IN1L Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_1L,
+	   ARIZONA_IN1L_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("IN1R Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_1R,
+	   ARIZONA_IN1R_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("IN2L Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_2L,
+	   ARIZONA_IN2L_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("IN2R Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_2R,
+	   ARIZONA_IN2R_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("IN3L Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_3L,
+	   ARIZONA_IN3L_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("IN3R Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_3R,
+	   ARIZONA_IN3R_MUTE_SHIFT, 1, 1),
+
+SOC_SINGLE_TLV("IN1L Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_1L,
+	       ARIZONA_IN1L_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
+SOC_SINGLE_TLV("IN1R Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_1R,
+	       ARIZONA_IN1R_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
+SOC_SINGLE_TLV("IN2L Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_2L,
+	       ARIZONA_IN2L_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
+SOC_SINGLE_TLV("IN2R Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_2R,
+	       ARIZONA_IN2R_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
+SOC_SINGLE_TLV("IN3L Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_3L,
+	       ARIZONA_IN3L_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
+SOC_SINGLE_TLV("IN3R Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_3R,
+	       ARIZONA_IN3R_DIG_VOL_SHIFT, 0xbf, 0, digital_tlv),
 
 SOC_ENUM("Input Ramp Up", arizona_in_vi_ramp),
 SOC_ENUM("Input Ramp Down", arizona_in_vd_ramp),
-- 
1.7.10.4
