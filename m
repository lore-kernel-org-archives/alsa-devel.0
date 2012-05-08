From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: alc5623: Convert to
	module_i2c_driver()
Date: Tue, 08 May 2012 23:42:23 +0800
Message-ID: <1336491743.14361.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0360F10447E
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:42:32 +0200 (CEST)
Received: by dajt11 with SMTP id t11so3327674daj.38
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 08:42:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 3061d35..1960478 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1083,25 +1083,7 @@ static struct i2c_driver alc5623_i2c_driver = {
 	.id_table = alc5623_i2c_table,
 };
 
-static int __init alc5623_modinit(void)
-{
-	int ret;
-
-	ret = i2c_add_driver(&alc5623_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "%s: can't add i2c driver", __func__);
-		return ret;
-	}
-
-	return ret;
-}
-module_init(alc5623_modinit);
-
-static void __exit alc5623_modexit(void)
-{
-	i2c_del_driver(&alc5623_i2c_driver);
-}
-module_exit(alc5623_modexit);
+module_i2c_driver(alc5623_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC alc5621/2/3 driver");
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
-- 
1.7.5.4
