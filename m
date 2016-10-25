From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add the DMIC initial delay to
	wait it ready." to the asoc tree
Date: Tue, 25 Oct 2016 20:24:03 +0100
Message-ID: <E1bz7KN-0004qs-HW@debutante>
References: <1477394846-14205-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0903C2606F8
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:24:11 +0200 (CEST)
In-Reply-To: <1477394846-14205-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shumingf@realtek.com, broonie@kernel.org, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add the DMIC initial delay to wait it ready.

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

>From a5461fd6c8f70b3d897f5f76612e890ad47a5b93 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 25 Oct 2016 19:27:26 +0800
Subject: [PATCH] ASoC: rt5514: Add the DMIC initial delay to wait it ready.

Due to the DMIC that needs time to initial after the MCLK is provided, the
field of delay time is implemented by the platform data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5514.txt |  3 +++
 include/sound/rt5514.h                             | 20 ++++++++++++++++++++
 sound/soc/codecs/rt5514.c                          | 17 +++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  2 ++
 4 files changed, 42 insertions(+)
 create mode 100644 include/sound/rt5514.h

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 9cabfc18cb57..929ca6756b02 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -13,6 +13,9 @@ Optional properties:
 - clocks: The phandle of the master clock to the CODEC
 - clock-names: Should be "mclk"
 
+- realtek,dmic-init-delay-ms
+  Set the DMIC initial delay (ms) to wait it ready.
+
 Pins on the device (for linking into audio routes) for RT5514:
 
   * DMIC1L
diff --git a/include/sound/rt5514.h b/include/sound/rt5514.h
new file mode 100644
index 000000000000..ef18494769ee
--- /dev/null
+++ b/include/sound/rt5514.h
@@ -0,0 +1,20 @@
+/*
+ * linux/sound/rt5514.h -- Platform data for RT5514
+ *
+ * Copyright 2016 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT5514_H
+#define __LINUX_SND_RT5514_H
+
+struct rt5514_platform_data {
+	unsigned int dmic_init_delay;
+};
+
+#endif
+
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f24b7cfd3a89..b281a46d769d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -452,6 +452,9 @@ static int rt5514_set_dmic_clk(struct snd_soc_dapm_widget *w,
 			RT5514_CLK_DMIC_OUT_SEL_MASK,
 			idx << RT5514_CLK_DMIC_OUT_SEL_SFT);
 
+	if (rt5514->pdata.dmic_init_delay)
+		msleep(rt5514->pdata.dmic_init_delay);
+
 	return idx;
 }
 
@@ -1073,9 +1076,18 @@ static const struct of_device_id rt5514_of_match[] = {
 MODULE_DEVICE_TABLE(of, rt5514_of_match);
 #endif
 
+static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
+{
+	device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
+		&rt5514->pdata.dmic_init_delay);
+
+	return 0;
+}
+
 static int rt5514_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
+	struct rt5514_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5514_priv *rt5514;
 	int ret;
 	unsigned int val;
@@ -1087,6 +1099,11 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5514);
 
+	if (pdata)
+		rt5514->pdata = *pdata;
+	else if (i2c->dev.of_node)
+		rt5514_parse_dt(rt5514, &i2c->dev);
+
 	rt5514->i2c_regmap = devm_regmap_init_i2c(i2c, &rt5514_i2c_regmap);
 	if (IS_ERR(rt5514->i2c_regmap)) {
 		ret = PTR_ERR(rt5514->i2c_regmap);
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 229de0e2c88c..5d343fb6d125 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -13,6 +13,7 @@
 #define __RT5514_H__
 
 #include <linux/clk.h>
+#include <sound/rt5514.h>
 
 #define RT5514_DEVICE_ID			0x10ec5514
 
@@ -243,6 +244,7 @@ enum {
 };
 
 struct rt5514_priv {
+	struct rt5514_platform_data pdata;
 	struct snd_soc_codec *codec;
 	struct regmap *i2c_regmap, *regmap;
 	struct clk *mclk;
-- 
2.8.1
