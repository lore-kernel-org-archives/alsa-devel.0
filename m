From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Correct OUT2/3 volume and
	switch names
Date: Fri, 15 Feb 2013 10:37:27 +0000
Message-ID: <1360924647-8861-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1360924647-8861-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DA3C26168D
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 11:40:48 +0100 (CET)
In-Reply-To: <1360924647-8861-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index a163132..1a97263 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -213,9 +213,9 @@ ARIZONA_MIXER_CONTROLS("SPKDAT2R", ARIZONA_OUT6RMIX_INPUT_1_SOURCE),
 
 SOC_SINGLE("HPOUT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_1L,
 	   ARIZONA_OUT1_OSR_SHIFT, 1, 0),
-SOC_SINGLE("OUT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_2L,
+SOC_SINGLE("HPOUT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_2L,
 	   ARIZONA_OUT2_OSR_SHIFT, 1, 0),
-SOC_SINGLE("OUT3 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_3L,
+SOC_SINGLE("HPOUT3 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_3L,
 	   ARIZONA_OUT3_OSR_SHIFT, 1, 0),
 SOC_SINGLE("Speaker High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_4L,
 	   ARIZONA_OUT4_OSR_SHIFT, 1, 0),
@@ -226,9 +226,9 @@ SOC_SINGLE("SPKDAT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_6L,
 
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("OUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
+SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("OUT3 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_3L,
+SOC_DOUBLE_R("HPOUT3 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_3L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_3R, ARIZONA_OUT3L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("Speaker Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_4L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_4R, ARIZONA_OUT4L_MUTE_SHIFT, 1, 1),
@@ -240,10 +240,10 @@ SOC_DOUBLE_R("SPKDAT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_6L,
 SOC_DOUBLE_R_TLV("HPOUT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
-SOC_DOUBLE_R_TLV("OUT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_2L,
+SOC_DOUBLE_R_TLV("HPOUT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
-SOC_DOUBLE_R_TLV("OUT3 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_3L,
+SOC_DOUBLE_R_TLV("HPOUT3 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_3L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_3R, ARIZONA_OUT3L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_DOUBLE_R_TLV("Speaker Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_4L,
@@ -260,11 +260,11 @@ SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume", ARIZONA_OUTPUT_PATH_CONFIG_1L,
 		       ARIZONA_OUTPUT_PATH_CONFIG_1R,
 		       ARIZONA_OUT1L_PGA_VOL_SHIFT,
 		       0x34, 0x40, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("OUT2 Volume", ARIZONA_OUTPUT_PATH_CONFIG_2L,
+SOC_DOUBLE_R_RANGE_TLV("HPOUT2 Volume", ARIZONA_OUTPUT_PATH_CONFIG_2L,
 		       ARIZONA_OUTPUT_PATH_CONFIG_2R,
 		       ARIZONA_OUT2L_PGA_VOL_SHIFT,
 		       0x34, 0x40, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("OUT3 Volume", ARIZONA_OUTPUT_PATH_CONFIG_3L,
+SOC_DOUBLE_R_RANGE_TLV("HPOUT3 Volume", ARIZONA_OUTPUT_PATH_CONFIG_3L,
 		       ARIZONA_OUTPUT_PATH_CONFIG_3R,
 		       ARIZONA_OUT3L_PGA_VOL_SHIFT, 0x34, 0x40, 0, ana_tlv),
 
-- 
1.7.2.5
