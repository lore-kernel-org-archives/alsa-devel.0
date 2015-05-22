From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 4/5] ASoC: tegra_max98090: Change nyan to use
	gpio-jack
Date: Fri, 22 May 2015 15:09:22 -0700
Message-ID: <1432332563-15447-5-git-send-email-dgreid@chromium.org>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f202.google.com (mail-pd0-f202.google.com
 [209.85.192.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 3139226043C
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:56 +0200 (CEST)
Received: by pdbht2 with SMTP id ht2so2375793pdb.0
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:55 -0700 (PDT)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Use the new gpio jack device instead of handling the gpios in the
machine driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/tegra/Kconfig          |   1 +
 sound/soc/tegra/tegra_max98090.c | 107 ++++++++-------------------------------
 2 files changed, 22 insertions(+), 86 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index a6768f8..de42bfb 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -125,6 +125,7 @@ config SND_SOC_TEGRA_MAX98090
 	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_MAX98090
+	select SND_SOC_GPIO_AUDIO_JACK
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
 	  boards using the MAX98090 codec, such as Venice2.
diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index 902da36..a8d77ff 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -41,8 +41,6 @@
 
 struct tegra_max98090 {
 	struct tegra_asoc_utils_data util_data;
-	int gpio_hp_det;
-	int gpio_mic_det;
 };
 
 static int tegra_max98090_asoc_hw_params(struct snd_pcm_substream *substream,
@@ -97,38 +95,6 @@ static struct snd_soc_ops tegra_max98090_ops = {
 	.hw_params = tegra_max98090_asoc_hw_params,
 };
 
-static struct snd_soc_jack tegra_max98090_hp_jack;
-
-static struct snd_soc_jack_pin tegra_max98090_hp_jack_pins[] = {
-	{
-		.pin = "Headphones",
-		.mask = SND_JACK_HEADPHONE,
-	},
-};
-
-static struct snd_soc_jack_gpio tegra_max98090_hp_jack_gpio = {
-	.name = "Headphone detection",
-	.report = SND_JACK_HEADPHONE,
-	.debounce_time = 150,
-	.invert = 1,
-};
-
-static struct snd_soc_jack tegra_max98090_mic_jack;
-
-static struct snd_soc_jack_pin tegra_max98090_mic_jack_pins[] = {
-	{
-		.pin = "Mic Jack",
-		.mask = SND_JACK_MICROPHONE,
-	},
-};
-
-static struct snd_soc_jack_gpio tegra_max98090_mic_jack_gpio = {
-	.name = "Mic detection",
-	.report = SND_JACK_MICROPHONE,
-	.debounce_time = 150,
-	.invert = 1,
-};
-
 static const struct snd_soc_dapm_widget tegra_max98090_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
@@ -145,50 +111,14 @@ static const struct snd_kcontrol_new tegra_max98090_controls[] = {
 
 static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
-
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_card_jack_new(rtd->card, "Headphones",
-				      SND_JACK_HEADPHONE,
-				      &tegra_max98090_hp_jack,
-				      tegra_max98090_hp_jack_pins,
-				      ARRAY_SIZE(tegra_max98090_hp_jack_pins));
-
-		tegra_max98090_hp_jack_gpio.gpio = machine->gpio_hp_det;
-		snd_soc_jack_add_gpios(&tegra_max98090_hp_jack,
-					1,
-					&tegra_max98090_hp_jack_gpio);
-	}
-
-	if (gpio_is_valid(machine->gpio_mic_det)) {
-		snd_soc_card_jack_new(rtd->card, "Mic Jack",
-				      SND_JACK_MICROPHONE,
-				      &tegra_max98090_mic_jack,
-				      tegra_max98090_mic_jack_pins,
-				      ARRAY_SIZE(tegra_max98090_mic_jack_pins));
-
-		tegra_max98090_mic_jack_gpio.gpio = machine->gpio_mic_det;
-		snd_soc_jack_add_gpios(&tegra_max98090_mic_jack,
-				       1,
-				       &tegra_max98090_mic_jack_gpio);
-	}
-
-	return 0;
-}
-
-static int tegra_max98090_card_remove(struct snd_soc_card *card)
-{
-	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_max98090_hp_jack, 1,
-					&tegra_max98090_hp_jack_gpio);
-	}
+	/* Force MICBIAS on because it is needed for mic detection. */
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
 
-	if (gpio_is_valid(machine->gpio_mic_det)) {
-		snd_soc_jack_free_gpios(&tegra_max98090_mic_jack, 1,
-					&tegra_max98090_mic_jack_gpio);
-	}
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -203,12 +133,17 @@ static struct snd_soc_dai_link tegra_max98090_dai = {
 			SND_SOC_DAIFMT_CBS_CFS,
 };
 
+static struct snd_soc_aux_dev gpio_headset_jack_dev = {
+		.name = "gpio-headset-jack",
+};
+
 static struct snd_soc_card snd_soc_tegra_max98090 = {
 	.name = "tegra-max98090",
 	.owner = THIS_MODULE,
-	.remove = tegra_max98090_card_remove,
 	.dai_link = &tegra_max98090_dai,
 	.num_links = 1,
+	.aux_dev = &gpio_headset_jack_dev,
+	.num_aux_devs = 1,
 	.controls = tegra_max98090_controls,
 	.num_controls = ARRAY_SIZE(tegra_max98090_controls),
 	.dapm_widgets = tegra_max98090_dapm_widgets,
@@ -234,15 +169,6 @@ static int tegra_max98090_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
-	machine->gpio_hp_det = of_get_named_gpio(np, "nvidia,hp-det-gpios", 0);
-	if (machine->gpio_hp_det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	machine->gpio_mic_det =
-			of_get_named_gpio(np, "nvidia,mic-det-gpios", 0);
-	if (machine->gpio_mic_det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
 	ret = snd_soc_of_parse_card_name(card, "nvidia,model");
 	if (ret)
 		goto err;
@@ -269,6 +195,15 @@ static int tegra_max98090_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	gpio_headset_jack_dev.codec_of_node = of_parse_phandle(np,
+			"nvidia,headset-dev", 0);
+	if (!gpio_headset_jack_dev.codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'nvidia,headset-dev' missing or invalid\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
 	tegra_max98090_dai.platform_of_node = tegra_max98090_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
-- 
2.2.1.62.g3f15098
