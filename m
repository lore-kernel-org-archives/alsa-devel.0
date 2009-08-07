From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH 2/2] ASoC: DaVinci: Support Audio on DA830 EVM
Date: Fri,  7 Aug 2009 10:07:51 -0400
Message-ID: <1249654071-23665-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F6F52448F
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 06:37:47 +0200 (CEST)
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

Add support for audio on DA830 EVM- here McASP1 is interfaced to 
TLV320AIC3106 codec.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/Kconfig       |   11 +++++++++++
 sound/soc/davinci/Makefile      |    1 +
 sound/soc/davinci/davinci-evm.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6802dd5..677a538 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -41,3 +41,14 @@ config SND_DAVINCI_SOC_SFFSDR
 	help
 	  Say Y if you want to add support for SoC audio on
 	  Lyrtech SFFSDR board.
+
+config  SND_DA830_SOC_EVM
+	tristate "SoC Audio support for DA830/OMAPL137 EVM"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA830_EVM
+	select SND_DAVINCI_SOC_MCASP
+	select SND_SOC_TLV320AIC3X
+
+	help
+	  Say Y if you want to add support for SoC audio on TI
+	  DA830/OMAPL137 EVM
+
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 67be54f..5e2195f 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,4 +13,5 @@ snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index f3bb6f6..a5a9212 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -54,6 +54,9 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	else if (machine_is_davinci_evm())
 		sysclk = 12288000;
 
+	else if (machine_is_davinci_da830_evm())
+		sysclk = 24576000;
+
 	else
 		return -EINVAL;
 
@@ -162,6 +165,14 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.ops = &evm_ops,
 	},
 };
+static struct snd_soc_dai_link da830_evm_dai = {
+	.name = "TLV320AIC3X",
+	.stream_name = "AIC3X",
+	.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+	.codec_dai = &aic3x_dai,
+	.init = evm_aic3x_init,
+	.ops = &evm_ops,
+};
 
 /* davinci-evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
@@ -179,6 +190,13 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.num_links = ARRAY_SIZE(dm6467_evm_dai),
 };
 
+static struct snd_soc_card da830_snd_soc_card = {
+	.name = "DA830 EVM",
+	.dai_link = &da830_evm_dai,
+	.platform = &davinci_soc_platform,
+	.num_links = 1,
+};
+
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
 	.i2c_bus = 1,
@@ -191,6 +209,11 @@ static struct aic3x_setup_data dm6467_evm_aic3x_setup = {
        .i2c_address = 0x18,
 };
 
+static struct aic3x_setup_data da830_evm_aic3x_setup = {
+	.i2c_bus = 1,
+	.i2c_address = 0x18,
+};
+
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
 	.card = &snd_soc_card_evm,
@@ -205,6 +228,13 @@ static struct snd_soc_device dm6467_evm_snd_devdata = {
 	.codec_data = &dm6467_evm_aic3x_setup,
 };
 
+/* evm audio subsystem */
+static struct snd_soc_device da830_evm_snd_devdata = {
+	.card = &da830_snd_soc_card,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &da830_evm_aic3x_setup,
+};
+
 static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
@@ -222,6 +252,9 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_dm6467_evm()) {
 		evm_snd_dev_data = &dm6467_evm_snd_devdata;
 		index = 0;
+	} else if (machine_is_davinci_da830_evm()) {
+		evm_snd_dev_data = &da830_evm_snd_devdata;
+		index = 1;
 	} else
 		return -EINVAL;
 
-- 
1.5.6
