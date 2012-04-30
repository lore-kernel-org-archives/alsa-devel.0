From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs42l52: Remove duplicate module exit
	code
Date: Mon, 30 Apr 2012 11:14:10 +0100
Message-ID: <1335780850-2902-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 179F724423
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 12:14:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, joe@nucleusys.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In the conversion to module_init_i2c() the original open coded module
exit function was left.  Remove it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42l52.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index e7fefbd..703060d 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1287,13 +1287,6 @@ static struct i2c_driver cs42l52_i2c_driver = {
 	.remove =   __devexit_p(cs42l52_i2c_remove),
 };
 
-static void __exit cs42l52_exit(void)
-{
-	i2c_del_driver(&cs42l52_i2c_driver);
-}
-
-module_exit(cs42l52_exit);
-
 module_i2c_driver(cs42l52_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC CS42L52 driver");
-- 
1.7.10
