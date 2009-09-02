From: miguel.aguilar@ridgerun.com
Subject: [PATCH v3 2/2] ASoC: Davinci: Add audio codec support
	for DM365 EVM
Date: Wed,  2 Sep 2009 09:15:14 -0600
Message-ID: <1251904514-7661-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id B09332463C
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 17:15:17 +0200 (CEST)
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
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, nsnehaprabha@ti.com
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This patch enables tlv320aic3101 support on DM365 EVM and
it was tested on DM365 EVM rev c.

Note: this patch was created based on temp/asoc branch.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 sound/soc/davinci/Kconfig       |    8 ++++++++
 sound/soc/davinci/Makefile      |    1 +
 sound/soc/davinci/davinci-evm.c |   21 ++++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 4dfd4ad..0bf835b 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -22,6 +22,14 @@ config SND_DAVINCI_SOC_EVM
 	  Say Y if you want to add support for SoC audio on TI
 	  DaVinci DM6446 or DM355 EVM platforms.
 
+config  SND_DM365_SOC_EVM
+	tristate "SoC Audio support for DaVinci DM365 EVM"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM365_EVM
+	select SND_DAVINCI_SOC_I2S
+	select SND_SOC_TLV320AIC3X
+	help
+	  Say Y if you want to add support for SoC audio on TI
+
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a6939d7..21a8e64 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -12,6 +12,7 @@ snd-soc-evm-objs := davinci-evm.o
 snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DM365_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 67414f6..d636d1a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -45,7 +45,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm())
+	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm()
+	    || machine_is_davinci_dm365_evm())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
@@ -184,6 +185,14 @@ static struct snd_soc_card snd_soc_card_evm = {
 	.num_links = 1,
 };
 
+/* davinci dm365 evm audio machine driver */
+static struct snd_soc_card dm365_snd_soc_card_evm = {
+	.name = "DaVinci DM365 EVM",
+	.platform = &davinci_soc_platform,
+	.dai_link = &evm_dai,
+	.num_links = 1,
+};
+
 /* davinci dm6467 evm audio machine driver */
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
@@ -216,6 +225,13 @@ static struct snd_soc_device evm_snd_devdata = {
 };
 
 /* evm audio subsystem */
+static struct snd_soc_device dm365_evm_snd_devdata = {
+	.card = &dm365_snd_soc_card_evm,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &aic3x_setup,
+};
+
+/* evm audio subsystem */
 static struct snd_soc_device dm6467_evm_snd_devdata = {
 	.card = &dm6467_snd_soc_card_evm,
 	.codec_dev = &soc_codec_dev_aic3x,
@@ -249,6 +265,9 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_dm355_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 1;
+	} else if (machine_is_davinci_dm365_evm()) {
+		evm_snd_dev_data = &dm365_evm_snd_devdata;
+		index = 0;
 	} else if (machine_is_davinci_dm6467_evm()) {
 		evm_snd_dev_data = &dm6467_evm_snd_devdata;
 		index = 0;
-- 
1.6.0.4
