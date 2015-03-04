From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/30] ASoC: ttc-dkb: Register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:31 +0100
Message-ID: <1425461626-21103-17-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B4C57264F30
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:02 +0100 (CET)
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
 sound/soc/pxa/ttc-dkb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 5001dbb..1753c7d 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -78,15 +78,12 @@ static int ttc_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Headset jack detection */
-	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE
-			| SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
-			&hs_jack);
-	snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
-			      hs_jack_pins);
-	snd_soc_jack_new(codec, "Microphone Jack", SND_JACK_MICROPHONE,
-			 &mic_jack);
-	snd_soc_jack_add_pins(&mic_jack, ARRAY_SIZE(mic_jack_pins),
-			      mic_jack_pins);
+	snd_soc_card_jack_new(rtd->card, "Headphone Jack", SND_JACK_HEADPHONE |
+			      SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
+			      &hs_jack, hs_jack_pins, ARRAY_SIZE(hs_jack_pins));
+	snd_soc_card_jack_new(rtd->card, "Microphone Jack", SND_JACK_MICROPHONE,
+			      &mic_jack, mic_jack_pins,
+			      ARRAY_SIZE(mic_jack_pins));
 
 	/* headphone, microphone detection & headset short detection */
 	pm860x_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADPHONE,
-- 
1.8.0
