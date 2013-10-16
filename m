From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: smdk_wm8994: Add .pm to struct
	smdk_audio_driver
Date: Wed, 16 Oct 2013 15:58:48 +0530
Message-ID: <1381919328-10828-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DF89126516B
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 12:29:37 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id kp14so861390pab.34
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 03:29:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Register PM ops for this driver.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/smdk_wm8994.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 831972d..b072bd1 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -9,6 +9,7 @@
 
 #include "../codecs/wm8994.h"
 #include <sound/pcm_params.h>
+#include <sound/soc.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -206,6 +207,7 @@ static struct platform_driver smdk_audio_driver = {
 		.name	= "smdk-audio-wm8894",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
+		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= smdk_audio_probe,
 };
-- 
1.7.9.5
