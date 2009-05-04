From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [ASoC PATCH 1/1] IMote 2 ASoC Support
Date: Mon, 04 May 2009 14:54:11 +0000
Message-ID: <49FF0193.1080908@cam.ac.uk>
References: <49FEFDC8.2090103@cam.ac.uk> <20090504144119.GO6975@sirena.org.uk>
	<49FEFED3.7090104@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-5.csi.cam.ac.uk (ppsw-5.csi.cam.ac.uk [131.111.8.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 912F1103821
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 16:54:42 +0200 (CEST)
In-Reply-To: <49FEFED3.7090104@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

From: Jonathan Cameron <jic23@cam.ac.uk>

IMote2 ASoC Support

This patch adds the ASoC side of the board support for the
Crossbow IMB400 daughter board.

Thanks to Crossbow for considerable assistance.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---

Changes since last post (in response to Mark's comments)

* Removed PLL code. The driver never initializes so why bother to
disable it.

* Removed excess headers.

Relatively straight forward configuration with the PXA acting as the clock
master.
 sound/soc/pxa/Kconfig  |    9 ++++
 sound/soc/pxa/Makefile |    2 +
 sound/soc/pxa/imote2.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index ad8a10f..eb75a1c 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -134,3 +134,12 @@ config SND_PXA2XX_SOC_MIOA701
         help
           Say Y if you want to add support for SoC audio on the
           MIO A701.
+
+config SND_PXA2XX_SOC_IMOTE2
+       tristate "SoC Audio support for IMote 2"
+       depends on SND_PXA2XX_SOC && MACH_INTELMOTE2
+       select SND_PXA2XX_SOC_I2S
+       select SND_SOC_WM8940
+       help
+         Say Y if you want to add support for SoC audio on the
+	 IMote 2.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 4b90c3c..6e096b4 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -22,6 +22,7 @@ snd-soc-palm27x-objs := palm27x.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
+snd-soc-imote2-objs := imote2.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -35,3 +36,4 @@ obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
+obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
new file mode 100644
index 0000000..405587a
--- /dev/null
+++ b/sound/soc/pxa/imote2.c
@@ -0,0 +1,114 @@
+
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/wm8940.h"
+#include "pxa2xx-i2s.h"
+#include "pxa2xx-pcm.h"
+
+static int imote2_asoc_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	int ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		clk = 11289600;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+				  | SND_SOC_DAIFMT_NB_NF
+				  | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* CPU should be clock master */
+	ret = snd_soc_dai_set_fmt(cpu_dai,  SND_SOC_DAIFMT_I2S
+				  | SND_SOC_DAIFMT_NB_NF
+				  | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set the I2S system clock as input (unused) */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, clk,
+		SND_SOC_CLOCK_OUT);
+
+	return ret;
+}
+
+static struct snd_soc_ops imote2_asoc_ops = {
+	.hw_params = imote2_asoc_hw_params,
+};
+
+static struct snd_soc_dai_link imote2_dai = {
+	.name = "WM8940",
+	.stream_name = "WM8940",
+	.cpu_dai = &pxa_i2s_dai,
+	.codec_dai = &wm8940_dai,
+	.ops = &imote2_asoc_ops,
+};
+
+static struct snd_soc_card snd_soc_imote2 = {
+	.name = "Imote2",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = &imote2_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device imote2_snd_devdata = {
+	.card = &snd_soc_imote2,
+	.codec_dev = &soc_codec_dev_wm8940,
+};
+
+static struct platform_device *imote2_snd_device;
+
+static int __init imote2_asoc_init(void)
+{
+	int ret;
+
+	if (!machine_is_intelmote2())
+		return -ENODEV;
+	imote2_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!imote2_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(imote2_snd_device, &imote2_snd_devdata);
+	imote2_snd_devdata.dev = &imote2_snd_device->dev;
+	ret = platform_device_add(imote2_snd_device);
+	if (ret)
+		platform_device_put(imote2_snd_device);
+
+	return ret;
+}
+module_init(imote2_asoc_init);
+
+static void __exit imote2_asoc_exit(void)
+{
+	platform_device_unregister(imote2_snd_device);
+}
+module_exit(imote2_asoc_exit);
+
+MODULE_AUTHOR("Jonathan Cameron");
+MODULE_DESCRIPTION("ALSA SoC Imote 2");
+MODULE_LICENSE("GPL");
