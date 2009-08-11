From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: Add audio support fot
	DA850/OMAP-L138 EVM
Date: Tue, 11 Aug 2009 16:59:21 -0400
Message-ID: <1250024361-26923-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 06E67103957
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 13:30:26 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

There is one instance of McASP on DA850/OMAP-L138 SoC. This is
connected to TLV320AIC3106 codec for audio playback and capture.
This patch adds audio support on this platform. Some of the
structure prefix names which are common for DA830/OMAP-L137 EVM and
DA850/OMAP-L138 EVM have been renamed to da8xx from da830.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/Kconfig       |   13 +++++++++++--
 sound/soc/davinci/Makefile      |    1 +
 sound/soc/davinci/davinci-evm.c |   29 +++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 677a538..4dfd4ad 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -43,12 +43,21 @@ config SND_DAVINCI_SOC_SFFSDR
 	  Lyrtech SFFSDR board.
 
 config  SND_DA830_SOC_EVM
-	tristate "SoC Audio support for DA830/OMAPL137 EVM"
+	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA830_EVM
 	select SND_DAVINCI_SOC_MCASP
 	select SND_SOC_TLV320AIC3X
 
 	help
 	  Say Y if you want to add support for SoC audio on TI
-	  DA830/OMAPL137 EVM
+	  DA830/OMAP-L137 EVM
+
+config  SND_DA850_SOC_EVM
+	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
+	select SND_DAVINCI_SOC_MCASP
+	select SND_SOC_TLV320AIC3X
+	help
+	  Say Y if you want to add support for SoC audio on TI
+	  DA850/OMAP-L138 EVM
 
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 5e2195f..a6939d7 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -14,4 +14,5 @@ snd-soc-sffsdr-objs := davinci-sffsdr.o
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index a5a9212..46c1b0c 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -54,7 +54,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	else if (machine_is_davinci_evm())
 		sysclk = 12288000;
 
-	else if (machine_is_davinci_da830_evm())
+	else if (machine_is_davinci_da830_evm() ||
+				machine_is_davinci_da850_evm())
 		sysclk = 24576000;
 
 	else
@@ -165,7 +166,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.ops = &evm_ops,
 	},
 };
-static struct snd_soc_dai_link da830_evm_dai = {
+static struct snd_soc_dai_link da8xx_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
 	.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
@@ -191,8 +192,15 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 };
 
 static struct snd_soc_card da830_snd_soc_card = {
-	.name = "DA830 EVM",
-	.dai_link = &da830_evm_dai,
+	.name = "DA830/OMAP-L137 EVM",
+	.dai_link = &da8xx_evm_dai,
+	.platform = &davinci_soc_platform,
+	.num_links = 1,
+};
+
+static struct snd_soc_card da850_snd_soc_card = {
+	.name = "DA850/OMAP-L138 EVM",
+	.dai_link = &da8xx_evm_dai,
 	.platform = &davinci_soc_platform,
 	.num_links = 1,
 };
@@ -209,7 +217,7 @@ static struct aic3x_setup_data dm6467_evm_aic3x_setup = {
        .i2c_address = 0x18,
 };
 
-static struct aic3x_setup_data da830_evm_aic3x_setup = {
+static struct aic3x_setup_data da8xx_evm_aic3x_setup = {
 	.i2c_bus = 1,
 	.i2c_address = 0x18,
 };
@@ -232,7 +240,13 @@ static struct snd_soc_device dm6467_evm_snd_devdata = {
 static struct snd_soc_device da830_evm_snd_devdata = {
 	.card = &da830_snd_soc_card,
 	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &da830_evm_aic3x_setup,
+	.codec_data = &da8xx_evm_aic3x_setup,
+};
+
+static struct snd_soc_device da850_evm_snd_devdata = {
+	.card		= &da850_snd_soc_card,
+	.codec_dev	= &soc_codec_dev_aic3x,
+	.codec_data	= &da8xx_evm_aic3x_setup,
 };
 
 static struct platform_device *evm_snd_device;
@@ -255,6 +269,9 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_da830_evm()) {
 		evm_snd_dev_data = &da830_evm_snd_devdata;
 		index = 1;
+	} else if (machine_is_davinci_da850_evm()) {
+		evm_snd_dev_data = &da850_evm_snd_devdata;
+		index = 0;
 	} else
 		return -EINVAL;
 
-- 
1.5.6
