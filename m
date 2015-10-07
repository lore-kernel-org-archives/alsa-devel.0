From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: nau8825: add acpi match ID
Date: Wed,  7 Oct 2015 14:33:57 -0700
Message-ID: <1444253637-65908-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A0DA261490
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 23:35:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, james.ausmus@intel.com, anatol@chromium.org, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, dgreid@chromium.org, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch adds the acpi match ID for nau8825 codec

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/nau8825.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c44a7a1..5c1badf 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -16,6 +16,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/acpi.h>
 
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -1090,10 +1091,19 @@ static const struct of_device_id nau8825_of_ids[] = {
 MODULE_DEVICE_TABLE(of, nau8825_of_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id nau8825_acpi_match[] = {
+	{ "10508825", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, nau8825_acpi_match);
+#endif
+
 static struct i2c_driver nau8825_driver = {
 	.driver = {
 		.name = "nau8825",
 		.of_match_table = of_match_ptr(nau8825_of_ids),
+		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
 	},
 	.probe = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
-- 
1.7.9.5
