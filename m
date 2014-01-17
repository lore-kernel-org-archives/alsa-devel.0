From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 09/16] ALSA: Oxygen: Modify initialization
	functions
Date: Fri, 17 Jan 2014 19:08:28 +0400
Message-ID: <1389971315-3215-9-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

Changes in GPIO values and sequence at startup, CS4245
initialization changed and simplified, according to
datasheets and reverse-engineering information.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   88 ++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 0a8ebe1..d6a8c72 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -147,50 +147,31 @@ static void cs4245_write_cached(struct oxygen *chip, unsigned int reg, u8 value)
 		cs4245_write(chip, reg, value);
 }
 
-static void cs4245_registers_init(struct oxygen *chip)
-{
-	struct dg *data = chip->model_data;
-
-	cs4245_write(chip, CS4245_POWER_CTRL, CS4245_PDN);
-	cs4245_write(chip, CS4245_DAC_CTRL_1,
-		     data->cs4245_regs[CS4245_DAC_CTRL_1]);
-	cs4245_write(chip, CS4245_ADC_CTRL,
-		     data->cs4245_regs[CS4245_ADC_CTRL]);
-	cs4245_write(chip, CS4245_SIGNAL_SEL,
-		     data->cs4245_regs[CS4245_SIGNAL_SEL]);
-	cs4245_write(chip, CS4245_PGA_B_CTRL,
-		     data->cs4245_regs[CS4245_PGA_B_CTRL]);
-	cs4245_write(chip, CS4245_PGA_A_CTRL,
-		     data->cs4245_regs[CS4245_PGA_A_CTRL]);
-	cs4245_write(chip, CS4245_ANALOG_IN,
-		     data->cs4245_regs[CS4245_ANALOG_IN]);
-	cs4245_write(chip, CS4245_DAC_A_CTRL,
-		     data->cs4245_regs[CS4245_DAC_A_CTRL]);
-	cs4245_write(chip, CS4245_DAC_B_CTRL,
-		     data->cs4245_regs[CS4245_DAC_B_CTRL]);
-	cs4245_write(chip, CS4245_DAC_CTRL_2,
-		     CS4245_DAC_SOFT | CS4245_DAC_ZERO | CS4245_INVERT_DAC);
-	cs4245_write(chip, CS4245_INT_MASK, 0);
-	cs4245_write(chip, CS4245_POWER_CTRL, 0);
-}
-
 static void cs4245_init(struct oxygen *chip)
 {
 	struct dg *data = chip->model_data;
 
-	data->cs4245_regs[CS4245_DAC_CTRL_1] =
-		CS4245_DAC_FM_SINGLE | CS4245_DAC_DIF_LJUST;
-	data->cs4245_regs[CS4245_ADC_CTRL] =
-		CS4245_ADC_FM_SINGLE | CS4245_ADC_DIF_LJUST;
-	data->cs4245_regs[CS4245_SIGNAL_SEL] =
-		CS4245_A_OUT_SEL_HIZ | CS4245_ASYNCH;
-	data->cs4245_regs[CS4245_PGA_B_CTRL] = 0;
-	data->cs4245_regs[CS4245_PGA_A_CTRL] = 0;
-	data->cs4245_regs[CS4245_ANALOG_IN] =
-		CS4245_PGA_SOFT | CS4245_PGA_ZERO | CS4245_SEL_INPUT_4;
-	data->cs4245_regs[CS4245_DAC_A_CTRL] = 0;
-	data->cs4245_regs[CS4245_DAC_B_CTRL] = 0;
-	cs4245_registers_init(chip);
+	/* Save the initial state: codec version, registers */
+	cs4245_shadow_control(chip, CS4245_SAVE_TO_SHADOW);
+
+	/*
+	 * Power up the CODEC internals, enable soft ramp & zero cross, work
+	 * in async. mode,
+	 * Enable aux output from DAC. Invert DAC output as in the Windows
+	 * driver
+	 */
+	data->cs4245_shadow[CS4245_POWER_CTRL] = 0;
+	data->cs4245_shadow[CS4245_SIGNAL_SEL] = CS4245_A_OUT_SEL_DAC |
+		CS4245_ASYNCH;
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] = 0;
+	data->cs4245_shadow[CS4245_DAC_CTRL_2] = CS4245_DAC_SOFT |
+		CS4245_DAC_ZERO | CS4245_INVERT_DAC;
+	data->cs4245_shadow[CS4245_ADC_CTRL] = 0;
+	data->cs4245_shadow[CS4245_ANALOG_IN] = CS4245_PGA_SOFT |
+		CS4245_PGA_ZERO;
+
+	cs4245_shadow_control(chip, CS4245_LOAD_FROM_SHADOW);
+
 	snd_component_add(chip->card, "CS4245");
 }
 
@@ -200,23 +181,20 @@ static void dg_output_enable(struct oxygen *chip)
 	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE);
 }
 
-static void dg_init(struct oxygen *chip)
+void dg_init(struct oxygen *chip)
 {
-	struct dg *data = chip->model_data;
-
-	data->output_sel = 0;
-	data->input_sel = 3;
-	data->hp_vol_att = 2 * 16;
+	/*
+	 * The pin XGPIO1 as XGPIO1, gpios 8,7,6,5,1,0 as outputs.
+	 */
 
 	cs4245_init(chip);
-
-	oxygen_clear_bits16(chip, OXYGEN_GPIO_CONTROL,
-			    GPIO_MAGIC | GPIO_HP_DETECT);
-	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL,
-			  GPIO_INPUT_ROUTE | GPIO_HP_REAR | GPIO_OUTPUT_ENABLE);
-	oxygen_clear_bits16(chip, OXYGEN_GPIO_DATA,
-			    GPIO_INPUT_ROUTE | GPIO_HP_REAR);
-	dg_output_enable(chip);
+	oxygen_write16(chip, OXYGEN_GPIO_CONTROL, GPIO_OUTPUT_ENABLE |
+		GPIO_HP_REAR | GPIO_INPUT_ROUTE);
+	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR | GPIO_INPUT_ROUTE);
+	/* Anti-pop delay */
+	msleep(2500);
+	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE |
+		GPIO_HP_REAR | GPIO_INPUT_ROUTE);
 }
 
 static void dg_cleanup(struct oxygen *chip)
@@ -231,7 +209,7 @@ static void dg_suspend(struct oxygen *chip)
 
 static void dg_resume(struct oxygen *chip)
 {
-	cs4245_registers_init(chip);
+	/*cs4245_registers_init(chip);*/
 	dg_output_enable(chip);
 }
 
-- 
1.7.10.4
