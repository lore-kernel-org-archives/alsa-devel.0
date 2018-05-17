From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: pcm512x: Add ACPI support
Date: Thu, 17 May 2018 17:53:26 -0500
Message-ID: <20180517225326.30881-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 64472266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 00:53:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

HID is assumed to be made of TI PCI ID (0x104C) + part number, so all
four 104C5121, 104C5122, 104C5141 104C5142 are valid.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/pcm512x-i2c.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 5f9c069569d5..0fe5ced841a3 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 
 #include "pcm512x.h"
 
@@ -52,6 +53,7 @@ static const struct i2c_device_id pcm512x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5121", },
 	{ .compatible = "ti,pcm5122", },
@@ -60,6 +62,18 @@ static const struct of_device_id pcm512x_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm512x_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pcm512x_acpi_match[] = {
+	{ "104C5121", 0 },
+	{ "104C5122", 0 },
+	{ "104C5141", 0 },
+	{ "104C5142", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, pcm512x_acpi_match);
+#endif
 
 static struct i2c_driver pcm512x_i2c_driver = {
 	.probe 		= pcm512x_i2c_probe,
@@ -67,7 +81,8 @@ static struct i2c_driver pcm512x_i2c_driver = {
 	.id_table	= pcm512x_i2c_id,
 	.driver		= {
 		.name	= "pcm512x",
-		.of_match_table = pcm512x_of_match,
+		.of_match_table = of_match_ptr(pcm512x_of_match),
+		.acpi_match_table = ACPI_PTR(pcm512x_acpi_match),
 		.pm     = &pcm512x_pm_ops,
 	},
 };
-- 
2.14.1
