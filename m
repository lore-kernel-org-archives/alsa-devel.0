From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Add external
	speaker mux support" to the asoc tree
Date: Fri,  4 Jan 2019 17:08:51 +0000 (GMT)
Message-ID: <20190104170851.D447B11270A3@debutante.sirena.org.uk>
References: <20190103134535.13861-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 90655267CD3
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:08:52 +0100 (CET)
In-Reply-To: <20190103134535.13861-8-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: Add external speaker mux support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0d3e91da0750835cfd5c16487ffb3cdd752ea53a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:32 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add external speaker mux support

The ES8316 only has a single (amplified) output. The ES8316 appnote showing
the intended usage uses a jack-receptacle which physically disconnects the
speakers from the output when a jack is plugged in.

But all 3 devices using the es8316 which I have (2 Cherry Trail devices and
one Bay Trail CR device), use an analog mux to disconnect the speakers,
driven by a GPIO.

This commit adds support for this, modelling this as a separate speaker
widget / dapm pin-switch which sets the mux to drive the speakers when
selected.

The intend is for userspace to use the recently added jack-detect support
and then automatically select either the Headphone or Speaker output based
on that.

Note this commit includes a workaround for an ACPI table bug which is
present on 2 of the 3 devices I have, see the added comment in the code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 98 ++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 905dd6904710..8e504fca4624 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -19,8 +19,11 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/module.h>
@@ -40,6 +43,8 @@
 struct byt_cht_es8316_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
+	struct gpio_desc *speaker_en_gpio;
+	bool speaker_en;
 };
 
 #define BYT_CHT_ES8316_SSP0			BIT(16)
@@ -56,7 +61,24 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0 enabled");
 }
 
+static int byt_cht_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_card *card = w->dapm->card;
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		priv->speaker_en = true;
+	else
+		priv->speaker_en = false;
+
+	gpiod_set_value_cansleep(priv->speaker_en_gpio, priv->speaker_en);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
@@ -67,6 +89,10 @@ static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	 */
 	SND_SOC_DAPM_MIC("Microphone 1", NULL),
 	SND_SOC_DAPM_MIC("Microphone 2", NULL),
+
+	SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
+			    byt_cht_es8316_speaker_power_event,
+			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 };
 
 static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
@@ -76,6 +102,14 @@ static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
 
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
+
+	/*
+	 * There is no separate speaker output instead the speakers are muxed to
+	 * the HP outputs. The mux is controlled by the "Speaker Power" supply.
+	 */
+	{"Speaker", NULL, "HPOL"},
+	{"Speaker", NULL, "HPOR"},
+	{"Speaker", NULL, "Speaker Power"},
 };
 
 static const struct snd_soc_dapm_route byt_cht_es8316_ssp0_map[] = {
@@ -95,6 +129,7 @@ static const struct snd_soc_dapm_route byt_cht_es8316_ssp2_map[] = {
 };
 
 static const struct snd_kcontrol_new byt_cht_es8316_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Microphone 1"),
@@ -323,6 +358,25 @@ static int byt_cht_es8316_resume(struct snd_soc_card *card)
 		}
 	}
 
+	/*
+	 * Some Cherry Trail boards with an ES8316 codec have a bug in their
+	 * ACPI tables where the MSSL1680 touchscreen's _PS0 and _PS3 methods
+	 * wrongly also set the speaker-enable GPIO to 1/0. Testing has shown
+	 * that this really is a bug and the GPIO has no influence on the
+	 * touchscreen at all.
+	 *
+	 * The silead.c touchscreen driver does not support runtime suspend, so
+	 * the GPIO can only be changed underneath us during a system suspend.
+	 * This resume() function runs from a pm complete() callback, and thus
+	 * is guaranteed to run after the touchscreen driver/ACPI-subsys has
+	 * brought the touchscreen back up again (and thus changed the GPIO).
+	 *
+	 * So to work around this we pass GPIOD_FLAGS_BIT_NONEXCLUSIVE when
+	 * requesting the GPIO and we set its value here to undo any changes
+	 * done by the touchscreen's broken _PS0 ACPI method.
+	 */
+	gpiod_set_value_cansleep(priv->speaker_en_gpio, priv->speaker_en);
+
 	return 0;
 }
 
@@ -347,12 +401,20 @@ static const struct x86_cpu_id baytrail_cpu_ids[] = {
 	{}
 };
 
+static const struct acpi_gpio_params first_gpio = { 0, 0, false };
+
+static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
+	{ "speaker-enable-gpios", &first_gpio, 1 },
+	{ },
+};
+
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
+	struct device *codec_dev;
 	int dai_index = 0;
 	int i;
 	int ret = 0;
@@ -405,12 +467,39 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* get speaker enable GPIO */
+	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL, codec_name);
+	if (!codec_dev)
+		return -EPROBE_DEFER;
+
+	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
+	priv->speaker_en_gpio =
+		gpiod_get_index(codec_dev, "speaker-enable", 0,
+				/* see comment in byt_cht_es8316_resume */
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	put_device(codec_dev);
+
+	if (IS_ERR(priv->speaker_en_gpio)) {
+		ret = PTR_ERR(priv->speaker_en_gpio);
+		switch (ret) {
+		case -ENOENT:
+			priv->speaker_en_gpio = NULL;
+			break;
+		default:
+			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
+			/* fall through */
+		case -EPROBE_DEFER:
+			return ret;
+		}
+	}
+
 	/* register the soc card */
 	byt_cht_es8316_card.dev = dev;
 	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
 
 	ret = devm_snd_soc_register_card(dev, &byt_cht_es8316_card);
 	if (ret) {
+		gpiod_put(priv->speaker_en_gpio);
 		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
 		return ret;
 	}
@@ -418,11 +507,20 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
+{
+	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
+
+	gpiod_put(priv->speaker_en_gpio);
+	return 0;
+}
+
 static struct platform_driver snd_byt_cht_es8316_mc_driver = {
 	.driver = {
 		.name = "bytcht_es8316",
 	},
 	.probe = snd_byt_cht_es8316_mc_probe,
+	.remove = snd_byt_cht_es8316_mc_remove,
 };
 
 module_platform_driver(snd_byt_cht_es8316_mc_driver);
-- 
2.20.1
