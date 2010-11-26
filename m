From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] ASoC: Fix resource leask in neo1973_gta02_init() error
	path
Date: Fri, 26 Nov 2010 14:52:47 +0800
Message-ID: <1290754367.25125.4.camel@mola>
References: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290754245.25125.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Graeme Gregory <graeme@openmoko.org>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Properly free allocated resources in neo1973_gta02_init() error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/neo1973_gta02_wm8753.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
index 8c65b63..3eec610 100644
--- a/sound/soc/samsung/neo1973_gta02_wm8753.c
+++ b/sound/soc/samsung/neo1973_gta02_wm8753.c
@@ -439,24 +439,20 @@ static int __init neo1973_gta02_init(void)
 
 	/* register bluetooth DAI here */
 	ret = snd_soc_register_dai(&neo1973_gta02_snd_device->dev, &bt_dai);
-	if (ret) {
-		platform_device_put(neo1973_gta02_snd_device);
-		return ret;
-	}
+	if (ret)
+		goto err_put_device;
 
 	platform_set_drvdata(neo1973_gta02_snd_device, &neo1973_gta02);
 	ret = platform_device_add(neo1973_gta02_snd_device);
 
-	if (ret) {
-		platform_device_put(neo1973_gta02_snd_device);
-		return ret;
-	}
+	if (ret)
+		goto err_unregister_dai;
 
 	/* Initialise GPIOs used by amp */
 	ret = gpio_request(GTA02_GPIO_HP_IN, "GTA02_HP_IN");
 	if (ret) {
 		pr_err("gta02_wm8753: Failed to register GPIO %d\n", GTA02_GPIO_HP_IN);
-		goto err_unregister_device;
+		goto err_del_device;
 	}
 
 	ret = gpio_direction_output(GTA02_GPIO_HP_IN, 1);
@@ -483,8 +479,12 @@ err_free_gpio_amp_shut:
 	gpio_free(GTA02_GPIO_AMP_SHUT);
 err_free_gpio_hp_in:
 	gpio_free(GTA02_GPIO_HP_IN);
-err_unregister_device:
-	platform_device_unregister(neo1973_gta02_snd_device);
+err_del_device:
+	platform_device_del(neo1973_gta02_snd_device);
+err_unregister_dai:
+	snd_soc_unregister_dai(&neo1973_gta02_snd_device->dev);
+err_put_device:
+	platform_device_put(neo1973_gta02_snd_device);
 	return ret;
 }
 module_init(neo1973_gta02_init);
-- 
1.7.2
