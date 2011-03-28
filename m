From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/3] ASoC: Blackfin: drop "-codec" from codec
	names
Date: Mon, 28 Mar 2011 01:45:08 -0400
Message-ID: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id CDA6B10389A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 08:44:04 +0200 (CEST)
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

The recent multi-component patch incorrectly added "-codec" suffixes to
parts which are not MFD.  Drop the suffix from the machine drivers too.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ad1836.c  |    2 +-
 sound/soc/blackfin/bf5xx-ad193x.c  |    2 +-
 sound/soc/blackfin/bf5xx-ad1980.c  |    2 +-
 sound/soc/blackfin/bf5xx-ad73311.c |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 83012da..826bae6 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -85,7 +85,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai = {
 	.cpu_dai_name = "bf5xx-tdm",
 	.codec_dai_name = "ad1836-hifi",
 	.platform_name = "bf5xx-tdm-pcm-audio",
-	.codec_name = "ad1836-codec.0",
+	.codec_name = "ad1836.0",
 	.ops = &bf5xx_ad1836_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 3367882..5794d09 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -113,7 +113,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai = {
 	.cpu_dai_name = "bf5xx-tdm",
 	.codec_dai_name ="ad193x-hifi",
 	.platform_name = "bf5xx-tdm-pcm-audio",
-	.codec_name = "ad193x-codec.5",
+	.codec_name = "ad193x.5",
 	.ops = &bf5xx_ad193x_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index d57c9c9..c147130 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -73,7 +73,7 @@ static struct snd_soc_dai_link bf5xx_board_dai = {
 	.cpu_dai_name = "bfin-ac97",
 	.codec_dai_name = "ad1980-hifi",
 	.platform_name = "bfin-pcm-audio",
-	.codec_name = "ad1980-codec",
+	.codec_name = "ad1980",
 	.ops = &bf5xx_board_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 732fb8b..1655f95 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -186,7 +186,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 	.cpu_dai_name = "bf5xx-i2s",
 	.codec_dai_name = "ad73311-hifi",
 	.platform_name = "bfin-pcm-audio",
-	.codec_name = "ad73311-codec",
+	.codec_name = "ad73311",
 	.ops = &bf5xx_ad73311_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index ad28663..732a02f 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -119,7 +119,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.cpu_dai_name = "bf5xx-i2s",
 	.codec_dai_name = "ssm2602-hifi",
 	.platform_name = "bf5xx-pcm-audio",
-	.codec_name = "ssm2602-codec.0-001b",
+	.codec_name = "ssm2602.0-001b",
 	.ops = &bf5xx_ssm2602_ops,
 };
 
-- 
1.7.4.1
