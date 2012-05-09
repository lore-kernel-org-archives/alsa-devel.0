From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/3] ASoC: cs42l73: Convert to
	module_i2c_driver()
Date: Wed, 9 May 2012 12:14:02 -0500
Message-ID: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe002.messaging.microsoft.com [213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D83A104540
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:17:00 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a94e1e9..60b7f53 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1428,25 +1428,7 @@ static struct i2c_driver cs42l73_i2c_driver = {
 
 };
 
-static int __init cs42l73_modinit(void)
-{
-	int ret;
-	ret = i2c_add_driver(&cs42l73_i2c_driver);
-	if (ret != 0) {
-		pr_err("Failed to register CS42L73 I2C driver: %d\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-module_init(cs42l73_modinit);
-
-static void __exit cs42l73_exit(void)
-{
-	i2c_del_driver(&cs42l73_i2c_driver);
-}
-
-module_exit(cs42l73_exit);
+module_i2c_driver(cs42l73_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC CS42L73 driver");
 MODULE_AUTHOR("Georgi Vlaev, Nucleus Systems Ltd, <joe@nucleusys.com>");
-- 
1.7.10
