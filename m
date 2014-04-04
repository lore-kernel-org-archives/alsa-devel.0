From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/6] ASoC: tpa6130a2: Include of.h
Date: Fri,  4 Apr 2014 11:29:13 +0530
Message-ID: <1396591153-10924-6-git-send-email-sachin.kamat@linaro.org>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AF9265728
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:54 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id lj1so2931115pab.8
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:53 -0700 (PDT)
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
 sound/soc/codecs/tpa6130a2.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index b27c396..8fc5a64 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -30,6 +30,7 @@
 #include <sound/tpa6130a2-plat.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 
 #include "tpa6130a2.h"
-- 
1.7.9.5
