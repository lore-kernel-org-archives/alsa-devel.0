From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: wm5100: Export wm5100_detect
Date: Thu, 23 Jan 2014 16:23:26 +0530
Message-ID: <1390474406-5790-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 59839264EFA
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 11:57:56 +0100 (CET)
Received: by mail-pa0-f48.google.com with SMTP id kx10so1708386pab.21
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 02:57:55 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Export the symbol so that it is accessible to modules. Fixes the
following error:

ERROR: "wm5100_detect" [sound/soc/samsung/snd-soc-lowland.ko] undefined!

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm5100.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4cf91deabc02..4e3e31aaf509 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
 #include <linux/gpio.h>
@@ -2141,6 +2142,7 @@ int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(wm5100_detect);
 
 static irqreturn_t wm5100_irq(int irq, void *data)
 {
-- 
1.7.9.5
