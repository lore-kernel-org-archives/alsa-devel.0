From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Add machine driver for ST DA7219
	MAX98357" to the asoc tree
Date: Fri, 16 Feb 2018 17:12:05 +0000
Message-ID: <E1emjYL-0007zl-KF@debutante>
References: <1518766875-15164-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B7D267E69
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 18:12:08 +0100 (CET)
In-Reply-To: <1518766875-15164-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Daniel Kurtz <djkurtz@chromium.org>, akshu.agrawal@amd.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Add machine driver for ST DA7219 MAX98357

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 608a300fc1f0e088446cbef8e13ded686c5172b6 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Fri, 16 Feb 2018 13:11:13 +0530
Subject: [PATCH] ASoC: AMD: Add machine driver for ST DA7219 MAX98357

The driver is used for AMD board using DA7219 and MAX98357 codec.

TEST=Build, apply grunt_mixer_settings:
  iotools mmio_write32 0xfed80e40 0x040c40c0
  iotools mmio_write32 0xfed80e28 0x10000
  iotools mmio_write8 0xfed816de 0xc0
  aplay -D plughw:0,0 ./sample_48000.wav -vv
  aplay -D plughw:0,0 ./sample_44100.wav -vv

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig                |   9 ++
 sound/soc/amd/Makefile               |   2 +
 sound/soc/amd/acp-da7219-max98357a.c | 246 +++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 sound/soc/amd/acp-da7219-max98357a.c

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index d5838402f667..6cbf9cf4d1a4 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -3,6 +3,15 @@ config SND_SOC_AMD_ACP
 	help
 	 This option enables ACP DMA support on AMD platform.
 
+config SND_SOC_AMD_CZ_DA7219MX98357_MACH
+	tristate "AMD CZ support for DA7219 and MAX9835"
+	select SND_SOC_DA7219
+	select SND_SOC_MAX98357A
+	select SND_SOC_ADAU7002
+	depends on SND_SOC_AMD_ACP && I2C
+	help
+	 This option enables machine driver for DA7219 and MAX9835.
+
 config SND_SOC_AMD_CZ_RT5645_MACH
 	tristate "AMD CZ support for RT5645"
 	select SND_SOC_RT5645
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index f07fd2e2870a..79b0622fa5d3 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -1,5 +1,7 @@
 acp_audio_dma-objs := acp-pcm-dma.o
+snd-soc-acp-da7219mx98357-mach-objs := acp-da7219-max98357a.o
 snd-soc-acp-rt5645-mach-objs := acp-rt5645.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP) += acp_audio_dma.o
+obj-$(CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH) += snd-soc-acp-da7219mx98357-mach.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
new file mode 100644
index 000000000000..e51a878890ce
--- /dev/null
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -0,0 +1,246 @@
+/*
+ * Machine driver for AMD ACP Audio engine using DA7219 & MAX98357 codec
+ *
+ * Copyright 2017 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+
+#include "../codecs/da7219.h"
+#include "../codecs/da7219-aad.h"
+
+#define CZ_PLAT_CLK 24000000
+#define MCLK_RATE 24576000
+#define DUAL_CHANNEL		2
+
+static struct snd_soc_jack cz_jack;
+
+static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
+				     CZ_PLAT_CLK, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
+				  CZ_PLAT_CLK, MCLK_RATE);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				&cz_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "HP jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	da7219_aad_jack_det(codec, &cz_jack);
+
+	return 0;
+}
+
+static const unsigned int channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const unsigned int rates[] = {
+	48000,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int cz_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	return 0;
+}
+
+static struct snd_soc_ops cz_da7219_cap_ops = {
+	.startup = cz_fe_startup,
+};
+
+static struct snd_soc_dai_link cz_dai_7219_98357[] = {
+	{
+		.name = "amd-da7219-play",
+		.stream_name = "Playback",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.init = cz_da7219_init,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "amd-da7219-cap",
+		.stream_name = "Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.4.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_capture = 1,
+		.ops = &cz_da7219_cap_ops,
+	},
+	{
+		.name = "amd-max98357-play",
+		.stream_name = "HiFi Playback",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.1.auto",
+		.codec_dai_name = "HiFi",
+		.codec_name = "MX98357A:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "dmic",
+		.stream_name = "DMIC Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "adau7002-hifi",
+		.codec_name = "ADAU7002:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_capture = 1,
+	},
+};
+
+static const struct snd_soc_dapm_widget cz_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route cz_audio_route[] = {
+	{"Headphones", NULL, "HPL"},
+	{"Headphones", NULL, "HPR"},
+	{"MIC", NULL, "Headset Mic"},
+	{"Speakers", NULL, "Speaker"},
+	{"PDM_DAT", NULL, "Int Mic"},
+};
+
+static const struct snd_kcontrol_new cz_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+};
+
+static struct snd_soc_card cz_card = {
+	.name = "acpd7219m98357",
+	.owner = THIS_MODULE,
+	.dai_link = cz_dai_7219_98357,
+	.num_links = ARRAY_SIZE(cz_dai_7219_98357),
+	.dapm_widgets = cz_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cz_widgets),
+	.dapm_routes = cz_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(cz_audio_route),
+	.controls = cz_mc_controls,
+	.num_controls = ARRAY_SIZE(cz_mc_controls),
+};
+
+static int cz_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct snd_soc_card *card;
+
+	card = &cz_card;
+	cz_card.dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
+	if (ret) {
+		dev_err(&pdev->dev,
+				"devm_snd_soc_register_card(%s) failed: %d\n",
+				cz_card.name, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static const struct acpi_device_id cz_audio_acpi_match[] = {
+	{ "AMD7219", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cz_audio_acpi_match);
+
+static struct platform_driver cz_pcm_driver = {
+	.driver = {
+		.name = "cz-da7219-max98357a",
+		.acpi_match_table = ACPI_PTR(cz_audio_acpi_match),
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = cz_probe,
+};
+
+module_platform_driver(cz_pcm_driver);
+
+MODULE_AUTHOR("akshu.agrawal@amd.com");
+MODULE_DESCRIPTION("DA7219 & MAX98357A audio support");
+MODULE_LICENSE("GPL v2");
-- 
2.16.1
