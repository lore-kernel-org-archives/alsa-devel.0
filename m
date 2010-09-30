From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove -dai suffix from i.MX SSI driver
Date: Thu, 30 Sep 2010 13:49:19 -0700
Message-ID: <1285879759-15750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0311110397C
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 22:49:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

While it is a generic serial port in practice the i.MX SSI is only supported
in Linux as an audio port (the i.MX has dedicated SPI controllers and so on).
This means we don't need to disambiguate against other uses of the hardware
and so can drop the -dai suffix from the driver name which fixes merge
issues with the i.MX tree in -next.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/clock-imx31.c |    4 ++--
 arch/arm/mach-mx3/clock-imx35.c |    4 ++--
 arch/arm/mach-mx3/devices.c     |    4 ++--
 arch/arm/plat-mxc/audmux-v2.c   |    4 ++--
 sound/soc/imx/eukrea-tlv320.c   |    2 +-
 sound/soc/imx/imx-ssi.c         |    2 +-
 sound/soc/imx/phycore-ac97.c    |    2 +-
 sound/soc/imx/wm1133-ev1.c      |    2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 9b52a67..9a9eb6d 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -558,8 +558,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
 	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
 	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK("imx-ssi-dai.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi-dai.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK(NULL, "firi", firi_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index f29c3e9..d3af0fd 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -464,8 +464,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "sdma", sdma_clk)
 	_REGISTER_CLOCK(NULL, "spba", spba_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK("imx-ssi-dai.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi-dai.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
 	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 90eccba..a4fd1a2 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -327,14 +327,14 @@ static struct resource imx_ssi_resources1[] = {
 };
 
 struct platform_device imx_ssi_device0 = {
-	.name = "imx-ssi-dai",
+	.name = "imx-ssi",
 	.id = 0,
 	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
 	.resource = imx_ssi_resources0,
 };
 
 struct platform_device imx_ssi_device1 = {
-	.name = "imx-ssi-dai",
+	.name = "imx-ssi",
 	.id = 1,
 	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
 	.resource = imx_ssi_resources1,
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 910374d..f9e7cdb 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -45,9 +45,9 @@ static const char *audmux_port_string(int port)
 {
 	switch (port) {
 	case MX31_AUDMUX_PORT1_SSI0:
-		return "imx-ssi-dai.0";
+		return "imx-ssi.0";
 	case MX31_AUDMUX_PORT2_SSI1:
-		return "imx-ssi-dai.1";
+		return "imx-ssi.1";
 	case MX31_AUDMUX_PORT3_SSI_PINS_3:
 		return "SSI3";
 	case MX31_AUDMUX_PORT4_SSI_PINS_4:
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index 807f736..b596752 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -82,7 +82,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.codec_dai	= "tlv320aic23-hifi",
 	.platform_name	= "imx-pcm-audio.0",
 	.codec_name	= "tlv320aic23-codec.0-001a",
-	.cpu_dai = "imx-ssi-dai.0",
+	.cpu_dai = "imx-ssi.0",
 	.ops		= &eukrea_tlv320_snd_ops,
 };
 
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 26716e9..d4bd345 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -734,7 +734,7 @@ static struct platform_driver imx_ssi_driver = {
 	.remove = __devexit_p(imx_ssi_remove),
 
 	.driver = {
-		.name = "imx-ssi-dai",
+		.name = "imx-ssi",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 65f0f99..6a65dd7 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -34,7 +34,7 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 		.stream_name	= "HiFi",
 		.codec_dai_name		= "wm9712-hifi",
 		.codec_name	= "wm9712-codec",
-		.cpu_dai_name	= "imx-ssi-dai.0",
+		.cpu_dai_name	= "imx-ssi.0",
 		.platform_name	= "imx-fiq-pcm-audio.0",
 		.ops		= &imx_phycore_hifi_ops,
 	},
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 7406863..30fdb15 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -243,7 +243,7 @@ static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link wm1133_ev1_dai = {
 	.name = "WM1133-EV1",
 	.stream_name = "Audio",
-	.cpu_dai_name = "imx-ssi-dai.0",
+	.cpu_dai_name = "imx-ssi.0",
 	.codec_dai_name = "wm8350-hifi",
 	.platform_name = "imx-fiq-pcm-audio.0",
 	.codec_name = "wm8350-codec.0-0x1a",
-- 
1.7.1
