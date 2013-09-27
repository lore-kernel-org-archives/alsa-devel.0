From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] ASoC: cs4271: Include linux/of.h header
Date: Fri, 27 Sep 2013 16:45:49 +0530
Message-ID: <1380280554-32591-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C7480265074
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:16:01 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id y10so2443370pdj.8
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 04:16:00 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/cs4271.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index a20f1bb..f6e9534 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <sound/pcm.h>
-- 
1.7.9.5
