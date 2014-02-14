From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ASoC: S3C: Remove invalid file reference
Date: Fri, 14 Feb 2014 14:20:13 +0530
Message-ID: <1392367814-2605-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 779DD261685
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 09:55:32 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id lj1so12006827pab.12
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 00:55:30 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, lgirdwood@gmail.com, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

Remove file references rendered invalid due to relocation.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/asoc-s3c.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 9efc04dd255a..709c6f7e2f8c 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-samsung/include/plat/audio.h
- *
+/*
  * Copyright (c) 2009 Samsung Electronics Co. Ltd
  * Author: Jaswinder Singh <jassi.brar@samsung.com>
  *
-- 
1.7.9.5
