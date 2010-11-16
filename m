From: Chris Paulson-Ellis <chris@edesix.com>
Subject: [PATCH] ASoC: davinci: fixes for multi-component
Date: Tue, 16 Nov 2010 12:27:09 +0000
Message-ID: <1289910429-29347-1-git-send-email-chris@edesix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from douglas.edesix.com (93-97-174-104.zone5.bethere.co.uk
	[93.97.174.104])
	by alsa0.perex.cz (Postfix) with ESMTP id AD7E91037E3
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 13:27:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
Cc: vbarinov@embeddedalley.com, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, Chris Paulson-Ellis <chris@edesix.com>, miguel.aguilar@ridgerun.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Multi-component commit f0fba2ad broke a few things which this patch should
fix. Tested on the DM355 EVM. I've been as careful as I can, but it would be
good if those with access to other Davinci boards could test.

--

The multi-component commit put the initialisation of
snd_soc_dai.[capture|playback]_dma_data into snd_soc_dai_ops.hw_params of the
McBSP, McASP & VCIF drivers (davinci-i2s.c, davinci-mcasp.c & davinci-vcif.c).
The initialisation had to be moved from the probe function in these drivers
because davinci_*_dai changed from snd_soc_dai to snd_soc_dai_driver.

Unfortunately, the DMA params pointer is needed by davinci_pcm_open (in
davinci-pcm.c) before hw_params is called. I have moved the initialisation to
a new snd_soc_dai_ops.startup function in each of these drivers. This fix
indicates that all platforms that use davinci-pcm must have been broken and
need to test with this fix.

--

The multi-component commit also changed the McBSP driver name from
"davinci-asp" to "davinci-i2s" in davinci-i2s.c without updating the board
level references to the driver name. This change is understandable, as there
is a similarly named "davinci-mcasp" driver in davinci-mcasp.c.

There is probably no 'correct' name for this driver. The DM6446 datasheet
calls it the "ASP" and describes it as a "specialised McBSP". The DM355
datasheet calls it the "ASP" and describes it as a "specialised ASP". The
DM365 datasheet calls it the "McBSP". Rather than fix this problem by
reverting to "davinci-asp", I've elected to avoid future confusion with the
"davinci-mcasp" driver by changing it to "davinci-mcbsp", which is also
consistent with the names of the functions in the driver. There are other
fixes required, so it was never going to be as simple as a revert anyway.

--

The DM365 only has one McBSP port (of the McBSP platforms, only the DM355 has
2 ports), so I've changed the the id of the platform_device from 0 to -1.

--

In davinci-evm.c, the DM6446 EVM can no longer share a snd_soc_dai_link
structure with the DM355 EVM as they use different cpu DAI names (the DM355
has 2 ports and the EVM uses the second port, but the DM6446 only has 1 port).
This also means that the 2 boards need different snd_soc_card structures.

--

The codec_name entries in davinci-evm.c didn't match the i2c ids in the board
files. I have only checked and fixed the details of the names used for the
McBSP based platforms. Someone with a McASP based platform (eg DA8xx) should
check the others.

Signed-off-by: Chris Paulson-Ellis <chris@edesix.com>
---
 arch/arm/mach-davinci/dm355.c      |    6 ++--
 arch/arm/mach-davinci/dm365.c      |    6 ++--
 arch/arm/mach-davinci/dm644x.c     |    4 +-
 sound/soc/davinci/davinci-evm.c    |   40 ++++++++++++++++++++++++++---------
 sound/soc/davinci/davinci-i2s.c    |   15 +++++++++---
 sound/soc/davinci/davinci-mcasp.c  |   13 +++++++++--
 sound/soc/davinci/davinci-sffsdr.c |    2 +-
 sound/soc/davinci/davinci-vcif.c   |   13 +++++++++--
 8 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9be261b..2652af1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -359,8 +359,8 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "uart1", &uart1_clk),
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci-asp.0", NULL, &asp0_clk),
-	CLK("davinci-asp.1", NULL, &asp1_clk),
+	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
+	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
 	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
 	CLK("spi_davinci.0", NULL, &spi0_clk),
@@ -664,7 +664,7 @@ static struct resource dm355_asp1_resources[] = {
 };
 
 static struct platform_device dm355_asp1_device = {
-	.name		= "davinci-asp",
+	.name		= "davinci-mcbsp",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(dm355_asp1_resources),
 	.resource	= dm355_asp1_resources,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a12065e..c466d71 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -459,7 +459,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
-	CLK("davinci-asp.0", NULL, &asp0_clk),
+	CLK("davinci-mcbsp", NULL, &asp0_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
@@ -922,8 +922,8 @@ static struct resource dm365_asp_resources[] = {
 };
 
 static struct platform_device dm365_asp_device = {
-	.name		= "davinci-asp",
-	.id		= 0,
+	.name		= "davinci-mcbsp",
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(dm365_asp_resources),
 	.resource	= dm365_asp_resources,
 };
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0608dd7..9a2376b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -302,7 +302,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("davinci-asp", NULL, &asp_clk),
+	CLK("davinci-mcbsp", NULL, &asp_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
 	CLK(NULL, "gpio", &gpio_clk),
@@ -580,7 +580,7 @@ static struct resource dm644x_asp_resources[] = {
 };
 
 static struct platform_device dm644x_asp_device = {
-	.name		= "davinci-asp",
+	.name		= "davinci-mcbsp",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(dm644x_asp_resources),
 	.resource	= dm644x_asp_resources,
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index a2cf64b..fd96905 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -158,12 +158,23 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* davinci-evm digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link evm_dai = {
+static struct snd_soc_dai_link dm6446_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-mcasp.0",
+	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.0-001a",
+	.codec_name = "tlv320aic3x-codec.1-001b",
+	.platform_name = "davinci-pcm-audio",
+	.init = evm_aic3x_init,
+	.ops = &evm_ops,
+};
+
+static struct snd_soc_dai_link dm355_evm_dai = {
+	.name = "TLV320AIC3X",
+	.stream_name = "AIC3X",
+	.cpu_dai_name = "davinci-mcbsp.1",
+	.codec_dai_name = "tlv320aic3x-hifi",
+	.codec_name = "tlv320aic3x-codec.1-001b",
 	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
@@ -173,10 +184,10 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name = "davinci-i2s",
+	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.init = evm_aic3x_init,
-	.codec_name = "tlv320aic3x-codec.0-001a",
+	.codec_name = "tlv320aic3x-codec.1-0018",
 	.ops = &evm_ops,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
@@ -220,10 +231,17 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.ops = &evm_ops,
 };
 
-/* davinci dm6446, dm355 evm audio machine driver */
-static struct snd_soc_card snd_soc_card_evm = {
-	.name = "DaVinci EVM",
-	.dai_link = &evm_dai,
+/* davinci dm6446 evm audio machine driver */
+static struct snd_soc_card dm6446_snd_soc_card_evm = {
+	.name = "DaVinci DM6446 EVM",
+	.dai_link = &dm6446_evm_dai,
+	.num_links = 1,
+};
+
+/* davinci dm355 evm audio machine driver */
+static struct snd_soc_card dm355_snd_soc_card_evm = {
+	.name = "DaVinci DM355 EVM",
+	.dai_link = &dm355_evm_dai,
 	.num_links = 1,
 };
 
@@ -262,10 +280,10 @@ static int __init evm_init(void)
 	int ret;
 
 	if (machine_is_davinci_evm()) {
-		evm_snd_dev_data = &snd_soc_card_evm;
+		evm_snd_dev_data = &dm6446_snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
-		evm_snd_dev_data = &snd_soc_card_evm;
+		evm_snd_dev_data = &dm355_snd_soc_card_evm;
 		index = 1;
 	} else if (machine_is_davinci_dm365_evm()) {
 		evm_snd_dev_data = &dm365_snd_soc_card_evm;
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index d46b545..9e0e565 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -426,9 +426,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
 
-	dai->capture_dma_data = dev->dma_params;
-	dai->playback_dma_data = dev->dma_params;
-
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -601,6 +598,15 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
+static int davinci_i2s_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+	return 0;
+}
+
 static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -612,6 +618,7 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
 static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
+	.startup	= davinci_i2s_startup,
 	.shutdown	= davinci_i2s_shutdown,
 	.prepare	= davinci_i2s_prepare,
 	.trigger	= davinci_i2s_trigger,
@@ -749,7 +756,7 @@ static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
 	.remove		= davinci_i2s_remove,
 	.driver		= {
-		.name	= "davinci-i2s",
+		.name	= "davinci-mcbsp",
 		.owner	= THIS_MODULE,
 	},
 };
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 86918ee..fb55d2c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -715,9 +715,6 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int word_length;
 	u8 fifo_level;
 
-	cpu_dai->capture_dma_data = dev->dma_params;
-	cpu_dai->playback_dma_data = dev->dma_params;
-
 	davinci_hw_common_param(dev, substream->stream);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = dev->txnumevt;
@@ -799,7 +796,17 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+	return 0;
+}
+
 static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
+	.startup	= davinci_mcasp_startup,
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 009b652..6c6666a 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -84,7 +84,7 @@ static struct snd_soc_ops sffsdr_ops = {
 static struct snd_soc_dai_link sffsdr_dai = {
 	.name = "PCM3008", /* Codec name */
 	.stream_name = "PCM3008 HiFi",
-	.cpu_dai_name = "davinci-asp.0",
+	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "pcm3008-hifi",
 	.codec_name = "pcm3008-codec",
 	.platform_name = "davinci-pcm-audio",
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index ea232f6..fb4cc1e 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -97,9 +97,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 			&davinci_vcif_dev->dma_params[substream->stream];
 	u32 w;
 
-	dai->capture_dma_data = davinci_vcif_dev->dma_params;
-	dai->playback_dma_data = davinci_vcif_dev->dma_params;
-
 	/* Restart the codec before setup */
 	davinci_vcif_stop(substream);
 	davinci_vcif_start(substream);
@@ -174,9 +171,19 @@ static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
+static int davinci_vcif_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct davinci_vcif_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+	return 0;
+}
+
 #define DAVINCI_VCIF_RATES	SNDRV_PCM_RATE_8000_48000
 
 static struct snd_soc_dai_ops davinci_vcif_dai_ops = {
+	.startup	= davinci_vcif_startup,
 	.trigger	= davinci_vcif_trigger,
 	.hw_params	= davinci_vcif_hw_params,
 };
-- 
1.7.2.3
