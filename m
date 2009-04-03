From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 5/5] ARM: DaVinci: ASoC: Add machine driver
	support for DM646x
Date: Thu,  2 Apr 2009 21:58:17 -0400
Message-ID: <1238723897-27687-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F07B103882
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:45:45 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n32EjdJ3006944
	for <alsa-devel@alsa-project.org>; Thu, 2 Apr 2009 09:45:44 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

This patch does the following: 
(1) Add support for the DM646x machine 
(2)Introduce the platform driver model to get platform data for all the machines
including dm355 and dm644x.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/davinci/davinci-evm.c |  129 ++++++++++++++++++++++++++++++++-------
 1 files changed, 107 insertions(+), 22 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 9b90b34..b89a322 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -20,11 +20,19 @@
 #include <sound/soc-dapm.h>
 
 #include <asm/dma.h>
-#include <mach/hardware.h>
+#include <asm/mach-types.h>
+
+#include <mach/asp.h>
+#include <mach/edma.h>
+#include <mach/mux.h>
+#include <mach/cpu.h>
+
 
 #include "../codecs/tlv320aic3x.h"
+#include "../codecs/davinci_codec_stubs.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
+#include "davinci-i2s-mcasp.h"
 
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
@@ -39,7 +47,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm())
+	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
@@ -140,6 +148,25 @@ static struct snd_soc_dai_link evm_dai = {
 	.ops = &evm_ops,
 };
 
+static struct snd_soc_dai_link dm6467_evm_dai[] = {
+	{
+		.name = "TLV320AIC3X",
+		.stream_name = "AIC3X",
+		.cpu_dai = davinci_iis_mcasp_dai,
+		.codec_dai = &aic3x_dai,
+		.init = evm_aic3x_init,
+		.ops = &evm_ops,
+	},
+	{
+		.name = "MCASP SPDIF",
+		.stream_name = "spdif",
+		.cpu_dai = &davinci_iis_mcasp_dai[1],
+		.codec_dai = dit_stub_dai,
+		.ops = &evm_ops,
+	},
+};
+
+
 /* davinci-evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
@@ -148,12 +175,27 @@ static struct snd_soc_card snd_soc_card_evm = {
 	.num_links = 1,
 };
 
+/* davinci dm6467 evm audio machine driver */
+static struct snd_soc_card dm6467_snd_soc_card_evm = {
+		.name = "DaVinci DM6467 EVM",
+		.platform = &davinci_soc_platform,
+		.dai_link = dm6467_evm_dai,
+		.num_links = 2,
+};
+
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
 	.i2c_bus = 0,
 	.i2c_address = 0x1b,
 };
 
+/* dm6467 evm audio private data */
+static struct aic3x_setup_data dm6467_evm_aic3x_setup = {
+       .i2c_bus = 1,
+       .i2c_address = 0x18,
+};
+
+
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
 	.card = &snd_soc_card_evm,
@@ -161,36 +203,58 @@ static struct snd_soc_device evm_snd_devdata = {
 	.codec_data = &evm_aic3x_setup,
 };
 
-static struct resource evm_snd_resources[] = {
-	{
-		.start = DAVINCI_MCBSP_BASE,
-		.end = DAVINCI_MCBSP_BASE + SZ_8K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct evm_snd_platform_data evm_snd_data = {
-	.tx_dma_ch	= DM644X_DMACH_MCBSP_TX,
-	.rx_dma_ch	= DM644X_DMACH_MCBSP_RX,
+/* evm audio subsystem */
+static struct snd_soc_device dm6467_evm_snd_devdata = {
+	.card = &dm6467_snd_soc_card_evm,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &dm6467_evm_aic3x_setup,
 };
 
 static struct platform_device *evm_snd_device;
 
-static int __init evm_init(void)
+static int davinci_evm_probe(struct platform_device *pdev)
 {
+	struct resource *resources;
+	struct evm_snd_platform_data *data = pdev->dev.platform_data;
+	struct snd_soc_device *evm_snd_dev_data;
+	int index;
 	int ret;
+	int res_size =  pdev->num_resources;
+
+	if (!data)
+		return -ENODEV;
+
+	resources = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!resources)
+		return -ENODEV;
+
+	if (machine_is_davinci_evm()) {
+		davinci_cfg_reg(DM644X_MCBSP);
+		evm_snd_dev_data = &evm_snd_devdata;
+		index = 0;
+	} else if (machine_is_davinci_dm355_evm()) {
+		/* we don't use ASP1 IRQs, or we'd need to mux them ... */
+		davinci_cfg_reg(DM355_EVT8_ASP1_TX);
+		davinci_cfg_reg(DM355_EVT9_ASP1_RX);
+		evm_snd_dev_data = &evm_snd_devdata;
+		index = 1;
+	} else if (machine_is_davinci_dm6467_evm()) {
+		evm_snd_dev_data = &dm6467_evm_snd_devdata;
+		index = 0;
+	} else
+		return -EINVAL;
 
-	evm_snd_device = platform_device_alloc("soc-audio", 0);
+	evm_snd_device = platform_device_alloc("soc-audio", index);
 	if (!evm_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
-	evm_snd_devdata.dev = &evm_snd_device->dev;
-	platform_device_add_data(evm_snd_device, &evm_snd_data,
-				 sizeof(evm_snd_data));
+       platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
+       evm_snd_dev_data->dev = &evm_snd_device->dev;
+       evm_snd_device->dev.platform_data = data;
+
+       ret = platform_device_add_resources(evm_snd_device,
+			resources, res_size);
 
-	ret = platform_device_add_resources(evm_snd_device, evm_snd_resources,
-					    ARRAY_SIZE(evm_snd_resources));
 	if (ret) {
 		platform_device_put(evm_snd_device);
 		return ret;
@@ -203,11 +267,32 @@ static int __init evm_init(void)
 	return ret;
 }
 
-static void __exit evm_exit(void)
+static int davici_evm_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(evm_snd_device);
+	return 0;
+}
+static struct platform_driver davinci_asoc_driver = {
+	.probe		= davinci_evm_probe,
+	.remove		= davici_evm_remove,
+	.driver		= {
+		.name	= "davinci-asoc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init evm_init(void)
+{
+	return platform_driver_register(&davinci_asoc_driver);
 }
 
+static void __exit evm_exit(void)
+{
+	platform_driver_unregister(&davinci_asoc_driver);
+}
+
+
+
 module_init(evm_init);
 module_exit(evm_exit);
 
-- 
1.5.6
