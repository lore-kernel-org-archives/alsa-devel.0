From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Remove output OSR and PGA volume
	controls
Date: Wed, 27 Nov 2013 15:22:13 +0000
Message-ID: <1385565733-8347-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0675E261AB2
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 16:25:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

These are managed automatically in current revisions.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 0e63d8c..9eb8517 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -309,19 +309,6 @@ ARIZONA_MIXER_CONTROLS("SPKDAT1R", ARIZONA_OUT5RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2L", ARIZONA_OUT6LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2R", ARIZONA_OUT6RMIX_INPUT_1_SOURCE),
 
-SOC_SINGLE("HPOUT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_1L,
-	   ARIZONA_OUT1_OSR_SHIFT, 1, 0),
-SOC_SINGLE("HPOUT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_2L,
-	   ARIZONA_OUT2_OSR_SHIFT, 1, 0),
-SOC_SINGLE("HPOUT3 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_3L,
-	   ARIZONA_OUT3_OSR_SHIFT, 1, 0),
-SOC_SINGLE("Speaker High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_4L,
-	   ARIZONA_OUT4_OSR_SHIFT, 1, 0),
-SOC_SINGLE("SPKDAT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_5L,
-	   ARIZONA_OUT5_OSR_SHIFT, 1, 0),
-SOC_SINGLE("SPKDAT2 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_6L,
-	   ARIZONA_OUT6_OSR_SHIFT, 1, 0),
-
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
@@ -354,18 +341,6 @@ SOC_DOUBLE_R_TLV("SPKDAT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_6L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_6R, ARIZONA_OUT6L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
-SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume", ARIZONA_OUTPUT_PATH_CONFIG_1L,
-		       ARIZONA_OUTPUT_PATH_CONFIG_1R,
-		       ARIZONA_OUT1L_PGA_VOL_SHIFT,
-		       0x34, 0x40, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("HPOUT2 Volume", ARIZONA_OUTPUT_PATH_CONFIG_2L,
-		       ARIZONA_OUTPUT_PATH_CONFIG_2R,
-		       ARIZONA_OUT2L_PGA_VOL_SHIFT,
-		       0x34, 0x40, 0, ana_tlv),
-SOC_DOUBLE_R_RANGE_TLV("HPOUT3 Volume", ARIZONA_OUTPUT_PATH_CONFIG_3L,
-		       ARIZONA_OUTPUT_PATH_CONFIG_3R,
-		       ARIZONA_OUT3L_PGA_VOL_SHIFT, 0x34, 0x40, 0, ana_tlv),
-
 SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 	   ARIZONA_SPK1R_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE("SPKDAT2 Switch", ARIZONA_PDM_SPK2_CTRL_1, ARIZONA_SPK2L_MUTE_SHIFT,
-- 
1.7.2.5
