From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] ASoC: Samsung: Remove dma.h inclusion
Date: Fri, 24 Jan 2014 16:23:23 +0530
Message-ID: <1390560804-31135-2-git-send-email-sachin.kamat@linaro.org>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D89D5261ADB
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 11:58:00 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id jt11so3127547pbb.11
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 02:58:00 -0800 (PST)
In-Reply-To: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

mach/dma.h is not referenced by this file. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/i2s.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index a9da24f34834..0a9b44c940ce 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -22,8 +22,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
-
 #include <linux/platform_data/asoc-s3c.h>
 
 #include "dma.h"
-- 
1.7.9.5
