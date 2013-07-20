From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] ASoC: wm8962: Add MODULE_ALIAS
Date: Sat, 20 Jul 2013 16:16:03 -0300
Message-ID: <1374347763-18261-3-git-send-email-festevam@gmail.com>
References: <1374347763-18261-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f172.google.com (mail-ye0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 203F32608D8
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 21:16:14 +0200 (CEST)
Received: by mail-ye0-f172.google.com with SMTP id l3so1671977yen.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 12:16:13 -0700 (PDT)
In-Reply-To: <1374347763-18261-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add MODULE_ALIAS, so that auto module loading can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8962.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8b8905d..a50033c 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3837,6 +3837,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 
 module_i2c_driver(wm8962_i2c_driver);
 
+MODULE_ALIAS("platform:wm8962");
 MODULE_DESCRIPTION("ASoC WM8962 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
1.8.1.2
