From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Fix typos in I2C address formatting
Date: Wed, 29 Sep 2010 22:20:27 -0700
Message-ID: <1285824027-897-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1285824027-897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 998EF10390F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 07:20:16 +0200 (CEST)
In-Reply-To: <1285824027-897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In the addition of address information for multi-component a few of the
machine drivers had typos in the I2C addrsses, with the bus address added
in the form 0xNN rather than 00NN as the I2C core formats it. Correct
these.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/playpaq_wm8510.c               |    2 +-
 sound/soc/atmel/snd-soc-afeb9260.c             |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c             |    2 +-
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    4 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c             |    4 ++--
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 9d545f2..80c4c01 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -356,7 +356,7 @@ static struct snd_soc_dai_link playpaq_wm8510_dai = {
 	.stream_name = "WM8510 PCM",
 	.cpu_dai_name= "atmel-ssc-dai.0",
 	.platform_name = "atmel-pcm-audio",
-	.codec_name = "wm8510.0-0x1a",
+	.codec_name = "wm8510.0-001a",
 	.codec_dai_name = "wm8510-hifi",
 	.init = playpaq_wm8510_init,
 	.ops = &playpaq_wm8510_ops,
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index ff6499b..c52fb6b 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -129,7 +129,7 @@ static struct snd_soc_dai_link afeb9260_dai = {
 	.cpu_dai_name = "atmel-ssc-dai.0",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "atmel_pcm-audio",
-	.codec_name = "tlv320aic23.0-0x1a",
+	.codec_name = "tlv320aic23.0-001a",
 	.init = afeb9260_tlv320aic23_init,
 	.ops = &afeb9260_ops,
 };
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index e1fda9b..1ecd0e7 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -120,7 +120,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.cpu_dai_name = "bf5xx-i2s",
 	.codec_dai_name = "ssm2602-hifi",
 	.platform_name = "bf5xx-pcm-audio",
-	.codec_name = "ssm2602.0-0x1b",
+	.codec_name = "ssm2602.0-001b",
 	.ops = &bf5xx_ssm2602_ops,
 };
 
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 5f3ab8b..518782c 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -142,7 +142,7 @@ static struct snd_soc_dai_link jive_dai = {
 	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
-	.codec_name	= "wm8750.0-0x1a",
+	.codec_name	= "wm8750.0-001a",
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
 };
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index 08b9ef7..641ea07 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -401,7 +401,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.codec_dai_name = "wm8753-hifi",
 	.init = neo1973_gta02_wm8753_init,
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8753.0-0x1a",
+	.codec_name = "wm8753.0-001a",
 	.ops = &neo1973_gta02_hifi_ops,
 },
 { /* Voice via BT */
@@ -410,7 +410,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.cpu_dai_name = "bluetooth-dai",
 	.codec_dai_name = "wm8753-voice",
 	.ops = &neo1973_gta02_voice_ops,
-	.codec_name = "wm8753.0-0x1a",
+	.codec_name = "wm8753.0-001a",
 	.platform_name = "s3c24xx-pcm-audio",
 },
 };
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index dd3fae2..4998fae 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -559,7 +559,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.platform_name = "s3c24xx-pcm-audio",
 	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
-	.codec_name = "wm8753.0-0x1a",
+	.codec_name = "wm8753.0-001a",
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
 },
@@ -569,7 +569,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.platform_name = "s3c24xx-pcm-audio",
 	.cpu_dai_name = "bluetooth-dai",
 	.codec_dai_name = "wm8753-voice",
-	.codec_name = "wm8753.0-0x1a",
+	.codec_name = "wm8753.0-001a",
 	.ops = &neo1973_voice_ops,
 },
 };
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index 6ad2144..51ad069 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -96,7 +96,7 @@ static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.name		= "tlv320aic33",
 	.stream_name	= "TLV320AIC33",
-	.codec_name	= "tlv320aic3x.0-0x1a",
+	.codec_name	= "tlv320aic3x.0-001a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 7fd1b2a..c2bb0c7 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -85,7 +85,7 @@ static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
-	.codec_name	= "tlv320aic3x.0-0x1a",
+	.codec_name	= "tlv320aic3x.0-001a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index f63dab9..1fb85a2 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -214,7 +214,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 		.cpu_dai_name	= "s3c64xx-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
 		.platform_name	= "s3c24xx-pcm-audio",
-		.codec_name	= "wm8750.0-0x1a",
+		.codec_name	= "wm8750.0-001a",
 		.init		= smartq_wm8987_init,
 		.ops		= &smartq_hifi_ops,
 	},
-- 
1.7.1
