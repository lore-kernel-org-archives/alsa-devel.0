From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: pxa2xx-i2s is the proper name of the
	I2S DAI, not pxa-i2s.
Date: Fri, 20 Aug 2010 17:18:43 +0100
Message-ID: <1282321125-15761-1-git-send-email-ian@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8B8224556
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:19:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/imote2.c   |    2 +-
 sound/soc/pxa/magician.c |    2 +-
 sound/soc/pxa/poodle.c   |    2 +-
 sound/soc/pxa/z2.c       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 03765fc..154fc6f 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -63,7 +63,7 @@ static struct snd_soc_ops imote2_asoc_ops = {
 static struct snd_soc_dai_link imote2_dai = {
 	.name = "WM8940",
 	.stream_name = "WM8940",
-	.cpu_dai_name = "pxa-i2s",
+	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8940-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8940-codec.0-0034",
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 608bc3d..b8207ce 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -437,7 +437,7 @@ static struct snd_soc_dai_link magician_dai[] = {
 {
 	.name = "uda1380",
 	.stream_name = "UDA1380 Capture",
-	.cpu_dai_name = "pxa-i2s",
+	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "uda1380-hifi-capture",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index fa752f6..af84ee9 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -266,7 +266,7 @@ static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link poodle_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731",
-	.cpu_dai_name = "pxa-i2s",
+	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8731-codec.0-001a",
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 704f74b..4cc841b 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -189,7 +189,7 @@ static struct snd_soc_ops z2_ops = {
 static struct snd_soc_dai_link z2_dai = {
 	.name		= "wm8750",
 	.stream_name	= "WM8750",
-	.cpu_dai_name	= "pxa-i2s",
+	.cpu_dai_name	= "pxa2xx-i2s",
 	.codec_dai_name	= "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name	= "wm8750-codec.0-001a",
-- 
1.7.0.4
