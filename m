From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: add pm function" to the asoc
	tree
Date: Mon, 16 Nov 2015 17:51:46 +0000
Message-ID: <E1ZyNwQ-0006nC-UZ@debutante>
References: <1447102560-14243-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DAA2604A4
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:54 +0100 (CET)
In-Reply-To: <1447102560-14243-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fang Yang A <yang.a.fang@intel.com>, Yong Zhi <yong.zhi@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: add pm function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4454a8378be5809c2b830531bb4c4712b5e46bef Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Mon, 9 Nov 2015 12:56:00 -0800
Subject: [PATCH] ASoC: nau8825: add pm function

This patch adds pm function and fixes following issues
1.i2c timeout after resume, after resume we saw interrupt handler
is called prior to i2c controller is resumed.This causes i2c timeout
2.no audio after resume

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7fc7b4e3f444..c1b87c5800b1 100644
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
2.6.2
