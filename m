From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: core: Implement
	devm_snd_soc_register_component()
Date: Wed,  4 Sep 2013 20:39:03 +0100
Message-ID: <1378323544-5932-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3270B265560
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 21:39:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since with the wider use of devres many drivers are now only calling
snd_soc_unregister_component() in their remove functions providing a
managed version will save a reasonable amount of code.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc.h    |  3 +++
 sound/soc/Makefile     |  2 +-
 sound/soc/soc-devres.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/soc-devres.c

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a72af63..f126676 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -381,6 +381,9 @@ void snd_soc_unregister_codec(struct device *dev);
 int snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
+int devm_snd_soc_register_component(struct device *dev,
+			 const struct snd_soc_component_driver *cmpnt_drv,
+			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
 				    unsigned int reg);
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 61a64d2..8b9e701 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
-snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o
+snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o soc-devres.o
 
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-objs += soc-generic-dmaengine-pcm.o
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
new file mode 100644
index 0000000..13fe86f
--- /dev/null
+++ b/sound/soc/soc-devres.c
@@ -0,0 +1,52 @@
+/*
+ * soc-devres.c  --  ALSA SoC Audio Layer devres functions
+ *
+ * Copyright (C) 2013 Linaro Ltd
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <sound/soc.h>
+
+static void devm_component_release(struct device *dev, void *res)
+{
+	snd_soc_unregister_component(*(struct device **)res);
+}
+
+/**
+ * devm_snd_soc_register_component - resource managed component registration
+ * @dev: Device used to manage component
+ * @cmpnt_drv: Component driver
+ * @dai_drv: DAI driver
+ * @num_dai: Number of DAIs to register
+ *
+ * Register a component with automatic unregistration when the device is
+ * unregistered.
+ */
+int devm_snd_soc_register_component(struct device *dev,
+			 const struct snd_soc_component_driver *cmpnt_drv,
+			 struct snd_soc_dai_driver *dai_drv, int num_dai)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_component_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = snd_soc_register_component(dev, cmpnt_drv, dai_drv, num_dai);
+	if (ret == 0) {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_snd_soc_register_component);
-- 
1.8.4.rc3
