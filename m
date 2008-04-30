From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] soc - neo1973_wm8753.c add suspend and
	shutdown hooks for lm4857 chip
Date: Wed, 30 Apr 2008 15:19:05 +0100
Message-ID: <1209565146-32393-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209565146-32393-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66B13245FB
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 16:19:09 +0200 (CEST)
In-Reply-To: <1209565146-32393-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.org>

Patch taken from the openmoko bugtracker
http://bugzilla.openmoko.org/cgi-bin/bugzilla/show_bug.cgi?id=781

This patch adds Suspend/Resume and Shutdown support for the lm4857 to
the driver.

Signed-off-by: Graeme Gregory <graeme@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index c8caddf..0e9d1c5 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -616,6 +616,35 @@ static int lm4857_i2c_attach(struct i2c_adapter *adap)
 	return i2c_probe(adap, &addr_data, lm4857_amp_probe);
 }
 
+static u8 lm4857_state;
+
+static int lm4857_suspend(struct i2c_client *dev, pm_message_t state)
+{
+	dev_dbg(&dev->dev, "lm4857_suspend\n");
+	lm4857_state = lm4857_regs[LM4857_CTRL] & 0xf;
+	if (lm4857_state) {
+		lm4857_regs[LM4857_CTRL] &= 0xf0;
+		lm4857_write_regs();
+	}
+	return 0;
+}
+
+static int lm4857_resume(struct i2c_client *dev)
+{
+	if (lm4857_state) {
+		lm4857_regs[LM4857_CTRL] |= (lm4857_state & 0x0f);
+		lm4857_write_regs();
+	}
+	return 0;
+}
+
+static void lm4857_shutdown(struct i2c_client *dev)
+{
+	dev_dbg(&dev->dev, "lm4857_shutdown\n");
+	lm4857_regs[LM4857_CTRL] &= 0xf0;
+	lm4857_write_regs();
+}
+
 /* corgi i2c codec control layer */
 static struct i2c_driver lm4857_i2c_driver = {
 	.driver = {
@@ -623,6 +652,9 @@ static struct i2c_driver lm4857_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.id =             I2C_DRIVERID_LM4857,
+	.suspend =        lm4857_suspend,
+	.resume	=         lm4857_resume,
+	.shutdown =       lm4857_shutdown,
 	.attach_adapter = lm4857_i2c_attach,
 	.detach_client =  lm4857_i2c_detach,
 	.command =        NULL,
-- 
1.5.5.1
