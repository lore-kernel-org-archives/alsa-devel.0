From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Add jack-detect
	support" to the asoc tree
Date: Fri,  4 Jan 2019 17:08:53 +0000 (GMT)
Message-ID: <20190104170853.B87BD11270A3@debutante.sirena.org.uk>
References: <20190103134535.13861-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F026E267CB6
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:08:54 +0100 (CET)
In-Reply-To: <20190103134535.13861-7-hdegoede@redhat.com>
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

   ASoC: Intel: bytcht_es8316: Add jack-detect support

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

>From 4bf538b42933253296daf86aab7ede56b5fb97bf Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:31 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add jack-detect support

Hookup the jack-detect support added to the codec driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 67 +++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 3358d82499a3..905dd6904710 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -22,12 +22,14 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/platform_sst_audio.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -37,6 +39,7 @@
 
 struct byt_cht_es8316_private {
 	struct clk *mclk;
+	struct snd_soc_jack jack;
 };
 
 #define BYT_CHT_ES8316_SSP0			BIT(16)
@@ -55,6 +58,7 @@ static void log_quirks(struct device *dev)
 
 static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
 	/*
 	 * The codec supports two analog microphone inputs. I have only
@@ -68,6 +72,7 @@ static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
 	{"MIC1", NULL, "Microphone 1"},
 	{"MIC2", NULL, "Microphone 2"},
+	{"MIC1", NULL, "Headset Mic"},
 
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
@@ -91,12 +96,25 @@ static const struct snd_soc_dapm_route byt_cht_es8316_ssp2_map[] = {
 
 static const struct snd_kcontrol_new byt_cht_es8316_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Microphone 1"),
 	SOC_DAPM_PIN_SWITCH("Microphone 2"),
 };
 
+static struct snd_soc_jack_pin byt_cht_es8316_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 {
+	struct snd_soc_component *codec = runtime->codec_dai->component;
 	struct snd_soc_card *card = runtime->card;
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 	const struct snd_soc_dapm_route *custom_map;
@@ -143,6 +161,18 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	ret = snd_soc_card_jack_new(card, "Headset",
+				    SND_JACK_HEADSET | SND_JACK_BTN_0,
+				    &priv->jack, byt_cht_es8316_jack_pins,
+				    ARRAY_SIZE(byt_cht_es8316_jack_pins));
+	if (ret) {
+		dev_err(card->dev, "jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_soc_component_set_jack(codec, &priv->jack, NULL);
+
 	return 0;
 }
 
@@ -263,6 +293,39 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 
 
 /* SoC card */
+static char codec_name[SND_ACPI_I2C_ID_LEN];
+
+static int byt_cht_es8316_suspend(struct snd_soc_card *card)
+{
+	struct snd_soc_component *component;
+
+	for_each_card_components(card, component) {
+		if (!strcmp(component->name, codec_name)) {
+			dev_dbg(component->dev, "disabling jack detect before suspend\n");
+			snd_soc_component_set_jack(component, NULL, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int byt_cht_es8316_resume(struct snd_soc_card *card)
+{
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_component *component;
+
+	for_each_card_components(card, component) {
+		if (!strcmp(component->name, codec_name)) {
+			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
+			snd_soc_component_set_jack(component, &priv->jack, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_card byt_cht_es8316_card = {
 	.name = "bytcht-es8316",
 	.owner = THIS_MODULE,
@@ -275,6 +338,8 @@ static struct snd_soc_card byt_cht_es8316_card = {
 	.controls = byt_cht_es8316_controls,
 	.num_controls = ARRAY_SIZE(byt_cht_es8316_controls),
 	.fully_routed = true,
+	.suspend_pre = byt_cht_es8316_suspend,
+	.resume_post = byt_cht_es8316_resume,
 };
 
 static const struct x86_cpu_id baytrail_cpu_ids[] = {
@@ -282,8 +347,6 @@ static const struct x86_cpu_id baytrail_cpu_ids[] = {
 	{}
 };
 
-static char codec_name[SND_ACPI_I2C_ID_LEN];
-
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	struct byt_cht_es8316_private *priv;
-- 
2.20.1
