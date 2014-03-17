From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH RFC] ALSA: oxygen: Xonar DG(X): fix Stereo
	Upmixing regression
Date: Mon, 17 Mar 2014 22:12:54 +0100
Message-ID: <53276556.20107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 977BD261A40
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 22:13:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The code introduced in commit 1f91ecc14dee ("ALSA: oxygen: modify
adjust_dg_dac_routing function") accidentally disregarded the old value
of the playback routing register, so it broke the "Stereo Upmixing"
mixer control.

The unmuted parts of the channel routing are the same for all settings
of the output destination, so it suffices to revert that part of the
patch.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/xonar_dg.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)


Roman, could you please test this patch, and add your Tested-by?


diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index ed6f199..4cf3200 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -238,11 +238,21 @@ void set_cs4245_adc_params(struct oxygen *chip,
 	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
 }

+static inline unsigned int shift_bits(unsigned int value,
+				      unsigned int shift_from,
+				      unsigned int shift_to,
+				      unsigned int mask)
+{
+	if (shift_from < shift_to)
+		return (value << (shift_to - shift_from)) & mask;
+	else
+		return (value >> (shift_from - shift_to)) & mask;
+}
+
 unsigned int adjust_dg_dac_routing(struct oxygen *chip,
 					  unsigned int play_routing)
 {
 	struct dg *data = chip->model_data;
-	unsigned int routing = 0;

 	switch (data->output_sel) {
 	case PLAYBACK_DST_HP:
@@ -252,15 +262,23 @@ unsigned int adjust_dg_dac_routing(struct oxygen *chip,
 			OXYGEN_PLAY_MUTE67, OXYGEN_PLAY_MUTE_MASK);
 		break;
 	case PLAYBACK_DST_MULTICH:
-		routing = (0 << OXYGEN_PLAY_DAC0_SOURCE_SHIFT) |
-			  (2 << OXYGEN_PLAY_DAC1_SOURCE_SHIFT) |
-			  (1 << OXYGEN_PLAY_DAC2_SOURCE_SHIFT) |
-			  (0 << OXYGEN_PLAY_DAC3_SOURCE_SHIFT);
 		oxygen_write8_masked(chip, OXYGEN_PLAY_ROUTING,
 			OXYGEN_PLAY_MUTE01, OXYGEN_PLAY_MUTE_MASK);
 		break;
 	}
-	return routing;
+	return (play_routing & OXYGEN_PLAY_DAC0_SOURCE_MASK) |
+	       shift_bits(play_routing,
+			  OXYGEN_PLAY_DAC2_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC1_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC1_SOURCE_MASK) |
+	       shift_bits(play_routing,
+			  OXYGEN_PLAY_DAC1_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC2_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC2_SOURCE_MASK) |
+	       shift_bits(play_routing,
+			  OXYGEN_PLAY_DAC0_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC3_SOURCE_SHIFT,
+			  OXYGEN_PLAY_DAC3_SOURCE_MASK);
 }

 void dump_cs4245_registers(struct oxygen *chip,
