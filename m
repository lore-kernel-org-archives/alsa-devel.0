From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: Add support for omap2evm board
Date: Wed, 19 Nov 2008 13:36:31 +0000
Message-ID: <1227101793-3768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
	<1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31B41103822
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:35 +0100 (CET)
In-Reply-To: <1227101793-3768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

This patch adds twl4030 audio support on omap2evm

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig    |    9 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap2evm.c |  150 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap2evm.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index cf40e42..6c56277 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -30,4 +30,13 @@ config SND_OMAP_SOC_OVERO
 	help
 	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
 
+config SND_OMAP_SOC_OMAP2EVM
+	tristate "SoC Audio support for OMAP2EVM board"
+	depends on SND_OMAP_SOC && MACH_OMAP2EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the omap2evm board.
+
+
 
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index fefc9be..f5da3cc 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -9,8 +9,10 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
+snd-soc-omap2evm-objs := omap2evm.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
new file mode 100644
index 0000000..c376213
--- /dev/null
+++ b/sound/soc/omap/omap2evm.c
@@ -0,0 +1,150 @@
+/*
+ * omap2evm.c  --  SoC audio machine driver for omap2evm board
+ *
+ * Author: Arun KS <arunks@mistralsolutions.com>
+ *
+ * Based on sound/soc/omap/overo.c by Steve Sakoman
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int omap2evm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap2evm_ops = {
+	.hw_params = omap2evm_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap2evm_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &omap2evm_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_omap2evm = {
+	.name = "omap2evm",
+	.dai_link = &omap2evm_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap2evm_snd_devdata = {
+	.machine = &snd_soc_machine_omap2evm,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap2evm_snd_device;
+
+static int __init omap2evm_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap2evm()) {
+		pr_debug("Not omap2evm!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "omap2evm SoC init\n");
+
+	omap2evm_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap2evm_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap2evm_snd_device, &omap2evm_snd_devdata);
+	omap2evm_snd_devdata.dev = &omap2evm_snd_device->dev;
+	*(unsigned int *)omap2evm_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(omap2evm_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap2evm_snd_device);
+
+	return ret;
+}
+module_init(omap2evm_soc_init);
+
+static void __exit omap2evm_soc_exit(void)
+{
+	platform_device_unregister(omap2evm_snd_device);
+}
+module_exit(omap2evm_soc_exit);
+
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_DESCRIPTION("ALSA SoC omap2evm");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
