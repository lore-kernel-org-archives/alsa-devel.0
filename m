From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/30] ASoC: broadwell: Register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:21 +0100
Message-ID: <1425461626-21103-7-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C897264F3D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:55 +0100 (CET)
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
 sound/soc/intel/broadwell.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index fba2ef5..fc55420 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -80,15 +80,9 @@ static int broadwell_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	int ret = 0;
-	ret = snd_soc_jack_new(codec, "Headset",
-		SND_JACK_HEADSET | SND_JACK_BTN_0, &broadwell_headset);
-
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&broadwell_headset,
-		ARRAY_SIZE(broadwell_headset_pins),
-		broadwell_headset_pins);
+	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+		SND_JACK_HEADSET | SND_JACK_BTN_0, &broadwell_headset,
+		broadwell_headset_pins, ARRAY_SIZE(broadwell_headset_pins));
 	if (ret)
 		return ret;
 
-- 
1.8.0
