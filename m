From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 7/7] ASoC: max98090: Add ACPI probing support
Date: Fri, 16 May 2014 16:55:25 +0300
Message-ID: <1400248525-21900-8-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A90AF2619DB
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:56:01 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add ACPI ID for MAX98090 and ACPI 5 I2C device probing support.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 0c8315270e8e..9b76f5a45115 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2329,9 +2330,11 @@ static const struct regmap_config max98090_regmap = {
 };
 
 static int max98090_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *id)
+				 const struct i2c_device_id *i2c_id)
 {
 	struct max98090_priv *max98090;
+	const struct acpi_device_id *acpi_id;
+	kernel_ulong_t driver_data = 0;
 	int ret;
 
 	pr_debug("max98090_i2c_probe\n");
@@ -2341,7 +2344,19 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	if (max98090 == NULL)
 		return -ENOMEM;
 
-	max98090->devtype = id->driver_data;
+	if (ACPI_HANDLE(&i2c->dev)) {
+		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
+					    &i2c->dev);
+		if (!acpi_id) {
+			dev_err(&i2c->dev, "No driver data\n");
+			return -EINVAL;
+		}
+		driver_data = acpi_id->driver_data;
+	} else if (i2c_id) {
+		driver_data = i2c_id->driver_data;
+	}
+
+	max98090->devtype = driver_data;
 	i2c_set_clientdata(i2c, max98090);
 	max98090->pdata = i2c->dev.platform_data;
 	max98090->irq = i2c->irq;
@@ -2432,12 +2447,21 @@ static const struct of_device_id max98090_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max98090_of_match);
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id max98090_acpi_match[] = {
+	{ "193C9890", MAX98090 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, max98090_acpi_match);
+#endif
+
 static struct i2c_driver max98090_i2c_driver = {
 	.driver = {
 		.name = "max98090",
 		.owner = THIS_MODULE,
 		.pm = &max98090_pm,
 		.of_match_table = of_match_ptr(max98090_of_match),
+		.acpi_match_table = ACPI_PTR(max98090_acpi_match),
 	},
 	.probe  = max98090_i2c_probe,
 	.remove = max98090_i2c_remove,
-- 
2.0.0.rc0
