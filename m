From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/14] ASoC: ts3a227e: add acpi table
Date: Tue, 22 Aug 2017 15:32:30 -0500
Message-ID: <20170822203239.19891-6-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9307A267044
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:12 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, "Fang, Yang A" <yang.a.fang@intel.com>, broonie@kernel.org, Fang@alsa-project.org, Thierry Escande <thierry.escande@collabora.com>
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch adds the acpi match table for the ts3a227e audio accessory
detection device. This enables headset features like jack plug/unplug
notifications, mic presence, and button pressed events.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 sound/soc/codecs/ts3a227e.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 4356843..738e04b 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -374,11 +375,20 @@ static const struct of_device_id ts3a227e_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id ts3a227e_acpi_match[] = {
+	{ "104C227E", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ts3a227e_acpi_match);
+#endif
+
 static struct i2c_driver ts3a227e_driver = {
 	.driver = {
 		.name = "ts3a227e",
 		.pm = &ts3a227e_pm,
 		.of_match_table = of_match_ptr(ts3a227e_of_match),
+		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),
 	},
 	.probe = ts3a227e_i2c_probe,
 	.id_table = ts3a227e_i2c_ids,
-- 
2.9.3
