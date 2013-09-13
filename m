From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: rt5640: Add ACPI probing support.
Date: Fri, 13 Sep 2013 17:57:36 +0100
Message-ID: <1379091456-7223-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379091456-7223-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 697412610A4
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 18:57:47 +0200 (CEST)
In-Reply-To: <1379091456-7223-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Allow the RT5640 to be probed as an ACPI I2C device.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index de40bd9..0bfb960 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2081,6 +2082,12 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 
+static struct acpi_device_id rt5640_acpi_match[] = {
+	{ "INT33CA", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
+
 static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
 {
 	rt5640->pdata.in1_diff = of_property_read_bool(np,
@@ -2200,6 +2207,7 @@ static struct i2c_driver rt5640_i2c_driver = {
 	.driver = {
 		.name = "rt5640",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5640_acpi_match),
 	},
 	.probe = rt5640_i2c_probe,
 	.remove   = rt5640_i2c_remove,
-- 
1.8.1.2
