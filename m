From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix I2C device names
Date: Thu, 12 Aug 2010 10:58:16 +0100
Message-ID: <1281607096-12879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F12B9103815
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 11:58:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some of the I2C device names got mangled into the form 0-0x1a rather
than 0-001a as they should be.  Also, the WM8580 is at I2C address 0x1b
not 0x1a on SMDK64xx.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c     |    2 +-
 sound/soc/davinci/davinci-evm.c      |    8 ++++----
 sound/soc/ep93xx/snappercl15.c       |    2 +-
 sound/soc/imx/eukrea-tlv320.c        |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c  |    4 ++--
 sound/soc/s6000/s6105-ipcam.c        |    2 +-
 sound/soc/sh/fsi-ak4642.c            |    2 +-
 sound/soc/sh/fsi-da7210.c            |    2 +-
 sound/soc/sh/migor.c                 |    2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index cf9f6c9..66a6f18 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -184,7 +184,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
 	.platform_name = "atmel_pcm-audio",
-	.codec_name = "wm8731-codec.0-0x1a",
+	.codec_name = "wm8731-codec.0-001a",
 	.ops = &at91sam9g20ek_ops,
 };
 
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 3d6b5b6..097bbbe 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -162,7 +162,7 @@ static struct snd_soc_dai_link evm_dai = {
 	.stream_name = "AIC3X",
 	.cpu_dai_name = "davinci-mcasp-dai.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.codec_name = "tlv320aic3x-codec.0-001a",
 	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
@@ -175,7 +175,7 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 	.cpu_dai_name = "davinci-i2s-dai",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.init = evm_aic3x_init,
-	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.codec_name = "tlv320aic3x-codec.0-001a",
 	.ops = &evm_ops,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
@@ -194,7 +194,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.cpu_dai_name= "davinci-mcasp-dai.0",
 		.codec_dai_name = "tlv320aic3x-hifi",
 		.platform_name ="davinci-pcm-audio",
-		.codec_name = "tlv320aic3x-codec.0-0x1a",
+		.codec_name = "tlv320aic3x-codec.0-001a",
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
 	},
@@ -213,7 +213,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.stream_name = "AIC3X",
 	.cpu_dai_name= "davinci-mcasp-dai.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.codec_name = "tlv320aic3x-codec.0-001a",
 	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 539e839..402d299 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -92,7 +92,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.stream_name	= "AIC23",
 	.cpu_dai_name	= "ep93xx-i2s-dai",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.codec_name	= "tlv320aic23-codec.0-0x1a",
+	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	=  "ep93xx-pcm-audio",
 	.init		= snappercl15_tlv320aic23_init,
 	.ops		= &snappercl15_ops,
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index ab76cae..807f736 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -81,7 +81,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.stream_name	= "TLV320AIC23",
 	.codec_dai	= "tlv320aic23-hifi",
 	.platform_name	= "imx-pcm-audio.0",
-	.codec_name	= "tlv320aic23-codec.0-0x1a",
+	.codec_name	= "tlv320aic23-codec.0-001a",
 	.cpu_dai = "imx-ssi-dai.0",
 	.ops		= &eukrea_tlv320_snd_ops,
 };
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 6f9ac42..b375021 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 	.cpu_dai_name = "kirkwood-i2s-dai",
 	.platform_name = "kirkwood-pcm-audio",
 	.codec_dai_name = "cs42l51_hifi",
-	.codec_name = "cs42l51-codec.0-0x4a",
+	.codec_name = "cs42l51-codec.0-004a",
 	.ops = &openrd_client_ops,
 },
 };
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 4ccfe84..9d959a0 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -226,7 +226,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8580-codec.0-0x1a",
+	.codec_name = "wm8580-codec.0-001b",
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
 },
@@ -236,7 +236,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8580-codec.0-0x1a",
+	.codec_name = "wm8580-codec.0-001b",
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
 },
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index dd39467..dff9d39 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -179,7 +179,7 @@ static struct snd_soc_dai_link s6105_dai = {
 	.cpu_dai_name = "s6000-i2s-dai",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name = "s6000-pcm-audio",
-	.codec_name = "tlv320aic3x-codec.0-0x1a",
+	.codec_name = "tlv320aic3x-codec.0-001a",
 	.init = s6105_aic3x_init,
 	.ops = &s6105_ops,
 };
diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
index ff17ff3..9e107a9 100644
--- a/sound/soc/sh/fsi-ak4642.c
+++ b/sound/soc/sh/fsi-ak4642.c
@@ -32,7 +32,7 @@ static struct snd_soc_dai_link fsi_dai_link = {
 	.cpu_dai_name	= "fsia-dai", /* fsi A */
 	.codec_dai_name	= "ak4642-hifi",
 	.platform_name	= "fsi-pcm-audio",
-	.codec_name	= "ak4642-codec.0-0x12",
+	.codec_name	= "ak4642-codec.0-0012",
 	.init		= fsi_ak4642_dai_init,
 	.ops		= NULL,
 };
diff --git a/sound/soc/sh/fsi-da7210.c b/sound/soc/sh/fsi-da7210.c
index e2f6fe5..4f9298f 100644
--- a/sound/soc/sh/fsi-da7210.c
+++ b/sound/soc/sh/fsi-da7210.c
@@ -28,7 +28,7 @@ static struct snd_soc_dai_link fsi_da7210_dai = {
 	.cpu_dai_name	= "fsib-dai", /* FSI B */
 	.codec_dai_name	= "da7210-hifi",
 	.platform_name	= "fsi-pcm-audio",
-	.codec_name	= "da7210-codec.0-0x1a",
+	.codec_name	= "da7210-codec.0-001a",
 	.init		= fsi_da7210_init,
 };
 
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 0dc3a0e..866d78f 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -155,7 +155,7 @@ static struct snd_soc_dai_link migor_dai = {
 	.cpu_dai_name = "siu-i2s-dai",
 	.codec_dai_name = "wm8978-hifi",
 	.platform_name = "siu-pcm-audio",
-	.codec_name = "wm8978-codec.0-0x1a",
+	.codec_name = "wm8978-codec.0-001a",
 	.ops = &migor_dai_ops,
 	.init = migor_dai_init,
 };
-- 
1.7.1
