From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 03/14] ASoC: multi-component - TI DaVinci
	Platform
Date: Wed, 11 Aug 2010 09:46:22 +0100
Message-ID: <1281516393-6060-4-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0190C103870
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:46:54 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2779440wwa.20
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:46:54 -0700 (PDT)
In-Reply-To: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the TI DaVinci platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Added ASoC DMA platform device.
 o EVM now has 2 DAI links instead of #ifdef around CODEC choice.
 o aic3x_setup data is now platform data.

CC: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-davinci/da830.c         |    6 +-
 arch/arm/mach-davinci/da850.c         |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c |    4 +-
 arch/arm/mach-davinci/devices.c       |   13 ++++
 arch/arm/mach-davinci/dm355.c         |    6 +-
 arch/arm/mach-davinci/dm365.c         |    4 +-
 arch/arm/mach-davinci/dm644x.c        |    4 +-
 arch/arm/mach-davinci/dm646x.c        |    8 +-
 sound/soc/davinci/davinci-evm.c       |  109 +++++++++++----------------------
 sound/soc/davinci/davinci-i2s.c       |   44 ++++++-------
 sound/soc/davinci/davinci-i2s.h       |    2 -
 sound/soc/davinci/davinci-mcasp.c     |   34 ++++------
 sound/soc/davinci/davinci-mcasp.h     |    2 -
 sound/soc/davinci/davinci-pcm.c       |   45 ++++++++++----
 sound/soc/davinci/davinci-pcm.h       |    3 -
 sound/soc/davinci/davinci-sffsdr.c    |   27 +++++----
 sound/soc/davinci/davinci-vcif.c      |   25 +++----
 sound/soc/davinci/davinci-vcif.h      |   28 ---------
 18 files changed, 159 insertions(+), 207 deletions(-)
 delete mode 100644 sound/soc/davinci/davinci-vcif.h

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 23e9eda..d2eb4fe 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -408,9 +408,9 @@ static struct clk_lookup da830_clks[] = {
 	CLK("eqep.0",		NULL,		&eqep0_clk),
 	CLK("eqep.1",		NULL,		&eqep1_clk),
 	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
-	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
-	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
+	CLK("davinci-mcasp-dai.0",	NULL,		&mcasp0_clk),
+	CLK("davinci-mcasp-dai.1",	NULL,		&mcasp1_clk),
+	CLK("davinci-mcasp-dai.2",	NULL,		&mcasp2_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6b8331b..e5b273d 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -373,7 +373,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
+	CLK("davinci-mcasp-dai.0",	NULL,		&mcasp_clk),
 	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
 	CLK("davinci_mmc.0",	NULL,		&mmcsd_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 8cda729..7cfed10 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -412,7 +412,7 @@ static struct resource da830_mcasp1_resources[] = {
 };
 
 static struct platform_device da830_mcasp1_device = {
-	.name		= "davinci-mcasp",
+	.name		= "davinci-mcasp-dai",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(da830_mcasp1_resources),
 	.resource	= da830_mcasp1_resources,
@@ -440,7 +440,7 @@ static struct resource da850_mcasp_resources[] = {
 };
 
 static struct platform_device da850_mcasp_device = {
-	.name		= "davinci-mcasp",
+	.name		= "davinci-mcasp-dai",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(da850_mcasp_resources),
 	.resource	= da850_mcasp_resources,
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 8b7201e..de40e9c 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -295,6 +295,18 @@ static void davinci_init_wdt(void)
 
 /*-------------------------------------------------------------------------*/
 
+struct platform_device davinci_pcm_device = {
+	.name		= "davinci-pcm-audio",
+	.id		= -1,
+};
+
+static void davinci_init_pcm(void)
+{
+	platform_device_register(&davinci_pcm_device);
+}
+
+/*-------------------------------------------------------------------------*/
+
 struct davinci_timer_instance davinci_timer_instance[2] = {
 	{
 		.base		= DAVINCI_TIMER0_BASE,
@@ -315,6 +327,7 @@ static int __init davinci_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	davinci_init_pcm();
 	davinci_init_wdt();
 
 	return 0;
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 3834781..479ad90 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -359,8 +359,8 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "uart1", &uart1_clk),
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci-asp.0", NULL, &asp0_clk),
-	CLK("davinci-asp.1", NULL, &asp1_clk),
+	CLK("davinci-asp-dai.0", NULL, &asp0_clk),
+	CLK("davinci-asp-dai.1", NULL, &asp1_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
 	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
 	CLK("spi_davinci.0", NULL, &spi0_clk),
@@ -662,7 +662,7 @@ static struct resource dm355_asp1_resources[] = {
 };
 
 static struct platform_device dm355_asp1_device = {
-	.name		= "davinci-asp",
+	.name		= "davinci-asp-dai",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(dm355_asp1_resources),
 	.resource	= dm355_asp1_resources,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a146849..3b457cb 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -459,7 +459,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
-	CLK("davinci-asp.0", NULL, &asp0_clk),
+	CLK("davinci-asp-dai.0", NULL, &asp0_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
@@ -906,7 +906,7 @@ static struct resource dm365_asp_resources[] = {
 };
 
 static struct platform_device dm365_asp_device = {
-	.name		= "davinci-asp",
+	.name		= "davinci-asp-dai",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(dm365_asp_resources),
 	.resource	= dm365_asp_resources,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 7ad1520..1a0f557 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -302,7 +302,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("davinci-asp", NULL, &asp_clk),
+	CLK("davinci-asp-dai", NULL, &asp_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
 	CLK(NULL, "gpio", &gpio_clk),
@@ -564,7 +564,7 @@ static struct resource dm644x_asp_resources[] = {
 };
 
 static struct platform_device dm644x_asp_device = {
-	.name		= "davinci-asp",
+	.name		= "davinci-asp-dai",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(dm644x_asp_resources),
 	.resource	= dm644x_asp_resources,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 9404565..d04457c 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -339,8 +339,8 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK(NULL, "gpio", &gpio_clk),
-	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
-	CLK("davinci-mcasp.1", NULL, &mcasp1_clk),
+	CLK("davinci-mcasp-dai.0", NULL, &mcasp0_clk),
+	CLK("davinci-mcasp-dai.1", NULL, &mcasp1_clk),
 	CLK(NULL, "aemif", &aemif_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK(NULL, "pwm0", &pwm0_clk),
@@ -635,14 +635,14 @@ static struct resource dm646x_mcasp1_resources[] = {
 };
 
 static struct platform_device dm646x_mcasp0_device = {
-	.name		= "davinci-mcasp",
+	.name		= "davinci-mcasp-dai",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(dm646x_mcasp0_resources),
 	.resource	= dm646x_mcasp0_resources,
 };
 
 static struct platform_device dm646x_mcasp1_device = {
-	.name		= "davinci-mcasp",
+	.name		= "davinci-mcasp-dai",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(dm646x_mcasp1_resources),
 	.resource	= dm646x_mcasp1_resources,
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 97f74d6..3d6b5b6 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,12 +28,9 @@
 #include <mach/mux.h>
 
 #include "../codecs/tlv320aic3x.h"
-#include "../codecs/cq93vc.h"
-#include "../codecs/spdif_transciever.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 #include "davinci-mcasp.h"
-#include "davinci-vcif.h"
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
 		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
@@ -41,8 +38,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 	unsigned sysclk;
 
@@ -87,7 +84,7 @@ static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	/* set cpu DAI configuration */
 	return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
@@ -132,8 +129,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 };
 
 /* Logic for a aic3x as connected on a davinci-evm */
-static int evm_aic3x_init(struct snd_soc_codec *codec)
+static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add davinci-evm specific widgets */
 	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
@@ -161,8 +160,10 @@ static int evm_aic3x_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_name = "davinci-mcasp-dai.0",
+	.codec_dai_name = "tlv320aic3x-hifi",
+	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -171,40 +172,49 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_name = "davinci-i2s-dai",
+	.codec_dai_name = "tlv320aic3x-hifi",
 	.init = evm_aic3x_init,
+	.codec_name = "tlv320aic3x-codec.0-0x1a",
 	.ops = &evm_ops,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
-	.cpu_dai = &davinci_vcif_dai,
-	.codec_dai = &cq93vc_dai,
+	.cpu_dai_name = "davinci-vcif-dai",
+	.codec_dai_name = "cq93vc-hifi",
+	.codec_name = "cq93vc-codec",
 #endif
+	.platform_name = "davinci-pcm-audio",
 };
 
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
 		.stream_name = "AIC3X",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-		.codec_dai = &aic3x_dai,
+		.cpu_dai_name= "davinci-mcasp-dai.0",
+		.codec_dai_name = "tlv320aic3x-hifi",
+		.platform_name ="davinci-pcm-audio",
+		.codec_name = "tlv320aic3x-codec.0-0x1a",
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
 	},
 	{
 		.name = "McASP",
 		.stream_name = "spdif",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
-		.codec_dai = &dit_stub_dai,
+		.cpu_dai_name= "davinci-mcasp-dai.1",
+		.codec_dai_name = "dit-hifi",
+		.codec_name = "spdif_dit",
+		.platform_name = "davinci-pcm-audio",
 		.ops = &evm_spdif_ops,
 	},
 };
 static struct snd_soc_dai_link da8xx_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_name= "davinci-mcasp-dai.0",
+	.codec_dai_name = "tlv320aic3x-hifi",
+	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -212,7 +222,6 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 /* davinci dm6446, dm355 evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = &evm_dai,
 	.num_links = 1,
 };
@@ -220,16 +229,13 @@ static struct snd_soc_card snd_soc_card_evm = {
 /* davinci dm365 evm audio machine driver */
 static struct snd_soc_card dm365_snd_soc_card_evm = {
 	.name = "DaVinci DM365 EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = &dm365_evm_dai,
 	.num_links = 1,
 };
 
-
 /* davinci dm6467 evm audio machine driver */
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = dm6467_evm_dai,
 	.num_links = ARRAY_SIZE(dm6467_evm_dai),
 };
@@ -237,82 +243,40 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 static struct snd_soc_card da830_snd_soc_card = {
 	.name = "DA830/OMAP-L137 EVM",
 	.dai_link = &da8xx_evm_dai,
-	.platform = &davinci_soc_platform,
 	.num_links = 1,
 };
 
 static struct snd_soc_card da850_snd_soc_card = {
 	.name = "DA850/OMAP-L138 EVM",
 	.dai_link = &da8xx_evm_dai,
-	.platform = &davinci_soc_platform,
 	.num_links = 1,
 };
 
-static struct aic3x_setup_data aic3x_setup;
-
-/* evm audio subsystem */
-static struct snd_soc_device evm_snd_devdata = {
-	.card = &snd_soc_card_evm,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device dm365_evm_snd_devdata = {
-	.card = &dm365_snd_soc_card_evm,
-#ifdef CONFIG_SND_DM365_AIC3X_CODEC
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
-	.codec_dev = &soc_codec_dev_cq93vc,
-#endif
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device dm6467_evm_snd_devdata = {
-	.card = &dm6467_snd_soc_card_evm,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device da830_evm_snd_devdata = {
-	.card = &da830_snd_soc_card,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-static struct snd_soc_device da850_evm_snd_devdata = {
-	.card		= &da850_snd_soc_card,
-	.codec_dev	= &soc_codec_dev_aic3x,
-	.codec_data	= &aic3x_setup,
-};
-
 static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
 {
-	struct snd_soc_device *evm_snd_dev_data;
+	struct snd_soc_card *evm_snd_dev_data;
 	int index;
 	int ret;
 
 	if (machine_is_davinci_evm()) {
-		evm_snd_dev_data = &evm_snd_devdata;
+		evm_snd_dev_data = &snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
-		evm_snd_dev_data = &evm_snd_devdata;
+		evm_snd_dev_data = &snd_soc_card_evm;
 		index = 1;
 	} else if (machine_is_davinci_dm365_evm()) {
-		evm_snd_dev_data = &dm365_evm_snd_devdata;
+		evm_snd_dev_data = &dm365_snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_dm6467_evm()) {
-		evm_snd_dev_data = &dm6467_evm_snd_devdata;
+		evm_snd_dev_data = &dm6467_snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_da830_evm()) {
-		evm_snd_dev_data = &da830_evm_snd_devdata;
+		evm_snd_dev_data = &da830_snd_soc_card;
 		index = 1;
 	} else if (machine_is_davinci_da850_evm()) {
-		evm_snd_dev_data = &da850_evm_snd_devdata;
+		evm_snd_dev_data = &da850_snd_soc_card;
 		index = 0;
 	} else
 		return -EINVAL;
@@ -322,7 +286,6 @@ static int __init evm_init(void)
 		return -ENOMEM;
 
 	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
-	evm_snd_dev_data->dev = &evm_snd_device->dev;
 	ret = platform_device_add(evm_snd_device);
 	if (ret)
 		platform_device_put(evm_snd_device);
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 9e8932a..3eadcfd 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -183,8 +183,7 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_platform *platform = socdev->card->platform;
+	struct snd_soc_platform *platform = rtd->platform;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
@@ -205,8 +204,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 	if (playback) {
 		/* Stop the DMA to avoid data loss */
 		/* while the transmitter is out of reset to handle XSYNCERR */
-		if (platform->pcm_ops->trigger) {
-			int ret = platform->pcm_ops->trigger(substream,
+		if (platform->driver->ops->trigger) {
+			int ret = platform->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_STOP);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA stop failed\n");
@@ -227,8 +226,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		toggle_clock(dev, playback);
 
 		/* Restart the DMA */
-		if (platform->pcm_ops->trigger) {
-			int ret = platform->pcm_ops->trigger(substream,
+		if (platform->driver->ops->trigger) {
+			int ret = platform->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_START);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
@@ -263,7 +262,7 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				   unsigned int fmt)
 {
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int pcr;
 	unsigned int srgr;
 	/* Attention srgr is updated by hw_params! */
@@ -404,7 +403,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				int div_id, int div)
 {
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 
 	if (div_id != DAVINCI_MCBSP_CLKGDV)
 		return -ENODEV;
@@ -417,7 +416,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&dev->dma_params[substream->stream];
 	struct snd_interval *i = NULL;
@@ -427,6 +426,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
 
+	dai->capture_dma_data = dev->dma_params;
+	dai->playback_dma_data = dev->dma_params;
+
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -569,7 +571,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0) {
@@ -582,7 +584,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0)
@@ -608,7 +610,7 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 }
@@ -625,9 +627,7 @@ static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 
 };
 
-struct snd_soc_dai davinci_i2s_dai = {
-	.name = "davinci-i2s",
-	.id = 0,
+static struct snd_soc_dai_driver davinci_i2s_dai = {
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -641,7 +641,6 @@ struct snd_soc_dai davinci_i2s_dai = {
 	.ops = &davinci_i2s_dai_ops,
 
 };
-EXPORT_SYMBOL_GPL(davinci_i2s_dai);
 
 static int davinci_i2s_probe(struct platform_device *pdev)
 {
@@ -720,10 +719,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 	dev->dev = &pdev->dev;
 
-	davinci_i2s_dai.private_data = dev;
-	davinci_i2s_dai.capture.dma_data = dev->dma_params;
-	davinci_i2s_dai.playback.dma_data = dev->dma_params;
-	ret = snd_soc_register_dai(&davinci_i2s_dai);
+	dev_set_drvdata(&pdev->dev, dev);
+
+	ret = snd_soc_register_dai(&pdev->dev, &davinci_i2s_dai);
 	if (ret != 0)
 		goto err_free_mem;
 
@@ -739,10 +737,10 @@ err_release_region:
 
 static int davinci_i2s_remove(struct platform_device *pdev)
 {
-	struct davinci_mcbsp_dev *dev = davinci_i2s_dai.private_data;
+	struct davinci_mcbsp_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *mem;
 
-	snd_soc_unregister_dai(&davinci_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev);
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
@@ -757,7 +755,7 @@ static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
 	.remove		= davinci_i2s_remove,
 	.driver		= {
-		.name	= "davinci-asp",
+		.name	= "davinci-i2s-dai",
 		.owner	= THIS_MODULE,
 	},
 };
diff --git a/sound/soc/davinci/davinci-i2s.h b/sound/soc/davinci/davinci-i2s.h
index 0b1e77b..48dac3e 100644
--- a/sound/soc/davinci/davinci-i2s.h
+++ b/sound/soc/davinci/davinci-i2s.h
@@ -17,6 +17,4 @@ enum davinci_mcbsp_div {
 	DAVINCI_MCBSP_CLKGDV,              /* Sample rate generator divider */
 };
 
-extern struct snd_soc_dai davinci_i2s_dai;
-
 #endif
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b247208..a1f14e4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -422,7 +422,7 @@ static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
-	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	void __iomem *base = dev->base;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -709,12 +709,15 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&dev->dma_params[substream->stream];
 	int word_length;
 	u8 fifo_level;
 
+	cpu_dai->capture_dma_data = dev->dma_params;
+	cpu_dai->playback_dma_data = dev->dma_params;
+
 	davinci_hw_common_param(dev, substream->stream);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = dev->txnumevt;
@@ -761,8 +764,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 				     int cmd, struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
 
 	switch (cmd) {
@@ -804,10 +806,9 @@ static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 
 };
 
-struct snd_soc_dai davinci_mcasp_dai[] = {
+static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
-		.name 		= "davinci-i2s",
-		.id 		= 0,
+		.name		= "davinci-mcasp-dai.0",
 		.playback	= {
 			.channels_min	= 2,
 			.channels_max 	= 2,
@@ -828,8 +829,7 @@ struct snd_soc_dai davinci_mcasp_dai[] = {
 
 	},
 	{
-		.name 		= "davinci-dit",
-		.id 		= 1,
+		"davinci-mcasp-dai.1",
 		.playback 	= {
 			.channels_min	= 1,
 			.channels_max	= 384,
@@ -840,7 +840,6 @@ struct snd_soc_dai davinci_mcasp_dai[] = {
 	},
 
 };
-EXPORT_SYMBOL_GPL(davinci_mcasp_dai);
 
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
@@ -917,11 +916,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	dma_data->channel = res->start;
-	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
-	davinci_mcasp_dai[pdata->op_mode].capture.dma_data = dev->dma_params;
-	davinci_mcasp_dai[pdata->op_mode].playback.dma_data = dev->dma_params;
-	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
-	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
+	dev_set_drvdata(&pdev->dev, dev);
+	ret = snd_soc_register_dai(&pdev->dev, &davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
 		goto err_release_region;
@@ -937,12 +933,10 @@ err_release_data:
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
-	struct snd_platform_data *pdata = pdev->dev.platform_data;
-	struct davinci_audio_dev *dev;
+	struct davinci_audio_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *mem;
 
-	snd_soc_unregister_dai(&davinci_mcasp_dai[pdata->op_mode]);
-	dev = davinci_mcasp_dai[pdata->op_mode].private_data;
+	snd_soc_unregister_dai(&pdev->dev);
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
@@ -959,7 +953,7 @@ static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
-		.name	= "davinci-mcasp",
+		.name	= "davinci-mcasp-dai",
 		.owner	= THIS_MODULE,
 	},
 };
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index e755b51..4681acc 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -22,8 +22,6 @@
 #include <mach/asp.h>
 #include "davinci-pcm.h"
 
-extern struct snd_soc_dai davinci_mcasp_dai[];
-
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_96000
 #define DAVINCI_MCASP_I2S_DAI	0
 #define DAVINCI_MCASP_DIT_DAI	1
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index a712411..9d35b8c 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -653,7 +653,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct davinci_pcm_dma_params *pa;
 	struct davinci_pcm_dma_params *params;
 
-	pa = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	pa = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	if (!pa)
 		return -ENODEV;
 	params = &pa[substream->stream];
@@ -821,7 +821,7 @@ static int davinci_pcm_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK,
 			pcm_hardware_playback.buffer_bytes_max);
@@ -829,7 +829,7 @@ static int davinci_pcm_new(struct snd_card *card,
 			return ret;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE,
 			pcm_hardware_capture.buffer_bytes_max);
@@ -840,25 +840,44 @@ static int davinci_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-struct snd_soc_platform davinci_soc_platform = {
-	.name = 	"davinci-audio",
-	.pcm_ops = 	&davinci_pcm_ops,
+static struct snd_soc_platform_driver davinci_soc_platform = {
+	.ops =		&davinci_pcm_ops,
 	.pcm_new = 	davinci_pcm_new,
 	.pcm_free = 	davinci_pcm_free,
 };
-EXPORT_SYMBOL_GPL(davinci_soc_platform);
 
-static int __init davinci_soc_platform_init(void)
+static int __devinit davinci_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&davinci_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &davinci_soc_platform);
 }
-module_init(davinci_soc_platform_init);
 
-static void __exit davinci_soc_platform_exit(void)
+static int __devexit davinci_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&davinci_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver davinci_pcm_driver = {
+	.driver = {
+			.name = "davinci-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = davinci_soc_platform_probe,
+	.remove = __devexit_p(davinci_soc_platform_remove),
+};
+
+static int __init snd_davinci_pcm_init(void)
+{
+	return platform_driver_register(&davinci_pcm_driver);
+}
+module_init(snd_davinci_pcm_init);
+
+static void __exit snd_davinci_pcm_exit(void)
+{
+	platform_driver_unregister(&davinci_pcm_driver);
 }
-module_exit(davinci_soc_platform_exit);
+module_exit(snd_davinci_pcm_exit);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index b799a02..c0d6c9b 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -28,7 +28,4 @@ struct davinci_pcm_dma_params {
 	unsigned int fifo_level;
 };
 
-
-extern struct snd_soc_platform davinci_soc_platform;
-
 #endif
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 40eccfe..1fd51a6 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -29,7 +29,6 @@
 #include <asm/plat-sffsdr/sffsdr-fpga.h>
 #endif
 
-#include <mach/mcbsp.h>
 #include <mach/edma.h>
 
 #include "../codecs/pcm3008.h"
@@ -48,7 +47,7 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int fs;
 	int ret = 0;
 
@@ -85,15 +84,16 @@ static struct snd_soc_ops sffsdr_ops = {
 static struct snd_soc_dai_link sffsdr_dai = {
 	.name = "PCM3008", /* Codec name */
 	.stream_name = "PCM3008 HiFi",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &pcm3008_dai,
+	.cpu_dai_name = "davinci-asp-dai.0",
+	.codec_dai_name = "pcm3008-hifi",
+	.codec_name = "pcm3008-codec",
+	.platform_name = "davinci-pcm-audio",
 	.ops = &sffsdr_ops,
 };
 
 /* davinci-sffsdr audio machine driver */
 static struct snd_soc_card snd_soc_sffsdr = {
 	.name = "DaVinci SFFSDR",
-	.platform = &davinci_soc_platform,
 	.dai_link = &sffsdr_dai,
 	.num_links = 1,
 };
@@ -106,11 +106,12 @@ static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
 	.pdda_pin = GPIO(38),
 };
 
-/* sffsdr audio subsystem */
-static struct snd_soc_device sffsdr_snd_devdata = {
-	.card = &snd_soc_sffsdr,
-	.codec_dev = &soc_codec_dev_pcm3008,
-	.codec_data = &sffsdr_pcm3008_setup,
+struct platform_device pcm3008_codec = {
+		.name = "pcm3008_codec_audio",
+		.id = 0,
+		.dev = {
+				.platform_data = &sffsdr_pcm3008_setup,
+		},
 };
 
 static struct resource sffsdr_snd_resources[] = {
@@ -135,14 +136,15 @@ static int __init sffsdr_init(void)
 	if (!machine_is_sffsdr())
 		return -EINVAL;
 
+	platform_device_register(&pcm3008_codec);
+
 	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
 	if (!sffsdr_snd_device) {
 		printk(KERN_ERR "platform device allocation failed\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
-	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
+	platform_set_drvdata(sffsdr_snd_device, &snd_soc_sffsdr);
 	platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
 				 sizeof(sffsdr_snd_data));
 
@@ -168,6 +170,7 @@ error:
 static void __exit sffsdr_exit(void)
 {
 	platform_device_unregister(sffsdr_snd_device);
+	platform_device_unregister(&pcm3008_codec);
 }
 
 module_init(sffsdr_init);
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 4867853..01d2298 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -36,7 +36,6 @@
 
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
-#include "davinci-vcif.h"
 
 #define MOD_REG_BIT(val, mask, set) do { \
 	if (set) { \
@@ -55,7 +54,7 @@ static void davinci_vcif_start(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_vcif_dev *davinci_vcif_dev =
-					rtd->dai->cpu_dai->private_data;
+			snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	u32 w;
 
@@ -74,7 +73,7 @@ static void davinci_vcif_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_vcif_dev *davinci_vcif_dev =
-					rtd->dai->cpu_dai->private_data;
+			snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	u32 w;
 
@@ -92,12 +91,15 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
-	struct davinci_vcif_dev *davinci_vcif_dev = dai->private_data;
+	struct davinci_vcif_dev *davinci_vcif_dev = snd_soc_dai_get_drvdata(dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	struct davinci_pcm_dma_params *dma_params =
 			&davinci_vcif_dev->dma_params[substream->stream];
 	u32 w;
 
+	dai->capture_dma_data = davinci_vcif_dev->dma_params;
+	dai->playback_dma_data = davinci_vcif_dev->dma_params;
+
 	/* Restart the codec before setup */
 	davinci_vcif_stop(substream);
 	davinci_vcif_start(substream);
@@ -179,8 +181,7 @@ static struct snd_soc_dai_ops davinci_vcif_dai_ops = {
 	.hw_params	= davinci_vcif_hw_params,
 };
 
-struct snd_soc_dai davinci_vcif_dai = {
-	.name = "davinci-vcif",
+static struct snd_soc_dai_driver davinci_vcif_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -194,7 +195,6 @@ struct snd_soc_dai davinci_vcif_dai = {
 	.ops = &davinci_vcif_dai_ops,
 
 };
-EXPORT_SYMBOL_GPL(davinci_vcif_dai);
 
 static int davinci_vcif_probe(struct platform_device *pdev)
 {
@@ -222,12 +222,9 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
 					davinci_vc->davinci_vcif.dma_rx_addr;
 
-	davinci_vcif_dai.dev = &pdev->dev;
-	davinci_vcif_dai.capture.dma_data = davinci_vcif_dev->dma_params;
-	davinci_vcif_dai.playback.dma_data = davinci_vcif_dev->dma_params;
-	davinci_vcif_dai.private_data = davinci_vcif_dev;
+	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
-	ret = snd_soc_register_dai(&davinci_vcif_dai);
+	ret = snd_soc_register_dai(&pdev->dev, &davinci_vcif_dai);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "could not register dai\n");
 		goto fail;
@@ -243,7 +240,7 @@ fail:
 
 static int davinci_vcif_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&davinci_vcif_dai);
+	snd_soc_unregister_dai(&pdev->dev);
 
 	return 0;
 }
@@ -252,7 +249,7 @@ static struct platform_driver davinci_vcif_driver = {
 	.probe		= davinci_vcif_probe,
 	.remove		= davinci_vcif_remove,
 	.driver		= {
-		.name	= "davinci_vcif",
+		.name	= "davinci-vcif-dai",
 		.owner	= THIS_MODULE,
 	},
 };
diff --git a/sound/soc/davinci/davinci-vcif.h b/sound/soc/davinci/davinci-vcif.h
deleted file mode 100644
index 571c994..0000000
--- a/sound/soc/davinci/davinci-vcif.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * ALSA SoC Voice Codec Interface for TI DAVINCI processor
- *
- * Copyright (C) 2010 Texas Instruments.
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef _DAVINCI_VCIF_H
-#define _DAVINCI_VCIF_H
-
-extern struct snd_soc_dai davinci_vcif_dai;
-
-#endif
-- 
1.7.0.4
