From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 29/30] ASoC: tegra_wm8903: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:44 +0100
Message-ID: <1425461626-21103-30-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DC0B62650FF
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:11 +0100 (CET)
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
 sound/soc/tegra/tegra_wm8903.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index e52420d..4a95b70 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -177,21 +177,19 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		tegra_wm8903_hp_jack_gpio.gpio = machine->gpio_hp_det;
-		snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
-				&tegra_wm8903_hp_jack);
-		snd_soc_jack_add_pins(&tegra_wm8903_hp_jack,
-					ARRAY_SIZE(tegra_wm8903_hp_jack_pins),
-					tegra_wm8903_hp_jack_pins);
+		snd_soc_card_jack_new(rtd->card, "Headphone Jack",
+				      SND_JACK_HEADPHONE, &tegra_wm8903_hp_jack,
+				      tegra_wm8903_hp_jack_pins,
+				      ARRAY_SIZE(tegra_wm8903_hp_jack_pins));
 		snd_soc_jack_add_gpios(&tegra_wm8903_hp_jack,
 					1,
 					&tegra_wm8903_hp_jack_gpio);
 	}
 
-	snd_soc_jack_new(codec, "Mic Jack", SND_JACK_MICROPHONE,
-			 &tegra_wm8903_mic_jack);
-	snd_soc_jack_add_pins(&tegra_wm8903_mic_jack,
-			      ARRAY_SIZE(tegra_wm8903_mic_jack_pins),
-			      tegra_wm8903_mic_jack_pins);
+	snd_soc_card_jack_new(rtd->card, "Mic Jack", SND_JACK_MICROPHONE,
+			      &tegra_wm8903_mic_jack,
+			      tegra_wm8903_mic_jack_pins,
+			      ARRAY_SIZE(tegra_wm8903_mic_jack_pins));
 	wm8903_mic_detect(codec, &tegra_wm8903_mic_jack, SND_JACK_MICROPHONE,
 				0);
 
-- 
1.8.0
