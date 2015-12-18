From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 12/19] ASoC: codec: rt5651: add ACPI and OF
	support
Date: Thu, 17 Dec 2015 20:35:49 -0600
Message-ID: <1450406156-22246-13-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA492657C9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:24 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

Add required tables for ACPI and OF matching

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5651.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 1d40318..4df7894 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1741,6 +1742,22 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5651_of_match[] = {
+	{ .compatible = "realtek,rt5651", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5651_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5651_acpi_match[] = {
+	{ "10EC5651", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5651_acpi_match);
+#endif
+
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1806,6 +1823,8 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
+		.acpi_match_table = ACPI_PTR(rt5651_acpi_match),
+		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
 	.probe = rt5651_i2c_probe,
 	.remove   = rt5651_i2c_remove,
-- 
1.9.1
