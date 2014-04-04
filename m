From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/6] ASoC: max98090: Include of.h
Date: Fri,  4 Apr 2014 11:29:10 +0530
Message-ID: <1396591153-10924-3-git-send-email-sachin.kamat@linaro.org>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id DCC8C265728
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:46 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id md12so2964847pbc.37
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:46 -0700 (PDT)
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
 sound/soc/codecs/max98090.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f7b0b37..4959e76 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-- 
1.7.9.5
