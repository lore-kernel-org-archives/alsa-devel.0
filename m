From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add support for OMAP3 Pandora
Date: Fri,  5 Dec 2008 16:54:21 +0000
Message-ID: <1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
Content-Type: multipart/mixed; boundary="===============0330853505312432706=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B77312417E
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 17:54:23 +0100 (CET)
In-Reply-To: <20081205165341.GA21294@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============0330853505312432706==

From: Grazvydas Ignotas <notasas@gmail.com>

This patch adds basic support for OMAP3 Pandora.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig        |    8 +
 sound/soc/omap/Makefile       |    2 +
 sound/soc/omap/omap3pandora.c |  311 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3pandora.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index da39f27..a7b1d77 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -46,3 +46,11 @@ config SND_OMAP_SOC_SDP3430
 	help
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP3430.
+
+config SND_OMAP_SOC_OMAP3_PANDORA
+	tristate "SoC Audio support for OMAP3 Pandora"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 29cf3a8..76fedd9 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -11,9 +11,11 @@ snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-sdp3430-objs := sdp3430.o
+snd-soc-omap3pandora-objs := omap3pandora.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
new file mode 100644
index 0000000..bd91594
--- /dev/null
+++ b/sound/soc/omap/omap3pandora.c
@@ -0,0 +1,311 @@
+/*
+ * omap3pandora.c  --  SoC audio for Pandora Handheld Console
+ *
+ * Author: Gražvydas Ignotas <notasas@gmail.com>
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
+#include <linux/gpio.h>
+#include <linux/delay.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+#define OMAP3_PANDORA_DAC_POWER_GPIO	118
+#define OMAP3_PANDORA_AMP_POWER_GPIO	14
+
+#define PREFIX "ASoC omap3pandora: "
+
+static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
+	struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set codec system clock\n");
+		return ret;
+	}
+
+	/* Set McBSP clock to external */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT, 0,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set cpu system clock\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 8);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set SRG clock divider\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+					  SND_SOC_DAIFMT_I2S |
+					  SND_SOC_DAIFMT_IB_NF |
+					  SND_SOC_DAIFMT_CBS_CFS);
+}
+
+static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+					  SND_SOC_DAIFMT_I2S |
+					  SND_SOC_DAIFMT_NB_NF |
+					  SND_SOC_DAIFMT_CBS_CFS);
+}
+
+static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
+	} else {
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+		mdelay(1);
+		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+	}
+
+	return 0;
+}
+
+/*
+ * Audio paths on Pandora board:
+ *
+ *  |O| ---> PCM DAC +-> AMP -> Headphone Jack
+ *  |M|         A    +--------> Line Out
+ *  |A| <~~clk~~+
+ *  |P| <--- TWL4030 <--------- Line In and MICs
+ */
+static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("PCM DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
+			   0, 0, NULL, 0, omap3pandora_hp_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+};
+
+static const struct snd_soc_dapm_widget omap3pandora_in_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic (Internal)", NULL),
+	SND_SOC_DAPM_MIC("Mic (external)", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static const struct snd_soc_dapm_route omap3pandora_out_map[] = {
+	{"Headphone Amplifier", NULL, "PCM DAC"},
+	{"Line Out", NULL, "PCM DAC"},
+	{"Headphone Jack", NULL, "Headphone Amplifier"},
+};
+
+static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
+	{"INL", NULL, "Line In"},
+	{"INR", NULL, "Line In"},
+	{"INL", NULL, "Mic (Internal)"},
+	{"INR", NULL, "Mic (external)"},
+};
+
+static int omap3pandora_out_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(codec, omap3pandora_out_dapm_widgets,
+				ARRAY_SIZE(omap3pandora_out_dapm_widgets));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_add_routes(codec, omap3pandora_out_map,
+		ARRAY_SIZE(omap3pandora_out_map));
+
+	return snd_soc_dapm_sync(codec);
+}
+
+static int omap3pandora_in_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(codec, omap3pandora_in_dapm_widgets,
+				ARRAY_SIZE(omap3pandora_in_dapm_widgets));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_add_routes(codec, omap3pandora_in_map,
+		ARRAY_SIZE(omap3pandora_in_map));
+
+	return snd_soc_dapm_sync(codec);
+}
+
+static struct snd_soc_ops omap3pandora_out_ops = {
+	.hw_params = omap3pandora_out_hw_params,
+};
+
+static struct snd_soc_ops omap3pandora_in_ops = {
+	.hw_params = omap3pandora_in_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3pandora_dai[] = {
+	{
+		.name = "PCM1773",
+		.stream_name = "HiFi Out",
+		.cpu_dai = &omap_mcbsp_dai[0],
+		.codec_dai = &twl4030_dai,
+		.ops = &omap3pandora_out_ops,
+		.init = omap3pandora_out_init,
+	}, {
+		.name = "TWL4030",
+		.stream_name = "Line/Mic In",
+		.cpu_dai = &omap_mcbsp_dai[1],
+		.codec_dai = &twl4030_dai,
+		.ops = &omap3pandora_in_ops,
+		.init = omap3pandora_in_init,
+	}
+};
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_omap3pandora = {
+	.name = "omap3pandora",
+	.platform = &omap_soc_platform,
+	.dai_link = omap3pandora_dai,
+	.num_links = ARRAY_SIZE(omap3pandora_dai),
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3pandora_snd_data = {
+	.card = &snd_soc_card_omap3pandora,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3pandora_snd_device;
+
+static int __init omap3pandora_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap3_pandora()) {
+		pr_debug(PREFIX "Not OMAP3 Pandora\n");
+		return -ENODEV;
+	}
+	pr_info("OMAP3 Pandora SoC init\n");
+
+	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
+	if (ret) {
+		pr_err(PREFIX "Failed to get DAC power GPIO\n");
+		return ret;
+	}
+
+	ret = gpio_direction_output(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+	if (ret) {
+		pr_err(PREFIX "Failed to set DAC power GPIO direction\n");
+		goto fail0;
+	}
+
+	ret = gpio_request(OMAP3_PANDORA_AMP_POWER_GPIO, "amp_power");
+	if (ret) {
+		pr_err(PREFIX "Failed to get amp power GPIO\n");
+		goto fail0;
+	}
+
+	ret = gpio_direction_output(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+	if (ret) {
+		pr_err(PREFIX "Failed to set amp power GPIO direction\n");
+		goto fail1;
+	}
+
+	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
+	if (omap3pandora_snd_device == NULL) {
+		pr_err(PREFIX "Platform device allocation failed\n");
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	platform_set_drvdata(omap3pandora_snd_device, &omap3pandora_snd_data);
+	omap3pandora_snd_data.dev = &omap3pandora_snd_device->dev;
+	*(unsigned int *)omap_mcbsp_dai[0].private_data = 1; /* McBSP2 */
+	*(unsigned int *)omap_mcbsp_dai[1].private_data = 3; /* McBSP4 */
+
+	ret = platform_device_add(omap3pandora_snd_device);
+	if (ret) {
+		pr_err(PREFIX "Unable to add platform device\n");
+		goto fail2;
+	}
+
+	return 0;
+
+fail2:
+	platform_device_put(omap3pandora_snd_device);
+fail1:
+	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
+fail0:
+	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
+	return ret;
+}
+module_init(omap3pandora_soc_init);
+
+static void __exit omap3pandora_soc_exit(void)
+{
+	platform_device_unregister(omap3pandora_snd_device);
+	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
+	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
+}
+module_exit(omap3pandora_soc_exit);
+
+MODULE_AUTHOR("Grazvydas Ignotas <notasas@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 Pandora");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5


--===============0330853505312432706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0330853505312432706==--
