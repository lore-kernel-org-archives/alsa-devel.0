From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/30] ASoC: speyside: Register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:38 +0100
Message-ID: <1425461626-21103-24-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ECDB26509D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:07 +0100 (CET)
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
 sound/soc/samsung/speyside.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 5ec7c52..2dcb988 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -153,16 +153,10 @@ static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 		pr_err("Failed to request HP_SEL GPIO: %d\n", ret);
 	gpio_direction_output(WM8996_HPSEL_GPIO, speyside_jack_polarity);
 
-	ret = snd_soc_jack_new(codec, "Headset",
-			       SND_JACK_LINEOUT | SND_JACK_HEADSET |
-			       SND_JACK_BTN_0,
-			       &speyside_headset);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&speyside_headset,
-				    ARRAY_SIZE(speyside_headset_pins),
-				    speyside_headset_pins);
+	ret = snd_soc_card_jack_new(rtd->card, "Headset", SND_JACK_LINEOUT |
+				    SND_JACK_HEADSET | SND_JACK_BTN_0,
+				    &speyside_headset, speyside_headset_pins,
+				    ARRAY_SIZE(speyside_headset_pins));
 	if (ret)
 		return ret;
 
-- 
1.8.0
