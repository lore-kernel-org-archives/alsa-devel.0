From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: alc5632: Convert to
	module_i2c_driver()
Date: Tue, 08 May 2012 23:43:33 +0800
Message-ID: <1336491813.14361.2.camel@phoenix>
References: <1336491743.14361.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7019D243DF
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:43:41 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so10947497pbb.38
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 08:43:40 -0700 (PDT)
In-Reply-To: <1336491743.14361.1.camel@phoenix>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrey Danin <danindrey@mail.ru>, Liam@alsa-project.org, Leon Romanovsky <leon@leon.nu>, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5632.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 93a5909..b29a53b 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1208,25 +1208,7 @@ static struct i2c_driver alc5632_i2c_driver = {
 	.id_table = alc5632_i2c_table,
 };
 
-static int __init alc5632_modinit(void)
-{
-	int ret;
-
-	ret = i2c_add_driver(&alc5632_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "%s: can't add i2c driver", __func__);
-		return ret;
-	}
-
-	return ret;
-}
-module_init(alc5632_modinit);
-
-static void __exit alc5632_modexit(void)
-{
-	i2c_del_driver(&alc5632_i2c_driver);
-}
-module_exit(alc5632_modexit);
+module_i2c_driver(alc5632_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC ALC5632 driver");
 MODULE_AUTHOR("Leon Romanovsky <leon@leon.nu>");
-- 
1.7.5.4
