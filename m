From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] ASoC: cs4271: Include linux/of.h header
Date: Fri, 11 Oct 2013 17:23:56 +0530
Message-ID: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F49C26567B
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 13:54:39 +0200 (CEST)
Received: by mail-pb0-f53.google.com with SMTP id up15so4070518pbc.26
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 04:54:39 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org
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
