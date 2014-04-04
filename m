From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] ASoC: rt5640: Include of.h
Date: Fri,  4 Apr 2014 11:29:11 +0530
Message-ID: <1396591153-10924-4-git-send-email-sachin.kamat@linaro.org>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6069926573B
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:49 +0200 (CEST)
Received: by mail-pa0-f41.google.com with SMTP id fa1so2986697pad.28
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:48 -0700 (PDT)
In-Reply-To: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
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

of_match_ptr is defined in of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/rt5640.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 68b4dd6..635363c 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-- 
1.7.9.5
