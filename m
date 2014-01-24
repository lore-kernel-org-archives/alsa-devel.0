From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] ASoC: Samsung: Add NULL check in i2s.c
Date: Fri, 24 Jan 2014 16:23:22 +0530
Message-ID: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D2EEC2616FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 11:57:58 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id jt11so3108916pbb.39
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 02:57:57 -0800 (PST)
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

'res' could be NULL from one of the operations above (line 1243). Thus
check 'res' for NULL before releasing the region to avoid null pointer
dereference.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/i2s.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 92f64363427d..a9da24f34834 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1268,7 +1268,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	release_mem_region(regs_base, resource_size(res));
+	if (res)
+		release_mem_region(regs_base, resource_size(res));
 
 	return ret;
 }
-- 
1.7.9.5
