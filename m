From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add ACPI match ID
Date: Mon, 15 May 2017 19:02:07 +0800
Message-ID: <1494846127-9008-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AA5A266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 13:02:17 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, Hsin-Yu Chao <hychao@chromium.org>, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds the ACPI match ID for rt5514 codec.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 6856b8c..1b6796c 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -1095,6 +1096,14 @@ static const struct of_device_id rt5514_of_match[] = {
 MODULE_DEVICE_TABLE(of, rt5514_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id rt5514_acpi_match[] = {
+	{ "10EC5514", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, rt5514_acpi_match);
+#endif
+
 static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
 {
 	device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
@@ -1198,6 +1207,7 @@ static const struct dev_pm_ops rt5514_i2_pm_ops = {
 static struct i2c_driver rt5514_i2c_driver = {
 	.driver = {
 		.name = "rt5514",
+		.acpi_match_table = ACPI_PTR(rt5514_acpi_match),
 		.of_match_table = of_match_ptr(rt5514_of_match),
 		.pm = &rt5514_i2_pm_ops,
 	},
-- 
2.7.4
