From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: ssm4567: Added ACPI entry for SSM4567
	codec
Date: Thu, 23 Jul 2015 19:11:54 +0000
Message-ID: <1437678714-5911-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 70F6A26128B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 21:12:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Harsha Priya <harshapriya.n@intel.com>, benzh@chromium.org, anatol@google.com, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, M Naveen <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

Added INT343B ACPI ID for the SSM4567 codec

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: M Naveen <naveen.m@intel.com>
Signed-off-by: M R Sathya Prakash <sathya.prakash.m.r@intel.com>
---
 sound/soc/codecs/ssm4567.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 938d2cb..af536ae 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -10,6 +10,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
@@ -450,10 +451,21 @@ static const struct i2c_device_id ssm4567_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
 
+#ifdef CONFIG_ACPI
+
+static const struct acpi_device_id ssm4567_acpi_match[] = {
+	{ "INT343B", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
+
+#endif
+
 static struct i2c_driver ssm4567_driver = {
 	.driver = {
 		.name = "ssm4567",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe = ssm4567_i2c_probe,
 	.remove = ssm4567_i2c_remove,
-- 
1.9.1
