From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move WM2000 to dev_pm_ops
Date: Fri, 25 Feb 2011 12:25:52 +0000
Message-ID: <1298636752-11198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F207103830
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:25:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's a general move to use dev_pm_ops rather than bus specific functions
in order to facilitate work on the PM core. Do this conversion to WM2000.
The driver ought to be updated to work better in a multi-component model
but the mechanical conversion ensures that we avoid blocking PM core work
until that happens.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 80ddf4f..a3b9cbb 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -836,24 +836,25 @@ static void wm2000_i2c_shutdown(struct i2c_client *i2c)
 }
 
 #ifdef CONFIG_PM
-static int wm2000_i2c_suspend(struct i2c_client *i2c, pm_message_t mesg)
+static int wm2000_i2c_suspend(struct device *dev)
 {
+	struct i2c_client *i2c = to_i2c_client(dev);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
 	return wm2000_anc_transition(wm2000, ANC_OFF);
 }
 
-static int wm2000_i2c_resume(struct i2c_client *i2c)
+static int wm2000_i2c_resume(struct device *dev)
 {
+	struct i2c_client *i2c = to_i2c_client(dev);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
 	return wm2000_anc_set_mode(wm2000);
 }
-#else
-#define wm2000_i2c_suspend NULL
-#define wm2000_i2c_resume NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(wm2000_pm, wm2000_i2c_suspend, wm2000_i2c_resume);
+
 static const struct i2c_device_id wm2000_i2c_id[] = {
 	{ "wm2000", 0 },
 	{ }
@@ -864,11 +865,10 @@ static struct i2c_driver wm2000_i2c_driver = {
 	.driver = {
 		.name = "wm2000",
 		.owner = THIS_MODULE,
+		.pm = &wm2000_pm,
 	},
 	.probe = wm2000_i2c_probe,
 	.remove = __devexit_p(wm2000_i2c_remove),
-	.suspend = wm2000_i2c_suspend,
-	.resume = wm2000_i2c_resume,
 	.shutdown = wm2000_i2c_shutdown,
 	.id_table = wm2000_i2c_id,
 };
-- 
1.7.2.3
