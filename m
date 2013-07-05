From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: codecs: da9055: Update driver name to
 fix breakage due to pmic driver with same name
Date: Fri, 5 Jul 2013 17:17:42 +0530
Message-ID: <1373024862.3233.63.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id D567E265852
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 13:20:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: "kiran.padwal" <kiran.padwal@kpitcummins.com>, linux-kernel <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch updates i2c driver name and device id of da9055 codec driver.
DA9055 is a PMIC + CODEC and currently, the corresponding PMIC driver
also registers itself with the same name as codec, i.e. "da9055".
Because of this the codec driver was broken. Now codec driver uses
"da9055-codec" as driver name instead of "da9055".

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
---
 sound/soc/codecs/da9055.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 2e1bf5d..e146f68 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1544,7 +1544,7 @@ static int da9055_remove(struct i2c_client
*client)
 }
 
 static const struct i2c_device_id da9055_i2c_id[] = {
-	{ "da9055", 0 },
+	{ "da9055-codec", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
@@ -1552,7 +1552,7 @@ MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
 	.driver = {
-		.name = "da9055",
+		.name = "da9055-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe		= da9055_i2c_probe,
-- 
1.7.1
