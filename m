From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] ASoC: rt5677: Convert to use
	module_i2c_driver
Date: Tue, 03 Jun 2014 10:56:41 +0800
Message-ID: <1401764201.15216.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 87F27265582
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 04:56:48 +0200 (CEST)
Received: by mail-vc0-f170.google.com with SMTP id la4so6077588vcb.15
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 19:56:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 833231e..60fff7f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3480,18 +3480,7 @@ static struct i2c_driver rt5677_i2c_driver = {
 	.remove   = rt5677_i2c_remove,
 	.id_table = rt5677_i2c_id,
 };
-
-static int __init rt5677_modinit(void)
-{
-	return i2c_add_driver(&rt5677_i2c_driver);
-}
-module_init(rt5677_modinit);
-
-static void __exit rt5677_modexit(void)
-{
-	i2c_del_driver(&rt5677_i2c_driver);
-}
-module_exit(rt5677_modexit);
+module_i2c_driver(rt5677_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC RT5677 driver");
 MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
-- 
1.8.3.2
