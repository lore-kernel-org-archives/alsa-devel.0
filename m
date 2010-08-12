From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Remove -dai suffix from Samsung DAI
	devices
Date: Thu, 12 Aug 2010 11:02:18 +0100
Message-ID: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFBB41038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:02:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

The IP blocks are all fixed function audio controllers so there's no
need to dedupe against other usages and the corresponding arch/arm
updates got missed anyway so revert to the original names for the
drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/aquila_wm8994.c              |    2 +-
 sound/soc/s3c24xx/goni_wm8994.c                |    2 +-
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    2 +-
 sound/soc/s3c24xx/neo1973_wm8753.c             |    2 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c             |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
index 44b06e9..235d197 100644
--- a/sound/soc/s3c24xx/aquila_wm8994.c
+++ b/sound/soc/s3c24xx/aquila_wm8994.c
@@ -233,7 +233,7 @@ static struct snd_soc_dai_link aquila_dai[] = {
 {
 	.name = "WM8994",
 	.stream_name = "WM8994 HiFi",
-	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
+	.cpu_dai_name = "s3c64xx-i2s-v4",
 	.codec_dai_name = "wm8994-hifi",
 	.platform_name = "s3c24xx-pcm-audio",
 	.codec_name = "wm8994-codec.0-0x1a",
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index 6ada34e..694f702 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -236,7 +236,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 {
 	.name = "WM8994",
 	.stream_name = "WM8994 HiFi",
-	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
+	.cpu_dai_name = "s3c64xx-i2s-v4",
 	.codec_dai_name = "wm8994-hifi",
 	.platform_name = "s3c24xx-pcm-audio",
 	.codec_name = "wm8994-codec.0-0x1a",
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 61e3067..49605cd 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -139,7 +139,7 @@ static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link jive_dai = {
 	.name		= "wm8750",
 	.stream_name	= "WM8750",
-	.cpu_dai_name	= "s3c2412-i2s-dai",
+	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
 	.codec_name	= "wm8750-codec.0-0x1a",
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index ef234c7..abe64ab 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -32,7 +32,7 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "s3c-ac97-dai",
+	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
 	.platform_name = "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index be1e81c..c457bfd 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -397,7 +397,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.cpu_dai_name = "s3c24xx-i2s-dai",
+	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
 	.init = neo1973_gta02_wm8753_init,
 	.platform_name = "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 8b5472e..d7a39a0 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -557,7 +557,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
 	.platform_name = "s3c24xx-pcm-audio",
-	.cpu_dai_name = "s3c24xx-i2s-dai",
+	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
 	.codec_name = "wm8753-codec.0-0x1a",
 	.init = neo1973_wm8753_init,
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index aa116f6..acd0096 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -188,7 +188,7 @@ static struct platform_driver s3c2412_iis_driver = {
 	.probe  = s3c2412_iis_dev_probe,
 	.remove = s3c2412_iis_dev_remove,
 	.driver = {
-		.name = "s3c2412-iis-dai",
+		.name = "s3c2412-iis",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index a6cbeef..1d0bade 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -495,7 +495,7 @@ static struct platform_driver s3c24xx_iis_driver = {
 	.probe  = s3c24xx_iis_dev_probe,
 	.remove = s3c24xx_iis_dev_remove,
 	.driver = {
-		.name = "s3c24xx-iis-dai",
+		.name = "s3c24xx-iis",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index 00ead0d..f884537 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -97,7 +97,7 @@ static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.name		= "tlv320aic33",
 	.stream_name	= "TLV320AIC33",
 	.codec_name	= "tlv320aic3x-codec.0-0x1a",
-	.cpu_dai_name	= "s3c24xx-i2s-dai",
+	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
 	.init		= simtec_hermes_init,
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 4ee4412..c096759 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -86,7 +86,7 @@ static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_name	= "tlv320aic3x-codec.0-0x1a",
-	.cpu_dai_name	= "s3c24xx-i2s-dai",
+	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
 	.init		= simtec_tlv320aic23_init,
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 7d049ed..bd48ffb 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -229,7 +229,7 @@ static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 	.stream_name = "UDA134X",
 	.codec_name = "uda134x-hifi",
 	.codec_dai_name = "uda134x-hifi",
-	.cpu_dai_name = "s3c24xx-i2s-dai",
+	.cpu_dai_name = "s3c24xx-i2s",
 	.ops = &s3c24xx_uda134x_ops,
 	.platform_name	= "s3c24xx-pcm-audio",
 };
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 885040b..7cab4fc 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -195,7 +195,7 @@ static struct platform_driver s3c64xx_i2sv4_driver = {
 	.probe  = s3c64xx_i2sv4_dev_probe,
 	.remove = s3c64xx_i2sv4_dev_remove,
 	.driver = {
-		.name = "s3c64xx-iis-v4-dai",
+		.name = "s3c64xx-iis-v4",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 161189b..a1d0b25 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -218,7 +218,7 @@ static struct platform_driver s3c64xx_iis_driver = {
 	.probe  = s3c64xx_iis_dev_probe,
 	.remove = s3c64xx_iis_dev_remove,
 	.driver = {
-		.name = "s3c64xx-iis-dai",
+		.name = "s3c64xx-iis",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index a908055..dd20ca7 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -211,7 +211,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 	{
 		.name		= "wm8987",
 		.stream_name	= "SmartQ Hi-Fi",
-		.cpu_dai_name	= "s3c64xx-i2s-dai.0",
+		.cpu_dai_name	= "s3c64xx-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
 		.platform_name	= "s3c24xx-pcm-audio",
 		.codec_name	= "wm8750-codec.0-0x1a",
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 9d959a0..5c21e26 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -223,7 +223,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
-	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
+	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "s3c24xx-pcm-audio",
 	.codec_name = "wm8580-codec.0-001b",
@@ -233,7 +233,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
+	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "s3c24xx-pcm-audio",
 	.codec_name = "wm8580-codec.0-001b",
-- 
1.7.1
