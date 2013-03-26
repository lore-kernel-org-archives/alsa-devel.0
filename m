From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: arizona: remove duplicated include from arizona.c
Date: Tue, 26 Mar 2013 14:47:08 +0800
Message-ID: <CAPgLHd9a+DV9cLbbNDp=TaVxDCjdK1oE1LXf0g4WOQ6bVgqGEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/arizona.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 26e1579..c979ff2 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -14,7 +14,6 @@
 #include <linux/gcd.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
-#include <linux/delay.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
