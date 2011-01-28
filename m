From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/7] ASoC: Tegra: Harmony: Support the internal
	speaker
Date: Fri, 28 Jan 2011 14:26:37 -0700
Message-ID: <1296250001-6348-3-git-send-email-swarren@nvidia.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6081024420
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:26:58 +0100 (CET)
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
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

Add DAPM widget definitions for the internal speaker paths. Currently, this
path is always enabled while playback is active.

Add code to control the speaker amplifier GPIO.

The GPIO is requested during _init, since that's the first time it is
guaranteed that the WM8903 module is loaded, probed, and hence has exported
its GPIO chip.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   51 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 2d6a15c..0f5a481 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -33,6 +33,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
+
+#include <mach/harmony_audio.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -48,6 +51,8 @@
 #define PREFIX DRV_NAME ": "
 
 struct tegra_harmony {
+	struct harmony_audio_platform_data *pdata;
+	int gpio_spkr_en_requested;
 };
 
 static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
@@ -113,7 +118,22 @@ static struct snd_soc_ops harmony_asoc_ops = {
 	.hw_params = harmony_asoc_hw_params,
 };
 
+static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+	struct harmony_audio_platform_data *pdata = harmony->pdata;
+
+	gpio_set_value_cansleep(pdata->gpio_spkr_en,
+				!!SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Int Spk", harmony_event_int_spk),
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 };
@@ -121,6 +141,10 @@ static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
 static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"Headphone Jack", NULL, "HPOUTR"},
 	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Int Spk", NULL, "ROP"},
+	{"Int Spk", NULL, "RON"},
+	{"Int Spk", NULL, "LOP"},
+	{"Int Spk", NULL, "LON"},
 	{"Mic Bias", NULL, "Mic Jack"},
 	{"IN1L", NULL, "Mic Bias"},
 };
@@ -129,6 +153,19 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+	struct harmony_audio_platform_data *pdata = harmony->pdata;
+	int ret;
+
+	ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
+	if (ret) {
+		dev_err(card->dev, "cannot get spkr_en gpio\n");
+		return ret;
+	}
+	harmony->gpio_spkr_en_requested = 1;
+
+	gpio_direction_output(pdata->gpio_spkr_en, 0);
 
 	snd_soc_dapm_new_controls(dapm, harmony_dapm_widgets,
 					ARRAY_SIZE(harmony_dapm_widgets));
@@ -137,6 +174,7 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 				ARRAY_SIZE(harmony_audio_map));
 
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Int Spk");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_sync(dapm);
 
@@ -164,6 +202,7 @@ static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_harmony;
 	struct tegra_harmony *harmony;
+	struct harmony_audio_platform_data *pdata;
 	int ret;
 
 	if (!machine_is_harmony()) {
@@ -171,12 +210,20 @@ static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data supplied\n");
+		return -EINVAL;
+	}
+
 	harmony = kzalloc(sizeof(struct tegra_harmony), GFP_KERNEL);
 	if (!harmony) {
 		dev_err(&pdev->dev, "Can't allocate tegra_harmony\n");
 		return -ENOMEM;
 	}
 
+	harmony->pdata = pdata;
+
 	ret = tegra_asoc_utils_init();
 	if (ret)
 		goto err_free_harmony;
@@ -208,6 +255,7 @@ static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+	struct harmony_audio_platform_data *pdata = harmony->pdata;
 
 	snd_soc_unregister_card(card);
 
@@ -217,6 +265,9 @@ static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini();
 
+	if (harmony->gpio_spkr_en_requested)
+		gpio_free(pdata->gpio_spkr_en);
+
 	kfree(harmony);
 
 	return 0;
-- 
1.7.1
