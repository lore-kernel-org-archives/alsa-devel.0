From: yang.a.fang@intel.com
Subject: [PATCH 1/2] ASoC: rt5645: Add ACPI match ID
Date: Thu, 23 Apr 2015 16:35:17 -0700
Message-ID: <1429832118-20741-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8654326041D
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 01:35:58 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch adds the ACPI match ID for rt5645/5650 codec

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5645.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index c9a4c5b..e16724a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2618,6 +2619,15 @@ static const struct i2c_device_id rt5645_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id rt5645_acpi_match[] = {
+	{ "10EC5645", 0 },
+	{ "10EC5650", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
+#endif
+
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2834,6 +2844,7 @@ static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe = rt5645_i2c_probe,
 	.remove   = rt5645_i2c_remove,
-- 
1.7.9.5
