From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add ACPI match ID" to the asoc
	tree
Date: Wed, 17 May 2017 10:51:18 +0100
Message-ID: <E1dAvby-0006eE-Ul@debutante>
References: <1494846127-9008-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6DE72664EB
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 11:51:29 +0200 (CEST)
In-Reply-To: <1494846127-9008-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, Hsin-Yu Chao <hychao@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add ACPI match ID

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

>From 6d3edf866ffa7a9348cfc30d9f58270e4f8d068e Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 15 May 2017 19:02:07 +0800
Subject: [PATCH] ASoC: rt5514: Add ACPI match ID

This patch adds the ACPI match ID for rt5514 codec.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index ff97360c03db..5c30c4d64ebe 100644
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
2.11.0
