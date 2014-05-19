From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: tegra: Replace instances of
	rtd->codec->card with rtd->card
Date: Mon, 19 May 2014 11:41:45 +0200
Message-ID: <1400492508-2732-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 65664261685
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 11:41:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

No need to go via the CODEC to get a pointer to the card. This will help to
eventually remove the card field from the snd_soc_codec struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/tegra/tegra_alc5632.c  | 5 ++---
 sound/soc/tegra/tegra_max98090.c | 5 ++---
 sound/soc/tegra/tegra_rt5640.c   | 5 ++---
 sound/soc/tegra/tegra_wm8753.c   | 3 +--
 sound/soc/tegra/tegra_wm8903.c   | 5 ++---
 sound/soc/tegra/trimslice.c      | 3 +--
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index c61ea3a..21ad9bd 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -41,8 +41,7 @@ static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_alc5632 *alc5632 = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
@@ -105,7 +104,7 @@ static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(codec->card);
+	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
 
 	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
 			 &tegra_alc5632_hs_jack);
diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index 0283cfb..b867b27 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -49,8 +49,7 @@ static int tegra_max98090_asoc_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
@@ -127,7 +126,7 @@ static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(codec->card);
+	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		snd_soc_jack_new(codec, "Headphones", SND_JACK_HEADPHONE,
diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
index 4511c5a..d720bd7 100644
--- a/sound/soc/tegra/tegra_rt5640.c
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -51,8 +51,7 @@ static int tegra_rt5640_asoc_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
@@ -110,7 +109,7 @@ static int tegra_rt5640_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(codec->card);
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(rtd->card);
 
 	snd_soc_jack_new(codec, "Headphones", SND_JACK_HEADPHONE,
 			 &tegra_rt5640_hp_jack);
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index 8e774d1..769e28f 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -55,8 +55,7 @@ static int tegra_wm8753_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 4ac7373..e795424 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -60,8 +60,7 @@ static int tegra_wm8903_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
@@ -173,7 +172,7 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 734bfcd..589d2d9 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -50,8 +50,7 @@ static int trimslice_asoc_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct tegra_trimslice *trimslice = snd_soc_card_get_drvdata(card);
 	int srate, mclk;
 	int err;
-- 
1.8.0
