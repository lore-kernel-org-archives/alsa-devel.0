From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] ASoC: tlv320aic23: Include of.h
Date: Fri,  4 Apr 2014 11:29:12 +0530
Message-ID: <1396591153-10924-5-git-send-email-sachin.kamat@linaro.org>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 65B5F26573C
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:52 +0200 (CEST)
Received: by mail-pa0-f41.google.com with SMTP id fa1so2964335pad.14
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:51 -0700 (PDT)
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
 sound/soc/codecs/tlv320aic23-i2c.c |    1 +
 sound/soc/codecs/tlv320aic31xx.c   |    1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic23-i2c.c b/sound/soc/codecs/tlv320aic23-i2c.c
index b73c94e..f137019 100644
--- a/sound/soc/codecs/tlv320aic23-i2c.c
+++ b/sound/soc/codecs/tlv320aic23-i2c.c
@@ -13,6 +13,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fa158cf..b93d500 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
-- 
1.7.9.5
