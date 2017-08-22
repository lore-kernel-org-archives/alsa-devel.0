From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ASoC: tegra: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:51 +0200
Message-ID: <20170822115951.6679-9-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B669E2675E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:59:55 +0200 (CEST)
In-Reply-To: <20170822115951.6679-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra_alc5632.c  | 13 -------------
 sound/soc/tegra/tegra_max98090.c | 18 ------------------
 sound/soc/tegra/tegra_rt5640.c   | 13 -------------
 sound/soc/tegra/tegra_rt5677.c   | 18 ------------------
 sound/soc/tegra/tegra_wm8903.c   |  5 -----
 5 files changed, 67 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 0509902512cc..00383155d5f8 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -124,18 +124,6 @@ static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int tegra_alc5632_card_remove(struct snd_soc_card *card)
-{
-	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(card);
-
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_alc5632_hs_jack, 1,
-					&tegra_alc5632_hp_jack_gpio);
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link tegra_alc5632_dai = {
 	.name = "ALC5632",
 	.stream_name = "ALC5632 PCM",
@@ -150,7 +138,6 @@ static struct snd_soc_dai_link tegra_alc5632_dai = {
 static struct snd_soc_card snd_soc_tegra_alc5632 = {
 	.name = "tegra-alc5632",
 	.owner = THIS_MODULE,
-	.remove = tegra_alc5632_card_remove,
 	.dai_link = &tegra_alc5632_dai,
 	.num_links = 1,
 	.controls = tegra_alc5632_controls,
diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index c34a54d6e812..955067adf2d9 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -176,23 +176,6 @@ static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int tegra_max98090_card_remove(struct snd_soc_card *card)
-{
-	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(card);
-
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_max98090_hp_jack, 1,
-					&tegra_max98090_hp_jack_gpio);
-	}
-
-	if (gpio_is_valid(machine->gpio_mic_det)) {
-		snd_soc_jack_free_gpios(&tegra_max98090_mic_jack, 1,
-					&tegra_max98090_mic_jack_gpio);
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link tegra_max98090_dai = {
 	.name = "max98090",
 	.stream_name = "max98090 PCM",
@@ -206,7 +189,6 @@ static struct snd_soc_dai_link tegra_max98090_dai = {
 static struct snd_soc_card snd_soc_tegra_max98090 = {
 	.name = "tegra-max98090",
 	.owner = THIS_MODULE,
-	.remove = tegra_max98090_card_remove,
 	.dai_link = &tegra_max98090_dai,
 	.num_links = 1,
 	.controls = tegra_max98090_controls,
diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
index 93a356802345..76ed6042d84d 100644
--- a/sound/soc/tegra/tegra_rt5640.c
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -126,18 +126,6 @@ static int tegra_rt5640_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int tegra_rt5640_card_remove(struct snd_soc_card *card)
-{
-	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(card);
-
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_rt5640_hp_jack, 1,
-					&tegra_rt5640_hp_jack_gpio);
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link tegra_rt5640_dai = {
 	.name = "RT5640",
 	.stream_name = "RT5640 PCM",
@@ -151,7 +139,6 @@ static struct snd_soc_dai_link tegra_rt5640_dai = {
 static struct snd_soc_card snd_soc_tegra_rt5640 = {
 	.name = "tegra-rt5640",
 	.owner = THIS_MODULE,
-	.remove = tegra_rt5640_card_remove,
 	.dai_link = &tegra_rt5640_dai,
 	.num_links = 1,
 	.controls = tegra_rt5640_controls,
diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index ebf58d0e0f10..dc5a295d61e5 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -169,23 +169,6 @@ static int tegra_rt5677_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int tegra_rt5677_card_remove(struct snd_soc_card *card)
-{
-	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
-
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_rt5677_hp_jack, 1,
-				&tegra_rt5677_hp_jack_gpio);
-	}
-
-	if (gpio_is_valid(machine->gpio_mic_present)) {
-		snd_soc_jack_free_gpios(&tegra_rt5677_mic_jack, 1,
-				&tegra_rt5677_mic_jack_gpio);
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link tegra_rt5677_dai = {
 	.name = "RT5677",
 	.stream_name = "RT5677 PCM",
@@ -199,7 +182,6 @@ static struct snd_soc_dai_link tegra_rt5677_dai = {
 static struct snd_soc_card snd_soc_tegra_rt5677 = {
 	.name = "tegra-rt5677",
 	.owner = THIS_MODULE,
-	.remove = tegra_rt5677_card_remove,
 	.dai_link = &tegra_rt5677_dai,
 	.num_links = 1,
 	.controls = tegra_rt5677_controls,
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index dbfb49298ae8..ce498cc0914b 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -205,11 +205,6 @@ static int tegra_wm8903_remove(struct snd_soc_card *card)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
 
-	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_free_gpios(&tegra_wm8903_hp_jack, 1,
-					&tegra_wm8903_hp_jack_gpio);
-	}
-
 	wm8903_mic_detect(codec, NULL, 0, 0);
 
 	return 0;
-- 
2.14.0
