From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: codecs: lm4857: Use dev_pm_ops
Date: Mon,  7 Feb 2011 00:04:19 +0100
Message-ID: <1297033463-14577-3-git-send-email-lars@metafoo.de>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (unknown [212.40.185.16])
	by alsa0.perex.cz (Postfix) with SMTP id 9F19D10380F
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 00:03:14 +0100 (CET)
In-Reply-To: <1297033463-14577-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use dev_pm_ops instead of legacy I2C power management hooks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm4857.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 2d726c0..76cdb3f 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -175,9 +175,9 @@ static void lm4857_shutdown(struct i2c_client *client)
 	lm4857_write_regs();
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
-static int lm4857_suspend(struct i2c_client *client, pm_message_t state)
+static int lm4857_suspend(struct device *dev)
 {
 	lm4857.state = lm4857.regs[LM4857_CTRL] & 0xF;
 
@@ -187,7 +187,7 @@ static int lm4857_suspend(struct i2c_client *client, pm_message_t state)
 	return 0;
 }
 
-static int lm4857_resume(struct i2c_client *dev)
+static int lm4857_resume(struct device *dev)
 {
 	if (lm4857.state) {
 		lm4857.regs[LM4857_CTRL] |= (lm4857.state & 0x0F);
@@ -196,9 +196,11 @@ static int lm4857_resume(struct i2c_client *dev)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(lm4857_pm_ops, lm4857_suspend, lm4857_resume);
+#define LM4857_PM_OPS (&lm4857_pm_ops)
+
 #else
-#define lm4857_suspend NULL
-#define lm4857_resume NULL
+#define LM4857_PM_OPS NULL
 #endif
 
 static const struct i2c_device_id lm4857_i2c_id[] = {
@@ -210,11 +212,10 @@ static struct i2c_driver lm4857_i2c_driver = {
 	.driver = {
 		.name = "LM4857 I2C Amp",
 		.owner = THIS_MODULE,
+		.pm = LM4857_PM_OPS,
 	},
 	.probe =          lm4857_probe,
 	.remove =         __devexit_p(lm4857_remove),
-	.suspend =        lm4857_suspend,
-	.resume	=         lm4857_resume,
 	.shutdown =       lm4857_shutdown,
 	.id_table =       lm4857_i2c_id,
 };
-- 
1.7.2.3
