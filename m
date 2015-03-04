From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/30] ASoC: cht_bsw_rt5645: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:23 +0100
Message-ID: <1425461626-21103-9-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 006FF264F50
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:56 +0100 (CET)
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
 sound/soc/intel/cht_bsw_rt5645.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/cht_bsw_rt5645.c
index dd93525..01222799 100644
--- a/sound/soc/intel/cht_bsw_rt5645.c
+++ b/sound/soc/intel/cht_bsw_rt5645.c
@@ -169,17 +169,17 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	ret = snd_soc_jack_new(codec, "Headphone Jack",
-				SND_JACK_HEADPHONE,
-				&ctx->hp_jack);
+	ret = snd_soc_card_jack_new(runtime->card, "Headphone Jack",
+				    SND_JACK_HEADPHONE, &ctx->hp_jack,
+				    NULL, 0);
 	if (ret) {
 		dev_err(runtime->dev, "HP jack creation failed %d\n", ret);
 		return ret;
 	}
 
-	ret = snd_soc_jack_new(codec, "Mic Jack",
-				SND_JACK_MICROPHONE,
-				&ctx->mic_jack);
+	ret = snd_soc_card_jack_new(runtime->card, "Mic Jack",
+				    SND_JACK_MICROPHONE, &ctx->mic_jack,
+				    NULL, 0);
 	if (ret) {
 		dev_err(runtime->dev, "Mic jack creation failed %d\n", ret);
 		return ret;
-- 
1.8.0
