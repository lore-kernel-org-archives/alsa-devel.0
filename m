From: tony.zou.hq@gmail.com
Subject: [PATCH] max98357a:add dai without triggered by pcm
Date: Fri, 29 Mar 2019 09:51:59 +0800
Message-ID: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, Tony Zou <zoutao@huaqin.corp-partner.google.com>
List-Id: alsa-devel@alsa-project.org

From: Tony Zou <zoutao@huaqin.corp-partner.google.com>

max98357a's enable pin need setting independently
when max98357a is shared I2S with other codec.

add dai "max98357a-hifi" without pcm trigger,
and use "Spk PA Switch" to set the enable pin.

Signed-off-by: Tony Zou <zoutao@huaqin.corp-partner.google.com>
---
 sound/soc/codecs/max98357a.c |   94 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576..bd3e77b 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -51,12 +51,52 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static const char * const ext_spk_text[] = {
+	"Off", "On"
+};
+
+static const struct soc_enum ext_spk_enum =
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			ARRAY_SIZE(ext_spk_text), ext_spk_text);
+
+
+static const struct snd_kcontrol_new ext_spk_mux =
+	SOC_DAPM_ENUM("Spk PA Switch", ext_spk_enum);
+
+
+static int max98357a_enable_spk_pa(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct gpio_desc *sdmode = snd_soc_component_get_drvdata(cmpnt);
+
+	if (!sdmode)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpiod_set_value(sdmode, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpiod_set_value(sdmode, 0);
+		break;
+	}
+	return 0;
+}
+
+
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Speaker"),
+	SND_SOC_DAPM_SPK("Spk PA", max98357a_enable_spk_pa),
+	SND_SOC_DAPM_MUX("Spk PA Switch", SND_SOC_NOPM, 0, 0,
+			&ext_spk_mux),
 };
 
 static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 	{"Speaker", NULL, "HiFi Playback"},
+	{"Speaker", NULL, "Spk PA"},
+	{"Spk PA", NULL, "Spk PA Switch"},
+	{"Spk PA Switch", "On", "HiFi Playback1"},
 };
 
 static int max98357a_component_probe(struct snd_soc_component *component)
@@ -88,30 +128,50 @@ static int max98357a_component_probe(struct snd_soc_component *component)
 	.trigger	= max98357a_daiops_trigger,
 };
 
-static struct snd_soc_dai_driver max98357a_dai_driver = {
-	.name = "HiFi",
-	.playback = {
-		.stream_name	= "HiFi Playback",
-		.formats	= SNDRV_PCM_FMTBIT_S16 |
-					SNDRV_PCM_FMTBIT_S24 |
-					SNDRV_PCM_FMTBIT_S32,
-		.rates		= SNDRV_PCM_RATE_8000 |
-					SNDRV_PCM_RATE_16000 |
-					SNDRV_PCM_RATE_48000 |
-					SNDRV_PCM_RATE_96000,
-		.rate_min	= 8000,
-		.rate_max	= 96000,
-		.channels_min	= 1,
-		.channels_max	= 2,
+static struct snd_soc_dai_driver max98357a_dai_driver[] = {
+	{
+		.name = "HiFi",
+		.playback = {
+			.stream_name	= "HiFi Playback",
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+						SNDRV_PCM_FMTBIT_S24 |
+						SNDRV_PCM_FMTBIT_S32,
+			.rates		= SNDRV_PCM_RATE_8000 |
+						SNDRV_PCM_RATE_16000 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_96000,
+			.rate_min	= 8000,
+			.rate_max	= 96000,
+			.channels_min	= 1,
+			.channels_max	= 2,
+		},
+		.ops    = &max98357a_dai_ops,
+	},
+	{
+		.name = "max98357a-hifi",
+		.playback = {
+			.stream_name	= "HiFi Playback1",
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+						SNDRV_PCM_FMTBIT_S24 |
+						SNDRV_PCM_FMTBIT_S32,
+			.rates		= SNDRV_PCM_RATE_8000 |
+						SNDRV_PCM_RATE_16000 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_96000,
+			.rate_min	= 8000,
+			.rate_max	= 96000,
+			.channels_min	= 1,
+			.channels_max	= 2,
+		},
+		.ops    = NULL,
 	},
-	.ops    = &max98357a_dai_ops,
 };
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
-			&max98357a_dai_driver, 1);
+			max98357a_dai_driver, ARRAY_SIZE(max98357a_dai_driver));
 }
 
 static int max98357a_platform_remove(struct platform_device *pdev)
-- 
1.7.9.5
