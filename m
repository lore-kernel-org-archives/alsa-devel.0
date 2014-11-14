From: mengdong.lin@intel.com
Subject: [PATCH] ASoC: rt5670 : Add ACPI match ID for Intel
	CHT/BSW platforms
Date: Fri, 14 Nov 2014 15:51:34 +0800
Message-ID: <7008ba4e47e5b26da2114bfbc65b634e4c409212.1415951477.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9385126650F
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 08:45:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, bardliao@realtek.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds the ACPI match ID for rt5670/5672 codec.
So on Intel CherryTrail/Braswell platforms, the codec can be enumerated from
ACPI and depends on ACPI to get platform-specific info and power saving.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Reviewed-by: Bard Liao <bardliao@realtek.com>

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index c4c42d5..fd32501 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -2503,6 +2504,14 @@ static const struct i2c_device_id rt5670_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id rt5670_acpi_match[] = {
+	{ "10EC5670", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5670_acpi_match);
+#endif
+
 static int rt5670_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2691,6 +2700,7 @@ static struct i2c_driver rt5670_i2c_driver = {
 	.driver = {
 		.name = "rt5670",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5670_acpi_match),
 	},
 	.probe = rt5670_i2c_probe,
 	.remove   = rt5670_i2c_remove,
-- 
1.9.1
