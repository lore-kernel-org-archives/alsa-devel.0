From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH 1/2] ASoC: SDP4430: Add sdp4430 machine driver
Date: Mon, 17 May 2010 19:53:10 -0500
Message-ID: <1274143990-314-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA6B24815
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 03:05:16 +0200 (CEST)
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, broonie@opensource.wolfsonmicro.com, Misael Lopez Cruz <x0052729@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <x0052729@ti.com>

Add ASoC support for TI SDP4430.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
---
 sound/soc/omap/Kconfig   |    9 ++
 sound/soc/omap/Makefile  |    2 +
 sound/soc/omap/sdp4430.c |  228 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/sdp4430.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4292701..c23c4a6 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -102,6 +102,15 @@ config SND_OMAP_SOC_SDP3430
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP3430.
 
+config SND_OMAP_SOC_SDP4430
+	tristate "SoC Audio support for Texas Instruments SDP4430"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	select SND_OMAP_SOC_MCPDM
+	select SND_SOC_TWL6040
+	help
+	  Say Y if you want to add support for SoC audio on Texas Instruments
+	  SDP4430.
+
 config SND_OMAP_SOC_OMAP3_PANDORA
 	tristate "SoC Audio support for OMAP3 Pandora"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 3a75755..ba9fc65 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -17,6 +17,7 @@ snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
+snd-soc-sdp4430-objs := sdp4430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
@@ -31,6 +32,7 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
+obj-$(CONFIG_SND_OMAP_SOC_SDP4430) += snd-soc-sdp4430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
new file mode 100644
index 0000000..83831ee
--- /dev/null
+++ b/sound/soc/omap/sdp4430.c
@@ -0,0 +1,228 @@
+/*
+ * sdp4430.c  --  SoC audio for TI OMAP4430 SDP
+ *
+ * Author: Misael Lopez Cruz <x0052729@ti.com>
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
+#include <plat/hardware.h>
+#include <plat/mux.h>
+
+#include "mcpdm.h"
+#include "omap-mcpdm.h"
+#include "omap-pcm.h"
+#include "../codecs/twl6040.h"
+
+static int twl6040_power_mode;
+
+static int sdp4430_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int clk_id, freq;
+	int ret;
+
+	if (twl6040_power_mode) {
+		clk_id = TWL6040_SYSCLK_SEL_HPPLL;
+		freq = 38400000;
+	} else {
+		clk_id = TWL6040_SYSCLK_SEL_LPPLL;
+		freq = 32768;
+	}
+
+	/* set the codec mclk */
+	ret = snd_soc_dai_set_sysclk(codec_dai, clk_id, freq,
+				SND_SOC_CLOCK_IN);
+	if (ret) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+}
+
+static struct snd_soc_ops sdp4430_ops = {
+	.hw_params = sdp4430_hw_params,
+};
+
+static int sdp4430_get_power_mode(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = twl6040_power_mode;
+	return 0;
+}
+
+static int sdp4430_set_power_mode(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	if (twl6040_power_mode == ucontrol->value.integer.value[0])
+		return 0;
+
+	twl6040_power_mode = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static const char *power_texts[] = {"Low-Power", "High-Performance"};
+
+static const struct soc_enum sdp4430_enum[] = {
+	SOC_ENUM_SINGLE_EXT(2, power_texts),
+};
+
+static const struct snd_kcontrol_new sdp4430_controls[] = {
+	SOC_ENUM_EXT("TWL6040 Power Mode", sdp4430_enum[0],
+		sdp4430_get_power_mode, sdp4430_set_power_mode),
+};
+
+/* SDP4430 machine DAPM */
+static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Ext Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* External Mics: MAINMIC, SUBMIC with bias*/
+	{"MAINMIC", NULL, "Main Mic Bias"},
+	{"SUBMIC", NULL, "Main Mic Bias"},
+	{"Main Mic Bias", NULL, "Ext Mic"},
+
+	/* External Speakers: HFL, HFR */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset Mic: HSMIC with bias */
+	{"HSMIC", NULL, "Headset Mic Bias"},
+	{"Headset Mic Bias", NULL, "Headset Mic"},
+
+	/* Headset Stereophone (Headphone): HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+};
+
+static int sdp4430_twl6040_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* Add SDP4430 specific controls */
+	ret = snd_soc_add_controls(codec, sdp4430_controls,
+				ARRAY_SIZE(sdp4430_controls));
+	if (ret)
+		return ret;
+
+	/* Add SDP4430 specific widgets */
+	ret = snd_soc_dapm_new_controls(codec, sdp4430_twl6040_dapm_widgets,
+				ARRAY_SIZE(sdp4430_twl6040_dapm_widgets));
+	if (ret)
+		return ret;
+
+	/* Set up SDP4430 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	/* SDP4430 connected pins */
+	snd_soc_dapm_enable_pin(codec, "Ext Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_enable_pin(codec, "Headset Mic");
+	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
+
+	/* TWL6040 not connected pins */
+	snd_soc_dapm_nc_pin(codec, "AFML");
+	snd_soc_dapm_nc_pin(codec, "AFMR");
+
+	ret = snd_soc_dapm_sync(codec);
+
+	return ret;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sdp4430_dai = {
+	.name = "TWL6040",
+	.stream_name = "TWL6040",
+	.cpu_dai = &omap_mcpdm_dai,
+	.codec_dai = &twl6040_dai,
+	.init = sdp4430_twl6040_init,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_sdp4430 = {
+	.name = "SDP4430",
+	.platform = &omap_soc_platform,
+	.dai_link = &sdp4430_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device sdp4430_snd_devdata = {
+	.card = &snd_soc_sdp4430,
+	.codec_dev = &soc_codec_dev_twl6040,
+};
+
+static struct platform_device *sdp4430_snd_device;
+
+static int __init sdp4430_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap_4430sdp()) {
+		pr_debug("Not SDP4430!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "SDP4430 SoC init\n");
+
+	sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!sdp4430_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(sdp4430_snd_device, &sdp4430_snd_devdata);
+	sdp4430_snd_devdata.dev = &sdp4430_snd_device->dev;
+
+	ret = platform_device_add(sdp4430_snd_device);
+	if (ret)
+		goto err;
+
+	/* Codec starts in HP mode */
+	twl6040_power_mode = 1;
+
+	return 0;
+
+err:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(sdp4430_snd_device);
+	return ret;
+}
+module_init(sdp4430_soc_init);
+
+static void __exit sdp4430_soc_exit(void)
+{
+	platform_device_unregister(sdp4430_snd_device);
+}
+module_exit(sdp4430_soc_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC SDP4430");
+MODULE_LICENSE("GPL");
+
-- 
1.6.3.3
