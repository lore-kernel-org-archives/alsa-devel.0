From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/3] ASoC: Blackfin: standardize machine driver
	names
Date: Mon, 28 Mar 2011 01:45:09 -0400
Message-ID: <1301291110-2443-2-git-send-email-vapier@gentoo.org>
References: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F2EF910384D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 08:44:03 +0200 (CEST)
In-Reply-To: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Some machine drivers were using "bf5xx-", others were using "bf5xx_",
while others were using "bfin-".  Further, some were using the same
name in the transport layer which makes it hard to use different codecs
at the same time.  So standardize all of them to "bfin-" and make sure
they are name spaced according to their driver name.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |    2 +-
 sound/soc/blackfin/bf5xx-ad1836.c   |    6 +++---
 sound/soc/blackfin/bf5xx-ad193x.c   |    6 +++---
 sound/soc/blackfin/bf5xx-ad1980.c   |    4 ++--
 sound/soc/blackfin/bf5xx-ad73311.c  |    6 +++---
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |    2 +-
 sound/soc/blackfin/bf5xx-i2s.c      |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c  |    6 +++---
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |    2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 5a2fd8a..e940d26 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -458,7 +458,7 @@ static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver bf5xx_pcm_driver = {
 	.driver = {
-			.name = "bf5xx-pcm-audio",
+			.name = "bfin-ac97-pcm-audio",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 826bae6..5d9d9e2 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -82,15 +82,15 @@ static struct snd_soc_ops bf5xx_ad1836_ops = {
 static struct snd_soc_dai_link bf5xx_ad1836_dai = {
 	.name = "ad1836",
 	.stream_name = "AD1836",
-	.cpu_dai_name = "bf5xx-tdm",
+	.cpu_dai_name = "bfin-tdm",
 	.codec_dai_name = "ad1836-hifi",
-	.platform_name = "bf5xx-tdm-pcm-audio",
+	.platform_name = "bfin-tdm-pcm-audio",
 	.codec_name = "ad1836.0",
 	.ops = &bf5xx_ad1836_ops,
 };
 
 static struct snd_soc_card bf5xx_ad1836 = {
-	.name = "bf5xx_ad1836",
+	.name = "bfin-ad1836",
 	.dai_link = &bf5xx_ad1836_dai,
 	.num_links = 1,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 5794d09..355094f 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -110,15 +110,15 @@ static struct snd_soc_ops bf5xx_ad193x_ops = {
 static struct snd_soc_dai_link bf5xx_ad193x_dai = {
 	.name = "ad193x",
 	.stream_name = "AD193X",
-	.cpu_dai_name = "bf5xx-tdm",
+	.cpu_dai_name = "bfin-tdm",
 	.codec_dai_name ="ad193x-hifi",
-	.platform_name = "bf5xx-tdm-pcm-audio",
+	.platform_name = "bfin-tdm-pcm-audio",
 	.codec_name = "ad193x.5",
 	.ops = &bf5xx_ad193x_ops,
 };
 
 static struct snd_soc_card bf5xx_ad193x = {
-	.name = "bf5xx_ad193x",
+	.name = "bfin-ad193x",
 	.dai_link = &bf5xx_ad193x_dai,
 	.num_links = 1,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index c147130..a381240 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -72,13 +72,13 @@ static struct snd_soc_dai_link bf5xx_board_dai = {
 	.stream_name = "AC97 HiFi",
 	.cpu_dai_name = "bfin-ac97",
 	.codec_dai_name = "ad1980-hifi",
-	.platform_name = "bfin-pcm-audio",
+	.platform_name = "bfin-ac97-pcm-audio",
 	.codec_name = "ad1980",
 	.ops = &bf5xx_board_ops,
 };
 
 static struct snd_soc_card bf5xx_board = {
-	.name = "bf5xx-board",
+	.name = "bfin-ad1980",
 	.dai_link = &bf5xx_board_dai,
 	.num_links = 1,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 1655f95..9f0d4f3 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -183,15 +183,15 @@ static struct snd_soc_ops bf5xx_ad73311_ops = {
 static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 	.name = "ad73311",
 	.stream_name = "AD73311",
-	.cpu_dai_name = "bf5xx-i2s",
+	.cpu_dai_name = "bfin-i2s",
 	.codec_dai_name = "ad73311-hifi",
-	.platform_name = "bfin-pcm-audio",
+	.platform_name = "bfin-i2s-pcm-audio",
 	.codec_name = "ad73311",
 	.ops = &bf5xx_ad73311_ops,
 };
 
 static struct snd_soc_card bf5xx_ad73311 = {
-	.name = "bf5xx_ad73311",
+	.name = "bfin-ad73311",
 	.probe = bf5xx_probe,
 	.dai_link = &bf5xx_ad73311_dai,
 	.num_links = 1,
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 890a0dc..50b1df8 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -292,7 +292,7 @@ static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_pcm_driver = {
 	.driver = {
-			.name = "bfin-pcm-audio",
+			.name = "bfin-i2s-pcm-audio",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 37d9d3c..dacd86c 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -316,7 +316,7 @@ static struct platform_driver bfin_i2s_driver = {
 	.remove = __devexit_p(bfin_i2s_drv_remove),
 
 	.driver = {
-		.name = "bf5xx-i2s",
+		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 732a02f..8a7b589 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -116,15 +116,15 @@ static struct snd_soc_ops bf5xx_ssm2602_ops = {
 static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.name = "ssm2602",
 	.stream_name = "SSM2602",
-	.cpu_dai_name = "bf5xx-i2s",
+	.cpu_dai_name = "bfin-i2s",
 	.codec_dai_name = "ssm2602-hifi",
-	.platform_name = "bf5xx-pcm-audio",
+	.platform_name = "bfin-i2s-pcm-audio",
 	.codec_name = "ssm2602.0-001b",
 	.ops = &bf5xx_ssm2602_ops,
 };
 
 static struct snd_soc_card bf5xx_ssm2602 = {
-	.name = "bf5xx_ssm2602",
+	.name = "bfin-ssm2602",
 	.dai_link = &bf5xx_ssm2602_dai,
 	.num_links = 1,
 };
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 74cf759..d1bd745 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -326,7 +326,7 @@ static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_tdm_driver = {
 	.driver = {
-			.name = "bf5xx-tdm-pcm-audio",
+			.name = "bfin-tdm-pcm-audio",
 			.owner = THIS_MODULE,
 	},
 
-- 
1.7.4.1
