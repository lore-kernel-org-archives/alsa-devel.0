From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] ASoC: tlv320aic3x: Include linux/of.h
	header
Date: Fri, 27 Sep 2013 16:45:53 +0530
Message-ID: <1380280554-32591-5-git-send-email-sachin.kamat@linaro.org>
References: <1380280554-32591-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1381526569A
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:16:11 +0200 (CEST)
Received: by mail-pb0-f47.google.com with SMTP id rr4so2409446pbb.20
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 04:16:11 -0700 (PDT)
In-Reply-To: <1380280554-32591-1-git-send-email-sachin.kamat@linaro.org>
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
 sound/soc/codecs/tlv320aic3x.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 892c108..f8b9fa6 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
-- 
1.7.9.5
