From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 26/30] ASoC: tegra_max98090: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:41 +0100
Message-ID: <1425461626-21103-27-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C45F8264EFF
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:09 +0100 (CET)
In-Reply-To: <1425461626-21103-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The jacks are card level elements so use snd_soc_card_jack_new() instead of
snd_soc_jack_new() to register them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/tegra/tegra_max98090.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index 1f20c2c..902da36 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -145,16 +145,14 @@ static const struct snd_kcontrol_new tegra_max98090_controls[] = {
 
 static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
 	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_jack_new(codec, "Headphones", SND_JACK_HEADPHONE,
-				&tegra_max98090_hp_jack);
-		snd_soc_jack_add_pins(&tegra_max98090_hp_jack,
-				ARRAY_SIZE(tegra_max98090_hp_jack_pins),
-				tegra_max98090_hp_jack_pins);
+		snd_soc_card_jack_new(rtd->card, "Headphones",
+				      SND_JACK_HEADPHONE,
+				      &tegra_max98090_hp_jack,
+				      tegra_max98090_hp_jack_pins,
+				      ARRAY_SIZE(tegra_max98090_hp_jack_pins));
 
 		tegra_max98090_hp_jack_gpio.gpio = machine->gpio_hp_det;
 		snd_soc_jack_add_gpios(&tegra_max98090_hp_jack,
@@ -163,11 +161,11 @@ static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (gpio_is_valid(machine->gpio_mic_det)) {
-		snd_soc_jack_new(codec, "Mic Jack", SND_JACK_MICROPHONE,
-				 &tegra_max98090_mic_jack);
-		snd_soc_jack_add_pins(&tegra_max98090_mic_jack,
-				      ARRAY_SIZE(tegra_max98090_mic_jack_pins),
-				      tegra_max98090_mic_jack_pins);
+		snd_soc_card_jack_new(rtd->card, "Mic Jack",
+				      SND_JACK_MICROPHONE,
+				      &tegra_max98090_mic_jack,
+				      tegra_max98090_mic_jack_pins,
+				      ARRAY_SIZE(tegra_max98090_mic_jack_pins));
 
 		tegra_max98090_mic_jack_gpio.gpio = machine->gpio_mic_det;
 		snd_soc_jack_add_gpios(&tegra_max98090_mic_jack,
-- 
1.8.0
