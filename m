From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/6] ASoC: Tegra: Harmony: Implement mic
	detection
Date: Thu,  3 Feb 2011 13:56:16 -0700
Message-ID: <1296766578-13988-4-git-send-email-swarren@nvidia.com>
References: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 91FBA103877
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:28 +0100 (CET)
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

* Add jack definition for mic jack
* Request wm8903 to enable mic detection
* Remove Mic Bias from DAPM route map, so that Mic Bias isn't disable
  when capture is stopped, thus preventing further mic detection from
  operating.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index e87395c..799b1ef 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -43,6 +43,8 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+#include "../codecs/wm8903.h"
+
 #include "tegra_das.h"
 #include "tegra_i2s.h"
 #include "tegra_pcm.h"
@@ -142,6 +144,15 @@ static struct snd_soc_jack_gpio harmony_hp_jack_gpios[] = {
 	}
 };
 
+static struct snd_soc_jack harmony_mic_jack;
+
+static struct snd_soc_jack_pin harmony_mic_jack_pins[] = {
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *k, int event)
 {
@@ -169,8 +180,7 @@ static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"Int Spk", NULL, "RON"},
 	{"Int Spk", NULL, "LOP"},
 	{"Int Spk", NULL, "LON"},
-	{"Mic Bias", NULL, "Mic Jack"},
-	{"IN1L", NULL, "Mic Bias"},
+	{"IN1L", NULL, "Mic Jack"},
 };
 
 static const struct snd_kcontrol_new harmony_controls[] = {
@@ -206,9 +216,6 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_add_routes(dapm, harmony_audio_map,
 				ARRAY_SIZE(harmony_audio_map));
 
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-	snd_soc_dapm_sync(dapm);
-
 	harmony_hp_jack_gpios[0].gpio = pdata->gpio_hp_det;
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 			 &harmony_hp_jack);
@@ -219,6 +226,13 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 			       ARRAY_SIZE(harmony_hp_jack_gpios),
 			       harmony_hp_jack_gpios);
 
+	snd_soc_jack_new(codec, "Mic Jack", SND_JACK_MICROPHONE,
+			 &harmony_mic_jack);
+	snd_soc_jack_add_pins(&harmony_mic_jack,
+			      ARRAY_SIZE(harmony_mic_jack_pins),
+			      harmony_mic_jack_pins);
+	wm8903_mic_detect(codec, &harmony_mic_jack, SND_JACK_MICROPHONE, 0);
+
 	return 0;
 }
 
-- 
1.7.1
