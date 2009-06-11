From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: Zoom2: Add machine driver for Zoom2 board
Date: Thu, 11 Jun 2009 17:35:27 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F6CFA515@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D24DB24367
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 00:35:38 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Add support for Zoom2 board. Zoom2 machine driver
connects both codec DAIs (audio and voice) to omap3
McBSP ports in the following way:

  HiFi <-> McBSP2
 Voice <-> McBSP3

The zoom2 driver has the following DAPM widgets:
* Ext Mic: MAINMIC, SUBMIC (with bias)
* Ext Spk: HFL, HFR
* Headset Stereophone: HSOL, HSOR
* Headset Mic: HSMIC (with bias)
* Aux In: AUXL, AUXR

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/Kconfig  |    7 +
 sound/soc/omap/Makefile |    2 +
 sound/soc/omap/zoom2.c  |  301 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/zoom2.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 675732e..397f3d8 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -64,4 +64,11 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
 	help
 	  Say Y if you want to add support for SoC audio on the Beagleboard.
 
+config SND_OMAP_SOC_ZOOM2
+	tristate "SoC Audio support for Zoom2"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for Soc audio on Zoom2 board.
 
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 0c9e4ac..5016840 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -13,6 +13,7 @@ snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
+snd-soc-zoom2-objs := zoom2.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
@@ -21,3 +22,4 @@ obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
+obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
new file mode 100644
index 0000000..be2e307
--- /dev/null
+++ b/sound/soc/omap/zoom2.c
@@ -0,0 +1,301 @@
+/*
+ * zoom2.c  --  SoC audio for Zoom2
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
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+#define ZOOM2_HEADSET_MUX_GPIO	(OMAP_MAX_GPIO_LINES + 15)
+
+static int zoom2_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
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
+					SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops zoom2_ops = {
+	.hw_params = zoom2_hw_params,
+};
+
+static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				SND_SOC_DAIFMT_DSP_A |
+				SND_SOC_DAIFMT_IB_NF |
+				SND_SOC_DAIFMT_CBS_CFM);
+	if (ret) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				SND_SOC_DAIFMT_DSP_A |
+				SND_SOC_DAIFMT_IB_NF |
+				SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops zoom2_voice_ops = {
+	.hw_params = zoom2_hw_voice_params,
+};
+
+/* Zoom2 machine DAPM */
+static const struct snd_soc_dapm_widget zoom2_twl4030_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Ext Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_LINE("Aux In", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* External Mics: MAINMIC, SUBMIC with bias*/
+	{"MAINMIC", NULL, "Mic Bias 1"},
+	{"SUBMIC", NULL, "Mic Bias 2"},
+	{"Mic Bias 1", NULL, "Ext Mic"},
+	{"Mic Bias 2", NULL, "Ext Mic"},
+
+	/* External Speakers: HFL, HFR */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset Stereophone:  HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+
+	/* Headset Mic: HSMIC with bias */
+	{"HSMIC", NULL, "Headset Mic Bias"},
+	{"Headset Mic Bias", NULL, "Headset Mic"},
+
+	/* Aux In: AUXL, AUXR */
+	{"Aux In", NULL, "AUXL"},
+	{"Aux In", NULL, "AUXR"},
+};
+
+static int zoom2_twl4030_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* Add Zoom2 specific widgets */
+	ret = snd_soc_dapm_new_controls(codec, zoom2_twl4030_dapm_widgets,
+				ARRAY_SIZE(zoom2_twl4030_dapm_widgets));
+	if (ret)
+		return ret;
+
+	/* Set up Zoom2 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	/* Zoom2 connected pins */
+	snd_soc_dapm_enable_pin(codec, "Ext Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_enable_pin(codec, "Headset Mic");
+	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(codec, "Aux In");
+
+	/* TWL4030 not connected pins */
+	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
+
+	snd_soc_dapm_nc_pin(codec, "OUTL");
+	snd_soc_dapm_nc_pin(codec, "OUTR");
+	snd_soc_dapm_nc_pin(codec, "EARPIECE");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
+	snd_soc_dapm_nc_pin(codec, "CARKITL");
+	snd_soc_dapm_nc_pin(codec, "CARKITR");
+
+	ret = snd_soc_dapm_sync(codec);
+
+	return ret;
+}
+
+static int zoom2_twl4030_voice_init(struct snd_soc_codec *codec)
+{
+	unsigned short reg;
+
+	/* Enable voice interface */
+	reg = codec->read(codec, TWL4030_REG_VOICE_IF);
+	reg |= TWL4030_VIF_DIN_EN | TWL4030_VIF_DOUT_EN | TWL4030_VIF_EN;
+	codec->write(codec, TWL4030_REG_VOICE_IF, reg);
+
+	return 0;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link zoom2_dai[] = {
+	{
+		.name = "TWL4030 I2S",
+		.stream_name = "TWL4030 Audio",
+		.cpu_dai = &omap_mcbsp_dai[0],
+		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.init = zoom2_twl4030_init,
+		.ops = &zoom2_ops,
+	},
+	{
+		.name = "TWL4030 PCM",
+		.stream_name = "TWL4030 Voice",
+		.cpu_dai = &omap_mcbsp_dai[1],
+		.codec_dai = &twl4030_dai[TWL4030_DAI_VOICE],
+		.init = zoom2_twl4030_voice_init,
+		.ops = &zoom2_voice_ops,
+	},
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_zoom2 = {
+	.name = "Zoom2",
+	.platform = &omap_soc_platform,
+	.dai_link = zoom2_dai,
+	.num_links = ARRAY_SIZE(zoom2_dai),
+};
+
+/* twl4030 setup */
+static struct twl4030_setup_data twl4030_setup = {
+	.ramp_delay_value = 2,	/* 81 ms */
+	.sysclk = 26000,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device zoom2_snd_devdata = {
+	.card = &snd_soc_zoom2,
+	.codec_dev = &soc_codec_dev_twl4030,
+	.codec_data = &twl4030_setup,
+};
+
+static struct platform_device *zoom2_snd_device;
+
+static int __init zoom2_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap_zoom2()) {
+		pr_debug("Not Zoom2!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "Zoom2 SoC init\n");
+
+	zoom2_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!zoom2_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(zoom2_snd_device, &zoom2_snd_devdata);
+	zoom2_snd_devdata.dev = &zoom2_snd_device->dev;
+	*(unsigned int *)zoom2_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
+	*(unsigned int *)zoom2_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
+
+	ret = platform_device_add(zoom2_snd_device);
+	if (ret)
+		goto err1;
+
+	BUG_ON(gpio_request(ZOOM2_HEADSET_MUX_GPIO, "hs_mux") < 0);
+	gpio_direction_output(ZOOM2_HEADSET_MUX_GPIO, 0);
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(zoom2_snd_device);
+
+	return ret;
+}
+module_init(zoom2_soc_init);
+
+static void __exit zoom2_soc_exit(void)
+{
+	gpio_free(ZOOM2_HEADSET_MUX_GPIO);
+
+	platform_device_unregister(zoom2_snd_device);
+}
+module_exit(zoom2_soc_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC Zoom2");
+MODULE_LICENSE("GPL");
+
-- 
1.5.4.3
