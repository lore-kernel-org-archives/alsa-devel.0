From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] ASoC: sgtl5000: Add MODULE_ALIAS
Date: Sat, 20 Jul 2013 16:16:02 -0300
Message-ID: <1374347763-18261-2-git-send-email-festevam@gmail.com>
References: <1374347763-18261-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f179.google.com (mail-ye0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EF142608D6
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 21:16:12 +0200 (CEST)
Received: by mail-ye0-f179.google.com with SMTP id r3so1684167yen.10
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 12:16:11 -0700 (PDT)
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
 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c8b9090..58b1b30 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1608,6 +1608,7 @@ static struct i2c_driver sgtl5000_i2c_driver = {
 
 module_i2c_driver(sgtl5000_i2c_driver);
 
+MODULE_ALIAS("platform:sgtl5000");
 MODULE_DESCRIPTION("Freescale SGTL5000 ALSA SoC Codec Driver");
 MODULE_AUTHOR("Zeng Zhaoming <zengzm.kernel@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
1.8.1.2
