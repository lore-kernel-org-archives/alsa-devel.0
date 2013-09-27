From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: wm8993: drop regulator_bulk_free of devm_ allocated data
Date: Fri, 27 Sep 2013 16:15:54 +0800
Message-ID: <CAPgLHd8rbL2mmN+hFb-Jqvy+tu7wyTj702Z0fKNG_KOCW1kd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sachin.kamat@linaro.org, wfp5p@virginia.edu
Cc: yongjun_wei@trendmicro.com.cn, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It's not necessary to free regulator consumers allocated with
devm_regulator_bulk_get.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/wm8993.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 433d59a..2ee23a3 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1562,7 +1562,6 @@ static int wm8993_remove(struct snd_soc_codec *codec)
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 
 	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 	return 0;
 }
 
