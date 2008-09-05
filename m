From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/14] ASoC: Fix an error path in neo1973_wm8753
Date: Fri,  5 Sep 2008 15:35:09 +0100
Message-ID: <1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080905143504.GA27793@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1489103841
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:25 +0200 (CEST)
In-Reply-To: <20080905143504.GA27793@rakim.wolfsonmicro.main>
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
Cc: Jean Delvare <khali@linux-fr.org>, Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Niemeyer <reddog@mastersword.de>
List-Id: alsa-devel@alsa-project.org

From: Jean Delvare <khali@linux-fr.org>

The error handling in neo1973_init is incorrect:

* If platform_device_add fails, we go on with the rest of the
  initialization instead of bailing out. Things will break when the
  module is removed (platform_device_unregister called on a device
  that wasn't registered.)

* If i2c_add_driver fails, we return an error so the module will not
  load, but we don't unregister neo1973_snd_device, so we are leaking
  resources.

Add the missing error handling.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Tim Niemeyer <reddog@mastersword.de>
Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 8089f8e..3aa441f 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -717,12 +717,16 @@ static int __init neo1973_init(void)
 	neo1973_snd_devdata.dev = &neo1973_snd_device->dev;
 	ret = platform_device_add(neo1973_snd_device);
 
-	if (ret)
+	if (ret) {
 		platform_device_put(neo1973_snd_device);
+		return ret;
+	}
 
 	ret = i2c_add_driver(&lm4857_i2c_driver);
-	if (ret != 0)
+	if (ret != 0) {
 		printk(KERN_ERR "can't add i2c driver");
+		platform_device_unregister(neo1973_snd_device);
+	}
 
 	return ret;
 }
-- 
1.5.6.5
