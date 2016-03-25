From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: nau8825: Fix jack detection across
	suspend
Date: Fri, 25 Mar 2016 16:10:39 -0700
Message-ID: <1458947439-21936-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 59AAA2610A3
 for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2016 00:11:57 +0100 (CET)
Received: by mail-pa0-f48.google.com with SMTP id fe3so54826907pab.1
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 16:11:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ben Zhang <benzh@chromium.org>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Jack plug status is rechecked at resume to handle plug/unplug
in S3 when the chip has no power.

Suspend/resume callbacks are moved from the i2c dev_pm_ops to
snd_soc_codec_driver. soc_resume_deferred is a delayed work
which may trigger nau8825_set_bias_level. The bias change races
against dev_pm_ops, causing jack detection issues.
soc_resume_deferred ensures bias change and snd_soc_codec_driver
suspend/resume are sequenced correctly.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 126 +++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3e7bee2..cb08a35 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -343,9 +343,12 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
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
@@ -607,6 +610,16 @@ static bool nau8825_is_jack_inserted(struct regmap *regmap)
 
 static void nau8825_restart_jack_detection(struct regmap *regmap)
 {
+	/* Chip needs one FSCLK cycle in order to generate interrupts,
+	 * as we cannot guarantee one will be provided by the system. Turning
+	 * master mode on then off enables us to generate that FSCLK cycle
+	 * with a minimum of contention on the clock bus.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+
 	/* this will restart the entire jack detection process including MIC/GND
 	 * switching and create interrupts. We have to go from 0 to 1 and back
 	 * to 0 to restart.
@@ -728,7 +741,10 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	struct regmap *regmap = nau8825->regmap;
 	int active_irq, clear_irq = 0, event = 0, event_mask = 0;
 
-	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
+	if (regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq)) {
+		dev_err(nau8825->dev, "failed to read irq status\n");
+		return IRQ_NONE;
+	}
 
 	if ((active_irq & NAU8825_JACK_EJECTION_IRQ_MASK) ==
 		NAU8825_JACK_EJECTION_DETECTED) {
@@ -1198,33 +1214,74 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 					return ret;
 				}
 			}
-
-			ret = regcache_sync(nau8825->regmap);
-			if (ret) {
-				dev_err(codec->dev,
-					"Failed to sync cache: %d\n", ret);
-				return ret;
-			}
 		}
-
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		if (nau8825->mclk_freq)
 			clk_disable_unprepare(nau8825->mclk);
-
-		regcache_mark_dirty(nau8825->regmap);
 		break;
 	}
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int nau8825_suspend(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	disable_irq(nau8825->irq);
+	regcache_cache_only(nau8825->regmap, true);
+	regcache_mark_dirty(nau8825->regmap);
+
+	return 0;
+}
+
+static int nau8825_resume(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	/* The chip may lose power and reset in S3. regcache_sync restores
+	 * register values including configurations for sysclk, irq, and
+	 * jack/button detection.
+	 */
+	regcache_cache_only(nau8825->regmap, false);
+	regcache_sync(nau8825->regmap);
+
+	/* Check the jack plug status directly. If the headset is unplugged
+	 * during S3 when the chip has no power, there will be no jack
+	 * detection irq even after the nau8825_restart_jack_detection below,
+	 * because the chip just thinks no headset has ever been plugged in.
+	 */
+	if (!nau8825_is_jack_inserted(nau8825->regmap)) {
+		nau8825_eject_jack(nau8825);
+		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
+	}
+
+	enable_irq(nau8825->irq);
+
+	/* Run jack detection to check the type (OMTP or CTIA) of the headset
+	 * if there is one. This handles the case where a different type of
+	 * headset is plugged in during S3. This triggers an IRQ iff a headset
+	 * is already plugged in.
+	 */
+	nau8825_restart_jack_detection(nau8825->regmap);
+
+	return 0;
+}
+#else
+#define nau8825_suspend NULL
+#define nau8825_resume NULL
+#endif
+
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
 	.set_sysclk = nau8825_set_sysclk,
 	.set_pll = nau8825_set_pll,
 	.set_bias_level = nau8825_set_bias_level,
 	.suspend_bias_off = true,
+	.suspend = nau8825_suspend,
+	.resume = nau8825_resume,
 
 	.controls = nau8825_controls,
 	.num_controls = ARRAY_SIZE(nau8825_controls),
@@ -1334,16 +1391,6 @@ static int nau8825_setup_irq(struct nau8825 *nau8825)
 	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
 		NAU8825_ENABLE_DACR, NAU8825_ENABLE_DACR);
 
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
 	ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
 		nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 		"nau8825", nau8825);
@@ -1411,36 +1458,6 @@ static int nau8825_i2c_remove(struct i2c_client *client)
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
@@ -1467,7 +1484,6 @@ static struct i2c_driver nau8825_driver = {
 		.name = "nau8825",
 		.of_match_table = of_match_ptr(nau8825_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
-		.pm = &nau8825_pm,
 	},
 	.probe = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
-- 
2.8.0.rc3.226.g39d4020
