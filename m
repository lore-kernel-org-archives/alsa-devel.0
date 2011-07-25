From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V5 2/3] ASoC: Add a DB1x00 AC97 machine driver
Date: Mon, 25 Jul 2011 13:44:46 +0200
Message-ID: <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
boards.

Run-tested on DB1500.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V4/V5: no changes.
V3: split off from patch 1, implemented new machine code.

 arch/mips/alchemy/devboards/db1x00/platform.c |   48 ++++++++++++++++
 sound/soc/au1x/Kconfig                        |    9 +++
 sound/soc/au1x/Makefile                       |    2 +
 sound/soc/au1x/db1000.c                       |   75 +++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/au1x/db1000.c

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 978d5ab..7057d28 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -19,8 +19,11 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
@@ -85,6 +88,45 @@
 #endif
 #endif
 
+static struct resource alchemy_ac97c_res[] = {
+	[0] = {
+		.start	= AU1000_AC97_PHYS_ADDR,
+		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMA_ID_AC97C_TX,
+		.end	= DMA_ID_AC97C_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMA_ID_AC97C_RX,
+		.end	= DMA_ID_AC97C_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device alchemy_ac97c_dev = {
+	.name		= "alchemy-ac97c",
+	.id		= -1,
+	.resource	= alchemy_ac97c_res,
+	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
+};
+
+static struct platform_device alchemy_ac97c_dma_dev = {
+	.name		= "alchemy-pcm-dma",
+	.id		= 0,
+};
+
+static struct platform_device db1x00_codec_dev = {
+	.name		= "ac97-codec",
+	.id		= -1,
+};
+
+static struct platform_device db1x00_audio_dev = {
+	.name		= "db1000-audio",
+};
+
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
@@ -113,6 +155,12 @@ static int __init db1xxx_dev_init(void)
 				    1);
 #endif
 	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
+
+	platform_device_register(&db1x00_codec_dev);
+	platform_device_register(&alchemy_ac97c_dma_dev);
+	platform_device_register(&alchemy_ac97c_dev);
+	platform_device_register(&db1x00_audio_dev);
+
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 0460b42..6d59254 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -41,6 +41,15 @@ config SND_SOC_AU1XI2SC
 ##
 ## Boards
 ##
+config SND_SOC_DB1000
+	tristate "DB1000 Audio support"
+	depends on SND_SOC_AU1XAUDIO
+	select SND_SOC_AU1XAC97C
+	select SND_SOC_AC97_CODEC
+	help
+	  Select this option to enable AC97 audio on the early DB1x00 series
+	  of boards (DB1000/DB1500/DB1100).
+
 config SND_SOC_DB1200
 	tristate "DB1200 AC97+I2S audio support"
 	depends on SND_SOC_AU1XPSC
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index ff5531e..9207105 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_SND_SOC_AU1XAC97C) += snd-soc-au1x-ac97c.o
 obj-$(CONFIG_SND_SOC_AU1XI2SC) += snd-soc-au1x-i2sc.o
 
 # Boards
+snd-soc-db1000-objs := db1000.o
 snd-soc-db1200-objs := db1200.o
 
+obj-$(CONFIG_SND_SOC_DB1000) += snd-soc-db1000.o
 obj-$(CONFIG_SND_SOC_DB1200) += snd-soc-db1200.o
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
new file mode 100644
index 0000000..127477a
--- /dev/null
+++ b/sound/soc/au1x/db1000.c
@@ -0,0 +1,75 @@
+/*
+ * DB1000/DB1500/DB1100 ASoC audio fabric support code.
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#include "psc.h"
+
+static struct snd_soc_dai_link db1000_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.codec_dai_name	= "ac97-hifi",
+	.cpu_dai_name	= "alchemy-ac97c",
+	.platform_name	= "alchemy-pcm-dma.0",
+	.codec_name	= "ac97-codec",
+};
+
+static struct snd_soc_card db1000_ac97 = {
+	.name		= "DB1000_AC97",
+	.dai_link	= &db1000_ac97_dai,
+	.num_links	= 1,
+};
+
+static int __devinit db1000_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &db1000_ac97;
+	card->dev = &pdev->dev;
+	return snd_soc_register_card(card);
+}
+
+static int __devexit db1000_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	snd_soc_unregister_card(card);
+	return 0;
+}
+
+static struct platform_driver db1000_audio_driver = {
+	.driver	= {
+		.name	= "db1000-audio",
+		.owner	= THIS_MODULE,
+		.pm	= &snd_soc_pm_ops,
+	},
+	.probe		= db1000_audio_probe,
+	.remove		= __devexit_p(db1000_audio_remove),
+};
+
+static int __init db1000_audio_load(void)
+{
+	return platform_driver_register(&db1000_audio_driver);
+}
+
+static void __exit db1000_audio_unload(void)
+{
+	platform_driver_unregister(&db1000_audio_driver);
+}
+
+module_init(db1000_audio_load);
+module_exit(db1000_audio_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DB1000/DB1500/DB1100 ASoC audio");
+MODULE_AUTHOR("Manuel Lauss");
-- 
1.7.6

