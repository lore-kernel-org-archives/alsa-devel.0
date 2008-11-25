From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/13] ASoC: Add support for TI SDP3430
Date: Tue, 25 Nov 2008 15:44:48 +0000
Message-ID: <1227627889-8373-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-11-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16AE924497
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:53 +0100 (CET)
In-Reply-To: <1227627889-8373-11-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <mesak82@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <mesak82@gmail.com>

This patch add ASoC support for TI SDP3430. It's based on Gumstix
Overo SoC code by Steve Sakoman.

Signed-off-by: Misael Lopez Cruz <mesak82@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig   |    7 ++
 sound/soc/omap/Makefile  |    3 +-
 sound/soc/omap/sdp3430.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/omap/sdp3430.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 0900437..1cd0176 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -38,5 +38,12 @@ config SND_OMAP_SOC_OMAP2EVM
 	help
 	  Say Y if you want to add support for SoC audio on the omap2evm board.
 
+config SND_OMAP_SOC_SDP3430
+	tristate "SoC Audio support for Texas Instruments SDP3430"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on Texas Instruments SDP3430.
 
 
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index f5da3cc..29cf3a8 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -10,9 +10,10 @@ snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
+snd-soc-sdp3430-objs := sdp3430.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
-
+obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
new file mode 100644
index 0000000..85fd160
--- /dev/null
+++ b/sound/soc/omap/sdp3430.c
@@ -0,0 +1,152 @@
+/*
+ * sdp3430.c  --  SoC audio for TI OMAP3430 SDP
+ *
+ * Author: Misael Lopez Cruz <x0052729@ti.com>
+ *
+ * Based on:
+ * Author: Steve Sakoman <steve@sakoman.com>
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
+static int sdp3430_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops sdp3430_ops = {
+	.hw_params = sdp3430_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sdp3430_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &sdp3430_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_sdp3430 = {
+	.name = "SDP3430",
+	.dai_link = &sdp3430_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device sdp3430_snd_devdata = {
+	.machine = &snd_soc_machine_sdp3430,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *sdp3430_snd_device;
+
+static int __init sdp3430_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap_3430sdp()) {
+		pr_debug("Not SDP3430!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "SDP3430 SoC init\n");
+
+	sdp3430_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!sdp3430_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(sdp3430_snd_device, &sdp3430_snd_devdata);
+	sdp3430_snd_devdata.dev = &sdp3430_snd_device->dev;
+	*(unsigned int *)sdp3430_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(sdp3430_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(sdp3430_snd_device);
+
+	return ret;
+}
+module_init(sdp3430_soc_init);
+
+static void __exit sdp3430_soc_exit(void)
+{
+	platform_device_unregister(sdp3430_snd_device);
+}
+module_exit(sdp3430_soc_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC SDP3430");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5
