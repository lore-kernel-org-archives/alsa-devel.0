From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 6/6] ASoC: Tegra: Harmony: Support both int and
	ext mics
Date: Thu,  3 Feb 2011 13:56:18 -0700
Message-ID: <1296766578-13988-6-git-send-email-swarren@nvidia.com>
References: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A647F103863
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:30 +0100 (CET)
In-Reply-To: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Note that the external mic is only connected to the codec's left channel,
and the internal mic is only connected to the codec's right channel.

Hence, when recording a stereo stream, which is the only supported channel
configuration, the recorded audio will only appear within one channel, and
which channel that is will differ depending on which mic is used.

At present, I'm not sure how best to resolve this. Downstream drivers
directly tweaked the wm8903's registers so that both ADCs processed the
same input channel.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   88 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 8ed88e3..b4526c4 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -52,10 +52,19 @@
 
 #define DRV_NAME "tegra-snd-harmony"
 
+#define GPIO_SPKR_EN    BIT(0)
+#define GPIO_INT_MIC_EN BIT(1)
+#define GPIO_EXT_MIC_EN BIT(2)
+
+#define MIC_SELECTION_OFF     0
+#define MIC_SELECTION_EXT_MIC 1
+#define MIC_SELECTION_INT_MIC 2
+
 struct tegra_harmony {
 	struct tegra_asoc_utils_data util_data;
 	struct harmony_audio_platform_data *pdata;
-	int gpio_spkr_en_requested;
+	int gpio_requested;
+	int mic_selection;
 };
 
 static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
@@ -181,10 +190,61 @@ static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"Int Spk", NULL, "LOP"},
 	{"Int Spk", NULL, "LON"},
 	{"IN1L", NULL, "Mic Jack"},
+	{"IN1R", NULL, "Mic Jack"},
+};
+
+static void harmony_mic_control(struct snd_soc_codec *codec)
+{
+	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+	struct harmony_audio_platform_data *pdata = harmony->pdata;
+	int int_mic_en = harmony->mic_selection == MIC_SELECTION_INT_MIC;
+	int ext_mic_en = harmony->mic_selection == MIC_SELECTION_EXT_MIC;
+
+	gpio_set_value_cansleep(pdata->gpio_int_mic_en, int_mic_en);
+	/* ext_mic_en is active low  */
+	gpio_set_value_cansleep(pdata->gpio_ext_mic_en, !ext_mic_en);
+}
+
+static int harmony_get_mic_selection(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+
+	ucontrol->value.integer.value[0] = harmony->mic_selection;
+
+	return 0;
+}
+
+static int harmony_set_mic_selection(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+
+	if (harmony->mic_selection == ucontrol->value.integer.value[0])
+		return 0;
+
+	harmony->mic_selection = ucontrol->value.integer.value[0];
+	harmony_mic_control(codec);
+
+	return 1;
+}
+
+static const char * const mic_selection_names[] = {"Off", "External",
+						   "Internal"};
+static const struct soc_enum harmony_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mic_selection_names),
+			    mic_selection_names),
 };
 
 static const struct snd_kcontrol_new harmony_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Int Spk"),
+	SOC_ENUM_EXT("Mic Selection", harmony_enum[0],
+		     harmony_get_mic_selection, harmony_set_mic_selection),
 };
 
 static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
@@ -201,10 +261,28 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 		dev_err(card->dev, "cannot get spkr_en gpio\n");
 		return ret;
 	}
-	harmony->gpio_spkr_en_requested = 1;
+	harmony->gpio_requested |= GPIO_SPKR_EN;
 
 	gpio_direction_output(pdata->gpio_spkr_en, 0);
 
+	ret = gpio_request(pdata->gpio_int_mic_en, "int_mic_en");
+	if (ret) {
+		dev_err(card->dev, "cannot get int_mic_en gpio\n");
+		return ret;
+	}
+	harmony->gpio_requested |= GPIO_INT_MIC_EN;
+
+	gpio_direction_output(pdata->gpio_int_mic_en, 1);
+
+	ret = gpio_request(pdata->gpio_ext_mic_en, "ext_mic_en");
+	if (ret) {
+		dev_err(card->dev, "cannot get ext_mic_en gpio\n");
+		return ret;
+	}
+	harmony->gpio_requested |= GPIO_EXT_MIC_EN;
+
+	gpio_direction_output(pdata->gpio_ext_mic_en, 0);
+
 	/* Not connected */
 	snd_soc_dapm_nc_pin(dapm, "IN3L");
 	snd_soc_dapm_nc_pin(dapm, "IN3R");
@@ -326,7 +404,11 @@ static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&harmony->util_data);
 
-	if (harmony->gpio_spkr_en_requested)
+	if (harmony->gpio_requested & GPIO_EXT_MIC_EN)
+		gpio_free(pdata->gpio_ext_mic_en);
+	if (harmony->gpio_requested & GPIO_INT_MIC_EN)
+		gpio_free(pdata->gpio_int_mic_en);
+	if (harmony->gpio_requested & GPIO_SPKR_EN)
 		gpio_free(pdata->gpio_spkr_en);
 
 	kfree(harmony);
-- 
1.7.1
