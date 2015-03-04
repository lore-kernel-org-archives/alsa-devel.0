From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/30] ASoC: mfld_machine: Register jacks at
	the card level
Date: Wed,  4 Mar 2015 10:33:24 +0100
Message-ID: <1425461626-21103-10-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AEC1E264F52
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:57 +0100 (CET)
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
 sound/soc/intel/mfld_machine.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/mfld_machine.c b/sound/soc/intel/mfld_machine.c
index d22b44d..49c09a0 100644
--- a/sound/soc/intel/mfld_machine.c
+++ b/sound/soc/intel/mfld_machine.c
@@ -255,20 +255,15 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
 
 	/* Headset and button jack detection */
-	ret_val = snd_soc_jack_new(runtime->codec, "Intel(R) MID Audio Jack",
-			SND_JACK_HEADSET | SND_JACK_BTN_0 |
-			SND_JACK_BTN_1, &mfld_jack);
+	ret_val = snd_soc_card_jack_new(runtime->card,
+			"Intel(R) MID Audio Jack", SND_JACK_HEADSET |
+			SND_JACK_BTN_0 | SND_JACK_BTN_1, &mfld_jack,
+			mfld_jack_pins, ARRAY_SIZE(mfld_jack_pins));
 	if (ret_val) {
 		pr_err("jack creation failed\n");
 		return ret_val;
 	}
 
-	ret_val = snd_soc_jack_add_pins(&mfld_jack,
-			ARRAY_SIZE(mfld_jack_pins), mfld_jack_pins);
-	if (ret_val) {
-		pr_err("adding jack pins failed\n");
-		return ret_val;
-	}
 	ret_val = snd_soc_jack_add_zones(&mfld_jack,
 			ARRAY_SIZE(mfld_zones), mfld_zones);
 	if (ret_val) {
-- 
1.8.0
