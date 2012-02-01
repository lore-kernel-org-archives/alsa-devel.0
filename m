From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: pcm: Improve error logging
Date: Wed,  1 Feb 2012 21:30:55 +0000
Message-ID: <1328131855-22916-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FFC324380
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 22:31:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use the standard logging macros and use dev_ variants where we can, also
reporting error codes whenever we report an error. These changes (the
error codes in particular) make it noticeably easier to figure out what
went wrong just from the basic dmesg output.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fabd33e..ef28dd5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -123,8 +123,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops->startup) {
 		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't open interface %s\n",
-				cpu_dai->name);
+			dev_err(cpu_dai->dev, "can't open interface %s: %d\n",
+				cpu_dai->name, ret);
 			goto out;
 		}
 	}
@@ -132,7 +132,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (platform->driver->ops && platform->driver->ops->open) {
 		ret = platform->driver->ops->open(substream);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't open platform %s\n", platform->name);
+			dev_err(platform->dev, "can't open platform %s: %d\n",
+				platform->name, ret);
 			goto platform_err;
 		}
 	}
@@ -140,8 +141,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (codec_dai->driver->ops->startup) {
 		ret = codec_dai->driver->ops->startup(substream, codec_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't open codec %s\n",
-				codec_dai->name);
+			dev_err(codec_dai->dev, "can't open codec %s: %d\n",
+				codec_dai->name, ret);
 			goto codec_dai_err;
 		}
 	}
@@ -149,7 +150,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
 		ret = rtd->dai_link->ops->startup(substream);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: %s startup failed\n", rtd->dai_link->name);
+			pr_err("asoc: %s startup failed: %d\n",
+			       rtd->dai_link->name, ret);
 			goto machine_err;
 		}
 	}
@@ -413,7 +415,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops && rtd->dai_link->ops->prepare) {
 		ret = rtd->dai_link->ops->prepare(substream);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: machine prepare error\n");
+			pr_err("asoc: machine prepare error: %d\n", ret);
 			goto out;
 		}
 	}
@@ -421,7 +423,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (platform->driver->ops && platform->driver->ops->prepare) {
 		ret = platform->driver->ops->prepare(substream);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: platform prepare error\n");
+			dev_err(platform->dev, "platform prepare error: %d\n",
+				ret);
 			goto out;
 		}
 	}
@@ -429,7 +432,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (codec_dai->driver->ops->prepare) {
 		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: codec DAI prepare error\n");
+			dev_err(codec_dai->dev, "DAI prepare error: %d\n",
+				ret);
 			goto out;
 		}
 	}
@@ -437,7 +441,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops->prepare) {
 		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: cpu DAI prepare error\n");
+			dev_err(cpu_dai->dev, "DAI prepare error: %d\n",
+				ret);
 			goto out;
 		}
 	}
@@ -484,7 +489,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: machine hw_params failed\n");
+			pr_err("asoc: machine hw_params failed: %d\n", ret);
 			goto out;
 		}
 	}
@@ -492,8 +497,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (codec_dai->driver->ops->hw_params) {
 		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't set codec %s hw params\n",
-				codec_dai->name);
+			dev_err(codec_dai->dev, "can't set %s hw params: %d\n",
+				codec_dai->name, ret);
 			goto codec_err;
 		}
 	}
@@ -501,8 +506,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (cpu_dai->driver->ops->hw_params) {
 		ret = cpu_dai->driver->ops->hw_params(substream, params, cpu_dai);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: interface %s hw params failed\n",
-				cpu_dai->name);
+			dev_err(cpu_dai->dev, "%s hw params failed: %d\n",
+				cpu_dai->name, ret);
 			goto interface_err;
 		}
 	}
@@ -510,8 +515,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (platform->driver->ops && platform->driver->ops->hw_params) {
 		ret = platform->driver->ops->hw_params(substream, params);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: platform %s hw params failed\n",
-				platform->name);
+			dev_err(platform->dev, "%s hw params failed: %d\n",
+			       platform->name, ret);
 			goto platform_err;
 		}
 	}
-- 
1.7.9.rc1
