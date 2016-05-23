From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH v2] ASoC: nau8825: non-clock jack detection for
	power saving at standby
Date: Mon, 23 May 2016 10:25:40 +0800
Message-ID: <1463970340-27548-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBDB82604A9
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 04:24:48 +0200 (CEST)
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

To resolve the conflict of the first verion. The information is as the
following.
> > ASoC: nau8825: non-clock jack detection for power saving at standby
> > has been applied to the asoc tree at
> >    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> This seems to conflict with some power management fixes in Linus' tree
> so I've dropped it.  Please check and resend.

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
---
 sound/soc/codecs/nau8825.c | 249 ++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/nau8825.h |   9 +-
 2 files changed, 188 insertions(+), 70 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 81fc97b..abaa5f4 100644
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
@@ -617,9 +623,6 @@ int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
 		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
 		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
 
-	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
-		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
@@ -635,16 +638,6 @@ static bool nau8825_is_jack_inserted(struct regmap *regmap)
 
 static void nau8825_restart_jack_detection(struct regmap *regmap)
 {
-	/* Chip needs one FSCLK cycle in order to generate interrupts,
-	 * as we cannot guarantee one will be provided by the system. Turning
-	 * master mode on then off enables us to generate that FSCLK cycle
-	 * with a minimum of contention on the clock bus.
-	 */
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
-	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
-
 	/* this will restart the entire jack detection process including MIC/GND
 	 * switching and create interrupts. We have to go from 0 to 1 and back
 	 * to 0 to restart.
@@ -655,6 +648,22 @@ static void nau8825_restart_jack_detection(struct regmap *regmap)
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
@@ -669,6 +678,69 @@ static void nau8825_eject_jack(struct nau8825 *nau8825)
 	regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 0xf, 0xf);
 
 	snd_soc_dapm_sync(dapm);
+
+	/* Clear all interruption status */
+	nau8825_int_status_clear_all(regmap);
+
+	/* Enable the insertion interruption, disable the ejection inter-
+	 * ruption, and then bypass de-bounce circuit.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL,
+		NAU8825_IRQ_EJECT_DIS | NAU8825_IRQ_INSERT_DIS,
+		NAU8825_IRQ_EJECT_DIS);
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
@@ -805,6 +877,26 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 
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
@@ -954,8 +1046,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 }
 
 static const struct regmap_config nau8825_regmap_config = {
-	.val_bits = 16,
-	.reg_bits = 16,
+	.val_bits = NAU8825_REG_DATA_LEN,
+	.reg_bits = NAU8825_REG_ADDR_LEN,
 
 	.max_register = NAU8825_REG_MAX,
 	.readable_reg = nau8825_readable_reg,
@@ -974,12 +1066,6 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 
 	nau8825->dapm = dapm;
 
-	/* Unmask interruptions. Handler uses dapm object so we can enable
-	 * interruptions only after dapm is fully initialized.
-	 */
-	regmap_write(nau8825->regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0);
-	nau8825_restart_jack_detection(nau8825->regmap);
-
 	return 0;
 }
 
@@ -1144,6 +1230,14 @@ static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
 	return 0;
 }
 
+static void nau8825_configure_mclk_as_sysclk(struct regmap *regmap)
+{
+	regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+		NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
+	regmap_update_bits(regmap, NAU8825_REG_FLL6,
+		NAU8825_DCO_EN, 0);
+}
+
 static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	unsigned int freq)
 {
@@ -1151,10 +1245,17 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	int ret;
 
 	switch (clk_id) {
+	case NAU8825_CLK_DIS:
+		/* Clock provided externally and disable internal VCO clock */
+		nau8825_configure_mclk_as_sysclk(regmap);
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
+
+		break;
 	case NAU8825_CLK_MCLK:
-		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
-			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
-		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
+		nau8825_configure_mclk_as_sysclk(regmap);
 		/* MCLK not changed by clock tree */
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_MCLK_SRC_MASK, 0);
@@ -1164,17 +1265,25 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_INTERNAL:
-		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN,
-			NAU8825_DCO_EN);
-		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
-			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
-		/* Decrease the VCO frequency for power saving */
-		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
-			NAU8825_CLK_MCLK_SRC_MASK, 0xf);
-		regmap_update_bits(regmap, NAU8825_REG_FLL1,
-			NAU8825_FLL_RATIO_MASK, 0x10);
-		regmap_update_bits(regmap, NAU8825_REG_FLL6,
-			NAU8825_SDM_EN, NAU8825_SDM_EN);
+		if (nau8825_is_jack_inserted(nau8825->regmap)) {
+			regmap_update_bits(regmap, NAU8825_REG_FLL6,
+				NAU8825_DCO_EN, NAU8825_DCO_EN);
+			regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+				NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+			/* Decrease the VCO frequency for power saving */
+			regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+				NAU8825_CLK_MCLK_SRC_MASK, 0xf);
+			regmap_update_bits(regmap, NAU8825_REG_FLL1,
+				NAU8825_FLL_RATIO_MASK, 0x10);
+			regmap_update_bits(regmap, NAU8825_REG_FLL6,
+				NAU8825_SDM_EN, NAU8825_SDM_EN);
+		} else {
+			/* The clock turns off intentionally for power saving
+			 * when no headset connected.
+			 */
+			nau8825_configure_mclk_as_sysclk(regmap);
+			dev_warn(nau8825->dev, "Disable clock for power saving when no headset connected\n");
+		}
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
@@ -1225,6 +1334,31 @@ static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
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
+	/* Enable both insertion and ejection interruptions, and then
+	 * bypass de-bounce circuit.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_HEADSET_COMPLETE_EN |
+		NAU8825_IRQ_EJECT_EN | NAU8825_IRQ_INSERT_EN,
+		NAU8825_IRQ_OUTPUT_EN | NAU8825_IRQ_HEADSET_COMPLETE_EN);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_DB_BYPASS, NAU8825_JACK_DET_DB_BYPASS);
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL,
+		NAU8825_IRQ_INSERT_DIS | NAU8825_IRQ_EJECT_DIS, 0);
+
+	return 0;
+}
+
 static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
@@ -1247,10 +1381,20 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 					return ret;
 				}
 			}
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
 		break;
@@ -1264,6 +1408,7 @@ static int nau8825_suspend(struct snd_soc_codec *codec)
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 
 	disable_irq(nau8825->irq);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 	regcache_cache_only(nau8825->regmap, true);
 	regcache_mark_dirty(nau8825->regmap);
 
@@ -1274,32 +1419,10 @@ static int nau8825_resume(struct snd_soc_codec *codec)
 {
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 
-	/* The chip may lose power and reset in S3. regcache_sync restores
-	 * register values including configurations for sysclk, irq, and
-	 * jack/button detection.
-	 */
 	regcache_cache_only(nau8825->regmap, false);
 	regcache_sync(nau8825->regmap);
-
-	/* Check the jack plug status directly. If the headset is unplugged
-	 * during S3 when the chip has no power, there will be no jack
-	 * detection irq even after the nau8825_restart_jack_detection below,
-	 * because the chip just thinks no headset has ever been plugged in.
-	 */
-	if (!nau8825_is_jack_inserted(nau8825->regmap)) {
-		nau8825_eject_jack(nau8825);
-		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
-	}
-
 	enable_irq(nau8825->irq);
 
-	/* Run jack detection to check the type (OMTP or CTIA) of the headset
-	 * if there is one. This handles the case where a different type of
-	 * headset is plugged in during S3. This triggers an IRQ iff a headset
-	 * is already plugged in.
-	 */
-	nau8825_restart_jack_detection(nau8825->regmap);
-
 	return 0;
 }
 #else
@@ -1408,20 +1531,8 @@ static int nau8825_read_device_properties(struct device *dev,
 
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
 	ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
 		nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 		"nau8825", nau8825);
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
