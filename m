From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 08/19] ALSA: Oxygen: Modify initialization
	functions
Date: Fri, 24 Jan 2014 16:18:09 +0400
Message-ID: <1390565900-3337-8-git-send-email-v1ron@mail.ru>
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

Change CS4245 initialization: different sequence and GPIO values,
according to datasheets and reverse-engineering information.
Change Cleanup/resume/suspend functions, since they use
initialization.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |  114 +++++++++++++++++++------------------------
 sound/pci/oxygen/xonar_dg.h |    1 -
 2 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 28cfeeb..4ec06e6 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -136,68 +136,50 @@ static void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value)
 			 CS4245_SPI_ADDRESS_S |
 			 CS4245_SPI_WRITE_S |
 			 (reg << 8) | value);
-	data->cs4245_regs[reg] = value;
+	data->cs4245_shadow[reg] = value;
 }
 
 static void cs4245_write_cached(struct oxygen *chip, unsigned int reg, u8 value)
 {
 	struct dg *data = chip->model_data;
 
-	if (value != data->cs4245_regs[reg])
+	if (value != data->cs4245_shadow[reg])
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
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] =
 		CS4245_DAC_FM_SINGLE | CS4245_DAC_DIF_LJUST;
-	data->cs4245_regs[CS4245_ADC_CTRL] =
+	data->cs4245_shadow[CS4245_ADC_CTRL] =
 		CS4245_ADC_FM_SINGLE | CS4245_ADC_DIF_LJUST;
-	data->cs4245_regs[CS4245_SIGNAL_SEL] =
-		CS4245_A_OUT_SEL_HIZ | CS4245_ASYNCH;
-	data->cs4245_regs[CS4245_PGA_B_CTRL] = 0;
-	data->cs4245_regs[CS4245_PGA_A_CTRL] = 0;
-	data->cs4245_regs[CS4245_ANALOG_IN] =
-		CS4245_PGA_SOFT | CS4245_PGA_ZERO | CS4245_SEL_INPUT_4;
-	data->cs4245_regs[CS4245_DAC_A_CTRL] = 0;
-	data->cs4245_regs[CS4245_DAC_B_CTRL] = 0;
-	cs4245_registers_init(chip);
-	snd_component_add(chip->card, "CS4245");
-}
+	data->cs4245_shadow[CS4245_PGA_B_CTRL] = 0;
+	data->cs4245_shadow[CS4245_PGA_A_CTRL] = 0;
+	data->cs4245_shadow[CS4245_DAC_A_CTRL] = 4;
+	data->cs4245_shadow[CS4245_DAC_B_CTRL] = 4;
 
-static void dg_output_enable(struct oxygen *chip)
-{
-	msleep(2500);
-	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE);
+	cs4245_shadow_control(chip, CS4245_LOAD_FROM_SHADOW);
+	snd_component_add(chip->card, "CS4245");
 }
 
 static void dg_init(struct oxygen *chip)
@@ -208,15 +190,18 @@ static void dg_init(struct oxygen *chip)
 	data->input_sel = 3;
 	data->hp_vol_att = 2 * 16;
 
-	cs4245_init(chip);
+	/*
+	 * The pin XGPIO1 as XGPIO1, gpios 8,7,6,5,1,0 as outputs.
+	 */
 
-	oxygen_clear_bits16(chip, OXYGEN_GPIO_CONTROL,
-			    GPIO_MAGIC | GPIO_HP_DETECT);
-	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL,
-			  GPIO_INPUT_ROUTE | GPIO_HP_REAR | GPIO_OUTPUT_ENABLE);
-	oxygen_clear_bits16(chip, OXYGEN_GPIO_DATA,
-			    GPIO_INPUT_ROUTE | GPIO_HP_REAR);
-	dg_output_enable(chip);
+	cs4245_init(chip);
+	oxygen_write16(chip, OXYGEN_GPIO_CONTROL, GPIO_OUTPUT_ENABLE |
+		GPIO_HP_REAR | GPIO_INPUT_ROUTE);
+	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_INPUT_ROUTE);
+	/* Anti-pop delay */
+	msleep(2500);
+	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE |
+		GPIO_INPUT_ROUTE);
 }
 
 static void dg_cleanup(struct oxygen *chip)
@@ -231,8 +216,9 @@ static void dg_suspend(struct oxygen *chip)
 
 static void dg_resume(struct oxygen *chip)
 {
-	cs4245_registers_init(chip);
-	dg_output_enable(chip);
+	cs4245_shadow_control(chip, CS4245_LOAD_FROM_SHADOW);
+	msleep(2500);
+	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE);
 }
 
 static void set_cs4245_dac_params(struct oxygen *chip,
@@ -241,7 +227,7 @@ static void set_cs4245_dac_params(struct oxygen *chip,
 	struct dg *data = chip->model_data;
 	u8 value;
 
-	value = data->cs4245_regs[CS4245_DAC_CTRL_1] & ~CS4245_DAC_FM_MASK;
+	value = data->cs4245_shadow[CS4245_DAC_CTRL_1] & ~CS4245_DAC_FM_MASK;
 	if (params_rate(params) <= 50000)
 		value |= CS4245_DAC_FM_SINGLE;
 	else if (params_rate(params) <= 100000)
@@ -257,7 +243,7 @@ static void set_cs4245_adc_params(struct oxygen *chip,
 	struct dg *data = chip->model_data;
 	u8 value;
 
-	value = data->cs4245_regs[CS4245_ADC_CTRL] & ~CS4245_ADC_FM_MASK;
+	value = data->cs4245_shadow[CS4245_ADC_CTRL] & ~CS4245_ADC_FM_MASK;
 	if (params_rate(params) <= 50000)
 		value |= CS4245_ADC_FM_SINGLE;
 	else if (params_rate(params) <= 100000)
@@ -334,7 +320,7 @@ static int output_switch_put(struct snd_kcontrol *ctl,
 	if (changed) {
 		data->output_sel = value->value.enumerated.item[0];
 
-		reg = data->cs4245_regs[CS4245_SIGNAL_SEL] &
+		reg = data->cs4245_shadow[CS4245_SIGNAL_SEL] &
 						~CS4245_A_OUT_SEL_MASK;
 		reg |= data->output_sel == 2 ?
 				CS4245_A_OUT_SEL_DAC : CS4245_A_OUT_SEL_HIZ;
@@ -505,7 +491,7 @@ static int input_sel_put(struct snd_kcontrol *ctl,
 		data->input_sel = value->value.enumerated.item[0];
 
 		cs4245_write(chip, CS4245_ANALOG_IN,
-			     (data->cs4245_regs[CS4245_ANALOG_IN] &
+			     (data->cs4245_shadow[CS4245_ANALOG_IN] &
 							~CS4245_SEL_MASK) |
 			     sel_values[data->input_sel]);
 
@@ -535,7 +521,7 @@ static int hpf_get(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 	struct dg *data = chip->model_data;
 
 	value->value.enumerated.item[0] =
-		!!(data->cs4245_regs[CS4245_ADC_CTRL] & CS4245_HPF_FREEZE);
+		!!(data->cs4245_shadow[CS4245_ADC_CTRL] & CS4245_HPF_FREEZE);
 	return 0;
 }
 
@@ -547,10 +533,10 @@ static int hpf_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 	int changed;
 
 	mutex_lock(&chip->mutex);
-	reg = data->cs4245_regs[CS4245_ADC_CTRL] & ~CS4245_HPF_FREEZE;
+	reg = data->cs4245_shadow[CS4245_ADC_CTRL] & ~CS4245_HPF_FREEZE;
 	if (value->value.enumerated.item[0])
 		reg |= CS4245_HPF_FREEZE;
-	changed = reg != data->cs4245_regs[CS4245_ADC_CTRL];
+	changed = reg != data->cs4245_shadow[CS4245_ADC_CTRL];
 	if (changed)
 		cs4245_write(chip, CS4245_ADC_CTRL, reg);
 	mutex_unlock(&chip->mutex);
@@ -630,7 +616,7 @@ static void dump_cs4245_registers(struct oxygen *chip,
 
 	snd_iprintf(buffer, "\nCS4245:");
 	for (i = 1; i <= 0x10; ++i)
-		snd_iprintf(buffer, " %02x", data->cs4245_regs[i]);
+		snd_iprintf(buffer, " %02x", data->cs4245_shadow[i]);
 	snd_iprintf(buffer, "\n");
 }
 
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index f861a4c..08e598c 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -30,7 +30,6 @@ struct dg {
 	s8 input_vol[4][2];
 	unsigned int input_sel;
 	u8 hp_vol_att;
-	u8 cs4245_regs[0x11];
 };
 
 extern struct oxygen_model model_xonar_dg;
-- 
1.7.10.4
