From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Wed, 28 Jan 2015 16:59:57 +0800
Message-ID: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0879026167A
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 10:00:17 +0100 (CET)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We do the power down process at bias level STANDBY. And do nothing
at bias level OFF. As a result, the register setting is the same
between bias level STANDBY and OFF. So we don't need to set
idle_bias_off true.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 847cc4b..81bdd276 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1144,7 +1144,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt286 = {
 	.suspend = rt286_suspend,
 	.resume = rt286_resume,
 	.set_bias_level = rt286_set_bias_level,
-	.idle_bias_off = true,
+	.idle_bias_off = false,
 	.controls = rt286_snd_controls,
 	.num_controls = ARRAY_SIZE(rt286_snd_controls),
 	.dapm_widgets = rt286_dapm_widgets,
-- 
1.8.1.1.439.g50a6b54
