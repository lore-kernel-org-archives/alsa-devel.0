From: miguel.aguilar@ridgerun.com
Subject: [PATCH v4 2/2] ASoC: Davinci: Add audio codec support
	for DM365 EVM
Date: Wed,  2 Sep 2009 15:33:59 -0600
Message-ID: <1251927239-3734-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D60024366
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 23:34:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com
Cc: santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This patch enables tlv320aic3101 support on DM365 EVM and
it was tested on DM365 EVM rev c.

Note: this patch was created based on temp/asoc branch.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 sound/soc/davinci/Kconfig       |    4 ++--
 sound/soc/davinci/davinci-evm.c |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 4dfd4ad..047ee39 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -13,9 +13,9 @@ config SND_DAVINCI_SOC_MCASP
 	tristate
 
 config SND_DAVINCI_SOC_EVM
-	tristate "SoC Audio support for DaVinci DM6446 or DM355 EVM"
+	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM
+	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM  || MACH_DAVINCI_DM365_EVM
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_TLV320AIC3X
 	help
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 67414f6..7ccbe66 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -45,7 +45,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm())
+	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm() ||
+	    machine_is_davinci_dm365_evm())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
@@ -176,7 +177,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.ops = &evm_ops,
 };
 
-/* davinci-evm audio machine driver */
+/* davinci dm6446, dm355 or dm365 evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
 	.platform = &davinci_soc_platform,
@@ -243,7 +244,7 @@ static int __init evm_init(void)
 	int index;
 	int ret;
 
-	if (machine_is_davinci_evm()) {
+	if (machine_is_davinci_evm() || machine_is_davinci_dm365_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
-- 
1.6.0.4
