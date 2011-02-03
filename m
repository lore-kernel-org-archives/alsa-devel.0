From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/6] ASoC: Tegra: Harmony: Add headphone jack
	detection
Date: Thu,  3 Feb 2011 13:56:13 -0700
Message-ID: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7263F103862
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:28 +0100 (CET)
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

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 1b80c4f..26ab4fd 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -38,6 +38,7 @@
 #include <mach/harmony_audio.h>
 
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -123,6 +124,24 @@ static struct snd_soc_ops harmony_asoc_ops = {
 	.hw_params = harmony_asoc_hw_params,
 };
 
+static struct snd_soc_jack harmony_hp_jack;
+
+static struct snd_soc_jack_pin harmony_hp_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+static struct snd_soc_jack_gpio harmony_hp_jack_gpios[] = {
+	{
+		.name = "headphone detect",
+		.report = SND_JACK_HEADPHONE,
+		.debounce_time = 150,
+		.invert = 1,
+	}
+};
+
 static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *k, int event)
 {
@@ -178,11 +197,20 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_add_routes(dapm, harmony_audio_map,
 				ARRAY_SIZE(harmony_audio_map));
 
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Int Spk");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_sync(dapm);
 
+	harmony_hp_jack_gpios[0].gpio = pdata->gpio_hp_det;
+	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
+			 &harmony_hp_jack);
+	snd_soc_jack_add_pins(&harmony_hp_jack,
+			      ARRAY_SIZE(harmony_hp_jack_pins),
+			      harmony_hp_jack_pins);
+	snd_soc_jack_add_gpios(&harmony_hp_jack,
+			       ARRAY_SIZE(harmony_hp_jack_gpios),
+			       harmony_hp_jack_gpios);
+
 	return 0;
 }
 
-- 
1.7.1
