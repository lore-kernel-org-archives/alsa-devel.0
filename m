From: <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC:rt286: set combo jack by dmi
Date: Thu, 6 Nov 2014 09:59:59 +0800
Message-ID: <1415239200-13788-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D9932261A74
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 03:00:45 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch enables combo jack configuration according to dmi.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* rename intel_platform to force_combo_jack_table
---
---
 sound/soc/codecs/rt286.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 97daa80..d4acb64 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1205,6 +1206,16 @@ static const struct acpi_device_id rt286_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
 
+static struct dmi_system_id force_combo_jack_table[] __initdata = {
+	{
+		.ident = "Intel Wilson Beach",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "Wilson Beach SDS")
+		}
+	},
+	{ }
+};
+
 static int rt286_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
@@ -1240,6 +1251,9 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
+	if (dmi_check_system(force_combo_jack_table))
+		rt286->pdata.cbj_en = true;
+
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
 
 	for (i = 0; i < RT286_POWER_REG_LEN; i++)
-- 
1.8.1.1.439.g50a6b54
