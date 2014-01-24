From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 10/19] ALSA: Oxygen: Modify
	adjust_dg_dac_routing function
Date: Fri, 24 Jan 2014 16:18:11 +0400
Message-ID: <1390565900-3337-10-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

When selecting the audio output destinations (headphones,
FP headphones, multichannel output), the channel routing
should be changed depending on what destination selected.
Also unnecessary I2S channels are digitally muted. This
function called when the user selects the destination
in the ALSA mixer.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   44 ++++++++++++++++++++-----------------------
 sound/pci/oxygen/xonar_dg.h |    2 ++
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index d9a8a4c..a7dc39d 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -271,33 +271,29 @@ static void set_cs4245_adc_params(struct oxygen *chip,
 	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
 }
 
-static inline unsigned int shift_bits(unsigned int value,
-				      unsigned int shift_from,
-				      unsigned int shift_to,
-				      unsigned int mask)
-{
-	if (shift_from < shift_to)
-		return (value << (shift_to - shift_from)) & mask;
-	else
-		return (value >> (shift_from - shift_to)) & mask;
-}
-
 static unsigned int adjust_dg_dac_routing(struct oxygen *chip,
 					  unsigned int play_routing)
 {
-	return (play_routing & OXYGEN_PLAY_DAC0_SOURCE_MASK) |
-	       shift_bits(play_routing,
-			  OXYGEN_PLAY_DAC2_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC1_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC1_SOURCE_MASK) |
-	       shift_bits(play_routing,
-			  OXYGEN_PLAY_DAC1_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC2_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC2_SOURCE_MASK) |
-	       shift_bits(play_routing,
-			  OXYGEN_PLAY_DAC0_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC3_SOURCE_SHIFT,
-			  OXYGEN_PLAY_DAC3_SOURCE_MASK);
+	struct dg *data = chip->model_data;
+	unsigned int routing = 0;
+
+	switch (data->pcm_output) {
+	case PLAYBACK_DST_HP:
+	case PLAYBACK_DST_HP_FP:
+		oxygen_write8_masked(chip, OXYGEN_PLAY_ROUTING,
+			OXYGEN_PLAY_MUTE23 | OXYGEN_PLAY_MUTE45 |
+			OXYGEN_PLAY_MUTE67, OXYGEN_PLAY_MUTE_MASK);
+		break;
+	case PLAYBACK_DST_MULTICH:
+		routing = (0 << OXYGEN_PLAY_DAC0_SOURCE_SHIFT) |
+		(2 << OXYGEN_PLAY_DAC1_SOURCE_SHIFT) |
+		(1 << OXYGEN_PLAY_DAC2_SOURCE_SHIFT) |
+		(0 << OXYGEN_PLAY_DAC3_SOURCE_SHIFT);
+		oxygen_write8_masked(chip, OXYGEN_PLAY_ROUTING,
+			OXYGEN_PLAY_MUTE01, OXYGEN_PLAY_MUTE_MASK);
+		break;
+	}
+	return routing;
 }
 
 static int output_switch_info(struct snd_kcontrol *ctl,
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 08e598c..578d7a2 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -26,6 +26,8 @@ enum cs4245_shadow_operation {
 struct dg {
 	/* The shadow copy of the CS4245 register space */
 	unsigned char cs4245_shadow[17];
+	/* Output select: headphone/speakers */
+	unsigned char pcm_output;
 	unsigned int output_sel;
 	s8 input_vol[4][2];
 	unsigned int input_sel;
-- 
1.7.10.4
