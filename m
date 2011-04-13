From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: Add Speyside headset jack detection
	support
Date: Tue, 12 Apr 2011 23:06:08 -0700
Message-ID: <1302674771-17169-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81EE7103870
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:41 +0200 (CEST)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Speyside makes use of support the WM8915 has for detecting the polarity
of the microphone and ground connections on headsets, using a GPIO to
control the polarity of the ground connection and switching between the
two microphone bias supplies available on the device in order to do so.
As a result of this the detection support is more involved than for most
other CODECs, using a callback to configure the current polarity of the
jack and translate this into the board-specific connections required for
the current scenario.

On Android some additional work is required to hook this up to the
application layer as the Android HeadsetObserver monitors a custom
drivers/switch API rather than the standard Linux APIs.  This can be
done by either updating HeadsetObserver or modifying the ALSA core to
report via drivers/switch as well.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   78 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 0adaf7f..612a39e 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -11,10 +11,14 @@
 
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <linux/gpio.h>
 
 #include "../codecs/wm8915.h"
 #include "../codecs/wm9081.h"
 
+#define WM8915_HPSEL_GPIO 214
+
 static int speyside_set_bias_level(struct snd_soc_card *card,
 				   enum snd_soc_bias_level level)
 {
@@ -79,11 +83,74 @@ static struct snd_soc_ops speyside_ops = {
 	.hw_params = speyside_hw_params,
 };
 
+static struct snd_soc_jack speyside_headset;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin speyside_headset_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+/* Default the headphone selection to active high */
+static int speyside_jack_polarity;
+
+static int speyside_get_micbias(struct snd_soc_dapm_widget *source,
+				struct snd_soc_dapm_widget *sink)
+{
+	if (speyside_jack_polarity && (strcmp(source->name, "MICB1") == 0))
+		return 1;
+	if (!speyside_jack_polarity && (strcmp(source->name, "MICB2") == 0))
+		return 1;
+
+	return 0;
+}
+
+static void speyside_set_polarity(struct snd_soc_codec *codec,
+				  int polarity)
+{
+	speyside_jack_polarity = !polarity;
+	gpio_direction_output(WM8915_HPSEL_GPIO, speyside_jack_polarity);
+
+	/* Re-run DAPM to make sure we're using the correct mic bias */
+	snd_soc_dapm_sync(&codec->dapm);
+}
+
 static int speyside_wm8915_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(dai, WM8915_SYSCLK_MCLK1, 32768, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = gpio_request(WM8915_HPSEL_GPIO, "HP_SEL");
+	if (ret != 0)
+		pr_err("Failed to request HP_SEL GPIO: %d\n", ret);
+	gpio_direction_output(WM8915_HPSEL_GPIO, speyside_jack_polarity);
 
-	return snd_soc_dai_set_sysclk(dai, WM8915_SYSCLK_MCLK1, 32768, 0);
+	ret = snd_soc_jack_new(codec, "Headset",
+			       SND_JACK_HEADSET | SND_JACK_BTN_0,
+			       &speyside_headset);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&speyside_headset,
+				    ARRAY_SIZE(speyside_headset_pins),
+				    speyside_headset_pins);
+	if (ret)
+		return ret;
+
+	wm8915_detect(codec, &speyside_headset, speyside_set_polarity);
+
+	return 0;
 }
 
 static struct snd_soc_dai_link speyside_dai[] = {
@@ -125,6 +192,7 @@ static struct snd_soc_codec_conf speyside_codec_conf[] = {
 
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
 	SND_SOC_DAPM_SPK("Main Speaker", NULL),
 
@@ -133,7 +201,15 @@ static struct snd_soc_dapm_widget widgets[] = {
 };
 
 static struct snd_soc_dapm_route audio_paths[] = {
+	{ "IN1RN", NULL, "MICB1" },
+	{ "IN1RP", NULL, "MICB1" },
+	{ "IN1RN", NULL, "MICB2" },
+	{ "IN1RP", NULL, "MICB2" },
+	{ "MICB1", NULL, "Headset Mic", speyside_get_micbias },
+	{ "MICB2", NULL, "Headset Mic", speyside_get_micbias },
+
 	{ "IN1LP", NULL, "MICB2" },
+	{ "IN1RN", NULL, "MICB1" },
 	{ "MICB2", NULL, "Main AMIC" },
 
 	{ "DMIC1DAT", NULL, "MICB1" },
-- 
1.7.4.1
