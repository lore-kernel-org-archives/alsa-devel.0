From: yang.a.fang@intel.com
Subject: [PATCH 1/8] ASoC: max98357a: Add ACPI ID for Maxim
Date: Fri, 11 Dec 2015 11:29:06 -0800
Message-ID: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4C126550C
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:30:59 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, rohit.m.ainapure@intel.com, james.ausmus@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rohit Ainapure <rohit.m.ainapure@intel.com>

Adding ACPI ID "MX98357A" for the MAXIM 98357A amp.

Signed-off-by: Rohit Ainapure <rohit.m.ainapure@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/max98357a.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index f5e3dce..5b1dfb1 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -12,6 +12,7 @@
  * max98357a.c -- MAX98357A ALSA SoC Codec driver
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -123,10 +124,19 @@ static const struct of_device_id max98357a_device_id[] = {
 MODULE_DEVICE_TABLE(of, max98357a_device_id);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id max98357a_acpi_match[] = {
+	{ "MX98357A", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, max98357a_acpi_match);
+#endif
+
 static struct platform_driver max98357a_platform_driver = {
 	.driver = {
 		.name = "max98357a",
 		.of_match_table = of_match_ptr(max98357a_device_id),
+		.acpi_match_table = ACPI_PTR(max98357a_acpi_match),
 	},
 	.probe	= max98357a_platform_probe,
 	.remove = max98357a_platform_remove,
-- 
1.7.9.5
