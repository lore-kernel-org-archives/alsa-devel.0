From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/6] ASoC: pcm1681: Include linux/of.h header
Date: Fri, 11 Oct 2013 17:23:57 +0530
Message-ID: <1381492441-31195-2-git-send-email-sachin.kamat@linaro.org>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 26420265695
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 13:54:41 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id fa1so4243653pad.5
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 04:54:41 -0700 (PDT)
In-Reply-To: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
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
 sound/soc/codecs/pcm1681.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 651ce09..54ea15b 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <sound/pcm.h>
-- 
1.7.9.5
