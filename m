From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: pxa: Remove duplicate inclusion of
	dmaengine.h
Date: Thu, 22 Aug 2013 13:30:15 +0530
Message-ID: <1377158415-469-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 31167265340
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:17:47 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc17so1469935pbc.32
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 01:17:47 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, leoy@marvell.com
List-Id: alsa-devel@alsa-project.org

dmaengine.h header file was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/pxa/mmp-pcm.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 9a97843..8235e23 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -17,7 +17,6 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/platform_data/mmp_audio.h>
-#include <linux/dmaengine.h>
 
 #include <sound/pxa2xx-lib.h>
 #include <sound/core.h>
-- 
1.7.9.5
