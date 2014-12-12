From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: set platform data by dmi
Date: Fri, 12 Dec 2014 16:06:07 +0800
Message-ID: <1418371567-1206-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ADF226532C
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 09:06:45 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch set specific data according to dmi data.

Signed-off-by: Jin Yao <yao.jin@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 8bf3a56..6074f04 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/spi/spi.h>
+#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2549,6 +2550,17 @@ static struct acpi_device_id rt5670_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5670_acpi_match);
 #endif
 
+static const struct dmi_system_id dmi_platform_data[] __initconst = {
+	{
+		.ident = "Intel Braswell",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Braswell CRB"),
+		},
+	},
+	{}
+};
+
 static int rt5670_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2568,6 +2580,12 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt5670->pdata = *pdata;
 
+	if (dmi_check_system(dmi_platform_data)) {
+		rt5670->pdata.dmic_en = true;
+		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
+		rt5670->pdata.jd_mode = 1;
+	}
+
 	rt5670->regmap = devm_regmap_init_i2c(i2c, &rt5670_regmap);
 	if (IS_ERR(rt5670->regmap)) {
 		ret = PTR_ERR(rt5670->regmap);
-- 
1.8.1.1.439.g50a6b54
