From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: nau8825: add pm function
Date: Mon,  9 Nov 2015 12:56:00 -0800
Message-ID: <1447102560-14243-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 80BB92604F8
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 21:57:36 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, james.ausmus@intel.com, yang.a.fang@intel.com, srinivas.sripathi@intel.com, sathyanarayana.nujella@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Yong Zhi <yong.zhi@intel.com>

This patch adds pm function and fixes following issues
1.i2c timeout after resume, after resume we saw interrupt handler
is called prior to i2c controller is resumed.This causes i2c timeout
2.no audio after resume

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/codecs/nau8825.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7fc7b4e..c1b87c5 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1271,6 +1271,36 @@ static int nau8825_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int nau8825_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct nau8825 *nau8825 = dev_get_drvdata(dev);
+
+	disable_irq(client->irq);
+	regcache_cache_only(nau8825->regmap, true);
+	regcache_mark_dirty(nau8825->regmap);
+
+	return 0;
+}
+
+static int nau8825_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct nau8825 *nau8825 = dev_get_drvdata(dev);
+
+	regcache_cache_only(nau8825->regmap, false);
+	regcache_sync(nau8825->regmap);
+	enable_irq(client->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops nau8825_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(nau8825_suspend, nau8825_resume)
+};
+
 static const struct i2c_device_id nau8825_i2c_ids[] = {
 	{ "nau8825", 0 },
 	{ }
@@ -1297,6 +1327,7 @@ static struct i2c_driver nau8825_driver = {
 		.name = "nau8825",
 		.of_match_table = of_match_ptr(nau8825_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
+		.pm = &nau8825_pm,
 	},
 	.probe = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
-- 
1.7.9.5
