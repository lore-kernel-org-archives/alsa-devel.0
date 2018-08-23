From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: wm8804: Add ACPI support
Date: Wed, 22 Aug 2018 22:49:36 -0500
Message-ID: <20180823034936.21696-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B123267663
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 05:49:47 +0200 (CEST)
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
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, tiwai@suse.de, patches@opensource.cirrus.com, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

HID made of either Wolfson/CirrusLogic PCI ID + 8804 identifier.

This helps enumerate the HifiBerry Digi+ HAT boards on the Up2 platform.

The scripts at https://github.com/thesofproject/acpi-scripts can be
used to add the ACPI initrd overlays.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/wm8804-i2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8804-i2c.c b/sound/soc/codecs/wm8804-i2c.c
index f27464c2c5ba..79541960f45d 100644
--- a/sound/soc/codecs/wm8804-i2c.c
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 
 #include "wm8804.h"
 
@@ -40,17 +41,29 @@ static const struct i2c_device_id wm8804_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8804_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id wm8804_of_match[] = {
 	{ .compatible = "wlf,wm8804", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, wm8804_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wm8804_acpi_match[] = {
+	{ "1AEC8804", 0 }, /* Wolfson PCI ID + part ID */
+	{ "10138804", 0 }, /* Cirrus Logic PCI ID + part ID */
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, wm8804_acpi_match);
+#endif
 
 static struct i2c_driver wm8804_i2c_driver = {
 	.driver = {
 		.name = "wm8804",
 		.pm = &wm8804_pm,
-		.of_match_table = wm8804_of_match,
+		.of_match_table = of_match_ptr(wm8804_of_match),
+		.acpi_match_table = ACPI_PTR(wm8804_acpi_match),
 	},
 	.probe = wm8804_i2c_probe,
 	.remove = wm8804_i2c_remove,
-- 
2.17.1
