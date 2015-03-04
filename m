From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/30] ASoC: omap-twl4030: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:27 +0100
Message-ID: <1425461626-21103-13-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8450264FE7
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:59 +0100 (CET)
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
 sound/soc/omap/omap-twl4030.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index fb1f6bb..3673ada 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -170,14 +170,10 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	if (priv->jack_detect > 0) {
 		hs_jack_gpios[0].gpio = priv->jack_detect;
 
-		ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
-				       &priv->hs_jack);
-		if (ret)
-			return ret;
-
-		ret = snd_soc_jack_add_pins(&priv->hs_jack,
-					    ARRAY_SIZE(hs_jack_pins),
-					    hs_jack_pins);
+		ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+					    SND_JACK_HEADSET, &priv->hs_jack,
+					    hs_jack_pins,
+					    ARRAY_SIZE(hs_jack_pins));
 		if (ret)
 			return ret;
 
-- 
1.8.0
