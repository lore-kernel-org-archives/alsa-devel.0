From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Add support for Gumstix Overo
Date: Fri, 31 Oct 2008 13:20:33 +0000
Message-ID: <1225459236-8633-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081031131828.GA8253@rakim.wolfsonmicro.main>
	<1225459236-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A373324528
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 14:20:38 +0100 (CET)
In-Reply-To: <1225459236-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

From: Steve Sakoman <steve@sakoman.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig  |   10 +++
 sound/soc/omap/Makefile |    3 +
 sound/soc/omap/overo.c  |  148 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/overo.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 8b7766b..cf40e42 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -21,3 +21,13 @@ config SND_OMAP_SOC_OSK5912
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
+
+config SND_OMAP_SOC_OVERO
+	tristate "SoC Audio support for Gumstix Overo"
+	depends on SND_OMAP_SOC && MACH_OVERO
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
+
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index e09d1f2..fefc9be 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -8,6 +8,9 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
+snd-soc-overo-objs := overo.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
+obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
new file mode 100644
index 0000000..c26d1de
--- /dev/null
+++ b/sound/soc/omap/overo.c
@@ -0,0 +1,148 @@
+/*
+ * overo.c  --  SoC audio for Gumstix Overo
+ *
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
+static int overo_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops overo_ops = {
+	.hw_params = overo_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link overo_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &overo_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_overo = {
+	.name = "overo",
+	.dai_link = &overo_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device overo_snd_devdata = {
+	.machine = &snd_soc_machine_overo,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *overo_snd_device;
+
+static int __init overo_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_overo()) {
+		pr_debug("Not Overo!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "overo SoC init\n");
+
+	overo_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!overo_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(overo_snd_device, &overo_snd_devdata);
+	overo_snd_devdata.dev = &overo_snd_device->dev;
+	*(unsigned int *)overo_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(overo_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(overo_snd_device);
+
+	return ret;
+}
+module_init(overo_soc_init);
+
+static void __exit overo_soc_exit(void)
+{
+	platform_device_unregister(overo_snd_device);
+}
+module_exit(overo_soc_exit);
+
+MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
+MODULE_DESCRIPTION("ALSA SoC overo");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
