From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: wm0010: fix error return code in wm0010_boot()
Date: Tue, 7 May 2013 19:38:52 +0800
Message-ID: <CAPgLHd-5rAbUnijs_dfeXuk9LhsSKihOBYeicLWDvZECfP0LmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the memory malloc of 'out' and 'img_swap' error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/wm0010.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 8df2b6e..370af0c 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -667,6 +667,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		/* On wm0010 only the CLKCTRL1 value is used */
 		pll_rec.clkctrl1 = wm0010->pll_clkctrl1;
 
+		ret = -ENOMEM;
 		len = pll_rec.length + 8;
 		out = kzalloc(len, GFP_KERNEL);
 		if (!out) {
