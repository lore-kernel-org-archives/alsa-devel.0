From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/30] ASoC: wm1133-ev: Register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:20 +0100
Message-ID: <1425461626-21103-6-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A7CF2264F36
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:54 +0100 (CET)
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
 sound/soc/fsl/wm1133-ev1.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index a958937..0653aa8 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -205,16 +205,14 @@ static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Headphone jack detection */
-	snd_soc_jack_new(codec, "Headphone", SND_JACK_HEADPHONE, &hp_jack);
-	snd_soc_jack_add_pins(&hp_jack, ARRAY_SIZE(hp_jack_pins),
-			      hp_jack_pins);
+	snd_soc_card_jack_new(rtd->card, "Headphone", SND_JACK_HEADPHONE,
+			      &hp_jack, hp_jack_pins, ARRAY_SIZE(hp_jack_pins));
 	wm8350_hp_jack_detect(codec, WM8350_JDR, &hp_jack, SND_JACK_HEADPHONE);
 
 	/* Microphone jack detection */
-	snd_soc_jack_new(codec, "Microphone",
-			 SND_JACK_MICROPHONE | SND_JACK_BTN_0, &mic_jack);
-	snd_soc_jack_add_pins(&mic_jack, ARRAY_SIZE(mic_jack_pins),
-			      mic_jack_pins);
+	snd_soc_card_jack_new(rtd->card, "Microphone",
+			      SND_JACK_MICROPHONE | SND_JACK_BTN_0, &mic_jack,
+			      mic_jack_pins, ARRAY_SIZE(mic_jack_pins));
 	wm8350_mic_jack_detect(codec, &mic_jack, SND_JACK_MICROPHONE,
 			       SND_JACK_BTN_0);
 
-- 
1.8.0
