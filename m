From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v4 4/4] ARM: DaVinci: ASoC: Add machine driver
	support for DM646x
Date: Fri,  5 Jun 2009 06:28:49 -0400
Message-ID: <1244197729-31032-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 0331910395D
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 13:07:31 +0200 (CEST)
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Steve Chen <schen@mvista.com>, Naresh Medisetty <naresh@ti.com>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

This patch does the following:
(1) Add support for the DM646x machine
(2) Modifications required to introduce the platform driver model to get
platform data for all the machines including dm355 and dm644x.

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch applies against ALSA mainline - the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/davinci/davinci-evm.c |  102 ++++++++++++++++++--------------------
 1 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 58fd1cb..f3bb6f6 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -27,9 +27,10 @@
 #include <mach/mux.h>
 
 #include "../codecs/tlv320aic3x.h"
+#include "../codecs/spdif_transciever.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
-
+#include "davinci-mcasp.h"
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
 		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
@@ -43,7 +44,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm())
+	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
@@ -144,6 +145,24 @@ static struct snd_soc_dai_link evm_dai = {
 	.ops = &evm_ops,
 };
 
+static struct snd_soc_dai_link dm6467_evm_dai[] = {
+	{
+		.name = "TLV320AIC3X",
+		.stream_name = "AIC3X",
+		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+		.codec_dai = &aic3x_dai,
+		.init = evm_aic3x_init,
+		.ops = &evm_ops,
+	},
+	{
+		.name = "McASP",
+		.stream_name = "spdif",
+		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
+		.codec_dai = &dit_stub_dai,
+		.ops = &evm_ops,
+	},
+};
+
 /* davinci-evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
@@ -152,12 +171,26 @@ static struct snd_soc_card snd_soc_card_evm = {
 	.num_links = 1,
 };
 
+/* davinci dm6467 evm audio machine driver */
+static struct snd_soc_card dm6467_snd_soc_card_evm = {
+	.name = "DaVinci DM6467 EVM",
+	.platform = &davinci_soc_platform,
+	.dai_link = dm6467_evm_dai,
+	.num_links = ARRAY_SIZE(dm6467_evm_dai),
+};
+
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
 	.i2c_bus = 1,
 	.i2c_address = 0x1b,
 };
 
+/* dm6467 evm audio private data */
+static struct aic3x_setup_data dm6467_evm_aic3x_setup = {
+       .i2c_bus = 1,
+       .i2c_address = 0x18,
+};
+
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
 	.card = &snd_soc_card_evm,
@@ -165,60 +198,30 @@ static struct snd_soc_device evm_snd_devdata = {
 	.codec_data = &evm_aic3x_setup,
 };
 
-/* DM6446 EVM uses ASP0; line-out is a pair of RCA jacks */
-static struct resource evm_snd_resources[] = {
-	{
-		.start = DAVINCI_ASP0_BASE,
-		.end = DAVINCI_ASP0_BASE + SZ_8K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct evm_snd_platform_data evm_snd_data = {
-	.tx_dma_ch	= DAVINCI_DMA_ASP0_TX,
-	.rx_dma_ch	= DAVINCI_DMA_ASP0_RX,
-};
-
-/* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
-static struct resource dm335evm_snd_resources[] = {
-	{
-		.start = DAVINCI_ASP1_BASE,
-		.end = DAVINCI_ASP1_BASE + SZ_8K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct evm_snd_platform_data dm335evm_snd_data = {
-	.tx_dma_ch	= DAVINCI_DMA_ASP1_TX,
-	.rx_dma_ch	= DAVINCI_DMA_ASP1_RX,
+/* evm audio subsystem */
+static struct snd_soc_device dm6467_evm_snd_devdata = {
+	.card = &dm6467_snd_soc_card_evm,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &dm6467_evm_aic3x_setup,
 };
 
 static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
 {
-	struct resource *resources;
-	unsigned num_resources;
-	struct evm_snd_platform_data *data;
+	struct snd_soc_device *evm_snd_dev_data;
 	int index;
 	int ret;
 
 	if (machine_is_davinci_evm()) {
-		davinci_cfg_reg(DM644X_MCBSP);
-
-		resources = evm_snd_resources;
-		num_resources = ARRAY_SIZE(evm_snd_resources);
-		data = &evm_snd_data;
+		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
-		/* we don't use ASP1 IRQs, or we'd need to mux them ... */
-		davinci_cfg_reg(DM355_EVT8_ASP1_TX);
-		davinci_cfg_reg(DM355_EVT9_ASP1_RX);
-
-		resources = dm335evm_snd_resources;
-		num_resources = ARRAY_SIZE(dm335evm_snd_resources);
-		data = &dm335evm_snd_data;
+		evm_snd_dev_data = &evm_snd_devdata;
 		index = 1;
+	} else if (machine_is_davinci_dm6467_evm()) {
+		evm_snd_dev_data = &dm6467_evm_snd_devdata;
+		index = 0;
 	} else
 		return -EINVAL;
 
@@ -226,17 +229,8 @@ static int __init evm_init(void)
 	if (!evm_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
-	evm_snd_devdata.dev = &evm_snd_device->dev;
-	platform_device_add_data(evm_snd_device, data, sizeof(*data));
-
-	ret = platform_device_add_resources(evm_snd_device, resources,
-			num_resources);
-	if (ret) {
-		platform_device_put(evm_snd_device);
-		return ret;
-	}
-
+	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
+	evm_snd_dev_data->dev = &evm_snd_device->dev;
 	ret = platform_device_add(evm_snd_device);
 	if (ret)
 		platform_device_put(evm_snd_device);
-- 
1.5.6
