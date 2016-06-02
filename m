From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: remove idle_bias_off = true
Date: Thu, 2 Jun 2016 14:51:52 +0800
Message-ID: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 81256265747
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 08:52:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, ramesh.babu@intel.com, bardliao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: bardliao <bardliao@realtek.com>

Codec will not go into suspend if there is any widget forced on with
idle_bias_off true. We want codec go into suspend when the system is
suspend. Also, we don't do anything in bias level OFF case. So it is
actually no different in bias level STANDBY or OFF case.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index f80cfe4..d403c20 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1094,7 +1094,6 @@ static struct snd_soc_codec_driver soc_codec_dev_rt298 = {
 	.suspend = rt298_suspend,
 	.resume = rt298_resume,
 	.set_bias_level = rt298_set_bias_level,
-	.idle_bias_off = true,
 	.controls = rt298_snd_controls,
 	.num_controls = ARRAY_SIZE(rt298_snd_controls),
 	.dapm_widgets = rt298_dapm_widgets,
-- 
1.8.1.1.439.g50a6b54
