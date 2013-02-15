From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm5102: Correct OUT2 volume and
	switch names
Date: Fri, 15 Feb 2013 10:37:26 +0000
Message-ID: <1360924647-8861-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D9AA26168D
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 11:40:43 +0100 (CET)
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
 sound/soc/codecs/wm5102.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index ab69c83..deb1097 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -755,7 +755,7 @@ SOC_SINGLE("SPKDAT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_5L,
 
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
-SOC_DOUBLE_R("OUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
+SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_MUTE_SHIFT, 1, 1),
 SOC_SINGLE("EPOUT Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_3L,
 	   ARIZONA_OUT3L_MUTE_SHIFT, 1, 1),
@@ -767,7 +767,7 @@ SOC_DOUBLE_R("SPKDAT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 SOC_DOUBLE_R_TLV("HPOUT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
-SOC_DOUBLE_R_TLV("OUT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_2L,
+SOC_DOUBLE_R_TLV("HPOUT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_SINGLE_TLV("EPOUT Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_3L,
-- 
1.7.2.5
