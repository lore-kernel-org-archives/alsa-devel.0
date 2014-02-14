From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: s3c24xx: Remove invalid file
	reference
Date: Fri, 14 Feb 2014 14:20:14 +0530
Message-ID: <1392367814-2605-2-git-send-email-sachin.kamat@linaro.org>
References: <1392367814-2605-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 8483D2652A6
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 09:55:34 +0100 (CET)
Received: by mail-pd0-f170.google.com with SMTP id p10so11790005pdj.1
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 00:55:33 -0800 (PST)
In-Reply-To: <1392367814-2605-1-git-send-email-sachin.kamat@linaro.org>
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
 include/linux/platform_data/asoc-s3c24xx_simtec.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c24xx_simtec.h b/include/linux/platform_data/asoc-s3c24xx_simtec.h
index 376af5286a3e..d220e54123aa 100644
--- a/include/linux/platform_data/asoc-s3c24xx_simtec.h
+++ b/include/linux/platform_data/asoc-s3c24xx_simtec.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-samsung/include/plat/audio-simtec.h
- *
+/*
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
-- 
1.7.9.5
