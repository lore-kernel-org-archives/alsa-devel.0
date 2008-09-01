From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 1/3] ASoC: Fix an error path in neo1973_wm8753
Date: Mon, 1 Sep 2008 17:44:05 +0200
Message-ID: <20080901174405.73e5ea98@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id ACFC024476
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 17:44:13 +0200 (CEST)
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
Cc: Ville@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <graeme@openmoko.org>, Tim Niemeyer <reddog@mastersword.de>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

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
---
I couldn't even test-build that one. Tim, Graeme, can any of you
please review and test this patch? Thanks.

 sound/soc/s3c24xx/neo1973_wm8753.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc5.orig/sound/soc/s3c24xx/neo1973_wm8753.c	2008-09-01 15:13:17.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/s3c24xx/neo1973_wm8753.c	2008-09-01 15:22:42.000000000 +0200
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
Jean Delvare
