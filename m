From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH v3 3/3] ASoC: ep93xx: add Simplemachines
	Sim.One AC97 audio support
Date: Thu, 14 Oct 2010 17:49:08 +0300
Message-ID: <a0a4850aa3947982f0de84299eb130597bf6a538.1287066937.git.mika.westerberg@iki.fi>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5B98B2446F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 16:49:10 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 18so485286bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 07:49:10 -0700 (PDT)
In-Reply-To: <cover.1287066937.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1287066937.git.mika.westerberg@iki.fi>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, Mika Westerberg <mika.westerberg@iki.fi>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add AC97 audio support for Simplemachines Sim.One board.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/simone.c |    1 +
 sound/soc/ep93xx/Kconfig      |    9 ++++
 sound/soc/ep93xx/Makefile     |    2 +
 sound/soc/ep93xx/simone.c     |   89 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ep93xx/simone.c

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 5dded58..f5f81f9 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -61,6 +61,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
+	ep93xx_register_ac97();
 }
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index 108e5ff..5742904 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -21,3 +21,12 @@ config SND_EP93XX_SOC_SNAPPERCL15
         help
           Say Y or M here if you want to add support for I2S audio on the
           Bluewater Systems Snapper CL15 module.
+
+config SND_EP93XX_SOC_SIMONE
+	tristate "SoC Audio support for Simplemachines Sim.One board"
+	depends on SND_EP93XX_SOC && MACH_SIM_ONE
+	select SND_EP93XX_SOC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  Say Y or M here if you want to add support for AC97 audio on the
+	  Simplemachines Sim.One board.
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
index ac06e00..8e7977f 100644
--- a/sound/soc/ep93xx/Makefile
+++ b/sound/soc/ep93xx/Makefile
@@ -9,5 +9,7 @@ obj-$(CONFIG_SND_EP93XX_SOC_AC97)		+= snd-soc-ep93xx-ac97.o
 
 # EP93XX Machine Support
 snd-soc-snappercl15-objs			:= snappercl15.o
+snd-soc-simone-objs				:= simone.o
 
 obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
+obj-$(CONFIG_SND_EP93XX_SOC_SIMONE)		+= snd-soc-simone.o
diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
new file mode 100644
index 0000000..4b0d199
--- /dev/null
+++ b/sound/soc/ep93xx/simone.c
@@ -0,0 +1,89 @@
+/*
+ * simone.c -- ASoC audio for Simplemachines Sim.One board
+ *
+ * Copyright (c) 2010 Mika Westerberg
+ *
+ * Based on snappercl15 machine driver by Ryan Mallon.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#include "ep93xx-pcm.h"
+
+static struct snd_soc_dai_link simone_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.cpu_dai_name	= "ep93xx-ac97",
+	.codec_dai_name	= "ac97-hifi",
+	.codec_name	= "ac97-codec",
+	.platform_name	= "ep93xx-pcm-audio",
+};
+
+static struct snd_soc_card snd_soc_simone = {
+	.name		= "Sim.One",
+	.dai_link	= &simone_dai,
+	.num_links	= 1,
+};
+
+static struct platform_device *simone_snd_ac97_device;
+static struct platform_device *simone_snd_device;
+
+static int __init simone_init(void)
+{
+	int ret;
+
+	if (!machine_is_sim_one())
+		return -ENODEV;
+
+	simone_snd_ac97_device = platform_device_alloc("ac97-codec", -1);
+	if (!simone_snd_ac97_device)
+		return -ENOMEM;
+
+	ret = platform_device_add(simone_snd_ac97_device);
+	if (ret)
+		goto fail;
+
+	simone_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!simone_snd_device) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	platform_set_drvdata(simone_snd_device, &snd_soc_simone);
+	ret = platform_device_add(simone_snd_device);
+	if (ret) {
+		platform_device_put(simone_snd_device);
+		goto fail;
+	}
+
+	return ret;
+
+fail:
+	platform_device_put(simone_snd_ac97_device);
+	return ret;
+}
+module_init(simone_init);
+
+static void __exit simone_exit(void)
+{
+	platform_device_unregister(simone_snd_device);
+	platform_device_unregister(simone_snd_ac97_device);
+}
+module_exit(simone_exit);
+
+MODULE_DESCRIPTION("ALSA SoC Simplemachines Sim.One");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
