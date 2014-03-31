From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: Change the setting method of
	idle_bias_off
Date: Mon, 31 Mar 2014 10:21:10 +0800
Message-ID: <1396232470-11979-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AC0132650D4
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 04:21:21 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch moves the idle_bias_off setting to struct "soc_codec_dev_rt5640".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index b088f14..6b8778f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1895,7 +1895,6 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	codec->dapm.idle_bias_off = 1;
 	rt5640_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5640_DUMMY1, 0x0301, 0x0301);
@@ -2004,6 +2003,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
 	.suspend = rt5640_suspend,
 	.resume = rt5640_resume,
 	.set_bias_level = rt5640_set_bias_level,
+	.idle_bias_off = true,
 	.controls = rt5640_snd_controls,
 	.num_controls = ARRAY_SIZE(rt5640_snd_controls),
 	.dapm_widgets = rt5640_dapm_widgets,
-- 
1.8.1.1.439.g50a6b54
