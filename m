From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/30] ASoC: simple-card: Register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:18 +0100
Message-ID: <1425461626-21103-4-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F62C264F30
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:53 +0100 (CET)
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
 sound/soc/generic/simple-card.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fb550b5..c49a408 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -176,11 +176,11 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 
 	if (gpio_is_valid(priv->gpio_hp_det)) {
-		snd_soc_jack_new(codec->codec, "Headphones", SND_JACK_HEADPHONE,
-				 &simple_card_hp_jack);
-		snd_soc_jack_add_pins(&simple_card_hp_jack,
-				      ARRAY_SIZE(simple_card_hp_jack_pins),
-				      simple_card_hp_jack_pins);
+		snd_soc_card_jack_new(rtd->card, "Headphones",
+				      SND_JACK_HEADPHONE,
+				      &simple_card_hp_jack,
+				      simple_card_hp_jack_pins,
+				      ARRAY_SIZE(simple_card_hp_jack_pins));
 
 		simple_card_hp_jack_gpio.gpio = priv->gpio_hp_det;
 		simple_card_hp_jack_gpio.invert = priv->gpio_hp_det_invert;
@@ -189,11 +189,11 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (gpio_is_valid(priv->gpio_mic_det)) {
-		snd_soc_jack_new(codec->codec, "Mic Jack", SND_JACK_MICROPHONE,
-				 &simple_card_mic_jack);
-		snd_soc_jack_add_pins(&simple_card_mic_jack,
-				      ARRAY_SIZE(simple_card_mic_jack_pins),
-				      simple_card_mic_jack_pins);
+		snd_soc_card_jack_new(rtd->card, "Mic Jack",
+				      SND_JACK_MICROPHONE,
+				      &simple_card_mic_jack,
+				      simple_card_mic_jack_pins,
+				      ARRAY_SIZE(simple_card_mic_jack_pins));
 		simple_card_mic_jack_gpio.gpio = priv->gpio_mic_det;
 		simple_card_mic_jack_gpio.invert = priv->gpio_mic_det_invert;
 		snd_soc_jack_add_gpios(&simple_card_mic_jack, 1,
-- 
1.8.0
