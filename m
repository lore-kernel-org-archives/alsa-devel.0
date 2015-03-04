From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 25/30] ASoC: tegra_alc5632: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:40 +0100
Message-ID: <1425461626-21103-26-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0022E264F3D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:08 +0100 (CET)
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
 sound/soc/tegra/tegra_alc5632.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 769aca2..6dcd06a 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -106,11 +106,10 @@ static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
 
-	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
-			 &tegra_alc5632_hs_jack);
-	snd_soc_jack_add_pins(&tegra_alc5632_hs_jack,
-			ARRAY_SIZE(tegra_alc5632_hs_jack_pins),
-			tegra_alc5632_hs_jack_pins);
+	snd_soc_card_jack_new(rtd->card, "Headset Jack", SND_JACK_HEADSET,
+			      &tegra_alc5632_hs_jack,
+			      tegra_alc5632_hs_jack_pins,
+			      ARRAY_SIZE(tegra_alc5632_hs_jack_pins));
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		tegra_alc5632_hp_jack_gpio.gpio = machine->gpio_hp_det;
-- 
1.8.0
