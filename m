From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: ADAU7002: Adding ACPI id
Date: Fri, 16 Feb 2018 13:11:12 +0530
Message-ID: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0059.outbound.protection.outlook.com [104.47.40.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F52826778B
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:54:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

Adding ACPI entry id for probing the driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/codecs/adau7002.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index 49475e3..fdff868 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -7,6 +7,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -69,10 +70,19 @@ static int adau7002_remove(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, adau7002_dt_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adau7002_acpi_match[] = {
+	{ "ADAU7002", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, adau7002_acpi_match);
+#endif
+
 static struct platform_driver adau7002_driver = {
 	.driver = {
 		.name = "adau7002",
 		.of_match_table	= of_match_ptr(adau7002_dt_ids),
+		.acpi_match_table = ACPI_PTR(adau7002_acpi_match),
 	},
 	.probe = adau7002_probe,
 	.remove = adau7002_remove,
-- 
1.9.1
