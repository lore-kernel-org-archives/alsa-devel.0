From: Jiecheng Wu <jasonwood2031@gmail.com>
Subject: [PATCH] sound/core.c: fix wrong return code of
	rsnd_probe() when devm_kzalloc() fails
Date: Sat, 18 Aug 2018 10:33:06 +0800
Message-ID: <20180818023306.6824-1-jasonwood2031@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FF602676C9
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2018 04:33:17 +0200 (CEST)
Received: by mail-pl0-f67.google.com with SMTP id p4-v6so934593pll.8
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 19:33:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
 by smtp.gmail.com with ESMTPSA id c88-v6sm4513787pfe.132.2018.08.17.19.33.14
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 17 Aug 2018 19:33:15 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Function rsnd_probe() defined in sound/soc/sh/rcar/core.c calls devm_kzalloc(). As devm_kzalloc() may return NULL when OOM happens, the caller should return -ENOMEM when devm_kzalloc() fails.
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f8425d8..fd92906 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1502,7 +1502,7 @@ static int rsnd_probe(struct platform_device *pdev)
 	 */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-		return -ENODEV;
+		return -ENOMEM;
 
 	priv->pdev	= pdev;
 	priv->flags	= (unsigned long)of_device_get_match_data(dev);
-- 
2.6.4
