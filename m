From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC driver
	support for TI DM646X EVM platform
Date: Mon, 16 Mar 2009 08:02:25 -0400
Message-ID: <1237204945-30039-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B5B5E103804
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:19:40 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCJY50027750
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:19:39 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds ASoC driver support for TI DM646X EVM platform

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies to the DaVinci git tree available at http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=commit;h=486afa37130356662213cc1a2199a285b4fd72af.

 sound/soc/davinci/davinci-evm.c |  131 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 95c44bf..9e832c9 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -25,10 +25,15 @@
 #include <mach/asp.h>
 #include <mach/edma.h>
 #include <mach/mux.h>
+#include <mach/cpu.h>
+
 
 #include "../codecs/tlv320aic3x.h"
+#include "../codecs/codec_stubs.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
+#include "davinci-i2s-mcasp.h"
+
 
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
@@ -43,14 +48,14 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk;
 
 	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm())
+	if (cpu_is_davinci_dm355() || cpu_is_davinci_dm646x())
 		sysclk = 27000000;
 
 	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
 	 * board-dm644x-evm.c using GPIOs from U18.  There are six
 	 * options; here we "know" we use a 48 KHz sample rate.
 	 */
-	else if (machine_is_davinci_evm())
+	else if (cpu_is_davinci_dm644x())
 		sysclk = 12288000;
 
 	else
@@ -144,6 +149,25 @@ static struct snd_soc_dai_link evm_dai = {
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
@@ -152,12 +176,27 @@ static struct snd_soc_card snd_soc_card_evm = {
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
 	.i2c_bus = 1,
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
@@ -165,6 +204,14 @@ static struct snd_soc_device evm_snd_devdata = {
 	.codec_data = &evm_aic3x_setup,
 };
 
+/* evm audio subsystem */
+static struct snd_soc_device dm6467_evm_snd_devdata = {
+		.card = &dm6467_snd_soc_card_evm,
+       .codec_dev = &soc_codec_dev_aic3x,
+       .codec_data = &dm6467_evm_aic3x_setup,
+};
+
+
 /* DM6446 EVM uses ASP0; line-out is a pair of RCA jacks */
 static struct resource evm_snd_resources[] = {
 	{
@@ -174,11 +221,64 @@ static struct resource evm_snd_resources[] = {
 	},
 };
 
+static struct resource dm6467_evm_snd_resources[] = {
+	{
+		.start = DAVINCI_DM646X_MCASP0_REG_BASE,
+		.end = DAVINCI_DM646X_MCASP0_REG_BASE + (SZ_1K << 1) - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = DAVINCI_DM646X_MCASP1_REG_BASE,
+		.end = DAVINCI_DM646X_MCASP1_REG_BASE + (SZ_1K << 1) - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+
+static u8 dm6467_iis_serializer_direction[] = {
+       TX_MODE, RX_MODE, INACTIVE_MODE, INACTIVE_MODE,
+};
+
+static u8 dm6467_dit_serializer_direction[] = {
+       TX_MODE, INACTIVE_MODE, INACTIVE_MODE, INACTIVE_MODE,
+};
+
+
 static struct evm_snd_platform_data evm_snd_data = {
 	.tx_dma_ch	= DAVINCI_DMA_ASP0_TX,
 	.rx_dma_ch	= DAVINCI_DMA_ASP0_RX,
 };
 
+static struct evm_snd_platform_data dm6467_evm_snd_data[] = {
+	{
+		.clk_name       = "McASPCLK0",
+		.tx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
+		.rx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AREVT0,
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0x400,
+		.op_mode        = DAVINCI_MCASP_IIS_MODE,
+		.num_serializer = 4,
+		.tdm_slots      = 2,
+		.serial_dir     = dm6467_iis_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+		.codec_fmt      = SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF,
+	},
+	{
+		.clk_name       = "McASPCLK1",
+		.tx_dma_ch      = DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
+		.rx_dma_ch      = -1,
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0,
+		.op_mode        = DAVINCI_MCASP_DIT_MODE,
+		.num_serializer = 4,
+		.tdm_slots      = 32,
+		.serial_dir     = dm6467_dit_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+		.codec_fmt      = SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF,
+	},
+};
+
+
 /* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
 static struct resource dm335evm_snd_resources[] = {
 	{
@@ -199,23 +299,33 @@ static int __init evm_init(void)
 {
 	struct resource *resources;
 	struct evm_snd_platform_data *data;
+	struct snd_soc_device *evm_snd_dev_data;
 	int index;
 	int ret;
+	int res_size;
 
-	if (machine_is_davinci_evm()) {
+	if (cpu_is_davinci_dm644x()) {
 		davinci_cfg_reg(DM644X_MCBSP);
-
+		evm_snd_dev_data = &evm_snd_devdata;
 		resources = evm_snd_resources;
 		data = &evm_snd_data;
+		res_size = ARRAY_SIZE(evm_snd_resources);
 		index = 0;
-	} else if (machine_is_davinci_dm355_evm()) {
+	} else if (cpu_is_davinci_dm355()) {
 		/* we don't use ASP1 IRQs, or we'd need to mux them ... */
 		davinci_cfg_reg(DM355_EVT8_ASP1_TX);
 		davinci_cfg_reg(DM355_EVT9_ASP1_RX);
-
+		evm_snd_dev_data = &evm_snd_devdata;
 		resources = dm335evm_snd_resources;
+		res_size = ARRAY_SIZE(dm335evm_snd_resources);
 		data = &dm335evm_snd_data;
 		index = 1;
+	} else if (cpu_is_davinci_dm646x()) {
+		evm_snd_dev_data = &dm6467_evm_snd_devdata;
+		resources = dm6467_evm_snd_resources;
+		res_size = ARRAY_SIZE(dm6467_evm_snd_resources);
+		data = dm6467_evm_snd_data;
+		index = 0;
 	} else
 		return -EINVAL;
 
@@ -223,11 +333,12 @@ static int __init evm_init(void)
 	if (!evm_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
-	evm_snd_devdata.dev = &evm_snd_device->dev;
-	platform_device_add_data(evm_snd_device, data, sizeof(data));
+	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
+	evm_snd_dev_data->dev = &evm_snd_device->dev;
+	evm_snd_device->dev.platform_data = data;
 
-	ret = platform_device_add_resources(evm_snd_device, resources, 1);
+	ret = platform_device_add_resources(evm_snd_device,
+			resources, res_size);
 	if (ret) {
 		platform_device_put(evm_snd_device);
 		return ret;
-- 
1.5.6
