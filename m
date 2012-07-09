From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Fix cut'n'paste for digital
	volume registers
Date: Mon,  9 Jul 2012 19:31:23 +0100
Message-ID: <1341858683-27437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C08224758
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2012 20:31:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The analogue PGA shifts were used; this makes no practical difference as
the values are the same.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 3827fa2..7a6a11a 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -68,13 +68,13 @@ SOC_DOUBLE_R("IN3 Digital Switch", ARIZONA_ADC_DIGITAL_VOLUME_3L,
 	     ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_MUTE_SHIFT, 1, 1),
 
 SOC_DOUBLE_R_TLV("IN1 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_1L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_1R, ARIZONA_IN1L_PGA_VOL_SHIFT,
+		 ARIZONA_ADC_DIGITAL_VOLUME_1R, ARIZONA_IN1L_DIG_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_DOUBLE_R_TLV("IN2 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_2L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_2R, ARIZONA_IN2L_PGA_VOL_SHIFT,
+		 ARIZONA_ADC_DIGITAL_VOLUME_2R, ARIZONA_IN2L_DIG_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_DOUBLE_R_TLV("IN3 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_3L,
-		 ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_PGA_VOL_SHIFT,
+		 ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_DIG_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
 ARIZONA_MIXER_CONTROLS("EQ1", ARIZONA_EQ1MIX_INPUT_1_SOURCE),
-- 
1.7.10
