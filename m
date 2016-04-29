From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 1/2] ASoC: nau8825: non-clock jack detection
	for power saving at standby
Date: Fri, 29 Apr 2016 16:15:17 +0800
Message-ID: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF26626518B
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 10:15:08 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The driver changes jack type detection interruption to non-clock archi-
tecture for less 1mW power saving. The architecture is called manual mode
jack detection. It has no hardware debounce, no jack type detection, but
only detecting jack insertion. After jack insertion, the driver will
switch to auto mode jack detection with internal clock which can detect
microphone, jack type and do hardware debounce.

The manual architecture has these main changes including codec initiation,
interruption, clock control, and power management. When codec initiation
or system resume, the clock is closed as jack insertion detection at man-
ual mode, and bypass debounce circuit. These configurations move to resume
setup function when setup bias level after resume.

When jack insertion detection happens, the manual mode turns off and make
configuration about jack type detection interruption at auto mode in auto
irq setup function which can detect microphone and jack type. The inter-
ruption will switch to manual mode again with clock free until jack ejec-
tion happens.

The system clock configuration adds clock disable option which can disable
internal VCO clock. Before the system clock change, there is an restric-
tion added to make sure clock disabled and not config any clock when no
headset connected.

In power management, we involve the solution about races and jack detec-
tion in resume from Ben Zhang in the following patch and list his comment.
[PATCH] ASoC: nau8825: Fix jack detection across suspend
"Jack plug status is rechecked at resume to handle plug/unplug
in S3 when the chip has no power."
"Suspend/resume callbacks are moved from the i2c dev_pm_ops to
snd_soc_codec_driver. soc_resume_deferred is a delayed work
which may trigger nau8825_set_bias_level. The bias change races
against dev_pm_ops, causing jack detection issues.
soc_resume_deferred ensures bias change and snd_soc_codec_driver
suspend/resume are sequenced correctly."

Change SAR widget to supply type which can prevent the codec keeping at
SND_SOC_BIAS_ON during suspend. The codec suspend function can just invoke
normally.

Before the system suspends, the driver turns off all interruptions. Keep
the interruption quiet before resume setup completes. The ADC channel will
be disabled which is needed for interruptions at audo mode.


Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 281 +++++++++++++++++++++++++++++++++++----------
 sound/soc/codecs/nau8825.h |   9 +-
 2 files changed, 226 insertions(+), 64 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index f35019a..9386624 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -30,10 +30,16 @@
 
 #include "nau8825.h"
 
+
+#define NUVOTON_CODEC_DAI "nau8825-hifi"
+
 #define NAU_FREF_MAX 13500000
 #define NAU_FVCO_MAX 124000000
 #define NAU_FVCO_MIN 90000000
 
+static int nau8825_configure_sysclk(struct nau8825 *nau8825,
+		int clk_id, unsigned int freq);
+
 struct nau8825_fll {
 	int mclk_src;
 	int ratio;
@@ -368,9 +374,12 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("ADC Power", NAU8825_REG_ANALOG_ADC_2, 6, 0, NULL,
 		0),
 
-	/* ADC for button press detection */
-	SND_SOC_DAPM_ADC("SAR", NULL, NAU8825_REG_SAR_CTRL,
-		NAU8825_SAR_ADC_EN_SFT, 0),
+	/* ADC for button press detection. A dapm supply widget is used to
+	 * prevent dapm_power_widgets keeping the codec at SND_SOC_BIAS_ON
+	 * during suspend.
+	 */
+	SND_SOC_DAPM_SUPPLY("SAR", NAU8825_REG_SAR_CTRL,
+		NAU8825_SAR_ADC_EN_SFT, 0, NULL, 0),
 
 	SND_SOC_DAPM_PGA_S("ADACL", 2, NAU8825_REG_RDAC, 12, 0, NULL, 0),
 	SND_SOC_DAPM_PGA_S("ADACR", 2, NAU8825_REG_RDAC, 13, 0, NULL, 0),
@@ -614,8 +623,10 @@ int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
 		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
 		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
 
-	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
-		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
+	/* Change jack type detection interruption to non-clock architecture
+	 * for power saving less 1mW. Move these configuration about inter-
+	 * ruption at auto mode to auto irq setup function.
+	 */
 
 	return 0;
 }
@@ -642,6 +653,22 @@ static void nau8825_restart_jack_detection(struct regmap *regmap)
 		NAU8825_JACK_DET_RESTART, 0);
 }
 
+static void nau8825_int_status_clear_all(struct regmap *regmap)
+{
+	int active_irq, clear_irq, i;
+
+	/* Reset the intrruption status from rightmost bit if the corres-
+	 * ponding irq event occurs.
+	 */
+	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
+	for (i = 0; i < NAU8825_REG_DATA_LEN; i++) {
+		clear_irq = (0x1 << i);
+		if (active_irq & clear_irq)
+			regmap_write(regmap,
+				NAU8825_REG_INT_CLR_KEY_STATUS, clear_irq);
+	}
+}
+
 static void nau8825_eject_jack(struct nau8825 *nau8825)
 {
 	struct snd_soc_dapm_context *dapm = nau8825->dapm;
@@ -656,6 +683,67 @@ static void nau8825_eject_jack(struct nau8825 *nau8825)
 	regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 0xf, 0xf);
 
 	snd_soc_dapm_sync(dapm);
+
+	/* Clear all interruption status */
+	nau8825_int_status_clear_all(regmap);
+
+	/* Mask all interruptions except jack insertion interruption */
+	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0xfffe);
+
+	/* Enable insertion interruption only and bypass de-bounce circuit */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_EJECT_EN |
+		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_INSERT_EN,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_EJECT_EN |
+		NAU8825_IRQ_HEADSET_COMPLETE_EN);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_DB_BYPASS, NAU8825_JACK_DET_DB_BYPASS);
+
+	/* Disable ADC needed for interruptions at audo mode */
+	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_ADC, 0);
+
+	/* Close clock for jack type detection at manual mode */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_DIS, 0);
+}
+
+/* Enable audo mode interruptions with internal clock. */
+static void nau8825_setup_auto_irq(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	/* Enable headset jack type detection complete interruption and
+	 * jack ejection interruption.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
+
+	/* Enable internal VCO needed for interruptions */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
+
+	/* Enable ADC needed for interruptions */
+	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
+
+	/* Chip needs one FSCLK cycle in order to generate interruptions,
+	 * as we cannot guarantee one will be provided by the system. Turning
+	 * master mode on then off enables us to generate that FSCLK cycle
+	 * with a minimum of contention on the clock bus.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+
+	/* Not bypass de-bounce circuit */
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_DB_BYPASS, 0);
+
+	/* Unmask all interruptions */
+	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0);
+
+	/* Restart the jack detection process at auto mode */
+	nau8825_restart_jack_detection(regmap);
 }
 
 static int nau8825_button_decode(int value)
@@ -753,7 +841,10 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	struct regmap *regmap = nau8825->regmap;
 	int active_irq, clear_irq = 0, event = 0, event_mask = 0;
 
-	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
+	if (regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq)) {
+		dev_err(nau8825->dev, "failed to clear interruption\n");
+		return IRQ_NONE;
+	}
 
 	if ((active_irq & NAU8825_JACK_EJECTION_IRQ_MASK) ==
 		NAU8825_JACK_EJECTION_DETECTED) {
@@ -789,6 +880,26 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 
 		event_mask |= SND_JACK_HEADSET;
 		clear_irq = NAU8825_HEADSET_COMPLETION_IRQ;
+	} else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
+		NAU8825_JACK_INSERTION_DETECTED) {
+		/* One more step to check GPIO status directly. Thus, the
+		 * driver can confirm the real insertion interruption because
+		 * the intrruption at manual mode has bypassed debounce
+		 * circuit which can get rid of unstable status.
+		 */
+		if (nau8825_is_jack_inserted(regmap)) {
+			/* Turn off insertion interruption at manual mode */
+			regmap_update_bits(regmap,
+				NAU8825_REG_INTERRUPT_DIS_CTRL,
+				NAU8825_IRQ_INSERT_DIS,
+				NAU8825_IRQ_INSERT_DIS);
+			regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+				NAU8825_IRQ_INSERT_EN, NAU8825_IRQ_INSERT_EN);
+			/* Enable interruption for jack type detection at audo
+			 * mode which can detect microphone and jack type.
+			 */
+			nau8825_setup_auto_irq(nau8825);
+		}
 	}
 
 	if (!clear_irq)
@@ -938,8 +1049,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 }
 
 static const struct regmap_config nau8825_regmap_config = {
-	.val_bits = 16,
-	.reg_bits = 16,
+	.val_bits = NAU8825_REG_DATA_LEN,
+	.reg_bits = NAU8825_REG_ADDR_LEN,
 
 	.max_register = NAU8825_REG_MAX,
 	.readable_reg = nau8825_readable_reg,
@@ -958,11 +1069,10 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 
 	nau8825->dapm = dapm;
 
-	/* Unmask interruptions. Handler uses dapm object so we can enable
-	 * interruptions only after dapm is fully initialized.
+	/* Change jack type detection interruption to non-clock architecture
+	 * for power saving less 1mW. Move these configuration about inter-
+	 * ruption at auto mode to auto irq setup function.
 	 */
-	regmap_write(nau8825->regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0);
-	nau8825_restart_jack_detection(nau8825->regmap);
 
 	return 0;
 }
@@ -1134,7 +1244,26 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	struct regmap *regmap = nau8825->regmap;
 	int ret;
 
+	if (!nau8825_is_jack_inserted(nau8825->regmap) &&
+		clk_id != NAU8825_CLK_DIS) {
+		/* For power saving less 1mW, the jack type detection inter-
+		 * ruption changes to non-clock architecture. Therefore, the
+		 * clock should be disabled and not allowed to config any clock
+		 * when no headset connected.
+		 */
+		dev_warn(nau8825->dev, "Souldn't enable any clock when no headset connected\n");
+		return 0;
+	}
+
 	switch (clk_id) {
+	case NAU8825_CLK_DIS:
+		/* Clock provided externally and disable internal VCO clock */
+		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
+		regmap_update_bits(regmap, NAU8825_REG_FLL6,
+			NAU8825_DCO_EN, 0);
+
+		break;
 	case NAU8825_CLK_MCLK:
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
@@ -1209,6 +1338,30 @@ static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	return nau8825_configure_sysclk(nau8825, clk_id, freq);
 }
 
+static int nau8825_resume_setup(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	/* Close clock when jack type detection at manual mode */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_DIS, 0);
+
+	/* Clear all interruption status */
+	nau8825_int_status_clear_all(regmap);
+
+	/* Enable insertion interruption only and bypass de-bounce circuit */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_EJECT_EN |
+		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_INSERT_EN,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_EJECT_EN |
+		NAU8825_IRQ_HEADSET_COMPLETE_EN);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_DB_BYPASS, NAU8825_JACK_DET_DB_BYPASS);
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL,
+				NAU8825_IRQ_INSERT_DIS, 0);
+
+	return 0;
+}
+
 static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
@@ -1238,11 +1391,22 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 					"Failed to sync cache: %d\n", ret);
 				return ret;
 			}
+
+			/* Setup codec configuration after resume */
+			nau8825_resume_setup(nau8825);
 		}
 
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		/* Turn off all interruptions before system shutdown. Keep the
+		 * interruption quiet before resume setup completes.
+		 */
+		regmap_write(nau8825->regmap,
+			NAU8825_REG_INTERRUPT_DIS_CTRL, 0xffff);
+		/* Disable ADC needed for interruptions at audo mode */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+			NAU8825_ENABLE_ADC, 0);
 		if (nau8825->mclk_freq)
 			clk_disable_unprepare(nau8825->mclk);
 
@@ -1252,12 +1416,50 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int nau8825_codec_suspend(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	disable_irq(nau8825->irq);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_cache_only(nau8825->regmap, true);
+
+	return 0;
+}
+
+static int nau8825_codec_resume(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(nau8825->regmap, false);
+	if (!nau8825_is_jack_inserted(nau8825->regmap)) {
+		/* Check the jack plug status directly. If the headset is un-
+		 * plugged during S3 when the chip has no power, there will
+		 * be no jack detection irq event after restarting jack detec-
+		 * tion, because the chip just thinks no headset has ever
+		 * been plugged in.
+		 */
+		nau8825_eject_jack(nau8825);
+		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
+	}
+	enable_irq(nau8825->irq);
+
+	return 0;
+}
+#else
+#define nau8825_codec_suspend NULL
+#define nau8825_codec_resume NULL
+#endif
+
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
 	.set_sysclk = nau8825_set_sysclk,
 	.set_pll = nau8825_set_pll,
 	.set_bias_level = nau8825_set_bias_level,
 	.suspend_bias_off = true,
+	.suspend = nau8825_codec_suspend,
+	.resume = nau8825_codec_resume,
 
 	.controls = nau8825_controls,
 	.num_controls = ARRAY_SIZE(nau8825_controls),
@@ -1351,29 +1553,13 @@ static int nau8825_read_device_properties(struct device *dev,
 
 static int nau8825_setup_irq(struct nau8825 *nau8825)
 {
-	struct regmap *regmap = nau8825->regmap;
 	int ret;
 
-	/* IRQ Output Enable */
-	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
-		NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
-
-	/* Enable internal VCO needed for interruptions */
-	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
-
-	/* Enable ADC needed for interrupts */
-	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
-		NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
-
-	/* Chip needs one FSCLK cycle in order to generate interrupts,
-	 * as we cannot guarantee one will be provided by the system. Turning
-	 * master mode on then off enables us to generate that FSCLK cycle
-	 * with a minimum of contention on the clock bus.
+	/* Change jack type detection interruption to non-clock architecture
+	 * for power saving less 1mW. Because resume and initiation all need
+	 * to enable the mechanism, move these configuration to resume setup
+	 * function.
 	 */
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
 
 	ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
 		nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1442,36 +1628,6 @@ static int nau8825_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int nau8825_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct nau8825 *nau8825 = dev_get_drvdata(dev);
-
-	disable_irq(client->irq);
-	regcache_cache_only(nau8825->regmap, true);
-	regcache_mark_dirty(nau8825->regmap);
-
-	return 0;
-}
-
-static int nau8825_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct nau8825 *nau8825 = dev_get_drvdata(dev);
-
-	regcache_cache_only(nau8825->regmap, false);
-	regcache_sync(nau8825->regmap);
-	enable_irq(client->irq);
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops nau8825_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(nau8825_suspend, nau8825_resume)
-};
-
 static const struct i2c_device_id nau8825_i2c_ids[] = {
 	{ "nau8825", 0 },
 	{ }
@@ -1498,7 +1654,6 @@ static struct i2c_driver nau8825_driver = {
 		.name = "nau8825",
 		.of_match_table = of_match_ptr(nau8825_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
-		.pm = &nau8825_pm,
 	},
 	.probe = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 9e6cb62..1100385 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -93,6 +93,9 @@
 #define NAU8825_REG_CHARGE_PUMP_INPUT_READ		0x81
 #define NAU8825_REG_GENERAL_STATUS		0x82
 #define NAU8825_REG_MAX		NAU8825_REG_GENERAL_STATUS
+/* 16-bit control register address, and 16-bits control register data */
+#define NAU8825_REG_ADDR_LEN		16
+#define NAU8825_REG_DATA_LEN		16
 
 /* ENA_CTRL (0x1) */
 #define NAU8825_ENABLE_DACR_SFT	10
@@ -145,6 +148,7 @@
 
 /* JACK_DET_CTRL (0xd) */
 #define NAU8825_JACK_DET_RESTART	(1 << 9)
+#define NAU8825_JACK_DET_DB_BYPASS	(1 << 8)
 #define NAU8825_JACK_INSERT_DEBOUNCE_SFT	5
 #define NAU8825_JACK_INSERT_DEBOUNCE_MASK	(0x7 << NAU8825_JACK_INSERT_DEBOUNCE_SFT)
 #define NAU8825_JACK_EJECT_DEBOUNCE_SFT		2
@@ -157,6 +161,7 @@
 #define NAU8825_IRQ_KEY_RELEASE_EN (1 << 7)
 #define NAU8825_IRQ_KEY_SHORT_PRESS_EN (1 << 5)
 #define NAU8825_IRQ_EJECT_EN (1 << 2)
+#define NAU8825_IRQ_INSERT_EN (1 << 0)
 
 /* IRQ_STATUS (0x10) */
 #define NAU8825_HEADSET_COMPLETION_IRQ	(1 << 10)
@@ -177,6 +182,7 @@
 #define NAU8825_IRQ_KEY_RELEASE_DIS (1 << 7)
 #define NAU8825_IRQ_KEY_SHORT_PRESS_DIS (1 << 5)
 #define NAU8825_IRQ_EJECT_DIS (1 << 2)
+#define NAU8825_IRQ_INSERT_DIS (1 << 0)
 
 /* SAR_CTRL (0x13) */
 #define NAU8825_SAR_ADC_EN_SFT	12
@@ -333,7 +339,8 @@
 
 /* System Clock Source */
 enum {
-	NAU8825_CLK_MCLK = 0,
+	NAU8825_CLK_DIS = 0,
+	NAU8825_CLK_MCLK,
 	NAU8825_CLK_INTERNAL,
 	NAU8825_CLK_FLL_MCLK,
 	NAU8825_CLK_FLL_BLK,
-- 
2.6.4
