From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 19/19] ALSA: Oxygen: Cleanup and minor
	changes
Date: Fri, 24 Jan 2014 16:18:20 +0400
Message-ID: <1390565900-3337-19-git-send-email-v1ron@mail.ru>
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

Remove old SPI control functions, change anti-pop init
sequence, remove some garbage from structures. The 'Apply' functions
must be called at the mixer initialization, otherwise
mixer settings sometimes will not be applied at startup.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c       |   36 ++++++------------------------------
 sound/pci/oxygen/xonar_dg.h       |    3 ---
 sound/pci/oxygen/xonar_dg_mixer.c |    5 +++++
 3 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index f504f4f..7ca7396 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -124,29 +124,6 @@ int cs4245_shadow_control(struct oxygen *chip, enum cs4245_shadow_operation op)
 	return 0;
 }
 
-void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value)
-{
-	struct dg *data = chip->model_data;
-
-	oxygen_write_spi(chip, OXYGEN_SPI_TRIGGER |
-			 OXYGEN_SPI_DATA_LENGTH_3 |
-			 OXYGEN_SPI_CLOCK_1280 |
-			 (0 << OXYGEN_SPI_CODEC_SHIFT) |
-			 OXYGEN_SPI_CEN_LATCH_CLOCK_HI,
-			 CS4245_SPI_ADDRESS_S |
-			 CS4245_SPI_WRITE_S |
-			 (reg << 8) | value);
-	data->cs4245_shadow[reg] = value;
-}
-
-void cs4245_write_cached(struct oxygen *chip, unsigned int reg, u8 value)
-{
-	struct dg *data = chip->model_data;
-
-	if (value != data->cs4245_shadow[reg])
-		cs4245_write(chip, reg, value);
-}
-
 void cs4245_init(struct oxygen *chip)
 {
 	struct dg *data = chip->model_data;
@@ -175,8 +152,8 @@ void cs4245_init(struct oxygen *chip)
 		CS4245_ADC_FM_SINGLE | CS4245_ADC_DIF_LJUST;
 	data->cs4245_shadow[CS4245_PGA_B_CTRL] = 0;
 	data->cs4245_shadow[CS4245_PGA_A_CTRL] = 0;
-	data->cs4245_shadow[CS4245_DAC_A_CTRL] = 4;
-	data->cs4245_shadow[CS4245_DAC_B_CTRL] = 4;
+	data->cs4245_shadow[CS4245_DAC_A_CTRL] = 8;
+	data->cs4245_shadow[CS4245_DAC_B_CTRL] = 8;
 
 	cs4245_shadow_control(chip, CS4245_LOAD_FROM_SHADOW);
 	snd_component_add(chip->card, "CS4245");
@@ -186,9 +163,8 @@ void dg_init(struct oxygen *chip)
 {
 	struct dg *data = chip->model_data;
 
-	data->output_sel = 0;
-	data->input_sel = 3;
-	data->hp_vol_att = 2 * 16;
+	data->output_sel = PLAYBACK_DST_HP_FP;
+	data->input_sel = CAPTURE_SRC_MIC;
 
 	/*
 	 * The pin XGPIO1 as XGPIO1, gpios 8,7,6,5,1,0 as outputs.
@@ -197,11 +173,11 @@ void dg_init(struct oxygen *chip)
 	cs4245_init(chip);
 	oxygen_write16(chip, OXYGEN_GPIO_CONTROL, GPIO_OUTPUT_ENABLE |
 		GPIO_HP_REAR | GPIO_INPUT_ROUTE);
-	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_INPUT_ROUTE);
-	/* Anti-pop delay */
+	/* Anti-pop delay, wait some time before enabling the output */
 	msleep(2500);
 	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE |
 		GPIO_INPUT_ROUTE);
+
 }
 
 void dg_cleanup(struct oxygen *chip)
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 79192a5..d7b3dd2 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -32,7 +32,6 @@ struct dg {
 	char input_vol[4][2];
 	/* Input select: mic/fp mic/line/aux */
 	unsigned char input_sel;
-	u8 hp_vol_att;
 };
 
 /* Xonar DG control routines */
@@ -51,8 +50,6 @@ void dump_cs4245_registers(struct oxygen *chip,
 void dg_suspend(struct oxygen *chip);
 void dg_resume(struct oxygen *chip);
 void dg_cleanup(struct oxygen *chip);
-void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value);
-void cs4245_write_cached(struct oxygen *chip, unsigned int reg, u8 value);
 
 extern struct oxygen_model model_xonar_dg;
 
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index 4b80675..70fc6b6 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -437,12 +437,17 @@ static int dg_mixer_init(struct oxygen *chip)
 	unsigned int i;
 	int err;
 
+	output_select_apply(chip);
+	input_source_apply(chip);
+	oxygen_update_dac_routing(chip);
+
 	for (i = 0; i < ARRAY_SIZE(dg_controls); ++i) {
 		err = snd_ctl_add(chip->card,
 				  snd_ctl_new1(&dg_controls[i], chip));
 		if (err < 0)
 			return err;
 	}
+
 	return 0;
 }
 
-- 
1.7.10.4
