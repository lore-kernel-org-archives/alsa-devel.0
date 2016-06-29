From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add new simple-card-utils.c" to the asoc tree
Date: Wed, 29 Jun 2016 19:20:48 +0100
Message-ID: <E1bIK6S-0004hf-4U@finisterre>
References: <87a8j6sj4w.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a8j6sj4w.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add new simple-card-utils.c

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

>From abd3147e69481caade441e8d8296fa3f541aea03 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 May 2016 09:00:14 +0000
Subject: [PATCH] ASoC: add new simple-card-utils.c

Current ALSA SoC has simple-card driver which is supporting both
platform and DT probe.
Now, some sound cards driver are created based on simple-card.
They have similar feature or function, but implemented separately
on each drivers. This is a waste of code.
OTOH, merging these driver into same driver is highly risk,
because it will be very difficult to keep compatibility.
More over, ALSA SoC want to have graph base of DT feature in the
future. Maybe it want to use simple-card like feature / function.
Because of these background, this patch creates simple-card
helper utils, and provides common function to each drivers.
1st is asoc_simple_card_parse_daifmt()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 21 ++++++++++++++
 sound/soc/generic/Kconfig             |  3 ++
 sound/soc/generic/Makefile            |  2 ++
 sound/soc/generic/simple-card-utils.c | 54 +++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 include/sound/simple_card_utils.h
 create mode 100644 sound/soc/generic/simple-card-utils.c

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
new file mode 100644
index 000000000000..7acc798016e0
--- /dev/null
+++ b/include/sound/simple_card_utils.h
@@ -0,0 +1,21 @@
+/*
+ * simple_card_core.h
+ *
+ * Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __SIMPLE_CARD_CORE_H
+#define __SIMPLE_CARD_CORE_H
+
+#include <sound/soc.h>
+
+int asoc_simple_card_parse_daifmt(struct device *dev,
+				  struct device_node *node,
+				  struct device_node *codec,
+				  char *prefix,
+				  unsigned int *retfmt);
+
+#endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 610f61251640..26c2fe6a0b93 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -1,3 +1,6 @@
+config SND_SIMPLE_CARD_UTILS
+       tristate
+
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
 	help
diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 9c3b246792bf..45602ca8536e 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -1,3 +1,5 @@
+obj-$(CONFIG_SND_SIMPLE_CARD_UTILS) := simple-card-utils.o
+
 snd-soc-simple-card-objs	:= simple-card.o
 
 obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
new file mode 100644
index 000000000000..3f6b72526f71
--- /dev/null
+++ b/sound/soc/generic/simple-card-utils.c
@@ -0,0 +1,54 @@
+/*
+ * simple-card-core.c
+ *
+ * Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/of.h>
+#include <sound/simple_card_utils.h>
+
+int asoc_simple_card_parse_daifmt(struct device *dev,
+				  struct device_node *node,
+				  struct device_node *codec,
+				  char *prefix,
+				  unsigned int *retfmt)
+{
+	struct device_node *bitclkmaster = NULL;
+	struct device_node *framemaster = NULL;
+	int prefix_len = prefix ? strlen(prefix) : 0;
+	unsigned int daifmt;
+
+	daifmt = snd_soc_of_parse_daifmt(node, prefix,
+					 &bitclkmaster, &framemaster);
+	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+
+	if (prefix_len && !bitclkmaster && !framemaster) {
+		/*
+		 * No dai-link level and master setting was not found from
+		 * sound node level, revert back to legacy DT parsing and
+		 * take the settings from codec node.
+		 */
+		dev_dbg(dev, "Revert to legacy daifmt parsing\n");
+
+		daifmt = snd_soc_of_parse_daifmt(codec, NULL, NULL, NULL) |
+			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
+	} else {
+		if (codec == bitclkmaster)
+			daifmt |= (codec == framemaster) ?
+				SND_SOC_DAIFMT_CBM_CFM : SND_SOC_DAIFMT_CBM_CFS;
+		else
+			daifmt |= (codec == framemaster) ?
+				SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
+	}
+
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+
+	*retfmt = daifmt;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_parse_daifmt);
-- 
2.8.1
