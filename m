From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 10/16] ALSA: Oxygen: Modify DAC/ADC
	parameters function
Date: Fri, 17 Jan 2014 19:08:29 +0400
Message-ID: <1389971315-3215-10-git-send-email-v1ron@mail.ru>
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

When selecting the audio sample rate for CS4245,
the MCLK divider should also be changed.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   62 ++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index d6a8c72..7dcca01 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -213,36 +213,54 @@ static void dg_resume(struct oxygen *chip)
 	dg_output_enable(chip);
 }
 
-static void set_cs4245_dac_params(struct oxygen *chip,
+void set_cs4245_dac_params(struct oxygen *chip,
 				  struct snd_pcm_hw_params *params)
 {
 	struct dg *data = chip->model_data;
-	u8 value;
-
-	value = data->cs4245_regs[CS4245_DAC_CTRL_1] & ~CS4245_DAC_FM_MASK;
-	if (params_rate(params) <= 50000)
-		value |= CS4245_DAC_FM_SINGLE;
-	else if (params_rate(params) <= 100000)
-		value |= CS4245_DAC_FM_DOUBLE;
-	else
-		value |= CS4245_DAC_FM_QUAD;
-	cs4245_write_cached(chip, CS4245_DAC_CTRL_1, value);
+	unsigned char dac_ctrl;
+	unsigned char mclk_freq;
+
+	dac_ctrl = data->cs4245_shadow[CS4245_DAC_CTRL_1] & ~CS4245_DAC_FM_MASK;
+	mclk_freq = data->cs4245_shadow[CS4245_MCLK_FREQ] & ~CS4245_MCLK1_MASK;
+	if (params_rate(params) <= 50000) {
+		dac_ctrl |= CS4245_DAC_FM_SINGLE;
+		mclk_freq |= CS4245_MCLK_1 << CS4245_MCLK1_SHIFT;
+	} else if (params_rate(params) <= 100000) {
+		dac_ctrl |= CS4245_DAC_FM_DOUBLE;
+		mclk_freq |= CS4245_MCLK_1 << CS4245_MCLK1_SHIFT;
+	} else {
+		dac_ctrl |= CS4245_DAC_FM_QUAD;
+		mclk_freq |= CS4245_MCLK_2 << CS4245_MCLK1_SHIFT;
+	}
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] = dac_ctrl;
+	data->cs4245_shadow[CS4245_MCLK_FREQ] = mclk_freq;
+	cs4245_write_spi(chip, CS4245_DAC_CTRL_1);
+	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
 }
 
-static void set_cs4245_adc_params(struct oxygen *chip,
+void set_cs4245_adc_params(struct oxygen *chip,
 				  struct snd_pcm_hw_params *params)
 {
 	struct dg *data = chip->model_data;
-	u8 value;
-
-	value = data->cs4245_regs[CS4245_ADC_CTRL] & ~CS4245_ADC_FM_MASK;
-	if (params_rate(params) <= 50000)
-		value |= CS4245_ADC_FM_SINGLE;
-	else if (params_rate(params) <= 100000)
-		value |= CS4245_ADC_FM_DOUBLE;
-	else
-		value |= CS4245_ADC_FM_QUAD;
-	cs4245_write_cached(chip, CS4245_ADC_CTRL, value);
+	unsigned char adc_ctrl;
+	unsigned char mclk_freq;
+
+	adc_ctrl = data->cs4245_shadow[CS4245_ADC_CTRL] & ~CS4245_ADC_FM_MASK;
+	mclk_freq = data->cs4245_shadow[CS4245_MCLK_FREQ] & ~CS4245_MCLK2_MASK;
+	if (params_rate(params) <= 50000) {
+		adc_ctrl |= CS4245_ADC_FM_SINGLE;
+		mclk_freq |= CS4245_MCLK_1 << CS4245_MCLK2_SHIFT;
+	} else if (params_rate(params) <= 100000) {
+		adc_ctrl |= CS4245_ADC_FM_DOUBLE;
+		mclk_freq |= CS4245_MCLK_1 << CS4245_MCLK2_SHIFT;
+	} else {
+		adc_ctrl |= CS4245_ADC_FM_QUAD;
+		mclk_freq |= CS4245_MCLK_2 << CS4245_MCLK2_SHIFT;
+	}
+	data->cs4245_shadow[CS4245_ADC_CTRL] = adc_ctrl;
+	data->cs4245_shadow[CS4245_MCLK_FREQ] = mclk_freq;
+	cs4245_write_spi(chip, CS4245_ADC_CTRL);
+	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
 }
 
 static inline unsigned int shift_bits(unsigned int value,
-- 
1.7.10.4
