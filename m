From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: Samsung: Remove redundant comment
Date: Thu,  4 Jul 2013 16:24:37 +0530
Message-ID: <1372935277-30488-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 58010264FBB
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 13:10:03 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so1105655pbc.23
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 04:10:02 -0700 (PDT)
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
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

There is a typo in the filename (i2c mentioned instead of i2s).
However, this is a redundant piece of information. Delete it
altogether.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/s3c-i2s-v2.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 20e98d1..e5e81b1 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -1,6 +1,4 @@
-/* sound/soc/samsung/s3c-i2c-v2.c
- *
- * ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
+/* ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
  *
  * Copyright (c) 2006 Wolfson Microelectronics PLC.
  *	Graeme Gregory graeme.gregory@wolfsonmicro.com
-- 
1.7.9.5
