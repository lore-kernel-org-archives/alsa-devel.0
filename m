From: miguel.aguilar@ridgerun.com
Subject: [PATCH 2/2] ASoC: Davinci: Add audio codec support for
	DM365 EVM
Date: Fri, 28 Aug 2009 13:55:36 -0600
Message-ID: <1251489336-23882-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 38B9910384E
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 21:55:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

1) Enables tlv320aic3101 support on DM365 EVM.
2) Set tlv320aic3x i2c setup into DM365 EVM board file.

This patch was tested on DM365 EVM rev c.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    3 +++
 sound/soc/davinci/Kconfig               |    9 +++++++++
 sound/soc/davinci/Makefile              |    1 +
 sound/soc/davinci/davinci-evm.c         |   29 +++++++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index fd2db78..cff68e1 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -187,6 +187,9 @@ static struct i2c_board_info i2c_info[] = {
 		I2C_BOARD_INFO("24c256", 0x50),
 		.platform_data	= &eeprom_info,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
 };
 
 static struct davinci_i2c_platform_data i2c_pdata = {
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6802dd5..b78b882 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -32,6 +32,15 @@ config  SND_DM6467_SOC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 
+config  SND_DM365_SOC_EVM
+	tristate "SoC Audio support for DaVinci DM365 EVM"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM365_EVM
+	select SND_DAVINCI_SOC_I2S
+	select SND_SOC_TLV320AIC3X
+
+	help
+	  Say Y if you want to add support for SoC audio on TI
+
 config SND_DAVINCI_SOC_SFFSDR
 	tristate "SoC Audio support for SFFSDR"
 	depends on SND_DAVINCI_SOC && MACH_SFFSDR
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 67be54f..8238612 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,4 +13,5 @@ snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DM365_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index f3bb6f6..a859208 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -44,7 +44,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm())
+	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm()
+	    || machine_is_davinci_dm365_evm())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
@@ -179,6 +180,14 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.num_links = ARRAY_SIZE(dm6467_evm_dai),
 };
 
+/* davinci dm365 evm audio machine driver */
+static struct snd_soc_card dm365_snd_soc_card_evm = {
+	.name = "DaVinci DM365 EVM",
+	.platform = &davinci_soc_platform,
+	.dai_link = &evm_dai,
+	.num_links = 1,
+};
+
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
 	.i2c_bus = 1,
@@ -191,6 +200,12 @@ static struct aic3x_setup_data dm6467_evm_aic3x_setup = {
        .i2c_address = 0x18,
 };
 
+/* dm365 evm audio private data */
+static struct aic3x_setup_data dm365_evm_aic3x_setup = {
+       .i2c_bus = 1,
+       .i2c_address = 0x18,
+};
+
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
 	.card = &snd_soc_card_evm,
@@ -198,13 +213,20 @@ static struct snd_soc_device evm_snd_devdata = {
 	.codec_data = &evm_aic3x_setup,
 };
 
-/* evm audio subsystem */
+/* dm6467 evm audio subsystem */
 static struct snd_soc_device dm6467_evm_snd_devdata = {
 	.card = &dm6467_snd_soc_card_evm,
 	.codec_dev = &soc_codec_dev_aic3x,
 	.codec_data = &dm6467_evm_aic3x_setup,
 };
 
+/* dm365 evm audio subsystem */
+static struct snd_soc_device dm365_evm_snd_devdata = {
+	.card = &dm365_snd_soc_card_evm,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &dm365_evm_aic3x_setup,
+};
+
 static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
@@ -222,6 +244,9 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_dm6467_evm()) {
 		evm_snd_dev_data = &dm6467_evm_snd_devdata;
 		index = 0;
+	}else if (machine_is_davinci_dm365_evm()) {
+		evm_snd_dev_data = &dm365_evm_snd_devdata;
+		index = 0;
 	} else
 		return -EINVAL;
 
-- 
1.6.0.4
