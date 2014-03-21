From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: mfld_machine: Fix compile error
Date: Fri, 21 Mar 2014 20:23:51 +0100
Message-ID: <1395429831-22561-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-054.synserver.de (smtp-out-054.synserver.de
 [212.40.185.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A39265044
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 20:23:23 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Fixes: 115f3f8 ("ASoC: mfld_machine: Convert to table based DAPM and control setup")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/mfld_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/mfld_machine.c b/sound/soc/intel/mfld_machine.c
index 4616942..031d787 100644
--- a/sound/soc/intel/mfld_machine.c
+++ b/sound/soc/intel/mfld_machine.c
@@ -254,7 +254,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
 
 	/* Headset and button jack detection */
-	ret_val = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+	ret_val = snd_soc_jack_new(mfld_codec, "Intel(R) MID Audio Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 |
 			SND_JACK_BTN_1, &mfld_jack);
 	if (ret_val) {
-- 
1.8.0
